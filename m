Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364D9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E262620873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OzaSE55L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E262620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbeGMV0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:26:07 -0400
Received: from www.zeus03.de ([194.117.254.33]:48502 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732717AbeGMV0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references; s=k1;
         bh=TyDHIV3F6W2grOqvBRQ47E4KYK9To9LnJv0HUB34Sbw=; b=OzaSE55Lv2UY
        eV1dDaD26J9BMTZsYt+zwqBBWchf42c6HEpKB/gbDrhM5XEhtczYcRkZbsEmx0bt
        IvBbh6yZnvYQ/pOee7Gxi83VelBM5Efq5seBlZToCNj3LFm2BcXa15v7T6QUkECW
        GYCCeqOQojWRIUAVBYuZ6WMPd+O2XIs=
Received: (qmail 3509 invoked from network); 13 Jul 2018 23:09:44 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 13 Jul 2018 23:09:44 +0200
X-UD-Smtp-Session: l3s3148p1@Otoo5udwfOUgAwDPW8bBAAId4P/+oMhl
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH/RFT 4/6] i2c: davinci: set SDA as output for recovery
Date:   Fri, 13 Jul 2018 23:09:16 +0200
Message-Id: <20180713210920.3648-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows for sending STOP when generating pulses which is much more
robust because it will bring clients into a default state.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-davinci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index d945a2654c2f..478acf0870aa 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -874,7 +874,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 			r = PTR_ERR(rinfo->scl_gpiod);
 			goto err_unuse_clocks;
 		}
-		rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
+		rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda",
+						  GPIOD_OUT_HIGH_OPEN_DRAIN);
 		if (IS_ERR(rinfo->sda_gpiod)) {
 			r = PTR_ERR(rinfo->sda_gpiod);
 			goto err_unuse_clocks;
-- 
2.11.0

