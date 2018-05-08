Return-Path: <mperttunen@nvidia.com>
X-Google-Smtp-Source: AB8JxZqWHJxDC+lNf/24cNgymfxZgN/m3KbVcwwgjt32nlsV7vae59BCZcBM0DFCdTyBaP7etlut
ARC-Seal: i=1; a=rsa-sha256; t=1525780183; cv=none;
        d=google.com; s=arc-20160816;
        b=lTIKKW8s08hJoRRg5yjutzeH49YhynBCFxdAXqnzXvj6eg2+HaItU2z/HVRaIvSP8I
         pR2h3W4vhcP3fVDaTYYaIVS5I6ayE9E/K03JVjG2OYqxbvXapCemZE2yx86Gr3gBCqq1
         uPQjnRE2ZhLB1PqnAEyYrVSEJVI/nzipEJuDY4W7f/PCgCs8oYeAVvl5ewzFNks3AskP
         CttyC67EABJ7bF+hvBwADVL2Y+bAnsj7Uls84sQLxtOAkhPZD9F7VgN7+KsIfrp/TsK2
         WrOfkKEdaZ5q6riuQO383ChXhtT/lltPGqiuQ8KuN7G+QKF90PGiAeUhft458RH2gcBU
         z7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=4EtNXQd0SYFz897+4HS/7u7hPUKgwGsSEGF5FRPBEE8=;
        b=kQdsMXJeFxaAtnLQ2+vIl4g/WK7SsVRZFrsAQfa73FQYHU4D7eGsO1rRZyfvHiyeOS
         IUfYyvVSoc9AWulOXiKlWYiMT7f8IID6ii5LLTsM3+Bb0tBdtzQZIcNtBB3u+D53ks79
         9pIRy4QZ/zAaR5dUJVRYaEnb3/EpjeecBVUWDXnEuseYun6iRd+jWo9iffr181TYceQc
         FEuwE8WxXsEPcgYfQIucoxa1Lg0lWUip4m7mF6vFi/HqqNpuFdV2AnyRJvpMIGPbdUJT
         oPyPnO9m1GFDEyIcXx2O+db61jJh9hWYxKZvNkUYh6YunZsfwUpPQzmaj0sDIO1TzYCJ
         UMrw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Tue, 08 May 2018 04:49:37 -0700
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
	<gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Mikko
 Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 7/8] arm64: tegra: Add nodes for tcu on Tegra194
Date: Tue, 8 May 2018 14:44:02 +0300
Message-ID: <20180508114403.14499-8-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180508114403.14499-1-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599896482174662066?=
X-GMAIL-MSGID: =?utf-8?q?1599896482174662066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add nodes required for communication through the Tegra Combined UART.
This includes the AON HSP instance, addition of shared interrupts
for the TOP0 HSP instance, and finally the TCU node itself. Also
mark the HSP instances as compatible to tegra194-hsp, as the hardware
is not identical but is compatible to tegra186-hsp.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 34 +++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6d699815a84f..d7f780b06fe2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -217,10 +217,31 @@
 		};
 
 		hsp_top0: hsp@3c00000 {
-			compatible = "nvidia,tegra186-hsp";
+			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
 			reg = <0x03c00000 0xa0000>;
-			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "doorbell";
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "doorbell", "shared0", "shared1", "shared2",
+			                  "shared3", "shared4", "shared5", "shared6",
+			                  "shared7";
+			#mbox-cells = <2>;
+		};
+
+		hsp_aon: hsp@c150000 {
+			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
+			reg = <0x0c150000 0xa0000>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "shared0", "shared1", "shared2", "shared3";
 			#mbox-cells = <2>;
 		};
 
@@ -382,6 +403,13 @@
 		};
 	};
 
+	tcu: tcu {
+		compatible = "nvidia,tegra194-tcu";
+		mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
+		         <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
+		mbox-names = "rx", "tx";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.16.1
