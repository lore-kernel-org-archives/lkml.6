Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A49C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6992A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6992A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeLJTCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:02:02 -0500
Received: from verein.lst.de ([213.95.11.211]:50554 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeLJTCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:02:01 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2896B6732D; Mon, 10 Dec 2018 20:02:00 +0100 (CET)
Date:   Mon, 10 Dec 2018 20:02:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: dma_declare_coherent_memory on main memory
Message-ID: <20181210190159.GA30648@lst.de>
References: <20181207153432.GA24917@lst.de> <20181210072648.ore6xttedsgpndi4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210072648.ore6xttedsgpndi4@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 08:26:48AM +0100, Sascha Hauer wrote:
> > the ARM imx27/31 ports and various sh boards use
> > dma_declare_coherent_memory on main memory taken from the memblock
> > allocator.
> > 
> > Is there any good reason these couldn't be switched to CMA areas?
> > Getting rid of these magic dma_declare_coherent_memory area would
> > help making the dma allocator a lot simpler.
> 
> At least for i.MX27/31 I'd say this predates CMA support, so historical
> reasons.

Ok.  Do you still have test hardware for i.MX?  If so I'd love to see
if the patch below works.  Note that this is the brute force approach,
just having a global CMA pool might be a little more elegant.

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 8661dd9b064a..88852e7e5e7e 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -185,3 +185,5 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
+CONFIG_CMA=y
+CONFIG_DMA_CMA=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1ad5736c8fa6..16c8d717316c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -444,3 +444,5 @@ CONFIG_PROVE_LOCKING=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FTRACE is not set
 # CONFIG_ARM_UNWIND is not set
+CONFIG_CMA=y
+CONFIG_DMA_CMA=y
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 5169dfba9718..2339a50d5459 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cma.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
@@ -35,6 +36,7 @@
 #include <linux/platform_data/asoc-mx27vis.h>
 #include <media/soc_camera.h>
 #include <sound/tlv320aic32x4.h>
+#include <asm/dma-contiguous.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -245,6 +247,7 @@ static phys_addr_t mx2_camera_base __initdata;
 static void __init visstrim_analog_camera_init(void)
 {
 	struct platform_device *pdev;
+	struct cma *cma;
 
 	gpio_set_value(TVP5150_PWDN, 1);
 	ndelay(1);
@@ -257,9 +260,10 @@ static void __init visstrim_analog_camera_init(void)
 	if (IS_ERR(pdev))
 		return;
 
-	dma_declare_coherent_memory(&pdev->dev, mx2_camera_base,
-				    mx2_camera_base, MX2_CAMERA_BUF_SIZE,
-				    DMA_MEMORY_EXCLUSIVE);
+	if (cma_init_reserved_mem(mx2_camera_base, MX2_CAMERA_BUF_SIZE, 0,
+			"visstrim-cam", &cma))
+		return;
+	dma_contiguous_early_fixup(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
 }
 
 static void __init visstrim_reserve(void)
@@ -440,13 +444,16 @@ static const struct imx_ssi_platform_data visstrim_m10_ssi_pdata __initconst = {
 static void __init visstrim_coda_init(void)
 {
 	struct platform_device *pdev;
+	struct cma *cma;
 
 	pdev = imx27_add_coda();
-	dma_declare_coherent_memory(&pdev->dev,
-				    mx2_camera_base + MX2_CAMERA_BUF_SIZE,
-				    mx2_camera_base + MX2_CAMERA_BUF_SIZE,
-				    MX2_CAMERA_BUF_SIZE,
-				    DMA_MEMORY_EXCLUSIVE);
+	if (IS_ERR(pdev))
+		return;
+	if (cma_init_reserved_mem(mx2_camera_base + MX2_CAMERA_BUF_SIZE,
+			MX2_CAMERA_BUF_SIZE, 0, "visstrim-coda", &cma))
+		return;
+	dma_contiguous_early_fixup(mx2_camera_base + MX2_CAMERA_BUF_SIZE,
+			MX2_CAMERA_BUF_SIZE);
 }
 
 /* DMA deinterlace */
@@ -459,21 +466,22 @@ static void __init visstrim_deinterlace_init(void)
 {
 	int ret = -ENOMEM;
 	struct platform_device *pdev = &visstrim_deinterlace;
+	struct cma *cma;
 
 	ret = platform_device_register(pdev);
 
-	dma_declare_coherent_memory(&pdev->dev,
-				    mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
-				    mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
-				    MX2_CAMERA_BUF_SIZE,
-				    DMA_MEMORY_EXCLUSIVE);
+	if (cma_init_reserved_mem(mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
+			MX2_CAMERA_BUF_SIZE, 0, "visstrim-deinterlace", &cma))
+		return;
+	dma_contiguous_early_fixup(mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE,
+			MX2_CAMERA_BUF_SIZE);
 }
 
 /* Emma-PrP for format conversion */
 static void __init visstrim_emmaprp_init(void)
 {
 	struct platform_device *pdev;
-	int ret;
+	struct cma *cma;
 
 	pdev = imx27_add_mx2_emmaprp();
 	if (IS_ERR(pdev))
@@ -483,12 +491,12 @@ static void __init visstrim_emmaprp_init(void)
 	 * Use the same memory area as the analog camera since both
 	 * devices are, by nature, exclusive.
 	 */
-	ret = dma_declare_coherent_memory(&pdev->dev,
-				mx2_camera_base, mx2_camera_base,
-				MX2_CAMERA_BUF_SIZE,
-				DMA_MEMORY_EXCLUSIVE);
-	if (ret)
+	if (cma_init_reserved_mem(mx2_camera_base, MX2_CAMERA_BUF_SIZE, 0,
+			"visstrim-emmaprp", &cma)) {
 		pr_err("Failed to declare memory for emmaprp\n");
+		return;
+	}
+	dma_contiguous_early_fixup(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
 }
 
 /* Audio */
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 643a3d749703..1c0705ec0ccd 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/cma.h>
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
 #include <linux/gpio.h>
@@ -37,6 +38,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
+#include <asm/dma-contiguous.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -466,6 +468,7 @@ static int __init mx31moboard_init_cam(void)
 {
 	int ret;
 	struct platform_device *pdev;
+	struct cma *cma;
 
 	imx31_add_ipu_core();
 
@@ -473,18 +476,18 @@ static int __init mx31moboard_init_cam(void)
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
-	ret = dma_declare_coherent_memory(&pdev->dev,
-					  mx3_camera_base, mx3_camera_base,
-					  MX3_CAMERA_BUF_SIZE,
-					  DMA_MEMORY_EXCLUSIVE);
+	ret = cma_init_reserved_mem(mx3_camera_base, MX3_CAMERA_BUF_SIZE, 0,
+			"mx31cam", &cma);
 	if (ret)
-		goto err;
+		goto out_device_put;
+	dma_contiguous_early_fixup(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
 
 	ret = platform_device_add(pdev);
 	if (ret)
-err:
-		platform_device_put(pdev);
-
+		goto out_device_put;
+	return 0;
+out_device_put:
+	platform_device_put(pdev);
 	return ret;
 
 }
