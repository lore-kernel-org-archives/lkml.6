Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF97BC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D81F215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxN3zPIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D81F215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeHRTD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:03:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46911 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeHRTDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:03:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id o8-v6so6099226edt.13;
        Sat, 18 Aug 2018 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3aVOrCkNI1os6TVHdY1oshlRajsFW3BR1KUv8+9Eqfo=;
        b=DxN3zPIkOxvg3893+OeDlwI3eGZjENc7qN5krCxfyz2s5nYrWhiTlLfFyIMDNNymBv
         efnkxrkXWLzR0e3Naoa9qwk9c+jO5EO2IN+8wOjX3WoYbIbn7Lzua69g1enpKCWbsBhJ
         yhO50E9SRe+hqxZSVW0E+W3CwQlhkVm1A/pYscKjUshd2xztYnH/BYDsZg7RkLS6mLck
         0Xyel3jWBqkqRYHkavDvhi7cOa/UwFyjgQ9+gA8fWZcT2Rx1/6Ynqgo4TJwIwEoKoZ1Y
         vM0iLUCn6n+aotlBl9d41KYz1mNkiLjEzFKS0ymwlIwDbRNoRtK3bWYURnTR/Oo7gymx
         PlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3aVOrCkNI1os6TVHdY1oshlRajsFW3BR1KUv8+9Eqfo=;
        b=eLNRCm8dLKcmtBrPoGpmiLM7/Y4LGZ1s0oNl7Nh4fO8XHCqwocrimA0Y4t4VyWnyqn
         xcYxrvP6ojB5751bDd+OBZfPrYrqzWMGbhJoWGz7T2mcH5m6JupBeFbhAshNE01NY4Ak
         VkG8fG5fIaMT/d+QkGF4LIT4rd6c8ZWs/5lhB1CkIre1IGjMI85j7gMfqDY9dxy7O5ZT
         Q905B8zET/prJyxVeF0uyoAMnywKfyLPrZt337IFcTBqtxwsy+ET1Jkt89MVrXk0UrKu
         Om6z6cupo1jhZAuzeiOmM1s89NJ32v73L7bEKa+AhqzfYpdsmuXXsx2Kk16COO7sb7st
         CSQg==
X-Gm-Message-State: AOUpUlEabRreEI/VclEtK5QvhwYi7gnrkCA+y/Ftl6qXt1FxQSGWLafD
        5nFunBvtxloYUU71CnajZ80=
X-Google-Smtp-Source: AA+uWPxX64b1cmnkST1P8lhrDZsCD7OcrbAuCNVMpiS/TBCIcGKPO1N9Ryo6OqE8l9w3G3V7YxxYcw==
X-Received: by 2002:a50:a584:: with SMTP id a4-v6mr48007342edc.289.1534607744046;
        Sat, 18 Aug 2018 08:55:44 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/19] dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
Date:   Sat, 18 Aug 2018 18:54:17 +0300
Message-Id: <20180818155430.5586-7-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting GART and Memory Controller wasn't a good decision that was made
back in the day. Given that the GART driver hasn't ever been used by
anything in the kernel, we decided that it will be better to correct the
mistakes of the past and merge two bindings into a single one. In a result
there is a DT ABI change for the Memory Controller that allows not to
break newer kernels using older DT by introducing a new required property,
the memory clock. Adding the new clock property also puts the tegra20-mc
binding in line with the bindings of the later Tegra generations.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/iommu/nvidia,tegra20-gart.txt    | 14 -----------
 .../memory-controllers/nvidia,tegra20-mc.txt  | 23 ++++++++++++++-----
 2 files changed, 17 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
deleted file mode 100644
index 099d9362ebc1..000000000000
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-NVIDIA Tegra 20 GART
-
-Required properties:
-- compatible: "nvidia,tegra20-gart"
-- reg: Two pairs of cells specifying the physical address and size of
-  the memory controller registers and the GART aperture respectively.
-
-Example:
-
-	gart {
-		compatible = "nvidia,tegra20-gart";
-		reg = <0x7000f024 0x00000018	/* controller registers */
-		       0x58000000 0x02000000>;	/* GART aperture */
-	};
diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
index 7d60a50a4fa1..1564df89392a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
@@ -2,25 +2,36 @@ NVIDIA Tegra20 MC(Memory Controller)
 
 Required properties:
 - compatible : "nvidia,tegra20-mc"
-- reg : Should contain 2 register ranges(address and length); see the
-  example below. Note that the MC registers are interleaved with the
-  GART registers, and hence must be represented as multiple ranges.
+- reg : Should contain 2 register ranges: physical base address and length of
+  the controller's registers and the GART aperture respectively.
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - mc: the module's clock input
 - interrupts : Should contain MC General interrupt.
 - #reset-cells : Should be 1. This cell represents memory client module ID.
   The assignments may be found in header file <dt-bindings/memory/tegra20-mc.h>
   or in the TRM documentation.
+- #iommu-cells: Should be 0. This cell represents the number of cells in an
+  IOMMU specifier needed to encode an address. GART supports only a single
+  address space that is shared by all devices, therefore no additional
+  information needed for the address encoding.
 
 Example:
 	mc: memory-controller@7000f000 {
 		compatible = "nvidia,tegra20-mc";
-		reg = <0x7000f000 0x024
-		       0x7000f03c 0x3c4>;
-		interrupts = <0 77 0x04>;
+		reg = <0x7000f000 0x400		/* controller registers */
+		       0x58000000 0x02000000>;	/* GART aperture */
+		clocks = <&tegra_car TEGRA20_CLK_MC>;
+		clock-names = "mc";
+		interrupts = <GIC_SPI 77 0x04>;
 		#reset-cells = <1>;
+		#iommu-cells = <0>;
 	};
 
 	video-codec@6001a000 {
 		compatible = "nvidia,tegra20-vde";
 		...
 		resets = <&mc TEGRA20_MC_RESET_VDE>;
+		iommus = <&mc>;
 	};
-- 
2.18.0

