Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC094C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C8C2082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehdLvAHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C8C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeH3MXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:23:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36662 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeH3MXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:23:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so3568103pgo.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/RXtHte8bNFCXLz2sWlB+/MjHMcewoMGpsLw3S8KcCM=;
        b=ehdLvAHulsqEGy2bI4CKy7Yju2jHtCBeOXunvc9ihc53cj2WslPESCJbLHPy1vlTvy
         E5paeKwr31lXBvDbVokPkwrPYr9JEkaEUbQw9yqhF3NaN+wyhQjNA6FcnMP49yd6Z83z
         K4WhB54ZIzBNrW5MufdnAHX7F7gaN8WAyiYeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/RXtHte8bNFCXLz2sWlB+/MjHMcewoMGpsLw3S8KcCM=;
        b=O7buIWBx8ezFELEqqelURG/e/j11TmTjSGyA8qYBbMC7nCBBstDH6Z95L9r50NUYUg
         xju3MI+bPXq1E9UrYg5ZXz3Ng7KEuuiezHjeWo1yZKHFtdLqtbSjPlMJYNxPXgjhsTfz
         MTbm/rFczwZ4OKPNrewRl4B9dJw5EHLohbI3ssDQV4Hljvi/0Q8+N9eM/V8LWpuzf9yT
         V2O5OwgjOQeUxErijDrGM8xA96QMYpOkTYDUkMBkmIqe8ETRf/ZCThrGdrrzfUySZ8Gk
         4tVrdEXKMrmcIqqI0btsuDeNeBlKWGnLxENOfhUuvlaGvxkrzE3J11PUrhdV4OosJ3va
         SecA==
X-Gm-Message-State: APzg51D1W69NMORhklgpn7/paed2PLqb2u90CJ9tc/3v++jA3MP5MMUb
        JaUtvZWlQxC1umKpDyTA3Da4qw==
X-Google-Smtp-Source: ANB0VdabDreFX2FsrZv0udlFgX9xdNrVWOThvGW5s/77A+m/aEsAfZtlMyNuQvGBMxFqDpQXZOSBzQ==
X-Received: by 2002:a65:6413:: with SMTP id a19-v6mr1774313pgv.359.1535617359659;
        Thu, 30 Aug 2018 01:22:39 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j22-v6sm8224885pfh.45.2018.08.30.01.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 01:22:38 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V8 9/9] dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller
Date:   Thu, 30 Aug 2018 16:21:45 +0800
Message-Id: <1535617305-16952-10-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
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

