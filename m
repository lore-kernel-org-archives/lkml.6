Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE170C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07112086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="xMnQQ4R7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfARBHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:07:21 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33358 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfARBHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547773638; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LdKmC0sOyR3V2mJtKk2VStVW2W3EwccGJghrjd+po30=;
        b=xMnQQ4R7KuLpk2Pch64tLORPLEPzAbzc/74NPOr6Q58I4KDHyQKIAsOmUaA/FOEVOhmClP
        AUmWlALF0ITh/YudOx8GruETDwiKOyxEL44oicuNTdQ0dMFlAIWPnenhpEf87cs58rKER2
        guDy0iWYulVghW66ZFfoqyA1EF+JMro=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/8] mtd: rawnand: jz4780-bch: Don't set clock rate in driver
Date:   Thu, 17 Jan 2019 22:06:32 -0300
Message-Id: <20190118010634.27399-6-paul@crapouillou.net>
In-Reply-To: <20190118010634.27399-1-paul@crapouillou.net>
References: <20190118010634.27399-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be done in devicetree. Besides, it prevents us from
supporting other SoCs which don't use the same clock frequency for the
BCH hardware.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mtd/nand/raw/jz4780_bch.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
index 7e4e5e627603..161d3821e1c4 100644
--- a/drivers/mtd/nand/raw/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/jz4780_bch.c
@@ -57,8 +57,6 @@
 #define BCH_BHINT_UNCOR			BIT(1)
 #define BCH_BHINT_ERR			BIT(0)
 
-#define BCH_CLK_RATE			(200 * 1000 * 1000)
-
 /* Timeout for BCH calculation/correction. */
 #define BCH_TIMEOUT_US			100000
 
@@ -348,8 +346,6 @@ static int jz4780_bch_probe(struct platform_device *pdev)
 		return PTR_ERR(bch->clk);
 	}
 
-	clk_set_rate(bch->clk, BCH_CLK_RATE);
-
 	mutex_init(&bch->lock);
 
 	bch->dev = dev;
-- 
2.11.0

