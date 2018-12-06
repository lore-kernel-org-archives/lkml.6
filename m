Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7F4C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ECB20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GtAM0LDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ECB20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeLFSqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:46:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46615 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeLFSp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:45:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so585508pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5UhrT1YkH+1fuPSdX416xfr8tjTg9v3qKT0L+zzi3Y=;
        b=GtAM0LDsdPTIsrG1utyHA2ut2UsmQlYukn9jWXYhaKKHc0lfIu6/I0O0tGoeO/niEg
         DRscOXQFU7Gq5sZUnV4ITLR5kHjdHBAAlNZvhQZsdDzpdJ92lWRO6rHdZZmguXeDHuio
         EBtUXyn7TQZ+S8z4A7z3UMtfV92J8jBGiRf+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5UhrT1YkH+1fuPSdX416xfr8tjTg9v3qKT0L+zzi3Y=;
        b=eSGC0QJTxU1b9MEaafZbf8gbLdNhY81Va6dwGGvpAkUy6JT1F+3VQicZ5OCBWoJ654
         AQt2uTmMeSdYtRdlJwdGmpH2YJKkkR2X1ibhuwbRTb8Cj+2oDnLJAW2Wl3uNb4OLGDTS
         cMDe3Ov6yBN9n37Aw7Q4/YZfbUJHaEDxe5nBJnQOEtjYXvxRxLX3TCLKVcC/7cK8KKkL
         TwSfR0cqvJoMKqk9WFtRGPF9npRL2EK+z2Map/FwvaA797MmDlTzIvYd0W2WyZIglsdz
         ur4y2k5dc9nqwbFayqBhd7H6eWuXmdm+MjZjTv03Aogpl58Y90XSCvToeZ3PpflF2jtN
         nZNQ==
X-Gm-Message-State: AA+aEWbMFvtAGM19on4ePdwfjZxbglut3ABVRdfUp+R6JeH6uEacVQ4X
        Q7N58aWQ7bAML25bhWK+LdrO+Q==
X-Google-Smtp-Source: AFSGD/WBpuQEvdtJTvoC3/RCZ4vnHe/J72zpdu2BGq0MCab+H0XnTdVrK7iACA6XJe5z+lykbrel7A==
X-Received: by 2002:a63:91c1:: with SMTP id l184mr25194557pge.29.1544121959034;
        Thu, 06 Dec 2018 10:45:59 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v89sm1458476pfk.12.2018.12.06.10.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 10:45:58 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 2/3] arm64: dts: qcom: sdm845: Add SD node
Date:   Thu,  6 Dec 2018 10:45:21 -0800
Message-Id: <20181206184522.118062-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181206184522.118062-1-evgreen@chromium.org>
References: <20181206184522.118062-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one of the two SD controllers to SDM845.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
 - Reworded commit message to note that there are multiple SD
 controllers.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1419b0098cb38..bb8eacdf40910 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1078,6 +1078,21 @@
 			};
 		};
 
+		sdhc_2: sdhci@8804000 {
+			compatible = "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x8804000 0x1000>;
+
+			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>;
+			clock-names = "iface", "core";
+
+			status = "disabled";
+		};
+
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sdm845-qusb2-phy";
 			reg = <0x88e2000 0x400>;
-- 
2.18.1

