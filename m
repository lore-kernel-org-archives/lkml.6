Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039C4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A896B20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A896B20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754360AbeFTDfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:35:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:47071 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754093AbeFTDfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:35:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5K3YFWW020218;
        Tue, 19 Jun 2018 22:34:16 -0500
Message-ID: <5d1f980286e2bba566421ebb29721770303fcf09.camel@kernel.crashing.org>
Subject: Re: [PATCH v10 3/7] i2c: fsi: Add port structures
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Eddie James <eajames@linux.vnet.ibm.com>, linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, joel@jms.id.au,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
Date:   Wed, 20 Jun 2018 13:34:15 +1000
In-Reply-To: <1528918579-27602-4-git-send-email-eajames@linux.vnet.ibm.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
         <1528918579-27602-4-git-send-email-eajames@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-13 at 14:36 -0500, Eddie James wrote:
>  }
>  
> +static int fsi_i2c_remove(struct device *dev)
> +{
> +       struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
> +       struct fsi_i2c_port *port;
> +
> +       list_for_each_entry(port, &i2c->ports, list) {
> +               i2c_del_adapter(&port->adapter);
> +               kfree(port);
> +       }
> +
> +       return 0;
> +}
> +

This is a use-after-free, the list linkage of the freed port is used to
get to the next one. With memory poisoning, kbooom !

You can fold that in:

From f9d9092160897e7308f6990067a03e937339537f Mon Sep 17 00:00:00 2001
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 20 Jun 2018 13:27:32 +1000
Subject: [PATCH] i2c: fsi: Fix use after free

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/i2c/busses/i2c-fsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 713959b44403..ff69ab6aa79a 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -696,9 +696,10 @@ static int fsi_i2c_probe(struct device *dev)
 static int fsi_i2c_remove(struct device *dev)
 {
 	struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
-	struct fsi_i2c_port *port;
+	struct fsi_i2c_port *port, *tmp;
 
-	list_for_each_entry(port, &i2c->ports, list) {
+	list_for_each_entry_safe(port,tmp, &i2c->ports, list) {
+		list_del(&port->list);
 		i2c_del_adapter(&port->adapter);
 		kfree(port);
 	}

