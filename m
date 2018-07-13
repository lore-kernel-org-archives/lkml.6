Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811B5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3729A208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="E/PhizbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3729A208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbeGMV0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:26:08 -0400
Received: from www.zeus03.de ([194.117.254.33]:48518 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732899AbeGMV0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references; s=k1;
         bh=b6oGDBIBfv/l0HoECb650AG0im9yfc37flMn/wBVbNQ=; b=E/PhizbGDs2C
        nmJzLFHh6i3bLfBfp4JV+QsTa6UaIHznQLrQvmWj44hCkyZUwmb77InHDZtpaCNo
        iML/mnWzEYUU7jqN0MaqZ0GJ3Oo/K/n2Vc+riztk5EFYHWOS6eu3IfMmpWxUr56o
        /LYuBPNL3wxXVZhKsMVFGZDAhlugiP0=
Received: (qmail 3547 invoked from network); 13 Jul 2018 23:09:45 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 13 Jul 2018 23:09:45 +0200
X-UD-Smtp-Session: l3s3148p1@C90y5udwfuUgAwDPW8bBAAId4P/+oMhl
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH/RFT 5/6] i2c: imx: set SDA as output for recovery
Date:   Fri, 13 Jul 2018 23:09:17 +0200
Message-Id: <20180713210920.3648-6-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 3e23ee26c55c..a3881e270106 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1009,7 +1009,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 			PINCTRL_STATE_DEFAULT);
 	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
 			"gpio");
-	rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
+	rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_OUT_HIGH_OPEN_DRAIN);
 	rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
 
 	if (PTR_ERR(rinfo->sda_gpiod) == -EPROBE_DEFER ||
-- 
2.11.0

