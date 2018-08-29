Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9980EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C852086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jr7z9Xrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C852086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeH2K7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:59:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42646 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeH2K7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:59:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so1880652plq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/RXtHte8bNFCXLz2sWlB+/MjHMcewoMGpsLw3S8KcCM=;
        b=Jr7z9XrhU3HrcPk/AT/DjDvnFFmTvleGb0H/furxCuBSYyZzL7uKeWtLUYar+F4IIm
         Wrt2u60UvZF4n/jHJcSF2kmPpVoRuvu+KpbmsZeWZoPnrxTfLHtVhelmeOLNp4to8NNb
         2scOigqUNNicqcWV8Z83dAFah/7kyxkvoRmRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/RXtHte8bNFCXLz2sWlB+/MjHMcewoMGpsLw3S8KcCM=;
        b=ntuAL9LrX8NLPCLu1EG7qc9UdBWR7sDWlXv1q7GThCsyPuGT4XFYcazWicqShyVHAN
         WpaSnt5ZrJD0oCviHNibN+3b0YdizfbTYSyTlz14VVmLLKIk637MpiIQIcCBmO8SxxqM
         67Li2uA6JRR5ZNFA8yUYRIXyfr3gmgmOCYkhg5L3BRxo8OQNAS5LtoYYOpbTapVUqDb8
         w4dsiKlfN5lUIXfVaYfWhOK4uYDnj2RsGx/uTpZNBEIK4cyfMqZnznWPCgGQ23s1uOxy
         2h2x/zhysLE9qXfqS3EfbrMdpa6yLhVlST/QdXM5lIuapRbWa4z+lZHjePe5V70BiIbC
         gYMQ==
X-Gm-Message-State: APzg51AV3JxvQn1unyHPPdGhzLtsi0Il/spGxBkxIGFpwEo4ABdq+AfG
        2cNbe3An/UsKWKMGmTlEiM62+w==
X-Google-Smtp-Source: ANB0Vdbdr+A5Bk/wBR5YVlkydZGX5vZd5YV2BsgEn4+LYzTHFAcGw8UH+2ipxrOBmL7mQktLBiZ7Wg==
X-Received: by 2002:a17:902:7203:: with SMTP id ba3-v6mr4757417plb.179.1535526234254;
        Wed, 29 Aug 2018 00:03:54 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d81-v6sm4317342pfj.122.2018.08.29.00.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 00:03:53 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V7 9/9] dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller
Date:   Wed, 29 Aug 2018 15:03:04 +0800
Message-Id: <1535526184-32718-10-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patch adds the device-tree binding documentation for Spreadtrum
SDHCI driver.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
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

