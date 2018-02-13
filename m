Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965394AbeBMRKU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:10:20 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53566 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965319AbeBMRBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:17 -0500
X-Google-Smtp-Source: AH8x225dpxIo9RdM1XkmHUzkaszMFmLDxhA18MzTnNM7F0O/MeMMwMFKxPC75XT2OnFSzNBEm+1Z/w==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
        spatakok@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 01/25] dt-bindings: soc: qcom: Add bindings for APR bus
Date: Tue, 13 Feb 2018 16:58:13 +0000
Message-Id: <20180213165837.1620-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
bus driver. This bus is used for communicating with DSP which provides
audio and various other services to cpu.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
new file mode 100644
index 000000000000..1b95fbfed348
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
@@ -0,0 +1,83 @@
+Qualcomm APR (Asynchronous Packet Router) binding
+
+This binding describes the Qualcomm APR. APR is a IPC protocol for
+communication between Application processor and QDSP. APR is mainly
+used for audio/voice services on the QDSP.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,apr-v<VERSION-NUMBER>", example "qcom,apr-v2"
+
+- qcom,apr-dest-domain-id
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Destination processor ID.
+	Possible values are :
+			1 - APR simulator
+			2 - PC
+			3 - MODEM
+			4 - ADSP
+			5 - APPS
+			6 - MODEM2
+			7 - APPS2
+
+= APR SERVICES
+Each subnode of the APR node can represent service tied to this apr. The name
+of the nodes are not important. The properties of these nodes are defined
+by the individual bindings for the specific service
+- but must contain the following property:
+
+- qcom,apr-svc-id
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: APR Service ID, used for matching the service.
+	Possible values are :
+			3 - DSP Core Service
+			4 - Audio Front End Service.
+			5 - Voice Stream Manager Service.
+			6 - Voice processing manager.
+			7 - Audio Stream Manager Service.
+			8 - Audio Device Manager Service.
+			9 - Multimode voice manager.
+			10 - Core voice stream.
+			11 - Core voice processor.
+			12 - Ultrasound stream manager.
+			13 - Listen stream manager.
+
+- qcom,apr-svc-name
+	Usage: required
+	Value type: <stringlist>
+	Definition: User readable name of a APR service.
+
+= APR DEVICES:
+Each subnode of the APR node can represent devices tied to this apr, like
+sound-card. The properties of these nodes are defined by the individual
+bindings for the specific device.
+
+= EXAMPLE
+The following example represents a QDSP based sound card on a MSM8996 device
+which uses apr as communication between Apps and QDSP.
+
+	apr {
+		compatible = "qcom,apr-v2";
+		qcom,smd-channels = "apr_audio_svc";
+		qcom,apr-dest-domain-id = <APR_DOMAIN_ADSP>;
+
+		q6core {
+			compatible = "qcom,q6core";
+			qcom,apr-svc-name = "CORE";
+			qcom,apr-svc-id = <APR_SVC_ADSP_CORE>;
+		};
+
+		q6afe {
+			compatible = "qcom,q6afe";
+			qcom,apr-svc-name = "AFE";
+			qcom,apr-svc-id = <APR_SVC_AFE>;
+		};
+
+		audio {
+			compatible = "qcom,msm8996-snd-card";
+			...
+		};
+	};
-- 
2.15.1
