Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8751C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6957B205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393953AbfAPPON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:14:13 -0500
Received: from shell.v3.sk ([90.176.6.54]:57025 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729301AbfAPPON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:14:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DAF5953FB6;
        Wed, 16 Jan 2019 16:14:05 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7Xdpyda0F2eO; Wed, 16 Jan 2019 16:13:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0BD8D53F97;
        Wed, 16 Jan 2019 16:13:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jRClzE9IfXmQ; Wed, 16 Jan 2019 16:13:55 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 20580533E2;
        Wed, 16 Jan 2019 16:13:55 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] pxa2xx: replace spi_master with spi_controller
Date:   Wed, 16 Jan 2019 16:13:31 +0100
Message-Id: <20190116151330.1971861-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's also a slave controller driver now, calling it "master" is slightly
misleading.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/spi/pxa2xx       |  10 +--
 arch/arm/mach-pxa/cm-x255.c    |   2 +-
 arch/arm/mach-pxa/cm-x270.c    |   2 +-
 arch/arm/mach-pxa/corgi.c      |   2 +-
 arch/arm/mach-pxa/devices.c    |   2 +-
 arch/arm/mach-pxa/em-x270.c    |   4 +-
 arch/arm/mach-pxa/hx4700.c     |   2 +-
 arch/arm/mach-pxa/icontrol.c   |   4 +-
 arch/arm/mach-pxa/littleton.c  |   2 +-
 arch/arm/mach-pxa/lubbock.c    |   2 +-
 arch/arm/mach-pxa/magician.c   |   2 +-
 arch/arm/mach-pxa/pcm027.c     |   2 +-
 arch/arm/mach-pxa/poodle.c     |   2 +-
 arch/arm/mach-pxa/spitz.c      |   2 +-
 arch/arm/mach-pxa/stargate2.c  |   6 +-
 arch/arm/mach-pxa/tosa.c       |   2 +-
 arch/arm/mach-pxa/z2.c         |   4 +-
 arch/arm/mach-pxa/zeus.c       |   2 +-
 drivers/spi/spi-pxa2xx-dma.c   |  58 ++++++------
 drivers/spi/spi-pxa2xx-pci.c   |   4 +-
 drivers/spi/spi-pxa2xx.c       | 156 ++++++++++++++++-----------------
 drivers/spi/spi-pxa2xx.h       |   4 +-
 include/linux/spi/pxa2xx_spi.h |   4 +-
 23 files changed, 140 insertions(+), 140 deletions(-)

diff --git a/Documentation/spi/pxa2xx b/Documentation/spi/pxa2xx
index 13a0b7fb192f..551325b66b23 100644
--- a/Documentation/spi/pxa2xx
+++ b/Documentation/spi/pxa2xx
@@ -21,15 +21,15 @@ Typically a SPI master is defined in the arch/.../mac=
h-*/board-*.c as a
 "platform device".  The master configuration is passed to the driver via=
 a table
 found in include/linux/spi/pxa2xx_spi.h:
=20
-struct pxa2xx_spi_master {
+struct pxa2xx_spi_controller {
 	u16 num_chipselect;
 	u8 enable_dma;
 };
=20
-The "pxa2xx_spi_master.num_chipselect" field is used to determine the nu=
mber of
+The "pxa2xx_spi_controller.num_chipselect" field is used to determine th=
e number of
 slave device (chips) attached to this SPI master.
=20
-The "pxa2xx_spi_master.enable_dma" field informs the driver that SSP DMA=
 should
+The "pxa2xx_spi_controller.enable_dma" field informs the driver that SSP=
 DMA should
 be used.  This caused the driver to acquire two DMA channels: rx_channel=
 and
 tx_channel.  The rx_channel has a higher DMA service priority the tx_cha=
nnel.
 See the "PXA2xx Developer Manual" section "DMA Controller".
@@ -51,7 +51,7 @@ static struct resource pxa_spi_nssp_resources[] =3D {
 	},
 };
=20
-static struct pxa2xx_spi_master pxa_nssp_master_info =3D {
+static struct pxa2xx_spi_controller pxa_nssp_master_info =3D {
 	.num_chipselect =3D 1, /* Matches the number of chips attached to NSSP =
*/
 	.enable_dma =3D 1, /* Enables NSSP DMA */
 };
@@ -206,7 +206,7 @@ DMA and PIO I/O Support
 -----------------------
 The pxa2xx_spi driver supports both DMA and interrupt driven PIO message
 transfers.  The driver defaults to PIO mode and DMA transfers must be en=
abled
-by setting the "enable_dma" flag in the "pxa2xx_spi_master" structure.  =
The DMA
+by setting the "enable_dma" flag in the "pxa2xx_spi_controller" structur=
e.  The DMA
 mode supports both coherent and stream based DMA mappings.
=20
 The following logic is used to determine the type of I/O to be used on
diff --git a/arch/arm/mach-pxa/cm-x255.c b/arch/arm/mach-pxa/cm-x255.c
index fa8e7dd4d898..4401dfcd7e68 100644
--- a/arch/arm/mach-pxa/cm-x255.c
+++ b/arch/arm/mach-pxa/cm-x255.c
@@ -98,7 +98,7 @@ static unsigned long cmx255_pin_config[] =3D {
 };
=20
 #if defined(CONFIG_SPI_PXA2XX)
-static struct pxa2xx_spi_master pxa_ssp_master_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp_master_info =3D {
 	.num_chipselect	=3D 1,
 };
=20
diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index f7081a50dc67..279eeca7add0 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -313,7 +313,7 @@ static inline void cmx270_init_mmc(void) {}
 #endif
=20
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static struct pxa2xx_spi_master cm_x270_spi_info =3D {
+static struct pxa2xx_spi_controller cm_x270_spi_info =3D {
 	.num_chipselect	=3D 1,
 	.enable_dma	=3D 1,
 };
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index c9732cace5e3..7ecf559bd71c 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -530,7 +530,7 @@ static struct pxa2xx_udc_mach_info udc_info __initdat=
a =3D {
 };
=20
 #if IS_ENABLED(CONFIG_SPI_PXA2XX)
-static struct pxa2xx_spi_master corgi_spi_info =3D {
+static struct pxa2xx_spi_controller corgi_spi_info =3D {
 	.num_chipselect	=3D 3,
 };
=20
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index a24783a03827..524d6093e0c7 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -1065,7 +1065,7 @@ struct platform_device pxa93x_device_gpio =3D {
=20
 /* pxa2xx-spi platform-device ID equals respective SSP platform-device I=
D + 1.
  * See comment in arch/arm/mach-pxa/ssp.c::ssp_probe() */
-void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *i=
nfo)
+void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controlle=
r *info)
 {
 	struct platform_device *pd;
=20
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 32c1edeb3f14..5e372760f16e 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -689,7 +689,7 @@ static inline void em_x270_init_lcd(void) {}
 #endif
=20
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static struct pxa2xx_spi_master em_x270_spi_info =3D {
+static struct pxa2xx_spi_controller em_x270_spi_info =3D {
 	.num_chipselect	=3D 1,
 };
=20
@@ -703,7 +703,7 @@ static struct tdo24m_platform_data em_x270_tdo24m_pda=
ta =3D {
 	.model =3D TDO35S,
 };
=20
-static struct pxa2xx_spi_master em_x270_spi_2_info =3D {
+static struct pxa2xx_spi_controller em_x270_spi_2_info =3D {
 	.num_chipselect	=3D 1,
 	.enable_dma	=3D 1,
 };
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index b79b757fdd41..c3b47557b3f2 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -629,7 +629,7 @@ static struct spi_board_info tsc2046_board_info[] __i=
nitdata =3D {
 	},
 };
=20
-static struct pxa2xx_spi_master pxa_ssp2_master_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp2_master_info =3D {
 	.num_chipselect =3D 1,
 	.enable_dma     =3D 1,
 };
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index cbaf4f6edcda..7e30452e3840 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -115,12 +115,12 @@ static struct spi_board_info mcp251x_board_info[] =3D=
 {
 	}
 };
=20
-static struct pxa2xx_spi_master pxa_ssp3_spi_master_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp3_spi_master_info =3D {
 	.num_chipselect =3D 2,
 	.enable_dma     =3D 1
 };
=20
-static struct pxa2xx_spi_master pxa_ssp4_spi_master_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp4_spi_master_info =3D {
 	.num_chipselect =3D 2,
 	.enable_dma     =3D 1
 };
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.=
c
index 39db4898dc4a..464b8bd2bcb9 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -191,7 +191,7 @@ static inline void littleton_init_lcd(void) {};
 #endif /* CONFIG_FB_PXA || CONFIG_FB_PXA_MODULE */
=20
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static struct pxa2xx_spi_master littleton_spi_info =3D {
+static struct pxa2xx_spi_controller littleton_spi_info =3D {
 	.num_chipselect		=3D 1,
 };
=20
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index a1391e113ef4..c1bd0d544981 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -197,7 +197,7 @@ static struct platform_device sa1111_device =3D {
  * (to J5) and poking board registers (as done below).  Else it's only u=
seful
  * for the temperature sensors.
  */
-static struct pxa2xx_spi_master pxa_ssp_master_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp_master_info =3D {
 	.num_chipselect	=3D 1,
 };
=20
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 08b079653c3f..618bcff4cdc9 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -932,7 +932,7 @@ struct pxa2xx_spi_chip tsc2046_chip_info =3D {
 	.gpio_cs	=3D GPIO14_MAGICIAN_TSC2046_CS,
 };
=20
-static struct pxa2xx_spi_master magician_spi_info =3D {
+static struct pxa2xx_spi_controller magician_spi_info =3D {
 	.num_chipselect	=3D 1,
 	.enable_dma	=3D 1,
 };
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index ccca9f7575c3..e2e613449660 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -132,7 +132,7 @@ static struct platform_device smc91x_device =3D {
 /*
  * SPI host and devices
  */
-static struct pxa2xx_spi_master pxa_ssp_master_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp_master_info =3D {
 	.num_chipselect	=3D 1,
 };
=20
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index c2a43d4cfd3e..9450a523cd0b 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -196,7 +196,7 @@ struct platform_device poodle_locomo_device =3D {
 EXPORT_SYMBOL(poodle_locomo_device);
=20
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static struct pxa2xx_spi_master poodle_spi_info =3D {
+static struct pxa2xx_spi_controller poodle_spi_info =3D {
 	.num_chipselect	=3D 1,
 };
=20
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 306818e2cf54..8dac824a85df 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -572,7 +572,7 @@ static struct spi_board_info spitz_spi_devices[] =3D =
{
 	},
 };
=20
-static struct pxa2xx_spi_master spitz_spi_info =3D {
+static struct pxa2xx_spi_controller spitz_spi_info =3D {
 	.num_chipselect	=3D 3,
 };
=20
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.=
c
index e0d6c872270a..c28d19b126a7 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -337,15 +337,15 @@ static struct platform_device stargate2_flash_devic=
e =3D {
 	.num_resources =3D 1,
 };
=20
-static struct pxa2xx_spi_master pxa_ssp_master_0_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp_master_0_info =3D {
 	.num_chipselect =3D 1,
 };
=20
-static struct pxa2xx_spi_master pxa_ssp_master_1_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp_master_1_info =3D {
 	.num_chipselect =3D 1,
 };
=20
-static struct pxa2xx_spi_master pxa_ssp_master_2_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp_master_2_info =3D {
 	.num_chipselect =3D 1,
 };
=20
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index e8a93c088c35..7439798d58e4 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -813,7 +813,7 @@ static struct platform_device tosa_bt_device =3D {
 	.dev.platform_data =3D &tosa_bt_data,
 };
=20
-static struct pxa2xx_spi_master pxa_ssp_master_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp_master_info =3D {
 	.num_chipselect	=3D 1,
 };
=20
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index e2353e75bb28..ad082e11e2a4 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -607,12 +607,12 @@ static struct spi_board_info spi_board_info[] __ini=
tdata =3D {
 },
 };
=20
-static struct pxa2xx_spi_master pxa_ssp1_master_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp1_master_info =3D {
 	.num_chipselect	=3D 1,
 	.enable_dma	=3D 1,
 };
=20
-static struct pxa2xx_spi_master pxa_ssp2_master_info =3D {
+static struct pxa2xx_spi_controller pxa_ssp2_master_info =3D {
 	.num_chipselect	=3D 1,
 };
=20
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index c411f79d4cb5..bdbcf46595f9 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -391,7 +391,7 @@ static struct platform_device zeus_sram_device =3D {
 };
=20
 /* SPI interface on SSP3 */
-static struct pxa2xx_spi_master pxa2xx_spi_ssp3_master_info =3D {
+static struct pxa2xx_spi_controller pxa2xx_spi_ssp3_master_info =3D {
 	.num_chipselect =3D 1,
 	.enable_dma     =3D 1,
 };
diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 2fa7f4b43492..15592598273e 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -23,7 +23,7 @@
 static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_dat=
a,
 					     bool error)
 {
-	struct spi_message *msg =3D drv_data->master->cur_msg;
+	struct spi_message *msg =3D drv_data->controller->cur_msg;
=20
 	/*
 	 * It is possible that one CPU is handling ROR interrupt and other
@@ -59,7 +59,7 @@ static void pxa2xx_spi_dma_transfer_complete(struct dri=
ver_data *drv_data,
 			msg->status =3D -EIO;
 		}
=20
-		spi_finalize_current_transfer(drv_data->master);
+		spi_finalize_current_transfer(drv_data->controller);
 	}
 }
=20
@@ -74,7 +74,7 @@ pxa2xx_spi_dma_prepare_one(struct driver_data *drv_data=
,
 			   struct spi_transfer *xfer)
 {
 	struct chip_data *chip =3D
-		spi_get_ctldata(drv_data->master->cur_msg->spi);
+		spi_get_ctldata(drv_data->controller->cur_msg->spi);
 	enum dma_slave_buswidth width;
 	struct dma_slave_config cfg;
 	struct dma_chan *chan;
@@ -102,14 +102,14 @@ pxa2xx_spi_dma_prepare_one(struct driver_data *drv_=
data,
 		cfg.dst_maxburst =3D chip->dma_burst_size;
=20
 		sgt =3D &xfer->tx_sg;
-		chan =3D drv_data->master->dma_tx;
+		chan =3D drv_data->controller->dma_tx;
 	} else {
 		cfg.src_addr =3D drv_data->ssdr_physical;
 		cfg.src_addr_width =3D width;
 		cfg.src_maxburst =3D chip->dma_burst_size;
=20
 		sgt =3D &xfer->rx_sg;
-		chan =3D drv_data->master->dma_rx;
+		chan =3D drv_data->controller->dma_rx;
 	}
=20
 	ret =3D dmaengine_slave_config(chan, &cfg);
@@ -130,8 +130,8 @@ irqreturn_t pxa2xx_spi_dma_transfer(struct driver_dat=
a *drv_data)
 	if (status & SSSR_ROR) {
 		dev_err(&drv_data->pdev->dev, "FIFO overrun\n");
=20
-		dmaengine_terminate_async(drv_data->master->dma_rx);
-		dmaengine_terminate_async(drv_data->master->dma_tx);
+		dmaengine_terminate_async(drv_data->controller->dma_rx);
+		dmaengine_terminate_async(drv_data->controller->dma_tx);
=20
 		pxa2xx_spi_dma_transfer_complete(drv_data, true);
 		return IRQ_HANDLED;
@@ -171,15 +171,15 @@ int pxa2xx_spi_dma_prepare(struct driver_data *drv_=
data,
 	return 0;
=20
 err_rx:
-	dmaengine_terminate_async(drv_data->master->dma_tx);
+	dmaengine_terminate_async(drv_data->controller->dma_tx);
 err_tx:
 	return err;
 }
=20
 void pxa2xx_spi_dma_start(struct driver_data *drv_data)
 {
-	dma_async_issue_pending(drv_data->master->dma_rx);
-	dma_async_issue_pending(drv_data->master->dma_tx);
+	dma_async_issue_pending(drv_data->controller->dma_rx);
+	dma_async_issue_pending(drv_data->controller->dma_tx);
=20
 	atomic_set(&drv_data->dma_running, 1);
 }
@@ -187,30 +187,30 @@ void pxa2xx_spi_dma_start(struct driver_data *drv_d=
ata)
 void pxa2xx_spi_dma_stop(struct driver_data *drv_data)
 {
 	atomic_set(&drv_data->dma_running, 0);
-	dmaengine_terminate_sync(drv_data->master->dma_rx);
-	dmaengine_terminate_sync(drv_data->master->dma_tx);
+	dmaengine_terminate_sync(drv_data->controller->dma_rx);
+	dmaengine_terminate_sync(drv_data->controller->dma_tx);
 }
=20
 int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 {
-	struct pxa2xx_spi_master *pdata =3D drv_data->master_info;
+	struct pxa2xx_spi_controller *pdata =3D drv_data->controller_info;
 	struct device *dev =3D &drv_data->pdev->dev;
-	struct spi_controller *master =3D drv_data->master;
+	struct spi_controller *controller =3D drv_data->controller;
 	dma_cap_mask_t mask;
=20
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
=20
-	master->dma_tx =3D dma_request_slave_channel_compat(mask,
+	controller->dma_tx =3D dma_request_slave_channel_compat(mask,
 				pdata->dma_filter, pdata->tx_param, dev, "tx");
-	if (!master->dma_tx)
+	if (!controller->dma_tx)
 		return -ENODEV;
=20
-	master->dma_rx =3D dma_request_slave_channel_compat(mask,
+	controller->dma_rx =3D dma_request_slave_channel_compat(mask,
 				pdata->dma_filter, pdata->rx_param, dev, "rx");
-	if (!master->dma_rx) {
-		dma_release_channel(master->dma_tx);
-		master->dma_tx =3D NULL;
+	if (!controller->dma_rx) {
+		dma_release_channel(controller->dma_tx);
+		controller->dma_tx =3D NULL;
 		return -ENODEV;
 	}
=20
@@ -219,17 +219,17 @@ int pxa2xx_spi_dma_setup(struct driver_data *drv_da=
ta)
=20
 void pxa2xx_spi_dma_release(struct driver_data *drv_data)
 {
-	struct spi_controller *master =3D drv_data->master;
+	struct spi_controller *controller =3D drv_data->controller;
=20
-	if (master->dma_rx) {
-		dmaengine_terminate_sync(master->dma_rx);
-		dma_release_channel(master->dma_rx);
-		master->dma_rx =3D NULL;
+	if (controller->dma_rx) {
+		dmaengine_terminate_sync(controller->dma_rx);
+		dma_release_channel(controller->dma_rx);
+		controller->dma_rx =3D NULL;
 	}
-	if (master->dma_tx) {
-		dmaengine_terminate_sync(master->dma_tx);
-		dma_release_channel(master->dma_tx);
-		master->dma_tx =3D NULL;
+	if (controller->dma_tx) {
+		dmaengine_terminate_sync(controller->dma_tx);
+		dma_release_channel(controller->dma_tx);
+		controller->dma_tx =3D NULL;
 	}
 }
=20
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 869f188b02eb..1727fdfbac28 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -197,7 +197,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	struct platform_device_info pi;
 	int ret;
 	struct platform_device *pdev;
-	struct pxa2xx_spi_master spi_pdata;
+	struct pxa2xx_spi_controller spi_pdata;
 	struct ssp_device *ssp;
 	struct pxa_spi_info *c;
 	char buf[40];
@@ -265,7 +265,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
 {
 	struct platform_device *pdev =3D pci_get_drvdata(dev);
-	struct pxa2xx_spi_master *spi_pdata;
+	struct pxa2xx_spi_controller *spi_pdata;
=20
 	spi_pdata =3D dev_get_platdata(&pdev->dev);
=20
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d84b893a64d7..69e874a2ad1e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -328,7 +328,7 @@ static void lpss_ssp_setup(struct driver_data *drv_da=
ta)
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
=20
 	/* Enable multiblock DMA transfers */
-	if (drv_data->master_info->enable_dma) {
+	if (drv_data->controller_info->enable_dma) {
 		__lpss_ssp_write_priv(drv_data, config->reg_ssp, 1);
=20
 		if (config->reg_general >=3D 0) {
@@ -368,7 +368,7 @@ static void lpss_ssp_select_cs(struct spi_device *spi=
,
 		__lpss_ssp_write_priv(drv_data,
 				      config->reg_cs_ctrl, value);
 		ndelay(1000000000 /
-		       (drv_data->master->max_speed_hz / 2));
+		       (drv_data->controller->max_speed_hz / 2));
 	}
 }
=20
@@ -567,7 +567,7 @@ static int u32_reader(struct driver_data *drv_data)
 static void reset_sccr1(struct driver_data *drv_data)
 {
 	struct chip_data *chip =3D
-		spi_get_ctldata(drv_data->master->cur_msg->spi);
+		spi_get_ctldata(drv_data->controller->cur_msg->spi);
 	u32 sccr1_reg;
=20
 	sccr1_reg =3D pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1;
@@ -599,8 +599,8 @@ static void int_error_stop(struct driver_data *drv_da=
ta, const char* msg)
=20
 	dev_err(&drv_data->pdev->dev, "%s\n", msg);
=20
-	drv_data->master->cur_msg->status =3D -EIO;
-	spi_finalize_current_transfer(drv_data->master);
+	drv_data->controller->cur_msg->status =3D -EIO;
+	spi_finalize_current_transfer(drv_data->controller);
 }
=20
 static void int_transfer_complete(struct driver_data *drv_data)
@@ -611,7 +611,7 @@ static void int_transfer_complete(struct driver_data =
*drv_data)
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, 0);
=20
-	spi_finalize_current_transfer(drv_data->master);
+	spi_finalize_current_transfer(drv_data->controller);
 }
=20
 static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
@@ -747,7 +747,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
=20
-	if (!drv_data->master->cur_msg) {
+	if (!drv_data->controller->cur_msg) {
 		handle_bad_msg(drv_data);
 		/* Never fail */
 		return IRQ_HANDLED;
@@ -879,7 +879,7 @@ static unsigned int quark_x1000_get_clk_div(int rate,=
 u32 *dds)
=20
 static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int ra=
te)
 {
-	unsigned long ssp_clk =3D drv_data->master->max_speed_hz;
+	unsigned long ssp_clk =3D drv_data->controller->max_speed_hz;
 	const struct ssp_device *ssp =3D drv_data->ssp;
=20
 	rate =3D min_t(int, ssp_clk, rate);
@@ -894,7 +894,7 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct dri=
ver_data *drv_data,
 					   int rate)
 {
 	struct chip_data *chip =3D
-		spi_get_ctldata(drv_data->master->cur_msg->spi);
+		spi_get_ctldata(drv_data->controller->cur_msg->spi);
 	unsigned int clk_div;
=20
 	switch (drv_data->ssp_type) {
@@ -908,7 +908,7 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct dri=
ver_data *drv_data,
 	return clk_div << 8;
 }
=20
-static bool pxa2xx_spi_can_dma(struct spi_controller *master,
+static bool pxa2xx_spi_can_dma(struct spi_controller *controller,
 			       struct spi_device *spi,
 			       struct spi_transfer *xfer)
 {
@@ -919,12 +919,12 @@ static bool pxa2xx_spi_can_dma(struct spi_controlle=
r *master,
 	       xfer->len >=3D chip->dma_burst_size;
 }
=20
-static int pxa2xx_spi_transfer_one(struct spi_controller *master,
+static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 				   struct spi_device *spi,
 				   struct spi_transfer *transfer)
 {
-	struct driver_data *drv_data =3D spi_controller_get_devdata(master);
-	struct spi_message *message =3D master->cur_msg;
+	struct driver_data *drv_data =3D spi_controller_get_devdata(controller)=
;
+	struct spi_message *message =3D controller->cur_msg;
 	struct chip_data *chip =3D spi_get_ctldata(message->spi);
 	u32 dma_thresh =3D chip->dma_threshold;
 	u32 dma_burst =3D chip->dma_burst_size;
@@ -1006,9 +1006,9 @@ static int pxa2xx_spi_transfer_one(struct spi_contr=
oller *master,
 					     "DMA burst size reduced to match bits_per_word\n");
 	}
=20
-	dma_mapped =3D master->can_dma &&
-		     master->can_dma(master, message->spi, transfer) &&
-		     master->cur_msg_mapped;
+	dma_mapped =3D controller->can_dma &&
+		     controller->can_dma(controller, message->spi, transfer) &&
+		     controller->cur_msg_mapped;
 	if (dma_mapped) {
=20
 		/* Ensure we have the correct interrupt handler */
@@ -1036,12 +1036,12 @@ static int pxa2xx_spi_transfer_one(struct spi_con=
troller *master,
 	cr0 =3D pxa2xx_configure_sscr0(drv_data, clk_div, bits);
 	if (!pxa25x_ssp_comp(drv_data))
 		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
-			master->max_speed_hz
+			controller->max_speed_hz
 				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
 			dma_mapped ? "DMA" : "PIO");
 	else
 		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
-			master->max_speed_hz / 2
+			controller->max_speed_hz / 2
 				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
 			dma_mapped ? "DMA" : "PIO");
=20
@@ -1092,7 +1092,7 @@ static int pxa2xx_spi_transfer_one(struct spi_contr=
oller *master,
 		}
 	}
=20
-	if (spi_controller_is_slave(master)) {
+	if (spi_controller_is_slave(controller)) {
 		while (drv_data->write(drv_data))
 			;
 		if (drv_data->gpiod_ready) {
@@ -1111,9 +1111,9 @@ static int pxa2xx_spi_transfer_one(struct spi_contr=
oller *master,
 	return 1;
 }
=20
-static int pxa2xx_spi_slave_abort(struct spi_master *master)
+static int pxa2xx_spi_slave_abort(struct spi_controller *controller)
 {
-	struct driver_data *drv_data =3D spi_controller_get_devdata(master);
+	struct driver_data *drv_data =3D spi_controller_get_devdata(controller)=
;
=20
 	/* Stop and reset SSP */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
@@ -1126,16 +1126,16 @@ static int pxa2xx_spi_slave_abort(struct spi_mast=
er *master)
=20
 	dev_dbg(&drv_data->pdev->dev, "transfer aborted\n");
=20
-	drv_data->master->cur_msg->status =3D -EINTR;
-	spi_finalize_current_transfer(drv_data->master);
+	drv_data->controller->cur_msg->status =3D -EINTR;
+	spi_finalize_current_transfer(drv_data->controller);
=20
 	return 0;
 }
=20
-static void pxa2xx_spi_handle_err(struct spi_controller *master,
+static void pxa2xx_spi_handle_err(struct spi_controller *controller,
 				 struct spi_message *msg)
 {
-	struct driver_data *drv_data =3D spi_controller_get_devdata(master);
+	struct driver_data *drv_data =3D spi_controller_get_devdata(controller)=
;
=20
 	/* Disable the SSP */
 	pxa2xx_spi_write(drv_data, SSCR0,
@@ -1159,9 +1159,9 @@ static void pxa2xx_spi_handle_err(struct spi_contro=
ller *master,
 		pxa2xx_spi_dma_stop(drv_data);
 }
=20
-static int pxa2xx_spi_unprepare_transfer(struct spi_controller *master)
+static int pxa2xx_spi_unprepare_transfer(struct spi_controller *controll=
er)
 {
-	struct driver_data *drv_data =3D spi_controller_get_devdata(master);
+	struct driver_data *drv_data =3D spi_controller_get_devdata(controller)=
;
=20
 	/* Disable the SSP now */
 	pxa2xx_spi_write(drv_data, SSCR0,
@@ -1260,7 +1260,7 @@ static int setup(struct spi_device *spi)
 		break;
 	default:
 		tx_hi_thres =3D 0;
-		if (spi_controller_is_slave(drv_data->master)) {
+		if (spi_controller_is_slave(drv_data->controller)) {
 			tx_thres =3D 1;
 			rx_thres =3D 2;
 		} else {
@@ -1287,7 +1287,7 @@ static int setup(struct spi_device *spi)
=20
 			chip->frm =3D spi->chip_select;
 		}
-		chip->enable_dma =3D drv_data->master_info->enable_dma;
+		chip->enable_dma =3D drv_data->controller_info->enable_dma;
 		chip->timeout =3D TIMOUT_DFLT;
 	}
=20
@@ -1310,7 +1310,7 @@ static int setup(struct spi_device *spi)
 		if (chip_info->enable_loopback)
 			chip->cr1 =3D SSCR1_LBM;
 	}
-	if (spi_controller_is_slave(drv_data->master)) {
+	if (spi_controller_is_slave(drv_data->controller)) {
 		chip->cr1 |=3D SSCR1_SCFR;
 		chip->cr1 |=3D SSCR1_SCLKDIR;
 		chip->cr1 |=3D SSCR1_SFRMDIR;
@@ -1497,10 +1497,10 @@ static bool pxa2xx_spi_idma_filter(struct dma_cha=
n *chan, void *param)
=20
 #endif /* CONFIG_PCI */
=20
-static struct pxa2xx_spi_master *
+static struct pxa2xx_spi_controller *
 pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
-	struct pxa2xx_spi_master *pdata;
+	struct pxa2xx_spi_controller *pdata;
 	struct acpi_device *adev;
 	struct ssp_device *ssp;
 	struct resource *res;
@@ -1568,10 +1568,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pde=
v)
 	return pdata;
 }
=20
-static int pxa2xx_spi_fw_translate_cs(struct spi_controller *master,
+static int pxa2xx_spi_fw_translate_cs(struct spi_controller *controller,
 				      unsigned int cs)
 {
-	struct driver_data *drv_data =3D spi_controller_get_devdata(master);
+	struct driver_data *drv_data =3D spi_controller_get_devdata(controller)=
;
=20
 	if (has_acpi_companion(&drv_data->pdev->dev)) {
 		switch (drv_data->ssp_type) {
@@ -1595,8 +1595,8 @@ static int pxa2xx_spi_fw_translate_cs(struct spi_co=
ntroller *master,
 static int pxa2xx_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
-	struct pxa2xx_spi_master *platform_info;
-	struct spi_controller *master;
+	struct pxa2xx_spi_controller *platform_info;
+	struct spi_controller *controller;
 	struct driver_data *drv_data;
 	struct ssp_device *ssp;
 	const struct lpss_config *config;
@@ -1622,37 +1622,37 @@ static int pxa2xx_spi_probe(struct platform_devic=
e *pdev)
 	}
=20
 	if (platform_info->is_slave)
-		master =3D spi_alloc_slave(dev, sizeof(struct driver_data));
+		controller =3D spi_alloc_slave(dev, sizeof(struct driver_data));
 	else
-		master =3D spi_alloc_master(dev, sizeof(struct driver_data));
+		controller =3D spi_alloc_master(dev, sizeof(struct driver_data));
=20
-	if (!master) {
-		dev_err(&pdev->dev, "cannot alloc spi_master\n");
+	if (!controller) {
+		dev_err(&pdev->dev, "cannot alloc spi_controller\n");
 		pxa_ssp_free(ssp);
 		return -ENOMEM;
 	}
-	drv_data =3D spi_controller_get_devdata(master);
-	drv_data->master =3D master;
-	drv_data->master_info =3D platform_info;
+	drv_data =3D spi_controller_get_devdata(controller);
+	drv_data->controller =3D controller;
+	drv_data->controller_info =3D platform_info;
 	drv_data->pdev =3D pdev;
 	drv_data->ssp =3D ssp;
=20
-	master->dev.of_node =3D pdev->dev.of_node;
+	controller->dev.of_node =3D pdev->dev.of_node;
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
-
-	master->bus_num =3D ssp->port_id;
-	master->dma_alignment =3D DMA_ALIGNMENT;
-	master->cleanup =3D cleanup;
-	master->setup =3D setup;
-	master->set_cs =3D pxa2xx_spi_set_cs;
-	master->transfer_one =3D pxa2xx_spi_transfer_one;
-	master->slave_abort =3D pxa2xx_spi_slave_abort;
-	master->handle_err =3D pxa2xx_spi_handle_err;
-	master->unprepare_transfer_hardware =3D pxa2xx_spi_unprepare_transfer;
-	master->fw_translate_cs =3D pxa2xx_spi_fw_translate_cs;
-	master->auto_runtime_pm =3D true;
-	master->flags =3D SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
+	controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
+
+	controller->bus_num =3D ssp->port_id;
+	controller->dma_alignment =3D DMA_ALIGNMENT;
+	controller->cleanup =3D cleanup;
+	controller->setup =3D setup;
+	controller->set_cs =3D pxa2xx_spi_set_cs;
+	controller->transfer_one =3D pxa2xx_spi_transfer_one;
+	controller->slave_abort =3D pxa2xx_spi_slave_abort;
+	controller->handle_err =3D pxa2xx_spi_handle_err;
+	controller->unprepare_transfer_hardware =3D pxa2xx_spi_unprepare_transf=
er;
+	controller->fw_translate_cs =3D pxa2xx_spi_fw_translate_cs;
+	controller->auto_runtime_pm =3D true;
+	controller->flags =3D SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
=20
 	drv_data->ssp_type =3D ssp->type;
=20
@@ -1661,10 +1661,10 @@ static int pxa2xx_spi_probe(struct platform_devic=
e *pdev)
 	if (pxa25x_ssp_comp(drv_data)) {
 		switch (drv_data->ssp_type) {
 		case QUARK_X1000_SSP:
-			master->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 32);
+			controller->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 32);
 			break;
 		default:
-			master->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 16);
+			controller->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 16);
 			break;
 		}
=20
@@ -1673,7 +1673,7 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
 		drv_data->clear_sr =3D SSSR_ROR;
 		drv_data->mask_sr =3D SSSR_RFS | SSSR_TFS | SSSR_ROR;
 	} else {
-		master->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 32);
+		controller->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 32);
 		drv_data->int_cr1 =3D SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE;
 		drv_data->dma_cr1 =3D DEFAULT_DMA_CR1;
 		drv_data->clear_sr =3D SSSR_ROR | SSSR_TINT;
@@ -1685,7 +1685,7 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
 			drv_data);
 	if (status < 0) {
 		dev_err(&pdev->dev, "cannot get IRQ %d\n", ssp->irq);
-		goto out_error_master_alloc;
+		goto out_error_controller_alloc;
 	}
=20
 	/* Setup DMA if requested */
@@ -1695,7 +1695,7 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
 			dev_dbg(dev, "no DMA channels available, using PIO\n");
 			platform_info->enable_dma =3D false;
 		} else {
-			master->can_dma =3D pxa2xx_spi_can_dma;
+			controller->can_dma =3D pxa2xx_spi_can_dma;
 		}
 	}
=20
@@ -1704,7 +1704,7 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
 	if (status)
 		goto out_error_dma_irq_alloc;
=20
-	master->max_speed_hz =3D clk_get_rate(ssp->clk);
+	controller->max_speed_hz =3D clk_get_rate(ssp->clk);
=20
 	/* Load default SSP configuration */
 	pxa2xx_spi_write(drv_data, SSCR0, 0);
@@ -1727,7 +1727,7 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
 		break;
 	default:
=20
-		if (spi_controller_is_slave(master)) {
+		if (spi_controller_is_slave(controller)) {
 			tmp =3D SSCR1_SCFR |
 			      SSCR1_SCLKDIR |
 			      SSCR1_SFRMDIR |
@@ -1740,7 +1740,7 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
 		}
 		pxa2xx_spi_write(drv_data, SSCR1, tmp);
 		tmp =3D SSCR0_Motorola | SSCR0_DataSize(8);
-		if (!spi_controller_is_slave(master))
+		if (!spi_controller_is_slave(controller))
 			tmp |=3D SSCR0_SCR(2);
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
@@ -1765,24 +1765,24 @@ static int pxa2xx_spi_probe(struct platform_devic=
e *pdev)
 			platform_info->num_chipselect =3D config->cs_num;
 		}
 	}
-	master->num_chipselect =3D platform_info->num_chipselect;
+	controller->num_chipselect =3D platform_info->num_chipselect;
=20
 	count =3D gpiod_count(&pdev->dev, "cs");
 	if (count > 0) {
 		int i;
=20
-		master->num_chipselect =3D max_t(int, count,
-			master->num_chipselect);
+		controller->num_chipselect =3D max_t(int, count,
+			controller->num_chipselect);
=20
 		drv_data->cs_gpiods =3D devm_kcalloc(&pdev->dev,
-			master->num_chipselect, sizeof(struct gpio_desc *),
+			controller->num_chipselect, sizeof(struct gpio_desc *),
 			GFP_KERNEL);
 		if (!drv_data->cs_gpiods) {
 			status =3D -ENOMEM;
 			goto out_error_clock_enabled;
 		}
=20
-		for (i =3D 0; i < master->num_chipselect; i++) {
+		for (i =3D 0; i < controller->num_chipselect; i++) {
 			struct gpio_desc *gpiod;
=20
 			gpiod =3D devm_gpiod_get_index(dev, "cs", i, GPIOD_ASIS);
@@ -1815,9 +1815,9 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
=20
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
-	status =3D devm_spi_register_controller(&pdev->dev, master);
+	status =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (status !=3D 0) {
-		dev_err(&pdev->dev, "problem registering spi master\n");
+		dev_err(&pdev->dev, "problem registering spi controller\n");
 		goto out_error_clock_enabled;
 	}
=20
@@ -1832,8 +1832,8 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
 	pxa2xx_spi_dma_release(drv_data);
 	free_irq(ssp->irq, drv_data);
=20
-out_error_master_alloc:
-	spi_controller_put(master);
+out_error_controller_alloc:
+	spi_controller_put(controller);
 	pxa_ssp_free(ssp);
 	return status;
 }
@@ -1854,7 +1854,7 @@ static int pxa2xx_spi_remove(struct platform_device=
 *pdev)
 	clk_disable_unprepare(ssp->clk);
=20
 	/* Release DMA */
-	if (drv_data->master_info->enable_dma)
+	if (drv_data->controller_info->enable_dma)
 		pxa2xx_spi_dma_release(drv_data);
=20
 	pm_runtime_put_noidle(&pdev->dev);
@@ -1876,7 +1876,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	struct ssp_device *ssp =3D drv_data->ssp;
 	int status;
=20
-	status =3D spi_controller_suspend(drv_data->master);
+	status =3D spi_controller_suspend(drv_data->controller);
 	if (status !=3D 0)
 		return status;
 	pxa2xx_spi_write(drv_data, SSCR0, 0);
@@ -1901,7 +1901,7 @@ static int pxa2xx_spi_resume(struct device *dev)
 	}
=20
 	/* Start the queue running */
-	return spi_controller_resume(drv_data->master);
+	return spi_controller_resume(drv_data->controller);
 }
 #endif
=20
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 4e324da66ef7..aba777b4502d 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -31,10 +31,10 @@ struct driver_data {
=20
 	/* SPI framework hookup */
 	enum pxa_ssp_type ssp_type;
-	struct spi_controller *master;
+	struct spi_controller *controller;
=20
 	/* PXA hookup */
-	struct pxa2xx_spi_master *master_info;
+	struct pxa2xx_spi_controller *controller_info;
=20
 	/* SSP register addresses */
 	void __iomem *ioaddr;
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_sp=
i.h
index b0674e330ef6..c1c59473cef9 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -22,7 +22,7 @@
 struct dma_chan;
=20
 /* device.platform_data for SSP controller devices */
-struct pxa2xx_spi_master {
+struct pxa2xx_spi_controller {
 	u16 num_chipselect;
 	u8 enable_dma;
 	bool is_slave;
@@ -54,7 +54,7 @@ struct pxa2xx_spi_chip {
=20
 #include <linux/clk.h>
=20
-extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *i=
nfo);
+extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controlle=
r *info);
=20
 #endif
 #endif
--=20
2.20.1

