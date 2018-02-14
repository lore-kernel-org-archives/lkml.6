Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030322AbeBNN3S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:29:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35268 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030221AbeBNN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:29:15 -0500
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, jcsing.lee@samsung.com,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, m.szyprowski@samsung.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: i2s: Define the parameters list for SAMSUNG_I2S_OPCLK" to the asoc tree
In-Reply-To: <20180205154403.13520-5-s.nawrocki@samsung.com>
Message-Id: <E1elx7Z-0006uJ-Eu@debutante>
Date: Wed, 14 Feb 2018 13:29:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: i2s: Define the parameters list for SAMSUNG_I2S_OPCLK

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 45ae70e8b60e1d1bbc71eeccaef4026c5e6638a3 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 12 Feb 2018 17:15:35 +0100
Subject: [PATCH] ASoC: samsung: i2s: Define the parameters list for
 SAMSUNG_I2S_OPCLK

The SAMSUNG_I2S_OPCLK is not currently used by any card driver thus we can
safely change semantics of 'dir' argument of the I2S set_sysclk() callback.
Now an enumeration is exported instead of directly using register bit field
values.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s-regs.h | 11 ++++++-----
 sound/soc/samsung/i2s.c      |  2 +-
 sound/soc/samsung/i2s.h      | 11 ++++++++---
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
index fe6914005494..964985ea2e80 100644
--- a/sound/soc/samsung/i2s-regs.h
+++ b/sound/soc/samsung/i2s-regs.h
@@ -65,11 +65,12 @@
 #define CON_RXDMA_ACTIVE	(1 << 1)
 #define CON_ACTIVE		(1 << 0)
 
-#define MOD_OPCLK_CDCLK_OUT	(0 << 30)
-#define MOD_OPCLK_CDCLK_IN	(1 << 30)
-#define MOD_OPCLK_BCLK_OUT	(2 << 30)
-#define MOD_OPCLK_PCLK		(3 << 30)
-#define MOD_OPCLK_MASK		(3 << 30)
+#define MOD_OPCLK_SHIFT		30
+#define MOD_OPCLK_CDCLK_OUT	(0 << MOD_OPCLK_SHIFT)
+#define MOD_OPCLK_CDCLK_IN	(1 << MOD_OPCLK_SHIFT)
+#define MOD_OPCLK_BCLK_OUT	(2 << MOD_OPCLK_SHIFT)
+#define MOD_OPCLK_PCLK		(3 << MOD_OPCLK_SHIFT)
+#define MOD_OPCLK_MASK		(3 << MOD_OPCLK_SHIFT)
 #define MOD_TXS_IDMA		(1 << 28) /* Sec_TXFIFO use I-DMA */
 
 #define MOD_BLCS_SHIFT		26
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 7b57ad11ca15..b6407fbabdd1 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -489,7 +489,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 	switch (clk_id) {
 	case SAMSUNG_I2S_OPCLK:
 		mask = MOD_OPCLK_MASK;
-		val = dir;
+		val = (dir << MOD_OPCLK_SHIFT) & MOD_OPCLK_MASK;
 		break;
 	case SAMSUNG_I2S_CDCLK:
 		mask = 1 << i2s_regs->cdclkcon_off;
diff --git a/sound/soc/samsung/i2s.h b/sound/soc/samsung/i2s.h
index 79781de2f247..a9832a9555cb 100644
--- a/sound/soc/samsung/i2s.h
+++ b/sound/soc/samsung/i2s.h
@@ -16,11 +16,16 @@
 #define SAMSUNG_I2S_DAI        "samsung-i2s"
 #define SAMSUNG_I2S_DAI_SEC    "samsung-i2s-sec"
 
-#define SAMSUNG_I2S_DIV_BCLK	1
+#define SAMSUNG_I2S_DIV_BCLK		1
 
-#define SAMSUNG_I2S_RCLKSRC_0	0
-#define SAMSUNG_I2S_RCLKSRC_1	1
+#define SAMSUNG_I2S_RCLKSRC_0		0
+#define SAMSUNG_I2S_RCLKSRC_1		1
 #define SAMSUNG_I2S_CDCLK		2
+/* Operation clock for IIS logic */
 #define SAMSUNG_I2S_OPCLK		3
+#define  SAMSUNG_I2S_OPCLK_CDCLK_OUT	0	/* CODEC clock out */
+#define  SAMSUNG_I2S_OPCLK_CDCLK_IN	1	/* CODEC clock in */
+#define  SAMSUNG_I2S_OPCLK_BCLK_OUT	2	/* Bit clock out */
+#define  SAMSUNG_I2S_OPCLK_PCLK		3	/* Audio bus clock */
 
 #endif /* __SND_SOC_SAMSUNG_I2S_H */
-- 
2.16.1
