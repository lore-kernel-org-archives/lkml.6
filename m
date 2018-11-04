Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B94DECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EC0204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2u6bzzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EC0204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeKDXI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:08:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730973AbeKDXI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:08:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6BEA2086B;
        Sun,  4 Nov 2018 13:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339604;
        bh=luNda04Udmxo9Reep5B48uYk2zGOd9jxlTkRrbQpY8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2u6bzzLu1sQbM+/Lt/Wa0vDGEM2ZwYt5SgWH5fDZfc+Di62ZNvxpzcnLgUIJHhj2
         20NHMxw0aHkzGI55m2IewVZ/mfHHNv4watrICc0RSjsSUN87WzMyU7h+7LtInuV4iA
         ZlJvkYnLO3IEiSCI0i8MyrOoB3L5yfjTBuGAIsH4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 44/45] ARM: dts: imx6ull: keep IMX6UL_ prefix for signals on both i.MX6UL and i.MX6ULL
Date:   Sun,  4 Nov 2018 08:52:39 -0500
Message-Id: <20181104135240.88431-44-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135240.88431-1-sashal@kernel.org>
References: <20181104135240.88431-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

[ Upstream commit 31edaa6e7fd8143085a6a60c564447c07e76ed9f ]

Signals available on both i.MX6UL and i.MX6ULL should have the same name
because it is the case of all others common signals, it avoids to make
mistakes (use the wrong ones) and it makes writing device tree files
less complicated. For example:

imx6ul-imx6ull-board.dtsi:
 ...
 pinctrl_uart5: uart5grp {
	fsl,pins = <
		MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX   0x1b0b1
	 	MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX   0x1b0b1
 	 >;
 };

imx6ul-board.dts:
 #include <imx6ul.dtsi>
 #include <imx6ul-imx6ull-board.dtsi>
 ...

imx6ull-board.dts:
 #include <imx6ull.dtsi>
 #include <imx6ul-imx6ull-board.dtsi>
 ...

Without this patch, the imx6ull-board.dtb will use
MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX instead of
MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX and the uart5 will be
misconfigured.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6ull-pinfunc.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
index fdc46bb09cc1..3c12a6fb0b61 100644
--- a/arch/arm/boot/dts/imx6ull-pinfunc.h
+++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
@@ -14,14 +14,23 @@
  * The pin function ID is a tuple of
  * <mux_reg conf_reg input_reg mux_mode input_val>
  */
+/* signals common for i.MX6UL and i.MX6ULL */
+#undef MX6UL_PAD_UART5_TX_DATA__UART5_DTE_RX
+#define MX6UL_PAD_UART5_TX_DATA__UART5_DTE_RX                    0x00BC 0x0348 0x0644 0x0 0x6
+#undef MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX
+#define MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX                    0x00C0 0x034C 0x0644 0x0 0x7
+#undef MX6UL_PAD_ENET1_RX_EN__UART5_DCE_RTS
+#define MX6UL_PAD_ENET1_RX_EN__UART5_DCE_RTS                     0x00CC 0x0358 0x0640 0x1 0x5
+#undef MX6UL_PAD_ENET1_TX_DATA0__UART5_DTE_RTS
+#define MX6UL_PAD_ENET1_TX_DATA0__UART5_DTE_RTS                  0x00D0 0x035C 0x0640 0x1 0x6
+#undef MX6UL_PAD_CSI_DATA02__UART5_DCE_RTS
+#define MX6UL_PAD_CSI_DATA02__UART5_DCE_RTS                      0x01EC 0x0478 0x0640 0x8 0x7
+
+/* signals for i.MX6ULL only */
 #define MX6ULL_PAD_UART1_TX_DATA__UART5_DTE_RX                    0x0084 0x0310 0x0644 0x9 0x4
 #define MX6ULL_PAD_UART1_RX_DATA__UART5_DCE_RX                    0x0088 0x0314 0x0644 0x9 0x5
 #define MX6ULL_PAD_UART1_CTS_B__UART5_DCE_RTS                     0x008C 0x0318 0x0640 0x9 0x3
 #define MX6ULL_PAD_UART1_RTS_B__UART5_DTE_RTS                     0x0090 0x031C 0x0640 0x9 0x4
-#define MX6ULL_PAD_UART5_TX_DATA__UART5_DTE_RX                    0x00BC 0x0348 0x0644 0x0 0x6
-#define MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX                    0x00C0 0x034C 0x0644 0x0 0x7
-#define MX6ULL_PAD_ENET1_RX_EN__UART5_DCE_RTS                     0x00CC 0x0358 0x0640 0x1 0x5
-#define MX6ULL_PAD_ENET1_TX_DATA0__UART5_DTE_RTS                  0x00D0 0x035C 0x0640 0x1 0x6
 #define MX6ULL_PAD_ENET2_RX_DATA0__EPDC_SDDO08                    0x00E4 0x0370 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_DATA1__EPDC_SDDO09                    0x00E8 0x0374 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_EN__EPDC_SDDO10                       0x00EC 0x0378 0x0000 0x9 0x0
@@ -55,7 +64,6 @@
 #define MX6ULL_PAD_CSI_DATA00__ESAI_TX_HF_CLK                     0x01E4 0x0470 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA01__ESAI_RX_HF_CLK                     0x01E8 0x0474 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA02__ESAI_RX_FS                         0x01EC 0x0478 0x0000 0x9 0x0
-#define MX6ULL_PAD_CSI_DATA02__UART5_DCE_RTS                      0x01EC 0x0478 0x0640 0x8 0x7
 #define MX6ULL_PAD_CSI_DATA03__ESAI_RX_CLK                        0x01F0 0x047C 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA04__ESAI_TX_FS                         0x01F4 0x0480 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA05__ESAI_TX_CLK                        0x01F8 0x0484 0x0000 0x9 0x0
-- 
2.17.1

