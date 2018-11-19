Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582CAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2152C2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="poQQkpiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2152C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbeKTCz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbeKTCz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:55:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A4BA20870;
        Mon, 19 Nov 2018 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645111;
        bh=fa52zViYd9r+AWfuIW7N4o8GQQsbRRTtQAhuwmpmzpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=poQQkpiGWDwHR6SHXfYmAy8kKFvml5jJGUV6mrnZu+unU8pDot/5Z9P7XIJ2dfkf6
         P6RGp+5OfmllPHvLm2DHFjkFxiyisJYKI0bLzz2CJWpiAM/K/JRE8PuJrxVDvlbpUS
         nttBcIp36JzJcDo0ZaoYJiNP7dhA7xmp2TxufJ10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 040/205] ARM: dts: imx6ull: keep IMX6UL_ prefix for signals on both i.MX6UL and i.MX6ULL
Date:   Mon, 19 Nov 2018 17:25:47 +0100
Message-Id: <20181119162624.551378892@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/imx6ull-pinfunc.h |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

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


