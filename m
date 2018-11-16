Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18023C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C795E2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZREiYdNr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rv4PbOrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C795E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389695AbeKPVh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:37:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeKPVh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:37:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD676612F6; Fri, 16 Nov 2018 11:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542367530;
        bh=w5KvvTBfYynd1x1fNTV9Dhsc1zAtL2Dub+JTXrIxKLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZREiYdNrpopwxL//NOj+pOwsD71XKYkMJjrA1KDMYvY/ne+Asr4cW+GJ9mGMEjohn
         0VbqMZXhPMoMcLsFRWvSppIe91k0R7e6/Gy1uHzzGBqo9getfQqsP9rgf28wdrfoXg
         6D9JYQLk7Zs4xY1qf2g1iT7LwgPldCROZgTgN3iI=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA6B060C65;
        Fri, 16 Nov 2018 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542367519;
        bh=w5KvvTBfYynd1x1fNTV9Dhsc1zAtL2Dub+JTXrIxKLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rv4PbOrTChP87+yr9r+x9NmXinZHN0EgK9gGw+S/3lQez6i5oFBJbSewCgHrEsKHD
         gsOCS8WCWeDm4djJI9Cnbs9VOYHCfqvmLGSgZARhMCEUU1TIVJRJNo4d3MLlmhWB7u
         Lzyt5RaNU+pOnn5yECj3ncF6DghIhvs3JYtU8+IE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA6B060C65
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [RESEND PATCH v17 4/5] dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
Date:   Fri, 16 Nov 2018 16:54:29 +0530
Message-Id: <20181116112430.31248-5-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
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

