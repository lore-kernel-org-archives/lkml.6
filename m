Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1EFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1122121934
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405033AbeLVU1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 15:27:21 -0500
Received: from sauhun.de ([88.99.104.3]:52674 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404952AbeLVU0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 15:26:42 -0500
Received: from localhost (p54B67A8B.dip0.t-ipconnect.de [84.182.122.139])
        by pokefinder.org (Postfix) with ESMTPSA id AEB4A2E3606;
        Sat, 22 Dec 2018 21:26:40 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 9/9] i2c: s3c2410: don't open code to reject transfers when suspended
Date:   Sat, 22 Dec 2018 21:26:23 +0100
Message-Id: <20181222202623.4521-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is handled by the I2C core meanwhile.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-s3c2410.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 2f2e28d60ef5..eeccd19b5f42 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -104,7 +104,6 @@ enum s3c24xx_i2c_state {
 struct s3c24xx_i2c {
 	wait_queue_head_t	wait;
 	kernel_ulong_t		quirks;
-	unsigned int		suspended:1;
 
 	struct i2c_msg		*msg;
 	unsigned int		msg_num;
@@ -703,9 +702,6 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 	unsigned long timeout;
 	int ret;
 
-	if (i2c->suspended)
-		return -EIO;
-
 	ret = s3c24xx_i2c_set_master(i2c);
 	if (ret != 0) {
 		dev_err(i2c->dev, "cannot get bus (error %d)\n", ret);
@@ -1246,8 +1242,6 @@ static int s3c24xx_i2c_suspend_noirq(struct device *dev)
 {
 	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->suspended = 1;
-
 	if (!IS_ERR(i2c->sysreg))
 		regmap_read(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, &i2c->sys_i2c_cfg);
 
@@ -1267,7 +1261,6 @@ static int s3c24xx_i2c_resume_noirq(struct device *dev)
 		return ret;
 	s3c24xx_i2c_init(i2c);
 	clk_disable(i2c->clk);
-	i2c->suspended = 0;
 
 	return 0;
 }
-- 
2.19.1

