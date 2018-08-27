Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C6E208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oP6QWxEK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FHOdmzEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C6E208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeH0Onn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:43:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeH0Onm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:43:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F031D60271; Mon, 27 Aug 2018 10:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535367452;
        bh=VVBqhhAqaGbsR10flQR3anV+mRsYiCXHJMjt8cgGVLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oP6QWxEKWJy/0Am9MEbvNXCi6v+chZ9DyTIAPuXTJAizBKM+i1KA3uZmOidLhJ06W
         o73fhPk1MB6ugh3iR+FGjfnnDhUNzsSuaDnjWA5jYYaH2DwIxicIyW9W8oM/l8MFyY
         uVvI/FGRviJBddr+SSUtJVD/+h57TenjntDo4be4=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A744607DC;
        Mon, 27 Aug 2018 10:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535367446;
        bh=VVBqhhAqaGbsR10flQR3anV+mRsYiCXHJMjt8cgGVLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHOdmzEmbRiYuWLOrq9jvqxuP7MygNo1/sJSxfKloxXY9l70AxrlluUwVLx3gvaka
         GWN1wp7zxCke80wljjkimkH8F1JmKQmFFyoOM5yv+L/orsTMp+doNjSu95t+om9lkt
         W5tdh15xOaHnTcWHUf7/IpgtANxRNteG4G9lmI7I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A744607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com, andy.gross@linaro.org,
        linux-pm@vger.kernel.org, sboyd@kernel.org, tfiga@chromium.org,
        jcrouse@codeaurora.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [Patch v15 4/5] dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
Date:   Mon, 27 Aug 2018 16:25:50 +0530
Message-Id: <20180827105551.16346-5-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Qcom's smmu-v2 implementation.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v14:
 - This is a new patch added in v15 after noticing the new
   checkpatch warning for separate dt-bindings doc.
 - This patch also addresses comments given by Rob and Robin to add
   a list of valid values of '<soc>' in "qcom,<soc>-smmu-v2"
   compatible string.

 .../devicetree/bindings/iommu/arm,smmu.txt         | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 8a6ffce12af5..52198a539606 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -17,10 +17,24 @@ conditions.
                         "arm,mmu-401"
                         "arm,mmu-500"
                         "cavium,smmu-v2"
+                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
 
                   depending on the particular implementation and/or the
                   version of the architecture implemented.
 
+                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
+                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
+                  string that should be present along with the "qcom,smmu-v2"
+                  to facilitate SoC specific clocks/power connections and to
+                  address specific bug fixes.
+                  '<soc>' string in "qcom,<soc>-smmu-v2" should be one of the
+                  following:
+                  msm8996 - for msm8996 Qcom SoC.
+                  sdm845 - for sdm845 Qcom Soc.
+
+                  An example string would be -
+                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
+
 - reg           : Base address and size of the SMMU.
 
 - #global-interrupts : The number of global interrupts exposed by the
@@ -71,6 +85,22 @@ conditions.
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
@@ -137,3 +167,20 @@ conditions.
                 iommu-map = <0 &smmu3 0 0x400>;
                 ...
         };
+
+	/* Qcom's arm,smmu-v2 implementation */
+	smmu4: iommu {
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

