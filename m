Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257CAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA51B20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rp2Uxdf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA51B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeHaSJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:09:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36374 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbeHaSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:09:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id j192-v6so5485702wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X0xVA0TCt7wBSet/Kqt22Pwihkmvcl6u+Lwi5by2s5w=;
        b=Rp2Uxdf7wG/dFXmBWzDJxRLQu3c7Gc6Vkv+fOQLHThgsJRukc0jLheov4T0dsQiPd7
         1XEOpL24OF3plBW7xKNtYtBotm/YMJWn+sn3Rr7DMM0LdYeDbMRa85R8H6gqxcwjXRGa
         in75crreXWWbwst6hwR+WNmneUrTMoLeypyrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X0xVA0TCt7wBSet/Kqt22Pwihkmvcl6u+Lwi5by2s5w=;
        b=gCKl2iEVy2jBLc1c5j0sl6ISB1C8bfk+4krIqRgX9XPhQhLy/jwo4t05Y27zvuB+Nc
         hrHC0qdW2n54JuHIhSWj1DbvT5EbZK+zrJ4/bhowhbDIwxm3Z/bwykqNO5hPFyN6g8Kr
         qmlaIAhB3RA4Y453G/MWSfNoYnnnkz/rC09M5VC+l/upW3Xvyi1EygLesUpX5vvSzdqf
         IwmosSiSStCegVyn1dTU5Cae2sLtpk2Osu/P00x6+i9uaUslpoEIX/8JNx7oDfmb8T3t
         IbKUR7FMaTvW7msh14YDrbXtS6r5yt7p1651hHcsTp0VRTJMMwl6KpBbrEUudXXbMIFq
         KrrA==
X-Gm-Message-State: APzg51BSe06PvFcX1slcfzbVVLzsRFKf/rPiFV2ghqHev3JDoAM07Z/T
        RRaS1rWDYtLxFRgVpTg/0uIntQ==
X-Google-Smtp-Source: ANB0VdYL0KAog2LQlu/+OkDH0tn8jUF7HeMUnkgn6pvMONyc4OcuZHUnMohVBuPMnB3Bv9CDaoZeVg==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74-v6mr5254514wmg.123.1535724125974;
        Fri, 31 Aug 2018 07:02:05 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id m68-v6sm8624513wmb.10.2018.08.31.07.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 07:02:05 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v9 6/8] dt-bindings: interconnect: Document qcom,msm8916 NoC bindings
Date:   Fri, 31 Aug 2018 17:01:49 +0300
Message-Id: <20180831140151.13972-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831140151.13972-1-georgi.djakov@linaro.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device-tree bindings of the Network-On-Chip interconnect
hardware found on Qualcomm msm8916 platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/qcom-msm8916.txt    | 41 ++++++++
 include/dt-bindings/interconnect/qcom.h       | 98 +++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
 create mode 100644 include/dt-bindings/interconnect/qcom.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt b/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
new file mode 100644
index 000000000000..744df51df4ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
@@ -0,0 +1,41 @@
+Qualcomm MSM8916 Network-On-Chip interconnect driver binding
+----------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+			"qcom,msm8916-bimc"
+			"qcom,msm8916-pnoc"
+			"qcom,msm8916-snoc"
+- #interconnect-cells : should contain 1
+- reg : shall contain base register location and length
+
+Optional properties :
+clocks : list of phandles and specifiers to all interconnect bus clocks
+clock-names : clock names should include both "bus_clk" and "bus_a_clk"
+
+Examples:
+
+		snoc: snoc@580000 {
+			compatible = "qcom,msm8916-snoc";
+			#interconnect-cells = <1>;
+			reg = <0x580000 0x14000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+		bimc: bimc@400000 {
+			compatible = "qcom,msm8916-bimc";
+			#interconnect-cells = <1>;
+			reg = <0x400000 0x62000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+		pnoc: pnoc@500000 {
+			compatible = "qcom,msm8916-pnoc";
+			#interconnect-cells = <1>;
+			reg = <0x500000 0x11000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
+				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+		};
diff --git a/include/dt-bindings/interconnect/qcom.h b/include/dt-bindings/interconnect/qcom.h
new file mode 100644
index 000000000000..48f944b30e5d
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm interconnect IDs
+ *
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_H
+
+#define BIMC_SNOC_MAS			1
+#define BIMC_SNOC_SLV			2
+#define MASTER_AMPSS_M0			3
+#define MASTER_BLSP_1			4
+#define MASTER_CRYPTO_CORE0		5
+#define MASTER_DEHR			6
+#define MASTER_GRAPHICS_3D		7
+#define MASTER_JPEG			8
+#define MASTER_LPASS			9
+#define MASTER_MDP_PORT0		10
+#define MASTER_QDSS_BAM			11
+#define MASTER_QDSS_ETR			12
+#define MASTER_SDCC_1			13
+#define MASTER_SDCC_2			14
+#define MASTER_SNOC_CFG			15
+#define MASTER_SPDM			16
+#define MASTER_TCU_0			17
+#define MASTER_TCU_1			18
+#define MASTER_USB_HS			19
+#define MASTER_VFE			20
+#define MASTER_VIDEO_P0			21
+#define PNOC_INT_0			22
+#define PNOC_INT_1			23
+#define PNOC_M_0			24
+#define PNOC_M_1			25
+#define PNOC_SLV_0			26
+#define PNOC_SLV_1			27
+#define PNOC_SLV_2			28
+#define PNOC_SLV_3			29
+#define PNOC_SLV_4			30
+#define PNOC_SLV_8			31
+#define PNOC_SLV_9			32
+#define PNOC_SNOC_MAS			33
+#define PNOC_SNOC_SLV			34
+#define SLAVE_AMPSS_L2			35
+#define SLAVE_BIMC_CFG			36
+#define SLAVE_BLSP_1			37
+#define SLAVE_BOOT_ROM			38
+#define SLAVE_CAMERA_CFG		39
+#define SLAVE_CATS_128			40
+#define SLAVE_CLK_CTL			41
+#define SLAVE_CRYPTO_0_CFG		42
+#define SLAVE_DEHR_CFG			43
+#define SLAVE_DISPLAY_CFG		44
+#define SLAVE_EBI_CH0			45
+#define SLAVE_GRAPHICS_3D_CFG		46
+#define SLAVE_IMEM_CFG			47
+#define SLAVE_LPASS			48
+#define SLAVE_MPM			49
+#define SLAVE_MSM_PDM			50
+#define SLAVE_MSM_TCSR			51
+#define SLAVE_MSS			52
+#define SLAVE_OCMEM_64			53
+#define SLAVE_PMIC_ARB			54
+#define SLAVE_PNOC_CFG			55
+#define SLAVE_PRNG			56
+#define SLAVE_QDSS_CFG			57
+#define SLAVE_QDSS_STM			58
+#define SLAVE_RBCPR_CFG			59
+#define SLAVE_RPM_MSG_RAM		60
+#define SLAVE_SDCC_1			61
+#define SLAVE_SDCC_4			62
+#define SLAVE_SECURITY			63
+#define SLAVE_SERVICE_SNOC		64
+#define SLAVE_SNOC_CFG			65
+#define SLAVE_SPDM			66
+#define SLAVE_SYSTEM_IMEM		67
+#define SLAVE_TLMM			68
+#define SLAVE_USB_HS			69
+#define SLAVE_VENUS_CFG			70
+#define SNOC_BIMC_0_MAS			71
+#define SNOC_BIMC_0_SLV			72
+#define SNOC_BIMC_1_MAS			73
+#define SNOC_BIMC_1_SLV			74
+#define SNOC_INT_0			75
+#define SNOC_INT_1			76
+#define SNOC_INT_BIMC			77
+#define SNOC_MM_INT_0			78
+#define SNOC_MM_INT_1			79
+#define SNOC_MM_INT_2			80
+#define SNOC_MM_INT_BIMC		81
+#define SNOC_PNOC_MAS			82
+#define SNOC_PNOC_SLV			83
+#define SNOC_QDSS_INT			84
+#define SYSTEM_SLAVE_FAB_APPS		85
+
+#endif
