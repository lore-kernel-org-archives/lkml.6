Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35801C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59C120645
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeOeL0uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59C120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbeKVHhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeKVHhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:37:22 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14A5820645;
        Wed, 21 Nov 2018 21:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542834083;
        bh=98QKv/cFE2YEIpS8pphhz7xBSxgdMnedf/yscpT1+e0=;
        h=From:To:Cc:Subject:Date:From;
        b=eeOeL0uZE7oqbvsgvdzglgS8gAtQLaPFpKaIaaeKws1A89aPddMJ+WHvpWCMwkVg0
         Y8CrIoT3bJW9AUocWLX+mqQ20eyJ0lmV0GsJB+GxwcBknpJXbviDAA3LqnOxT/8KO2
         oXbGux5DCFG5p/Fp88ytjYiYBRbZ0pQsIP68Y58c=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] clk: qcom: Move to menuconfig and reduce lines
Date:   Wed, 21 Nov 2018 13:01:22 -0800
Message-Id: <20181121210122.114859-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We duplicate the 'depends on' in almost every Kconfig here, and it's
getting out of hand now that we have tens of options for various SoC
drivers here. Let's clean it up a little by making a menuconfig for a
submenu and adding an if wrapper around the driver section.

Cc: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/Kconfig | 39 +++++----------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index a611531df115..1977f40f4bec 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -9,16 +9,17 @@ config QCOM_GDSC
 config QCOM_RPMCC
 	bool
 
-config COMMON_CLK_QCOM
+menuconfig COMMON_CLK_QCOM
 	tristate "Support for Qualcomm's clock controllers"
 	depends on OF
 	depends on ARCH_QCOM || COMPILE_TEST
 	select REGMAP_MMIO
 	select RESET_CONTROLLER
 
+if COMMON_CLK_QCOM
+
 config QCOM_A53PLL
 	tristate "MSM8916 A53 PLL"
-	depends on COMMON_CLK_QCOM
 	default ARCH_QCOM
 	help
 	  Support for the A53 PLL on MSM8916 devices. It provides
@@ -28,7 +29,6 @@ config QCOM_A53PLL
 
 config QCOM_CLK_APCS_MSM8916
 	tristate "MSM8916 APCS Clock Controller"
-	depends on COMMON_CLK_QCOM
 	depends on QCOM_APCS_IPC || COMPILE_TEST
 	default ARCH_QCOM
 	help
@@ -39,7 +39,6 @@ config QCOM_CLK_APCS_MSM8916
 
 config QCOM_CLK_RPM
 	tristate "RPM based Clock Controller"
-	depends on COMMON_CLK_QCOM && MFD_QCOM_RPM
 	select QCOM_RPMCC
 	help
 	  The RPM (Resource Power Manager) is a dedicated hardware engine for
@@ -52,7 +51,6 @@ config QCOM_CLK_RPM
 
 config QCOM_CLK_SMD_RPM
 	tristate "RPM over SMD based Clock Controller"
-	depends on COMMON_CLK_QCOM && QCOM_SMD_RPM
 	select QCOM_RPMCC
 	help
 	  The RPM (Resource Power Manager) is a dedicated hardware engine for
@@ -65,7 +63,6 @@ config QCOM_CLK_SMD_RPM
 
 config QCOM_CLK_RPMH
 	tristate "RPMh Clock Driver"
-	depends on COMMON_CLK_QCOM && QCOM_RPMH
 	help
 	 RPMh manages shared resources on some Qualcomm Technologies, Inc.
 	 SoCs. It accepts requests from other hardware subsystems via RSC.
@@ -75,7 +72,6 @@ config QCOM_CLK_RPMH
 config APQ_GCC_8084
 	tristate "APQ8084 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on apq8084 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -85,7 +81,6 @@ config APQ_MMCC_8084
 	tristate "APQ8084 Multimedia Clock Controller"
 	select APQ_GCC_8084
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the multimedia clock controller on apq8084 devices.
 	  Say Y if you want to support multimedia devices such as display,
@@ -93,7 +88,6 @@ config APQ_MMCC_8084
 
 config IPQ_GCC_4019
 	tristate "IPQ4019 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on ipq4019 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -101,7 +95,6 @@ config IPQ_GCC_4019
 
 config IPQ_GCC_806X
 	tristate "IPQ806x Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on ipq806x devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -110,7 +103,6 @@ config IPQ_GCC_806X
 config IPQ_LCC_806X
 	tristate "IPQ806x LPASS Clock Controller"
 	select IPQ_GCC_806X
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the LPASS clock controller on ipq806x devices.
 	  Say Y if you want to use audio devices such as i2s, pcm,
@@ -118,7 +110,6 @@ config IPQ_LCC_806X
 
 config IPQ_GCC_8074
 	tristate "IPQ8074 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for global clock controller on ipq8074 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -127,7 +118,6 @@ config IPQ_GCC_8074
 
 config MSM_GCC_8660
 	tristate "MSM8660 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8660 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -136,7 +126,6 @@ config MSM_GCC_8660
 config MSM_GCC_8916
 	tristate "MSM8916 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8916 devices.
 	  Say Y if you want to use devices such as UART, SPI i2c, USB,
@@ -144,7 +133,6 @@ config MSM_GCC_8916
 
 config MSM_GCC_8960
 	tristate "APQ8064/MSM8960 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on apq8064/msm8960 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -153,7 +141,6 @@ config MSM_GCC_8960
 config MSM_LCC_8960
 	tristate "APQ8064/MSM8960 LPASS Clock Controller"
 	select MSM_GCC_8960
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the LPASS clock controller on apq8064/msm8960 devices.
 	  Say Y if you want to use audio devices such as i2s, pcm,
@@ -161,7 +148,6 @@ config MSM_LCC_8960
 
 config MDM_GCC_9615
 	tristate "MDM9615 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on mdm9615 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -170,7 +156,6 @@ config MDM_GCC_9615
 config MDM_LCC_9615
 	tristate "MDM9615 LPASS Clock Controller"
 	select MDM_GCC_9615
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the LPASS clock controller on mdm9615 devices.
 	  Say Y if you want to use audio devices such as i2s, pcm,
@@ -179,7 +164,6 @@ config MDM_LCC_9615
 config MSM_MMCC_8960
 	tristate "MSM8960 Multimedia Clock Controller"
 	select MSM_GCC_8960
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the multimedia clock controller on msm8960 devices.
 	  Say Y if you want to support multimedia devices such as display,
@@ -188,7 +172,6 @@ config MSM_MMCC_8960
 config MSM_GCC_8974
 	tristate "MSM8974 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8974 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -198,7 +181,6 @@ config MSM_MMCC_8974
 	tristate "MSM8974 Multimedia Clock Controller"
 	select MSM_GCC_8974
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the multimedia clock controller on msm8974 devices.
 	  Say Y if you want to support multimedia devices such as display,
@@ -206,7 +188,6 @@ config MSM_MMCC_8974
 
 config MSM_GCC_8994
 	tristate "MSM8994 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8994 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -215,7 +196,6 @@ config MSM_GCC_8994
 config MSM_GCC_8996
 	tristate "MSM8996 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8996 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -225,7 +205,6 @@ config MSM_MMCC_8996
 	tristate "MSM8996 Multimedia Clock Controller"
 	select MSM_GCC_8996
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the multimedia clock controller on msm8996 devices.
 	  Say Y if you want to support multimedia devices such as display,
@@ -233,7 +212,6 @@ config MSM_MMCC_8996
 
 config MSM_GCC_8998
 	tristate "MSM8998 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8998 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -241,7 +219,6 @@ config MSM_GCC_8998
 
 config QCS_GCC_404
 	tristate "QCS404 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on QCS404 devices.
 	  Say Y if you want to use multimedia devices or peripheral
@@ -249,7 +226,6 @@ config QCS_GCC_404
 
 config SDM_CAMCC_845
 	tristate "SDM845 Camera Clock Controller"
-	depends on COMMON_CLK_QCOM
 	select SDM_GCC_845
 	help
 	  Support for the camera clock controller on SDM845 devices.
@@ -258,7 +234,6 @@ config SDM_CAMCC_845
 config SDM_GCC_660
 	tristate "SDM660 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on SDM660 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -267,7 +242,6 @@ config SDM_GCC_660
 config SDM_GCC_845
 	tristate "SDM845 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on SDM845 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -275,7 +249,6 @@ config SDM_GCC_845
 
 config SDM_VIDEOCC_845
 	tristate "SDM845 Video Clock Controller"
-	depends on COMMON_CLK_QCOM
 	select SDM_GCC_845
 	select QCOM_GDSC
 	help
@@ -286,7 +259,6 @@ config SDM_VIDEOCC_845
 config SDM_DISPCC_845
 	tristate "SDM845 Display Clock Controller"
 	select SDM_GCC_845
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
 	  SDM845 devices.
@@ -304,7 +276,6 @@ config SPMI_PMIC_CLKDIV
 
 config QCOM_HFPLL
 	tristate "High-Frequency PLL (HFPLL) Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the high-frequency PLLs present on Qualcomm devices.
 	  Say Y if you want to support CPU frequency scaling on devices
@@ -312,7 +283,6 @@ config QCOM_HFPLL
 
 config KPSS_XCC
 	tristate "KPSS Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the Krait ACC and GCC clock controllers. Say Y
 	  if you want to support CPU frequency scaling on devices such
@@ -320,8 +290,9 @@ config KPSS_XCC
 
 config KRAITCC
 	tristate "Krait Clock Controller"
-	depends on COMMON_CLK_QCOM && ARM
 	select KRAIT_CLOCKS
 	help
 	  Support for the Krait CPU clocks on Qualcomm devices.
 	  Say Y if you want to support CPU frequency scaling.
+
+endif
-- 
Sent by a computer through tubes

