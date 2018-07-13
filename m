Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB34ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D1D20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Sdjk2/9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D1D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbeGMV0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:26:04 -0400
Received: from www.zeus03.de ([194.117.254.33]:48434 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731962AbeGMV0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references; s=k1;
         bh=ULm2Bo/WMxPVBZgzWE5gkC4xnOYTVZj8SgrPVWn9sy0=; b=Sdjk2/9pzZ+3
        hc7KGchkgL7ASY/+UidBjOZNqm843yGSUylsiuw83SBWP7+IPgBGPI28j/QF/zOK
        J8svp2CGnG/DIOJa7LYJsWRXb1kEVhUPEr3Uod/eIv/ThPuknRv6Wd6hGY5zDNlk
        RwFwGAKDH8VVSVBaU2uu2lN2TaqH31I=
Received: (qmail 3404 invoked from network); 13 Jul 2018 23:09:42 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 13 Jul 2018 23:09:42 +0200
X-UD-Smtp-Session: l3s3148p1@NHUL5udwduUgAwDPW8bBAAId4P/+oMhl
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH/RFT 1/6] i2c: designware: use open drain for recovery GPIO
Date:   Fri, 13 Jul 2018 23:09:13 +0200
Message-Id: <20180713210920.3648-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C is open drain, so set up the GPIO accordingly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index fc7c255c80af..a546db80f53e 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -665,7 +665,7 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 	struct gpio_desc *gpio;
 	int r;
 
-	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
+	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
 	if (IS_ERR(gpio)) {
 		r = PTR_ERR(gpio);
 		if (r == -ENOENT || r == -ENOSYS)
-- 
2.11.0

