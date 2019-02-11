Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3365AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F284120838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895416;
	bh=0s9Lufb1rVi03qTnL6+QEd7KuRQVSj/aJ9oUsMcPPfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IIL0fOz3dKIVwVys8JgfosV7bqAH1ypI99+RC+uLqgbvBDq/ugD/a5GlFAZZQq2B7
	 WVXN3s/BfZnRzex3HGV32VhKBmoC/oEqVaSqZqr6YrjIpQj1051c4pmcAybOD70esv
	 B+otNeVlZbO2UUPhuJvCAHs4VB8OTWGNMiaWj1kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfBKOaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:30:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbfBKOaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D95B2082F;
        Mon, 11 Feb 2019 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895409;
        bh=0s9Lufb1rVi03qTnL6+QEd7KuRQVSj/aJ9oUsMcPPfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mN5RITp4Kgb7Zceft6/jzS4phAJkpXGlkA46DOVqcX4MR0cAUfTEvq+unjBWK6RBj
         csC0zi9jGBKQMEkqe7VBMoQMUAGn7YUBqlF1i8353n5d5Ty/4JT4dWWs7G80EjwrrF
         mYzg/+ld2XYF/fw8npsL1rRB8TLgIMgtmiV1x7bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 178/352] mmc: jz4740: Get CD/WP GPIOs from descriptors
Date:   Mon, 11 Feb 2019 15:16:45 +0100
Message-Id: <20190211141858.411767436@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0c901c0566fb4edc2631c3786e5085a037be91f8 ]

Modifty the JZ4740 driver to retrieve card detect and write
protect GPIO pins from GPIO descriptors instead of hard-coded
global numbers. Augment the only board file using this in the
process and cut down on passed in platform data.

Preserve the code setting the caps2 flags for CD and WP
as active low or high since the slot GPIO code currently
ignores the gpiolib polarity inversion semantice and uses
the raw accessors to read the GPIO lines, but set the right
polarity flags in the descriptor table for jz4740.

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@linux-mips.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mips/include/asm/mach-jz4740/jz4740_mmc.h |  2 --
 arch/mips/jz4740/board-qi_lb60.c              | 12 ++++++++---
 drivers/mmc/host/jz4740_mmc.c                 | 20 +++++++++----------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
index e9cc62cfac99..ff50aeb1a933 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
@@ -4,8 +4,6 @@
 
 struct jz4740_mmc_platform_data {
 	int gpio_power;
-	int gpio_card_detect;
-	int gpio_read_only;
 	unsigned card_detect_active_low:1;
 	unsigned read_only_active_low:1;
 	unsigned power_active_low:1;
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index af0c8ace0141..705593d40d12 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -43,7 +43,6 @@
 #include "clock.h"
 
 /* GPIOs */
-#define QI_LB60_GPIO_SD_CD		JZ_GPIO_PORTD(0)
 #define QI_LB60_GPIO_SD_VCC_EN_N	JZ_GPIO_PORTD(2)
 
 #define QI_LB60_GPIO_KEYOUT(x)		(JZ_GPIO_PORTC(10) + (x))
@@ -386,12 +385,18 @@ static struct platform_device qi_lb60_gpio_keys = {
 };
 
 static struct jz4740_mmc_platform_data qi_lb60_mmc_pdata = {
-	.gpio_card_detect	= QI_LB60_GPIO_SD_CD,
-	.gpio_read_only		= -1,
 	.gpio_power		= QI_LB60_GPIO_SD_VCC_EN_N,
 	.power_active_low	= 1,
 };
 
+static struct gpiod_lookup_table qi_lb60_mmc_gpio_table = {
+	.dev_id = "jz4740-mmc.0",
+	.table = {
+		GPIO_LOOKUP("GPIOD", 0, "cd", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /* beeper */
 static struct pwm_lookup qi_lb60_pwm_lookup[] = {
 	PWM_LOOKUP("jz4740-pwm", 4, "pwm-beeper", NULL, 0,
@@ -500,6 +505,7 @@ static int __init qi_lb60_init_platform_devices(void)
 	gpiod_add_lookup_table(&qi_lb60_audio_gpio_table);
 	gpiod_add_lookup_table(&qi_lb60_nand_gpio_table);
 	gpiod_add_lookup_table(&qi_lb60_spigpio_gpio_table);
+	gpiod_add_lookup_table(&qi_lb60_mmc_gpio_table);
 
 	spi_register_board_info(qi_lb60_spi_board_info,
 				ARRAY_SIZE(qi_lb60_spi_board_info));
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 0c1efd5100b7..44ea452add8e 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -983,17 +983,17 @@ static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
 	if (!pdata->read_only_active_low)
 		mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
-	if (gpio_is_valid(pdata->gpio_card_detect)) {
-		ret = mmc_gpio_request_cd(mmc, pdata->gpio_card_detect, 0);
-		if (ret)
-			return ret;
-	}
+	/*
+	 * Get optional card detect and write protect GPIOs,
+	 * only back out on probe deferral.
+	 */
+	ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0, NULL);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
-	if (gpio_is_valid(pdata->gpio_read_only)) {
-		ret = mmc_gpio_request_ro(mmc, pdata->gpio_read_only);
-		if (ret)
-			return ret;
-	}
+	ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0, NULL);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
 	return jz4740_mmc_request_gpio(&pdev->dev, pdata->gpio_power,
 			"MMC read only", true, pdata->power_active_low);
-- 
2.19.1



