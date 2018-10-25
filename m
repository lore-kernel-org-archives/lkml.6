Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AACFECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C8720873
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yXoyDUVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C8720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbeJYWwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbeJYWwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:43 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CA1120883;
        Thu, 25 Oct 2018 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477185;
        bh=D0Dh1yG3iOxNcNy3n2Cv0NQ5+h7zo4mXf05Az25dia4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yXoyDUVPGNJwlTFgUUPzY9vlXRJEvvxrdU5rxhWX3+ZO1t9rYNYTlelX/06tPVNJF
         FvCZk6TInIIVm0PYQ+a6lYpzsD0+L25tptNnM3uBx4s3vPnknMP0pSrHzUHKrxQvpQ
         HjOQFsdbxwtlz9/saxLUY1Xu00aqLGvNOq9zYMUo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 34/98] serial: samsung: Add the support for Exynos5433 SoC
Date:   Thu, 25 Oct 2018 10:17:49 -0400
Message-Id: <20181025141853.214051-34-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chanwoo Choi <cw00.choi@samsung.com>

[ Upstream commit 31ec77aca72ee5920ed3ec3d047734dc0bc43342 ]

This patch adds new s3c24xx_serial_drv_data structure for Exynos5433 SoC
because Exynos5433 has different fifo size from existing Exynos4 SoC.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/samsung.c | 56 +++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index ba59a76edc8b..957992ceba0a 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1785,32 +1785,43 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 #endif
 
 #if defined(CONFIG_ARCH_EXYNOS)
+#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
+	.info = &(struct s3c24xx_uart_info) {			\
+		.name		= "Samsung Exynos UART",	\
+		.type		= PORT_S3C6400,			\
+		.has_divslot	= 1,				\
+		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
+		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
+		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,	\
+		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,	\
+		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,	\
+		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,	\
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,		\
+		.num_clks	= 1,				\
+		.clksel_mask	= 0,				\
+		.clksel_shift	= 0,				\
+	},							\
+	.def_cfg = &(struct s3c2410_uartcfg) {			\
+		.ucon		= S5PV210_UCON_DEFAULT,		\
+		.ufcon		= S5PV210_UFCON_DEFAULT,	\
+		.has_fracval	= 1,				\
+	}							\
+
 static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
-	.info = &(struct s3c24xx_uart_info) {
-		.name		= "Samsung Exynos4 UART",
-		.type		= PORT_S3C6400,
-		.has_divslot	= 1,
-		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
-		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
-		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
-		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,
-		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,
-		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,
-		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
-		.num_clks	= 1,
-		.clksel_mask	= 0,
-		.clksel_shift	= 0,
-	},
-	.def_cfg = &(struct s3c2410_uartcfg) {
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT,
-		.has_fracval	= 1,
-	},
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
 	.fifosize = { 256, 64, 16, 16 },
 };
+
+static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
+	.fifosize = { 64, 256, 16, 256 },
+};
+
 #define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos4210_serial_drv_data)
+#define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos5433_serial_drv_data)
 #else
 #define EXYNOS4210_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define EXYNOS5433_SERIAL_DRV_DATA (kernel_ulong_t)NULL
 #endif
 
 static struct platform_device_id s3c24xx_serial_driver_ids[] = {
@@ -1832,6 +1843,9 @@ static struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	}, {
 		.name		= "exynos4210-uart",
 		.driver_data	= EXYNOS4210_SERIAL_DRV_DATA,
+	}, {
+		.name		= "exynos5433-uart",
+		.driver_data	= EXYNOS5433_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -1851,6 +1865,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 		.data = (void *)S5PV210_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos4210-uart",
 		.data = (void *)EXYNOS4210_SERIAL_DRV_DATA },
+	{ .compatible = "samsung,exynos5433-uart",
+		.data = (void *)EXYNOS5433_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
-- 
2.17.1

