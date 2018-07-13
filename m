Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE1BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF7520873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="EKs4jTy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF7520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbeGMV0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:26:06 -0400
Received: from www.zeus03.de ([194.117.254.33]:48470 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732589AbeGMV0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references; s=k1;
         bh=Pxg0D6gPydncZpakJGoJP7XH88zvwDWI6lnNmfm0LJk=; b=EKs4jTy4wN68
        xjThzOQOWbmb8HAlK0sg787sTIFzoN9VNbHVKmjS5pqD3Z7h3pKG3fEuRnEnPEj1
        MS8zgxinRkuVAbv/iqwsECl4p3VLEHpRnD89eKjBbTodYqs5Vt+JB8B8XR0VX6RQ
        Z3AlPOnQKcv3p9+uMhKMyyRSMF5yqBY=
Received: (qmail 3472 invoked from network); 13 Jul 2018 23:09:44 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 13 Jul 2018 23:09:44 +0200
X-UD-Smtp-Session: l3s3148p1@dNoe5udweuUgAwDPW8bBAAId4P/+oMhl
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH/RFT 3/6] i2c: designware: set SDA as output for recovery
Date:   Fri, 13 Jul 2018 23:09:15 +0200
Message-Id: <20180713210920.3648-4-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-designware-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index a546db80f53e..25981efc844e 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -674,7 +674,7 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 	}
 	rinfo->scl_gpiod = gpio;
 
-	gpio = devm_gpiod_get_optional(dev->dev, "sda", GPIOD_IN);
+	gpio = devm_gpiod_get_optional(dev->dev, "sda", GPIOD_OUT_HIGH_OPEN_DRAIN);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 	rinfo->sda_gpiod = gpio;
-- 
2.11.0

