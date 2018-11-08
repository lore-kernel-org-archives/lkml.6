Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2707BC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2E120827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bH/9IRHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2E120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeKHQja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:39:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37832 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHQj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:39:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id u13-v6so8894848pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 23:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3vMxLtPf9r6hzmpfaef+RgAfUttYAOF79DIGRd82YSo=;
        b=bH/9IRHngeLTJxG4V4rnbQTFFcZwgE2I/NXi9zaplan6xTtRa9r18D5jcWATa6Qwbv
         xmH6Bj8o9p/dtXXSnBRkMN0sZty3dbVVqXhDbgQuQGVhlJTTXNtawMH+YSXEZO52H77O
         G28vluSynRk8+0CWkZVuXOEbtIeiAVB3lz+CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3vMxLtPf9r6hzmpfaef+RgAfUttYAOF79DIGRd82YSo=;
        b=OqTzgYW6fiOmZkAKpqBVSrfp+5imzZAU+ZfsoU5vj3r5eVVIeEC0NGf3iESB7e7zk9
         A6KzkRjHH7+SCV4xpBY36BZXDUhmQXVAEVJsoqPzmY2yiEw5Hs0dShvGXdY2wYCl6JQP
         lk+UQoFam3/umiAIU6xP2Ulgd5tTBB+PqGcS/5foyq/4KqNW7DhtIPYs8+esqOhh5z+U
         fbTpRKLH1YwhIKpd+5QR4uXbnsLytZQQgdBW8tKhJQG7l1tF4VKe4ac7WxS2ZNQroZzV
         aOCkrnfRHHgs1ANUzMhVZjL+FWdqkWKL2EngqMAiIazyu6Ye6+XEkUSKyPH5V0/UgTUx
         l4Kw==
X-Gm-Message-State: AGRZ1gK/exjih4/hwbBL6yur6uoVpqmbt3l8sEmZ6hOV0AOuGB/TkZ5A
        PVEaKEUs9tDOz5fW2GNQcODy1w==
X-Google-Smtp-Source: AJdET5e8RhLLfaOy053JijMlGtP/0besP084dHmIO15CD5Km2YRS4yppepg/qrgjFjmAk4kdLQJ5QQ==
X-Received: by 2002:aa7:804e:: with SMTP id y14-v6mr3361226pfm.73.1541660725587;
        Wed, 07 Nov 2018 23:05:25 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id w63-v6sm2550618pgw.60.2018.11.07.23.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 23:05:24 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed USB PHY binding
Date:   Thu,  8 Nov 2018 15:04:48 +0800
Message-Id: <20181108070449.23572-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181108070449.23572-1-shawn.guo@linaro.org>
References: <20181108070449.23572-1-shawn.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sriharsha Allenki <sallenki@codeaurora.org>

It adds bindings for Synopsys 28nm femto phy controller that supports
LS/FS/HS usb connectivity on Qualcomm chipsets.

Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
new file mode 100644
index 000000000000..75e7a09dd558
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
@@ -0,0 +1,101 @@
+Qualcomm Synopsys 28nm Femto phy controller
+===========================================
+
+Synopsys 28nm femto phy controller supports LS/FS/HS usb connectivity on
+Qualcomm chipsets.
+
+Required properties:
+
+- compatible:
+    Value type: <string>
+    Definition: Should contain "qcom,usb-snps-hsphy".
+
+- reg:
+    Value type: <prop-encoded-array>
+    Definition: USB PHY base address and length of the register map.
+
+- #phy-cells:
+    Value type: <u32>
+    Definition: Should be 0.
+
+- clocks:
+    Value type: <prop-encoded-array>
+    Definition: See clock-bindings.txt section "consumers". List of
+		three clock specifiers for reference, phy core and
+		sleep clocks.
+
+- clock-names:
+    Value type: <string>
+    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
+		property. Must contain "ref", "phy" and "sleep".
+
+- resets:
+    Value type: <prop-encoded-array>
+    Definition: See reset.txt section "consumers". PHY reset specifiers
+		for phy core and POR resets.
+
+- reset-names:
+    Value type: <string>
+    Definition: Names of the resets in 1-1 correspondence with the "resets"
+		property. Must contain "phy" and "por".
+
+- vdd-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator VDD supply node.
+
+- vdda1p8-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator 1.8V supply node.
+
+- vdda3p3-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator 3.3V supply node.
+
+- qcom,vdd-voltage-level:
+    Value type: <prop-array>
+    Definition: This is a list of three integer values <no min max> where
+		each value corresponding to voltage corner in uV.
+
+Optional properties:
+
+- extcon:
+    Value type: <prop-encoded-array>
+    Definition: Should contain the vbus extcon.
+
+- qcom,init-seq:
+    Value type: <u32 array>
+    Definition: Should contain a sequence of <offset value delay> tuples to
+                program 'value' into phy register at 'offset' with 'delay'
+		in us afterwards.
+
+Example:
+
+	phy@7a000 {
+		compatible = "qcom,usb-snps-hsphy";
+		reg = <0x7a000 0x200>;
+		#phy-cells = <0>;
+		clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+			 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+			 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+		clock-names = "ref", "phy", "sleep";
+		resets = <&gcc GCC_USB_HS_PHY_CFG_AHB_BCR>,
+			 <&gcc GCC_USB2A_PHY_BCR>;
+		reset-names = "phy", "por";
+		vdd-supply = <&vreg_l4_1p2>;
+		vdda1p8-supply = <&vreg_l5_1p8>;
+		vdda3p3-supply = <&vreg_l12_3p3>;
+		qcom,vdd-voltage-level = <0 1144000 1200000>;
+		qcom,init-seq = <0xc0 0x01 0>,
+				<0xe8 0x0d 0>,
+				<0x74 0x12 0>,
+				<0x98 0x63 0>,
+				<0x9c 0x03 0>,
+				<0xa0 0x1d 0>,
+				<0xa4 0x03 0>,
+				<0x8c 0x23 0>,
+				<0x78 0x08 0>,
+				<0x7c 0xdc 0>,
+				<0x90 0xe0 20>,
+				<0x74 0x10 0>,
+				<0x90 0x60 0>;
+	};
-- 
2.18.0

