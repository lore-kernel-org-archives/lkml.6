Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BD1C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24CE20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn89HzmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24CE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeK0Rro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbeK0Rro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:47:44 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC5A720873;
        Tue, 27 Nov 2018 06:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543301452;
        bh=VtOtSY7bZLEn1TABMVBxv8ngRENN25VwFk8pfsORqnI=;
        h=From:To:Cc:Subject:Date:From;
        b=Cn89HzmN9nEPzX0AXsfct0kqIy3S65GmU/25Ho+juHU+R7L9d2QeziYGuwwNfTcye
         AXBXYYHr1NaSM8Y6o6UlWEWCz5SAHK1J9duCPaOchIbrEsado1das0sCJhwkuqS+1W
         PdFZP6braQZIyZUXlbYrK8To32S+R2yIdn0bjxnE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2] clk: qcom: Move to menuconfig and reduce lines
Date:   Mon, 26 Nov 2018 22:50:51 -0800
Message-Id: <20181127065051.54389-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
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

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Changes from v1:
 * Don't remove full depends on lines when they have something else

 drivers/clk/qcom/Kconfig | 43 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index a611531df115..cf1dec367192 100644
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
@@ -39,7 +39,7 @@ config QCOM_CLK_APCS_MSM8916
 
 config QCOM_CLK_RPM
 	tristate "RPM based Clock Controller"
-	depends on COMMON_CLK_QCOM && MFD_QCOM_RPM
+	depends on MFD_QCOM_RPM
 	select QCOM_RPMCC
 	help
 	  The RPM (Resource Power Manager) is a dedicated hardware engine for
@@ -52,7 +52,7 @@ config QCOM_CLK_RPM
 
 config QCOM_CLK_SMD_RPM
 	tristate "RPM over SMD based Clock Controller"
-	depends on COMMON_CLK_QCOM && QCOM_SMD_RPM
+	depends on QCOM_SMD_RPM
 	select QCOM_RPMCC
 	help
 	  The RPM (Resource Power Manager) is a dedicated hardware engine for
@@ -65,7 +65,7 @@ config QCOM_CLK_SMD_RPM
 
 config QCOM_CLK_RPMH
 	tristate "RPMh Clock Driver"
-	depends on COMMON_CLK_QCOM && QCOM_RPMH
+	depends on QCOM_RPMH
 	help
 	 RPMh manages shared resources on some Qualcomm Technologies, Inc.
 	 SoCs. It accepts requests from other hardware subsystems via RSC.
@@ -75,7 +75,6 @@ config QCOM_CLK_RPMH
 config APQ_GCC_8084
 	tristate "APQ8084 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on apq8084 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -85,7 +84,6 @@ config APQ_MMCC_8084
 	tristate "APQ8084 Multimedia Clock Controller"
 	select APQ_GCC_8084
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the multimedia clock controller on apq8084 devices.
 	  Say Y if you want to support multimedia devices such as display,
@@ -93,7 +91,6 @@ config APQ_MMCC_8084
 
 config IPQ_GCC_4019
 	tristate "IPQ4019 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on ipq4019 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -101,7 +98,6 @@ config IPQ_GCC_4019
 
 config IPQ_GCC_806X
 	tristate "IPQ806x Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on ipq806x devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -110,7 +106,6 @@ config IPQ_GCC_806X
 config IPQ_LCC_806X
 	tristate "IPQ806x LPASS Clock Controller"
 	select IPQ_GCC_806X
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the LPASS clock controller on ipq806x devices.
 	  Say Y if you want to use audio devices such as i2s, pcm,
@@ -118,7 +113,6 @@ config IPQ_LCC_806X
 
 config IPQ_GCC_8074
 	tristate "IPQ8074 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for global clock controller on ipq8074 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -127,7 +121,6 @@ config IPQ_GCC_8074
 
 config MSM_GCC_8660
 	tristate "MSM8660 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8660 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -136,7 +129,6 @@ config MSM_GCC_8660
 config MSM_GCC_8916
 	tristate "MSM8916 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8916 devices.
 	  Say Y if you want to use devices such as UART, SPI i2c, USB,
@@ -144,7 +136,6 @@ config MSM_GCC_8916
 
 config MSM_GCC_8960
 	tristate "APQ8064/MSM8960 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on apq8064/msm8960 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -153,7 +144,6 @@ config MSM_GCC_8960
 config MSM_LCC_8960
 	tristate "APQ8064/MSM8960 LPASS Clock Controller"
 	select MSM_GCC_8960
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the LPASS clock controller on apq8064/msm8960 devices.
 	  Say Y if you want to use audio devices such as i2s, pcm,
@@ -161,7 +151,6 @@ config MSM_LCC_8960
 
 config MDM_GCC_9615
 	tristate "MDM9615 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on mdm9615 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -170,7 +159,6 @@ config MDM_GCC_9615
 config MDM_LCC_9615
 	tristate "MDM9615 LPASS Clock Controller"
 	select MDM_GCC_9615
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the LPASS clock controller on mdm9615 devices.
 	  Say Y if you want to use audio devices such as i2s, pcm,
@@ -179,7 +167,6 @@ config MDM_LCC_9615
 config MSM_MMCC_8960
 	tristate "MSM8960 Multimedia Clock Controller"
 	select MSM_GCC_8960
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the multimedia clock controller on msm8960 devices.
 	  Say Y if you want to support multimedia devices such as display,
@@ -188,7 +175,6 @@ config MSM_MMCC_8960
 config MSM_GCC_8974
 	tristate "MSM8974 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8974 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -198,7 +184,6 @@ config MSM_MMCC_8974
 	tristate "MSM8974 Multimedia Clock Controller"
 	select MSM_GCC_8974
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the multimedia clock controller on msm8974 devices.
 	  Say Y if you want to support multimedia devices such as display,
@@ -206,7 +191,6 @@ config MSM_MMCC_8974
 
 config MSM_GCC_8994
 	tristate "MSM8994 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8994 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -215,7 +199,6 @@ config MSM_GCC_8994
 config MSM_GCC_8996
 	tristate "MSM8996 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8996 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -225,7 +208,6 @@ config MSM_MMCC_8996
 	tristate "MSM8996 Multimedia Clock Controller"
 	select MSM_GCC_8996
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the multimedia clock controller on msm8996 devices.
 	  Say Y if you want to support multimedia devices such as display,
@@ -233,7 +215,6 @@ config MSM_MMCC_8996
 
 config MSM_GCC_8998
 	tristate "MSM8998 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on msm8998 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -241,7 +222,6 @@ config MSM_GCC_8998
 
 config QCS_GCC_404
 	tristate "QCS404 Global Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on QCS404 devices.
 	  Say Y if you want to use multimedia devices or peripheral
@@ -249,7 +229,6 @@ config QCS_GCC_404
 
 config SDM_CAMCC_845
 	tristate "SDM845 Camera Clock Controller"
-	depends on COMMON_CLK_QCOM
 	select SDM_GCC_845
 	help
 	  Support for the camera clock controller on SDM845 devices.
@@ -258,7 +237,6 @@ config SDM_CAMCC_845
 config SDM_GCC_660
 	tristate "SDM660 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on SDM660 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -267,7 +245,6 @@ config SDM_GCC_660
 config SDM_GCC_845
 	tristate "SDM845 Global Clock Controller"
 	select QCOM_GDSC
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on SDM845 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -275,7 +252,6 @@ config SDM_GCC_845
 
 config SDM_VIDEOCC_845
 	tristate "SDM845 Video Clock Controller"
-	depends on COMMON_CLK_QCOM
 	select SDM_GCC_845
 	select QCOM_GDSC
 	help
@@ -286,7 +262,6 @@ config SDM_VIDEOCC_845
 config SDM_DISPCC_845
 	tristate "SDM845 Display Clock Controller"
 	select SDM_GCC_845
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
 	  SDM845 devices.
@@ -304,7 +279,6 @@ config SPMI_PMIC_CLKDIV
 
 config QCOM_HFPLL
 	tristate "High-Frequency PLL (HFPLL) Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the high-frequency PLLs present on Qualcomm devices.
 	  Say Y if you want to support CPU frequency scaling on devices
@@ -312,7 +286,6 @@ config QCOM_HFPLL
 
 config KPSS_XCC
 	tristate "KPSS Clock Controller"
-	depends on COMMON_CLK_QCOM
 	help
 	  Support for the Krait ACC and GCC clock controllers. Say Y
 	  if you want to support CPU frequency scaling on devices such
@@ -320,8 +293,10 @@ config KPSS_XCC
 
 config KRAITCC
 	tristate "Krait Clock Controller"
-	depends on COMMON_CLK_QCOM && ARM
+	depends on ARM
 	select KRAIT_CLOCKS
 	help
 	  Support for the Krait CPU clocks on Qualcomm devices.
 	  Say Y if you want to support CPU frequency scaling.
+
+endif
-- 
Sent by a computer through tubes

