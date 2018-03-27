Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeC0Sxp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 14:53:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeC0Sxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 14:53:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20AC6602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc: linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, kyan@codeaurora.org, ckadabi@codeaurora.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v3 1/2] Documentation: Documentation for qcom, llcc
Date: Tue, 27 Mar 2018 11:52:01 -0700
Message-Id: <1522176722-12691-2-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522176722-12691-1-git-send-email-rishabhb@codeaurora.org>
References: <1522176722-12691-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for last level cache controller device tree bindings,
client bindings usage examples.

Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
new file mode 100644
index 0000000..ceb20a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
@@ -0,0 +1,70 @@
+== Introduction==
+
+LLCC (Last Level Cache Controller) driver is implemented as a platform device.
+The driver Programs the SCT (system configuration table). The SCT programming
+divides the system cache into slices. Each slice is assigned an ID A.K.A
+SCID(Sub-cache ID).
+HW modules that are designated to use the system cache are known as clients.
+Each client must also be represented as a node in the device tree just like
+any other hw module.
+One client can have multiple SCID's assigned meaning each client could get
+multiple slices in the cache. Client can use the slices for various pre-defined
+usecases. Each client defines a set of names for these usecases in its
+device tree binding.
+Client makes a request to LLCC device to get cache-slices properties for each
+of its usecase. Client gets the information like cache slice ID and size of the
+cache slice.
+
+== llcc device ==
+
+Properties:
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,sdm855-llcc"
+
+- reg:
+	Usage: required
+	Value Type: <prop-encoded-array>
+	Definition: must be addresses and sizes of the LLCC registers
+
+- #cache-cells:
+	Usage: required
+	Value Type: <u32>
+	Definition: Number of cache cells, must be 1
+
+- max-slices:
+	usage: required
+	Value Type: <u32>
+	Definition: Number of cache slices supported by hardware
+
+Example:
+
+	llcc: qcom,sdm855-llcc@01100000 {
+		compatible = "qcom,sdm845-llcc";
+		reg = <0x01100000 0x250000>;
+		#cache-cells = <1>;
+		max-slices = <32>;
+	};
+
+== Client ==
+
+Required properties:
+- cache-slice-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: A set of names that identify the usecase names of a client that
+			uses cache slice. These strings are used to look up the cache slice
+		    entries by name.
+
+- cache-slices:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: The tuple has phandle to llcc device as the first argument and
+			the second argument is the usecase id of the client.
+For Example:
+
+	venus {
+		cache-slice-names = "vidsc0", "vidsc1";
+		cache-slices = <&llcc 2>, <&llcc 3>;
+	};
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
