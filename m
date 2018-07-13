Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B940CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A04420873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="xnHEJ4kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A04420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbeGMV0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:26:11 -0400
Received: from www.zeus03.de ([194.117.254.33]:48540 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732663AbeGMV0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references; s=k1;
         bh=fvo4uODzq779gZ7ZCxpFXKFmEiv8vkRlzDD0wa85F8U=; b=xnHEJ4krhasA
        /CIteL8yaQz6E5QMBOEevv96v4YO8WtyTaXllIP5tvFmjBuw6L4pAYC28U9Jp87M
        0KUqvVisoMBlxJqBGj0YcfuXlLchtC4B0jUh5TMhuZ/ut8k/EYzZ20nyXlIuRhIz
        yaBqcQ5RU7aRK/vi8fR3x20IXFxPP8o=
Received: (qmail 3567 invoked from network); 13 Jul 2018 23:09:46 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 13 Jul 2018 23:09:46 +0200
X-UD-Smtp-Session: l3s3148p1@1H085udwgOUgAwDPW8bBAAId4P/+oMhl
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [PATCH/RFT 6/6] i2c: recovery: remove bogus check if SDA GPIO is set to output
Date:   Fri, 13 Jul 2018 23:09:18 +0200
Message-Id: <20180713210920.3648-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check did not work as intended. I2C is open drain, so this function
will likely always have presented the GPIO as input because
gpiod_get_direction doesn't know about open drain states. Remove this
check for now. We can add it again once we know how to get more precise
information about the GPIO.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 301285c54603..7c5f012f561c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -261,9 +261,7 @@ static void i2c_init_recovery(struct i2c_adapter *adap)
 		bri->set_scl = set_scl_gpio_value;
 		if (bri->sda_gpiod) {
 			bri->get_sda = get_sda_gpio_value;
-			/* FIXME: add proper flag instead of '0' once available */
-			if (gpiod_get_direction(bri->sda_gpiod) == 0)
-				bri->set_sda = set_sda_gpio_value;
+			bri->set_sda = set_sda_gpio_value;
 		}
 		return;
 	}
-- 
2.11.0

