Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 18BAAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D8420891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZFwLRIYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D8420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965537AbeFOCFc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:05:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33543 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965475AbeFOCF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:05:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so4134071pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 19:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMrql5pChvk0l0OVuaoPU9zdtIybInbwoq7vsafDp1A=;
        b=ZFwLRIYf1YMykqsQUjRHRqpN6ibWMmukmz+3u1v2oql47QrPLYYZMaXn8EblWJ6SAy
         6E0gBwWqnlRh9auRrDR2Y4FhwuTaI+7V1XmoFOpoCqg3Bq4G7IzdMrj8BJZetfMpbSlj
         n3glKy+FwSivSAjshgGEAnlJhXx/xHq7vsAq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMrql5pChvk0l0OVuaoPU9zdtIybInbwoq7vsafDp1A=;
        b=AqYCKxIpd7c6rH2QDj3csfNjuR8I6OqKMDuIZ8mAw969e+p7LH1zABPd/wQf/4GVnp
         juJELckiiXPy+dPnzM4Y8cv1PIGrmchghfmte91UlU7jPSt1z5t+m6nA/sJZiemBYcKk
         hogojFaluamUbsrDAya5CULL/dpenMax9W7XLvCCyTlZMQ0jkmDQehFVjmwcPuVih1J1
         t8A7hZREgvFbUR9Qe2AoPCOK6EvH/oKa1OggqpJR38pIWWJlpBqjj40G3UhIhpheMwSN
         bPB6NLaAPxZnB7OCV2QIGGcbTCpOh45GZPtJSWNOt0rqxNBC6CUoaCbksp99QE4MBGnN
         pkDg==
X-Gm-Message-State: APt69E2ZDqBaQrOKubH+FACppoJiMukilFz+u71HzyaBf629I/pQOuA0
        D6dukTBxh9pIPkEKGuVcvx395wYyV40=
X-Google-Smtp-Source: ADUXVKKwO6gUr45e/gQlv0AchmVW5iyLsMD8EhZmPV/pP6kzko3yj6im7cPSYGCIY0SWaR0wGvf7BQ==
X-Received: by 2002:a62:4556:: with SMTP id s83-v6mr12043599pfa.73.1529028326182;
        Thu, 14 Jun 2018 19:05:26 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k69-v6sm9504953pgc.39.2018.06.14.19.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 19:05:25 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V2 7/7] dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller
Date:   Fri, 15 Jun 2018 10:04:15 +0800
Message-Id: <1529028255-6022-8-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
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

