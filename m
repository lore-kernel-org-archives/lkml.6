Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbeDTB1D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 21:27:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41318 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeDTB1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 21:27:01 -0400
X-Google-Smtp-Source: AIpwx49efzYhREDdk4D1ZHYfmVaccILJayP/YA7UEiLIlAnp5MJl1I2jkJfxqACMhM8byBdDItXDnQ==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH] arm64: dts: msm8996: Add modem remoteproc
Date: Thu, 19 Apr 2018 18:26:57 -0700
Message-Id: <20180420012657.29895-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the modem remoteproc node and the child smd-edge in order to be able
to boot the modem Hexagon found in MSM8996 based devices.

Also extend the tcsr mutex node size, to cover the registers at the end
of the block, used for halting the modem subsystem.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This patch depends on the recent patch adding a few additional clocks to
gcc-msm8996.

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 64 +++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4010e2f1a177..70009b15ffd1 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -620,7 +620,6 @@
 				pm8994_l31: l31 {};
 				pm8994_l32: l32 {};
 			};
-
 		};
 	};
 
@@ -637,7 +636,7 @@
 
 		tcsr_mutex_regs: syscon@740000 {
 			compatible = "syscon";
-			reg = <0x740000 0x20000>;
+			reg = <0x740000 0x40000>;
 		};
 
 		tcsr: syscon@7a0000 {
@@ -1850,6 +1849,67 @@
 				power-domains = <&mmcc VENUS_CORE1_GDSC>;
 			};
 		};
+
+		remoteproc@2080000 {
+			compatible = "qcom,msm8996-mss-pil";
+
+			reg = <0x2080000 0x100>,
+			      <0x2180000 0x040>;
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended = <&intc 0 448 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&xo_board>,
+				 <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&rpmcc RPM_SMD_PCNOC_CLK>,
+				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&gcc GCC_MSS_GPLL0_DIV_CLK>,
+				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+				 <&gcc GCC_MSS_MNOC_BIMC_AXI_CLK>,
+				 <&rpmcc RPM_SMD_QDSS_CLK>;
+
+			clock-names = "xo", "iface", "pnoc", "bus",
+				      "mem", "gpll0_mss_clk", "snoc_axi_clk",
+				      "mnoc_axi_clk", "qdss";
+
+			mx-supply = <&pm8994_s2>;
+			cx-supply = <&pm8994_s1>;
+			pll-supply = <&pm8994_l12>;
+
+			resets = <&gcc GCC_MSS_RESTART>;
+			reset-names = "mss_restart";
+
+			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			mba {
+				memory-region = <&mba_region>;
+			};
+
+			mpss {
+				memory-region = <&mpss_region>;
+			};
+
+			smd-edge {
+				interrupts = <0 449 IRQ_TYPE_EDGE_RISING>;
+
+				label = "modem";
+				mboxes = <&apcs_glb 12>;
+				qcom,smd-edge = <0>;
+				qcom,remote-pid = <1>;
+			};
+		};
 	};
 
 	sound: sound {
-- 
2.16.2
