Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83846C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F979208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bMexLY6q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jRHc9qT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F979208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeLDGXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:23:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDGXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:23:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5AE6961330; Tue,  4 Dec 2018 06:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543904584;
        bh=2oM7nGlEc676NkVqRQCuFvnMw7qZCWlXC+n2IiReOUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMexLY6qykkPFnG4UwU0KHJv4ZTuHooWNHGDgQx1nAssI8Vzoh9k0e5FJ4ID2hasf
         mhCGf9hyjxqqTrnYW0DXcC08OhA9hnnjQxGqCvHC1S/ftV5BjYUxXr5tlkMqTr3duX
         jxfOWvKKtz0iwfj2J0cPC5cSZUjnuTR/EbYcgYZk=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B31F6130A;
        Tue,  4 Dec 2018 06:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543904576;
        bh=2oM7nGlEc676NkVqRQCuFvnMw7qZCWlXC+n2IiReOUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRHc9qT7RSaM0dFhTCZbBF6zJUYImlFpTmyeQ4Fef0KUEEzdhzkyDBIzKSKvmLBhI
         3QB2yelT3o/7dbI6XrRGNDBdAc0waz4X5YP6ugYM2A9MEfnpnQHTdWI6Q5A021Kv+K
         GLN/8qgNXVie6M5IfYy7cluC08Sn0uij4h61t+38=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B31F6130A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        thor.thayer@linux.intel.com,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v19 4/5] dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
Date:   Tue,  4 Dec 2018 11:52:12 +0530
Message-Id: <20181204062213.6875-5-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20181204062213.6875-1-vivek.gautam@codeaurora.org>
References: <20181204062213.6875-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Qcom's smmu-v2 implementation.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes since v18:
 None.

 .../devicetree/bindings/iommu/arm,smmu.txt         | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 8a6ffce12af5..a6504b37cc21 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -17,10 +17,16 @@ conditions.
                         "arm,mmu-401"
                         "arm,mmu-500"
                         "cavium,smmu-v2"
+                        "qcom,smmu-v2"
 
                   depending on the particular implementation and/or the
                   version of the architecture implemented.
 
+                  Qcom SoCs must contain, as below, SoC-specific compatibles
+                  along with "qcom,smmu-v2":
+                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
+                  "qcom,sdm845-smmu-v2", "qcom,smmu-v2".
+
 - reg           : Base address and size of the SMMU.
 
 - #global-interrupts : The number of global interrupts exposed by the
@@ -71,6 +77,22 @@ conditions.
                   or using stream matching with #iommu-cells = <2>, and
                   may be ignored if present in such cases.
 
+- clock-names:    List of the names of clocks input to the device. The
+                  required list depends on particular implementation and
+                  is as follows:
+                  - for "qcom,smmu-v2":
+                    - "bus": clock required for downstream bus access and
+                             for the smmu ptw,
+                    - "iface": clock required to access smmu's registers
+                               through the TCU's programming interface.
+                  - unspecified for other implementations.
+
+- clocks:         Specifiers for all clocks listed in the clock-names property,
+                  as per generic clock bindings.
+
+- power-domains:  Specifiers for power domains required to be powered on for
+                  the SMMU to operate, as per generic power domain bindings.
+
 ** Deprecated properties:
 
 - mmu-masters (deprecated in favour of the generic "iommus" binding) :
@@ -137,3 +159,20 @@ conditions.
                 iommu-map = <0 &smmu3 0 0x400>;
                 ...
         };
+
+	/* Qcom's arm,smmu-v2 implementation */
+	smmu4: iommu@d00000 {
+		compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+		reg = <0xd00000 0x10000>;
+
+		#global-interrupts = <1>;
+		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		power-domains = <&mmcc MDSS_GDSC>;
+
+		clocks = <&mmcc SMMU_MDP_AXI_CLK>,
+			 <&mmcc SMMU_MDP_AHB_CLK>;
+		clock-names = "bus", "iface";
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

