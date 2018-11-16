Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CEAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC822087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lr4jqeVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC822087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbeKQBJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:09:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44121 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbeKQBJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:09:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so2059278pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 06:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hs8kJ/n19MYFQ4F1jRnsUG7KKzdTPo3hrqv1mlxboZ0=;
        b=Lr4jqeVufeDPnc5cx/2thacJ2qirHnXgHuv18PjuFf8xPZkV7foZTCu19aGc+Y3z/a
         XrsPxOD0rcSpnllP4H2ydNwicB05Prph8CXJJJUWflXGv2o3zYfTP5tJLGwGeEsw5F7p
         /Aw1IssFwm0w8JtHYcbbsEN5OUGEAIMWRy9es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hs8kJ/n19MYFQ4F1jRnsUG7KKzdTPo3hrqv1mlxboZ0=;
        b=K739+SEuZ0bwT21w7ss6hzesZYX0MIc1YQnG3BE0H6J8ZdcQtTHTfaRv1iaVZoJuqI
         U3cpHBSLpmwqdbszy9+rAiU48s15ejnarYAicC33fDiW1X1GB8Dg33sZFs0aj7Q0Az+T
         WzANozGids68/CVN+5v4A5r0nAOTpo6JEWVT2URSi3jXAZMzkQa+tAi0shmjzVYMw8Cu
         zskO60Lyjc3vL3ay5KnMmbecdQBD5Sg2H3sCGIDcN9i4N/dEka9QOKN1MS4hTvudYD1N
         z9Ks7advvEMtAy8kIiL4E9zaoNASAy6gMC6A/ZEpcfcPoeq31gR3DBYfUs8UTJ0VY+xA
         uYwg==
X-Gm-Message-State: AGRZ1gI0lan5KciMBppvB56GnGprxeuyhLU/AEphw9GpC1xhcjI9GHWb
        i5d+piIfitFbJfQWHu0oVmBW0A==
X-Google-Smtp-Source: AJdET5dczsmDuhcHnsBlJl7mr8b7m4yB5f5KxnSdlDMRph+R3QXYEwUgyoH5hkr9GhE9BY/dDAoOwA==
X-Received: by 2002:a62:b50:: with SMTP id t77mr546315pfi.87.1542380188504;
        Fri, 16 Nov 2018 06:56:28 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id u6sm31591670pgr.79.2018.11.16.06.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 06:56:26 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed USB PHY binding
Date:   Fri, 16 Nov 2018 22:55:58 +0800
Message-Id: <20181116145559.31876-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181116145559.31876-1-shawn.guo@linaro.org>
References: <20181116145559.31876-1-shawn.guo@linaro.org>
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
 .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
new file mode 100644
index 000000000000..b6f8a3eadca6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
@@ -0,0 +1,108 @@
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
+    Definition: Should contain "qcom,qcs404-usb-hsphy".
+
+- reg:
+    Value type: <prop-encoded-array>
+    Definition: USB PHY base address and length of the register map.
+
+- #phy-cells:
+    Value type: <u32>
+    Definition: Should be 0. See phy/phy-bindings.txt for details.
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
+- qcom,init-seq:
+    Value type: <u32 array>
+    Definition: Should contain a sequence of <offset value delay> tuples to
+                program 'value' into phy register at 'offset' with 'delay'
+		in us afterwards.
+
+Optional child nodes:
+
+- The link to the USB connector should be modeled using the OF graph bindings
+  specified in bindings/graph.txt.
+
+Example:
+
+	phy@7a000 {
+		compatible = "qcom,qcs404-usb-hsphy";
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
+
+		port {
+			ep_usb_phy: endpoint {
+				remote-endpoint = <&ep_usb_con>;
+			};
+		};
+	};
-- 
2.18.0

