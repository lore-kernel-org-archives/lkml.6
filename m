Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032574AbeBNQ3D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:29:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54734 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032392AbeBNQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:29:01 -0500
From: Mark Brown <broonie@kernel.org>
To: Trent Piepho <tpiepho@impinj.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: bcm2835aux: Avoid 64-bit arithmetic in xfer len calc" to the spi tree
In-Reply-To: <20180212193814.17644-1-tpiepho@impinj.com>
Message-Id: <E1elzvF-0005oU-Pj@debutante>
Date: Wed, 14 Feb 2018 16:28:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: bcm2835aux: Avoid 64-bit arithmetic in xfer len calc

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

>From d704afffe65c8fab424963c1ba4ec4364c2d6a82 Mon Sep 17 00:00:00 2001
From: Trent Piepho <tpiepho@impinj.com>
Date: Mon, 12 Feb 2018 11:38:14 -0800
Subject: [PATCH] spi: bcm2835aux: Avoid 64-bit arithmetic in xfer len calc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We want to check for xfers that are over 30 microseconds.  Rather than
find how many µs a xfer will take, instead find how many bytes can be
transferred in 30 µs.  The latter must be less than 32 bits (since our
clock speed is limited to 32 bits), while the former involves 64 bit
quantities and more arithmetic operations.

Signed-off-by: Trent Piepho <tpiepho@impinj.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835aux.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 7428091d3f5b..1431cb98fe40 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -321,7 +321,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, speed;
 	unsigned long spi_used_hz;
-	unsigned long long xfer_time_us;
 
 	/* calculate the registers to handle
 	 *
@@ -358,20 +357,21 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	bs->rx_len = tfr->len;
 	bs->pending = 0;
 
-	/* calculate the estimated time in us the transfer runs
-	 * note that there are are 2 idle clocks after each
-	 * chunk getting transferred - in our case the chunk size
-	 * is 3 bytes, so we approximate this by 9 bits/byte
+	/* Calculate the estimated time in us the transfer runs.  Note that
+	 * there are are 2 idle clocks cycles after each chunk getting
+	 * transferred - in our case the chunk size is 3 bytes, so we
+	 * approximate this by 9 cycles/byte.  This is used to find the number
+	 * of Hz per byte per polling limit.  E.g., we can transfer 1 byte in
+	 * 30 µs per 300,000 Hz of bus clock.
 	 */
-	xfer_time_us = tfr->len * 9 * 1000000;
-	do_div(xfer_time_us, spi_used_hz);
-
+#define HZ_PER_BYTE ((9 * 1000000) / BCM2835_AUX_SPI_POLLING_LIMIT_US)
 	/* run in polling mode for short transfers */
-	if (xfer_time_us < BCM2835_AUX_SPI_POLLING_LIMIT_US)
+	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
 		return bcm2835aux_spi_transfer_one_poll(master, spi, tfr);
 
 	/* run in interrupt mode for all others */
 	return bcm2835aux_spi_transfer_one_irq(master, spi, tfr);
+#undef HZ_PER_BYTE
 }
 
 static int bcm2835aux_spi_prepare_message(struct spi_master *master,
-- 
2.16.1
