Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851BAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE332245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE332245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeKMUUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:20:34 -0500
Received: from shell.v3.sk ([90.176.6.54]:38266 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732176AbeKMUUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:20:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F1CFDC677C;
        Tue, 13 Nov 2018 11:23:03 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id x7MvGT_M0XLy; Tue, 13 Nov 2018 11:22:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 64B5AC6B61;
        Tue, 13 Nov 2018 11:22:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id re-KJ90Waj78; Tue, 13 Nov 2018 11:22:42 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 7132EC6AF3;
        Tue, 13 Nov 2018 11:22:41 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 3/6] spi: pxa2xx: Add slave mode support
Date:   Tue, 13 Nov 2018 11:22:25 +0100
Message-Id: <20181113102228.820214-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113102228.820214-1-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on an OLPC XO-1.75 machine, where the Embedded Controller happens
to be a SPI master.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/spi/spi-pxa2xx.c       | 81 +++++++++++++++++++++++++++++++---
 include/linux/spi/pxa2xx_spi.h |  1 +
 2 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 612cc49db28f..54ae77f1227c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -626,6 +626,11 @@ static irqreturn_t interrupt_transfer(struct driver_=
data *drv_data)
 		return IRQ_HANDLED;
 	}
=20
+	if (irq_status & SSSR_TUR) {
+		int_error_stop(drv_data, "interrupt_transfer: fifo underrun");
+		return IRQ_HANDLED;
+	}
+
 	if (irq_status & SSSR_TINT) {
 		pxa2xx_spi_write(drv_data, SSSR, SSSR_TINT);
 		if (drv_data->read(drv_data)) {
@@ -1073,6 +1078,11 @@ static int pxa2xx_spi_transfer_one(struct spi_cont=
roller *master,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
=20
+	if (spi_controller_is_slave(master)) {
+		while (drv_data->write(drv_data))
+			;
+	}
+
 	/*
 	 * Release the data by enabling service requests and interrupts,
 	 * without changing any mode bits
@@ -1082,6 +1092,27 @@ static int pxa2xx_spi_transfer_one(struct spi_cont=
roller *master,
 	return 1;
 }
=20
+static int pxa2xx_spi_slave_abort(struct spi_master *master)
+{
+	struct driver_data *drv_data =3D spi_controller_get_devdata(master);
+
+	/* Stop and reset SSP */
+	write_SSSR_CS(drv_data, drv_data->clear_sr);
+	reset_sccr1(drv_data);
+	if (!pxa25x_ssp_comp(drv_data))
+		pxa2xx_spi_write(drv_data, SSTO, 0);
+	pxa2xx_spi_flush(drv_data);
+	pxa2xx_spi_write(drv_data, SSCR0,
+			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+
+	dev_dbg(&drv_data->pdev->dev, "transfer aborted\n");
+
+	drv_data->master->cur_msg->status =3D -EINTR;
+	spi_finalize_current_transfer(drv_data->master);
+
+	return 0;
+}
+
 static void pxa2xx_spi_handle_err(struct spi_controller *master,
 				 struct spi_message *msg)
 {
@@ -1209,9 +1240,14 @@ static int setup(struct spi_device *spi)
 		rx_thres =3D config->rx_threshold;
 		break;
 	default:
-		tx_thres =3D TX_THRESH_DFLT;
 		tx_hi_thres =3D 0;
-		rx_thres =3D RX_THRESH_DFLT;
+		if (spi_controller_is_slave(drv_data->master)) {
+			tx_thres =3D 1;
+			rx_thres =3D 2;
+		} else {
+			tx_thres =3D TX_THRESH_DFLT;
+			rx_thres =3D RX_THRESH_DFLT;
+		}
 		break;
 	}
=20
@@ -1255,6 +1291,12 @@ static int setup(struct spi_device *spi)
 		if (chip_info->enable_loopback)
 			chip->cr1 =3D SSCR1_LBM;
 	}
+	if (spi_controller_is_slave(drv_data->master)) {
+		chip->cr1 |=3D SSCR1_SCFR;
+		chip->cr1 |=3D SSCR1_SCLKDIR;
+		chip->cr1 |=3D SSCR1_SFRMDIR;
+		chip->cr1 |=3D SSCR1_SPH;
+	}
=20
 	chip->lpss_rx_threshold =3D SSIRF_RxThresh(rx_thres);
 	chip->lpss_tx_threshold =3D SSITF_TxLoThresh(tx_thres)
@@ -1494,6 +1536,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev=
)
 	}
 #endif
=20
+#if CONFIG_OF
+	if (of_id) {
+		pdata->is_slave =3D of_property_read_bool(pdev->dev.of_node,
+								"spi-slave");
+	}
+#endif
+
 	ssp->clk =3D devm_clk_get(&pdev->dev, NULL);
 	ssp->irq =3D platform_get_irq(pdev, 0);
 	ssp->type =3D type;
@@ -1559,7 +1608,11 @@ static int pxa2xx_spi_probe(struct platform_device=
 *pdev)
 		return -ENODEV;
 	}
=20
-	master =3D spi_alloc_master(dev, sizeof(struct driver_data));
+	if (platform_info->is_slave)
+		master =3D spi_alloc_slave(dev, sizeof(struct driver_data));
+	else
+		master =3D spi_alloc_master(dev, sizeof(struct driver_data));
+
 	if (!master) {
 		dev_err(&pdev->dev, "cannot alloc spi_master\n");
 		pxa_ssp_free(ssp);
@@ -1581,6 +1634,7 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
 	master->setup =3D setup;
 	master->set_cs =3D pxa2xx_spi_set_cs;
 	master->transfer_one =3D pxa2xx_spi_transfer_one;
+	master->slave_abort =3D pxa2xx_spi_slave_abort;
 	master->handle_err =3D pxa2xx_spi_handle_err;
 	master->unprepare_transfer_hardware =3D pxa2xx_spi_unprepare_transfer;
 	master->fw_translate_cs =3D pxa2xx_spi_fw_translate_cs;
@@ -1610,7 +1664,8 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
 		drv_data->int_cr1 =3D SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE;
 		drv_data->dma_cr1 =3D DEFAULT_DMA_CR1;
 		drv_data->clear_sr =3D SSSR_ROR | SSSR_TINT;
-		drv_data->mask_sr =3D SSSR_TINT | SSSR_RFS | SSSR_TFS | SSSR_ROR;
+		drv_data->mask_sr =3D SSSR_TINT | SSSR_RFS | SSSR_TFS
+						| SSSR_ROR | SSSR_TUR;
 	}
=20
 	status =3D request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
@@ -1658,10 +1713,22 @@ static int pxa2xx_spi_probe(struct platform_devic=
e *pdev)
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
 	default:
-		tmp =3D SSCR1_RxTresh(RX_THRESH_DFLT) |
-		      SSCR1_TxTresh(TX_THRESH_DFLT);
+
+		if (spi_controller_is_slave(master)) {
+			tmp =3D SSCR1_SCFR |
+			      SSCR1_SCLKDIR |
+			      SSCR1_SFRMDIR |
+			      SSCR1_RxTresh(2) |
+			      SSCR1_TxTresh(1) |
+			      SSCR1_SPH;
+		} else {
+			tmp =3D SSCR1_RxTresh(RX_THRESH_DFLT) |
+			      SSCR1_TxTresh(TX_THRESH_DFLT);
+		}
 		pxa2xx_spi_write(drv_data, SSCR1, tmp);
-		tmp =3D SSCR0_SCR(2) | SSCR0_Motorola | SSCR0_DataSize(8);
+		tmp =3D SSCR0_Motorola | SSCR0_DataSize(8);
+		if (!spi_controller_is_slave(master))
+			tmp |=3D SSCR0_SCR(2);
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
 	}
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_sp=
i.h
index 9ec4c147abbc..b0674e330ef6 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -25,6 +25,7 @@ struct dma_chan;
 struct pxa2xx_spi_master {
 	u16 num_chipselect;
 	u8 enable_dma;
+	bool is_slave;
=20
 	/* DMA engine specific config */
 	bool (*dma_filter)(struct dma_chan *chan, void *param);
--=20
2.19.1

