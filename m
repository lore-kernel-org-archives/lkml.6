Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933237AbeE2KW1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:22:27 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46828 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932904AbeE2KUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:20:54 -0400
X-Google-Smtp-Source: AB8JxZobGbS5tuPy4Ue8LR1pA0HWrRkH4spMXLyFgZ6Fp3mRp/0bKc0ou488EGqv+WbxuHTusyoVew==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        bgoswami@codeaurora.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org,
        tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/6] ASoC: qdsp6: dt-bindings: Add q6afe tdm dt binding
Date: Tue, 29 May 2018 11:18:28 +0100
Message-Id: <20180529101833.30489-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180529101833.30489-1-srinivas.kandagatla@linaro.org>
References: <20180529101833.30489-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings required for TDM ports on AFE.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt       | 68 ++++++++++++++++++
 include/dt-bindings/sound/qcom,q6afe.h             | 80 ++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index 14335a08b963..bdbf87df8c0b 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -46,6 +46,53 @@ configuration of each dai. Must contain the following properties.
 	Definition: Must be list of serial data lines used by this dai.
 	should be one or more of the 1-4 sd lines.
 
+ - qcom,tdm-sync-mode:
+	Usage: required for tdm interface
+	Value type: <prop-encoded-array>
+	Definition: Synchronization mode.
+		0 - Short sync bit mode
+		1 - Long sync mode
+		2 - Short sync slot mode
+
+ - qcom,tdm-sync-src:
+	Usage: required for tdm interface
+	Value type: <prop-encoded-array>
+	Definition: Synchronization source.
+		0 - External source
+		1 - Internal source
+
+ - qcom,tdm-data-out:
+	Usage: required for tdm interface
+	Value type: <prop-encoded-array>
+	Definition: Data out signal to drive with other masters.
+		0 - Disable
+		1 - Enable
+
+ - qcom,tdm-invert-sync:
+	Usage: required for tdm interface
+	Value type: <prop-encoded-array>
+	Definition: Invert the sync.
+		0 - Normal
+		1 - Invert
+
+ - qcom,tdm-data-delay:
+	Usage: required for tdm interface
+	Value type: <prop-encoded-array>
+	Definition: Number of bit clock to delay data
+		with respect to sync edge.
+		0 - 0 bit clock cycle
+		1 - 1 bit clock cycle
+		2 - 2 bit clock cycle
+
+ - qcom,tdm-data-align:
+	Usage: required for tdm interface
+	Value type: <prop-encoded-array>
+	Definition: Indicate how data is packed
+		within the slot. For example, 32 slot width in case of
+		sample bit width is 24.
+		0 - MSB
+		1 - LSB
+
 = EXAMPLE
 
 q6afe@4 {
@@ -61,6 +108,27 @@ q6afe@4 {
 			reg = <1>;
 		};
 
+		tdm@24 {
+			reg = <24>;
+			qcom,tdm-sync-mode = <1>:
+			qcom,tdm-sync-src = <1>;
+			qcom,tdm-data-out = <0>;
+			qcom,tdm-invert-sync = <1>;
+			qcom,tdm-data-delay = <1>;
+			qcom,tdm-data-align = <0>;
+
+		};
+
+		tdm@25 {
+			reg = <25>;
+			qcom,tdm-sync-mode = <1>:
+			qcom,tdm-sync-src = <1>;
+			qcom,tdm-data-out = <0>;
+			qcom,tdm-invert-sync = <1>;
+			qcom,tdm-data-delay <1>:
+			qcom,tdm-data-align = <0>;
+		};
+
 		prim-mi2s-rx@16 {
 			reg = <16>;
 			qcom,sd-lines = <1 3>;
diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
index e162045f5dc9..e2d3892240b8 100644
--- a/include/dt-bindings/sound/qcom,q6afe.h
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -26,6 +26,86 @@
 #define TERTIARY_MI2S_TX	21
 #define QUATERNARY_MI2S_RX	22
 #define QUATERNARY_MI2S_TX	23
+#define PRIMARY_TDM_RX_0	24
+#define PRIMARY_TDM_TX_0	25
+#define PRIMARY_TDM_RX_1	26
+#define PRIMARY_TDM_TX_1	27
+#define PRIMARY_TDM_RX_2	28
+#define PRIMARY_TDM_TX_2	29
+#define PRIMARY_TDM_RX_3	30
+#define PRIMARY_TDM_TX_3	31
+#define PRIMARY_TDM_RX_4	32
+#define PRIMARY_TDM_TX_4	33
+#define PRIMARY_TDM_RX_5	34
+#define PRIMARY_TDM_TX_5	35
+#define PRIMARY_TDM_RX_6	36
+#define PRIMARY_TDM_TX_6	37
+#define PRIMARY_TDM_RX_7	38
+#define PRIMARY_TDM_TX_7	39
+#define SECONDARY_TDM_RX_0	40
+#define SECONDARY_TDM_TX_0	41
+#define SECONDARY_TDM_RX_1	42
+#define SECONDARY_TDM_TX_1	43
+#define SECONDARY_TDM_RX_2	44
+#define SECONDARY_TDM_TX_2	45
+#define SECONDARY_TDM_RX_3	46
+#define SECONDARY_TDM_TX_3	47
+#define SECONDARY_TDM_RX_4	48
+#define SECONDARY_TDM_TX_4	49
+#define SECONDARY_TDM_RX_5	50
+#define SECONDARY_TDM_TX_5	51
+#define SECONDARY_TDM_RX_6	52
+#define SECONDARY_TDM_TX_6	53
+#define SECONDARY_TDM_RX_7	54
+#define SECONDARY_TDM_TX_7	55
+#define TERTIARY_TDM_RX_0	56
+#define TERTIARY_TDM_TX_0	57
+#define TERTIARY_TDM_RX_1	58
+#define TERTIARY_TDM_TX_1	59
+#define TERTIARY_TDM_RX_2	60
+#define TERTIARY_TDM_TX_2	61
+#define TERTIARY_TDM_RX_3	62
+#define TERTIARY_TDM_TX_3	63
+#define TERTIARY_TDM_RX_4	64
+#define TERTIARY_TDM_TX_4	65
+#define TERTIARY_TDM_RX_5	66
+#define TERTIARY_TDM_TX_5	67
+#define TERTIARY_TDM_RX_6	68
+#define TERTIARY_TDM_TX_6	69
+#define TERTIARY_TDM_RX_7	70
+#define TERTIARY_TDM_TX_7	71
+#define QUATERNARY_TDM_RX_0	72
+#define QUATERNARY_TDM_TX_0	73
+#define QUATERNARY_TDM_RX_1	74
+#define QUATERNARY_TDM_TX_1	75
+#define QUATERNARY_TDM_RX_2	76
+#define QUATERNARY_TDM_TX_2	77
+#define QUATERNARY_TDM_RX_3	78
+#define QUATERNARY_TDM_TX_3	79
+#define QUATERNARY_TDM_RX_4	80
+#define QUATERNARY_TDM_TX_4	81
+#define QUATERNARY_TDM_RX_5	82
+#define QUATERNARY_TDM_TX_5	83
+#define QUATERNARY_TDM_RX_6	84
+#define QUATERNARY_TDM_TX_6	85
+#define QUATERNARY_TDM_RX_7	86
+#define QUATERNARY_TDM_TX_7	87
+#define QUINARY_TDM_RX_0	88
+#define QUINARY_TDM_TX_0	89
+#define QUINARY_TDM_RX_1	90
+#define QUINARY_TDM_TX_1	91
+#define QUINARY_TDM_RX_2	92
+#define QUINARY_TDM_TX_2	93
+#define QUINARY_TDM_RX_3	94
+#define QUINARY_TDM_TX_3	95
+#define QUINARY_TDM_RX_4	96
+#define QUINARY_TDM_TX_4	97
+#define QUINARY_TDM_RX_5	98
+#define QUINARY_TDM_TX_5	99
+#define QUINARY_TDM_RX_6	100
+#define QUINARY_TDM_TX_6	101
+#define QUINARY_TDM_RX_7	102
+#define QUINARY_TDM_TX_7	103
 
 #endif /* __DT_BINDINGS_Q6_AFE_H__ */
 
-- 
2.16.2
