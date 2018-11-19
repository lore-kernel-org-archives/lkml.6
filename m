Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFB4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034CC206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Y99awQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034CC206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbeKTDNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728787AbeKTDNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:13:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A2772089F;
        Mon, 19 Nov 2018 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646136;
        bh=KGPgyQc+5ZlRJWTAQHf3sXIsjtwezEOnT/+J5qHGTLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Y99awQyyQrYLYqQ3+iyAaGtHj36tZ3TbDUdu7pDvlVEs6TWB1U3YyUv3Cr4go6g8
         51dfWfKiOqYTJVjKz5UuzmWiEhLuj9SejtlTtqAgMb1/h4vi5odkgM32fgsMwGw3gb
         CWKp5lIgg3RakCBcSPSvE2tQzTa7b16zhA5ZbEBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.14 051/124] reset: hisilicon: fix potential NULL pointer dereference
Date:   Mon, 19 Nov 2018 17:28:25 +0100
Message-Id: <20181119162623.493108367@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit e9a2310fb689151166df7fd9971093362d34bd79 upstream.

There is a potential execution path in which function
platform_get_resource() returns NULL. If this happens,
we will end up having a NULL pointer dereference.

Fix this by replacing devm_ioremap with devm_ioremap_resource,
which has the NULL check and the memory region request.

This code was detected with the help of Coccinelle.

Cc: stable@vger.kernel.org
Fixes: 97b7129cd2af ("reset: hisilicon: change the definition of hisi_reset_init")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/hisilicon/reset.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -109,9 +109,8 @@ struct hisi_reset_controller *hisi_reset
 		return NULL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rstc->membase = devm_ioremap(&pdev->dev,
-				res->start, resource_size(res));
-	if (!rstc->membase)
+	rstc->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rstc->membase))
 		return NULL;
 
 	spin_lock_init(&rstc->lock);


