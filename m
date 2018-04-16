Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeDPRQ0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:16:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57994 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeDPRQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:16:24 -0400
From: Mark Brown <broonie@kernel.org>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, linux-spi@vger.kernel.org
Subject: Applied "spi: stm32: Fix error handling in stm32_spi_probe()" to the spi tree
In-Reply-To: <1522439684-7510-1-git-send-email-khoroshilov@ispras.ru>
Message-Id: <E1f87jg-000397-5U@debutante>
Date: Mon, 16 Apr 2018 18:16:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32: Fix error handling in stm32_spi_probe()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 05799ddf74f642911d27514227b89392ba02b26f Mon Sep 17 00:00:00 2001
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Fri, 30 Mar 2018 22:54:44 +0300
Subject: [PATCH] spi: stm32: Fix error handling in stm32_spi_probe()

clk_get_rate() is below clk_prepare_enable(), so
its error should lead to goto err_clk_disable, not to err_master_put.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Reviewed-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ba9743fa2326..ad1e55d3d5d5 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1129,7 +1129,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (!spi->clk_rate) {
 		dev_err(&pdev->dev, "clk rate = 0\n");
 		ret = -EINVAL;
-		goto err_master_put;
+		goto err_clk_disable;
 	}
 
 	spi->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-- 
2.17.0
