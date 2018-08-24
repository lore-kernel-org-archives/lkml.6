Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02498C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF46920676
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQ/9niS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF46920676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeHXMzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:55:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44511 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeHXMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:55:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so851732plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/RXtHte8bNFCXLz2sWlB+/MjHMcewoMGpsLw3S8KcCM=;
        b=RQ/9niS2ZQDepy69GPR4TwrmfOO7UsOK2r2+SLhbspcKcRYUR5uLpEtybkOmM965Jq
         o2j18KVbNEKoeSXb0iYqm0uY+CI+ZWRvt8pa4ARh8rmundcEHO3lzIc5bIXK+7t8HXFw
         xUfnvM1MrewnCHXWevfo3yq+2FY5pS3dQzyVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/RXtHte8bNFCXLz2sWlB+/MjHMcewoMGpsLw3S8KcCM=;
        b=Fyjw7NL33Va652GQzmmcHJ1BMq24ljJWKhn/K3lz6dgh7bhgSWkdlSrlvsXz0ML756
         Nl6+f42fQ//Kj0J9deEBFsO6J66SjPGjhl053UFKIhmsTlJJ0Hn8BenCAqOkDyBF1Vzg
         /zQPdZmB7lApSa4TtpWR3n396kbMVUy/1lNCwZDtqoehPBr5cCmat9o2KF2Z0XKydiMA
         JlFWOB6T+uHEDhgsEPj3IVOGYOL6Kc+coMrNr0vMsFK5q138il8GUaNKcCFQp1NRRWgg
         zJjeehol0CGC4yxc90nV1YjtQIpTkFU9R+iY1uMGLzbx4d9NnCvwkKIkx34jiiMg7enj
         eaOA==
X-Gm-Message-State: APzg51BNA9dFpbBtx0xHA+0YiO9rxgt9NIiMH2MPZjkNm3bIYmGvcPnI
        pzFVTR0IuBmTFRDhr1JDiNvglA==
X-Google-Smtp-Source: ANB0VdZnwwLL4fRKLiPN3Whsd+t4BUzVjPk9IL+mx+6kOQAFbAxQc0QWmNSIfiS9IrDHgdkRAHIdyg==
X-Received: by 2002:a17:902:8a92:: with SMTP id p18-v6mr891941plo.148.1535102517890;
        Fri, 24 Aug 2018 02:21:57 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g6-v6sm9520314pfb.11.2018.08.24.02.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Aug 2018 02:21:57 -0700 (PDT)
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
Subject: [PATCH V6 9/9] dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller
Date:   Fri, 24 Aug 2018 17:20:28 +0800
Message-Id: <1535102428-20332-10-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
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

