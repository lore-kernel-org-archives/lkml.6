Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BB3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAF821527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/biwson"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAF821527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbeKVFo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:44:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeKVFo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:44:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFF10214D9;
        Wed, 21 Nov 2018 19:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827335;
        bh=0k8KAoLCuUq4rhMgAODQwCMhP6oCFGup1BiTIiKj5xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/biwsonxHYpmMisgshOi7GvsC9/EQFuZE428GiUpaa9+TQ4Mh3sRi3hV4Az3CcTh
         pcBdOP53lgkAwc51GEy7hSmM3ST96aCs48roZDiAYgDXcv/FbkXvBBDc8MecO2QeYL
         bfUwCP9C6lM8PE5Nahp2/4zolqSkokAgXSMls7WA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tristram Ha <Tristram.Ha@microchip.com>,
        Pavel Machek <pavel@ucw.cz>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 11/21] net: dsa: microchip: initialize mutex before use
Date:   Wed, 21 Nov 2018 20:06:55 +0100
Message-Id: <20181121183422.540905822@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
References: <20181121183422.103826775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tristram Ha <Tristram.Ha@microchip.com>

[ Upstream commit 284fb78ed7572117846f8e1d1d8e3dbfd16880c2 ]

Initialize mutex before use.  Avoid kernel complaint when
CONFIG_DEBUG_LOCK_ALLOC is enabled.

Fixes: b987e98e50ab90e5 ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/microchip/ksz_common.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1104,11 +1104,6 @@ static int ksz_switch_init(struct ksz_de
 {
 	int i;
 
-	mutex_init(&dev->reg_mutex);
-	mutex_init(&dev->stats_mutex);
-	mutex_init(&dev->alu_mutex);
-	mutex_init(&dev->vlan_mutex);
-
 	dev->ds->ops = &ksz_switch_ops;
 
 	for (i = 0; i < ARRAY_SIZE(ksz_switch_chips); i++) {
@@ -1193,6 +1188,11 @@ int ksz_switch_register(struct ksz_devic
 	if (dev->pdata)
 		dev->chip_id = dev->pdata->chip_id;
 
+	mutex_init(&dev->reg_mutex);
+	mutex_init(&dev->stats_mutex);
+	mutex_init(&dev->alu_mutex);
+	mutex_init(&dev->vlan_mutex);
+
 	if (ksz_switch_detect(dev))
 		return -EINVAL;
 


