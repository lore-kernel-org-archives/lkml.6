Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2159BECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE23D20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM9YM+mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE23D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbeGRUd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbeGRUd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:33:56 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B172084E;
        Wed, 18 Jul 2018 19:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531943670;
        bh=2y8PzIfIY9CDQGh7og5ZfK9czo7/NDDq+/TkTPiMSKM=;
        h=From:To:Subject:Date:From;
        b=nM9YM+mgNaAhB6OaBvVsV/Qdaqe416a8DqG+niSzV3COsl2XQRAeI9a9h7vpdlokg
         6RLwTRrFbKfTT+dC9Px5xw7Gdd6CAPJYBqK8F4u5iYaZEohhlhr57hrJCxifqkif01
         cyC3g/e044gtSiRK5fNME5NExseyR/EjcUrfcGG0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andi Shyti <andi@etezian.org>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: exynos5: Describe the hardware variant for readability
Date:   Wed, 18 Jul 2018 21:54:04 +0200
Message-Id: <20180718195404.5095-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver supports multiple hardware variants of Exynos I2C controller
which differ in FIFO depth, handling of interrupts and bus recovery in
HSI2C_MASTER_ST_LOSE state.

The difference in variant was a single bit set for Exynos7 variants and
implicit lack of this bit for other variants.

Make each variant explicit which also fixes the GCC warning about
documentation:

    drivers/i2c/busses/i2c-exynos5.c:223: warning: Function parameter or member 'hw' not described in 'exynos_hsi2c_variant'

No change in functionality.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/i2c/busses/i2c-exynos5.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index de82ad8ff534..c1ce2299a76e 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -176,7 +176,10 @@
 
 #define EXYNOS5_I2C_TIMEOUT (msecs_to_jiffies(100))
 
-#define HSI2C_EXYNOS7	BIT(0)
+enum i2c_type_exynos {
+	I2C_TYPE_EXYNOS5,
+	I2C_TYPE_EXYNOS7,
+};
 
 struct exynos5_i2c {
 	struct i2c_adapter	adap;
@@ -212,27 +215,30 @@ struct exynos5_i2c {
 /**
  * struct exynos_hsi2c_variant - platform specific HSI2C driver data
  * @fifo_depth: the fifo depth supported by the HSI2C module
+ * @hw: the hardware variant of Exynos I2C controller
  *
  * Specifies platform specific configuration of HSI2C module.
  * Note: A structure for driver specific platform data is used for future
  * expansion of its usage.
  */
 struct exynos_hsi2c_variant {
-	unsigned int	fifo_depth;
-	unsigned int	hw;
+	unsigned int		fifo_depth;
+	enum i2c_type_exynos	hw;
 };
 
 static const struct exynos_hsi2c_variant exynos5250_hsi2c_data = {
 	.fifo_depth	= 64,
+	.hw		= I2C_TYPE_EXYNOS5,
 };
 
 static const struct exynos_hsi2c_variant exynos5260_hsi2c_data = {
 	.fifo_depth	= 16,
+	.hw		= I2C_TYPE_EXYNOS5,
 };
 
 static const struct exynos_hsi2c_variant exynos7_hsi2c_data = {
 	.fifo_depth	= 16,
-	.hw		= HSI2C_EXYNOS7,
+	.hw		= I2C_TYPE_EXYNOS7,
 };
 
 static const struct of_device_id exynos5_i2c_match[] = {
@@ -300,7 +306,7 @@ static int exynos5_i2c_set_timing(struct exynos5_i2c *i2c, bool hs_timings)
 	 */
 	t_ftl_cycle = (readl(i2c->regs + HSI2C_CONF) >> 16) & 0x7;
 	temp = clkin / op_clk - 8 - t_ftl_cycle;
-	if (i2c->variant->hw != HSI2C_EXYNOS7)
+	if (i2c->variant->hw != I2C_TYPE_EXYNOS7)
 		temp -= t_ftl_cycle;
 	div = temp / 512;
 	clk_cycle = temp / (div + 1) - 2;
@@ -424,7 +430,7 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 	writel(int_status, i2c->regs + HSI2C_INT_STATUS);
 
 	/* handle interrupt related to the transfer status */
-	if (i2c->variant->hw == HSI2C_EXYNOS7) {
+	if (i2c->variant->hw == I2C_TYPE_EXYNOS7) {
 		if (int_status & HSI2C_INT_TRANS_DONE) {
 			i2c->trans_done = 1;
 			i2c->state = 0;
@@ -571,7 +577,7 @@ static void exynos5_i2c_bus_check(struct exynos5_i2c *i2c)
 {
 	unsigned long timeout;
 
-	if (i2c->variant->hw != HSI2C_EXYNOS7)
+	if (i2c->variant->hw != I2C_TYPE_EXYNOS7)
 		return;
 
 	/*
@@ -612,7 +618,7 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 	unsigned long flags;
 	unsigned short trig_lvl;
 
-	if (i2c->variant->hw == HSI2C_EXYNOS7)
+	if (i2c->variant->hw == I2C_TYPE_EXYNOS7)
 		int_en |= HSI2C_INT_I2C_TRANS;
 	else
 		int_en |= HSI2C_INT_I2C;
-- 
2.14.1

