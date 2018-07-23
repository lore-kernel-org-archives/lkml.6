Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A782DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601FC20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CffCcna6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601FC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbeGWLKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:10:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45178 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388443AbeGWLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:10:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so8648pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMrql5pChvk0l0OVuaoPU9zdtIybInbwoq7vsafDp1A=;
        b=CffCcna69M9mIBu8F3DaqT/aURH/Z9hNxoiO8RCU5b5PMlhWLQQv9L7Gj/38sQQDOk
         vV0cJJd9U86FHXvtVXrGW2SYs+E2vSneAIVEt3861zJg7ZDoOBdocwrX/WO3CdALndK2
         rDut3rYidECFgGwUPm3FDxbIXlz9eD+W/+dWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMrql5pChvk0l0OVuaoPU9zdtIybInbwoq7vsafDp1A=;
        b=PQr1rqPAhIgvR8Jn8K4npgON3VfP0HYdeL3jcA2eVvYzZ8i/Puv4Y22VSKx5CadSBp
         x/+kWkelNGB3HUrECo3f+z3Dn8YVNONCT0Pwb2LXRZt6Or8gFO6RjNWa4gRNjkeF8ET8
         69AnmS4ztJYquKwmVBrxAdwWrvIGaI8Ub5e/80N855YvvpOkQ6Je+cZqrgMCnckVuFdp
         HGUy6ERqfTrjnNOONYE5zsreDqWLPzO6HoC4eSeRwEDScnSsM8kMWvfp55iE0vIIKVHC
         9pNaF+kpGdJGtcRSFBZsvyl8QwRD22dTkkZH9THlyE46OkJqpR17CxSj22MJzhzWcEdJ
         tezg==
X-Gm-Message-State: AOUpUlGE+kYukaKZmkh7VopcmVBb+mG9ZxEgdciHuXIE+71luPeSF5bt
        sgNLyN57EFZRdxq8EnaTcyFuig==
X-Google-Smtp-Source: AAOMgpec4hlV4bTq1n8pNJGaof+3oRH5kf4zpHnn4kVEyZYg0l540MxeoCxAIM2lnvBnxBl1rBRJGA==
X-Received: by 2002:a62:3545:: with SMTP id c66-v6mr12569338pfa.63.1532340580981;
        Mon, 23 Jul 2018 03:09:40 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm13470698pfk.87.2018.07.23.03.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 03:09:40 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
Subject: [PATCH V4 7/7] dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller
Date:   Mon, 23 Jul 2018 18:08:28 +0800
Message-Id: <1532340508-8749-8-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
References: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

This patch adds the device-tree binding documentation for Spreadtrum
SDHCI driver.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 .../devicetree/bindings/mmc/sdhci-sprd.txt         | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
new file mode 100644
index 0000000..45c9978
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
@@ -0,0 +1,41 @@
+* Spreadtrum SDHCI controller (sdhci-sprd)
+
+The Secure Digital (SD) Host controller on Spreadtrum SoCs provides an interface
+for MMC, SD and SDIO types of cards.
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-sprd driver.
+
+Required properties:
+- compatible: Should contain "sprd,sdhci-r11".
+- reg: physical base address of the controller and length.
+- interrupts: Interrupts used by the SDHCI controller.
+- clocks: Should contain phandle for the clock feeding the SDHCI controller
+- clock-names: Should contain the following:
+	"sdio" - SDIO source clock (required)
+	"enable" - gate clock which used for enabling/disabling the device (required)
+
+Optional properties:
+- assigned-clocks: the same with "sdio" clock
+- assigned-clock-parents: the default parent of "sdio" clock
+
+Examples:
+
+sdio0: sdio@20600000 {
+	compatible  = "sprd,sdhci-r11";
+	reg = <0 0x20600000 0 0x1000>;
+	interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+
+	clock-names = "sdio", "enable";
+	clocks = <&ap_clk CLK_EMMC_2X>,
+		 <&apahb_gate CLK_EMMC_EB>;
+	assigned-clocks = <&ap_clk CLK_EMMC_2X>;
+	assigned-clock-parents = <&rpll CLK_RPLL_390M>;
+
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
-- 
2.7.4

