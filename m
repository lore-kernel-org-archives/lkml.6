Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148A6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85D92086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SI7crVEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85D92086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeK0VFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:05:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37882 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730530AbeK0VFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:05:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so7648169pge.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x5i7/5XJL064OccNs2o8bb+FMlNTe/XBc/lkskb4qJo=;
        b=SI7crVEdMqebg624wiZeDMSIW6pJ5Hg10C0Bqu6igkVOYED7jrZAePHAIwO+G7m+WQ
         0ah5XIs97w9n7HSzauSdm+d4B0zrewvtLctMVDOHksFuatQMQTOA2aBo91aDVBqBFftk
         SGcttAw718qXzKQPZaG1oG7YVcwN+6K/IBTjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x5i7/5XJL064OccNs2o8bb+FMlNTe/XBc/lkskb4qJo=;
        b=kBMmfPGsVWkPIKxnl0YH+8uuhr/YcvIQALSPpVtV48GRD7Hq8qHxVBs2Gc9ZwCYE+w
         Jb2j1EIE5pWMUJSHKNHJJZOUDkl5RtssFWm3aV8OxWG/fboGyR7+WReusD7R84JvFknS
         Wge6v5e8vCksKrwZA9p8uOnxV8h++QrJw8yG77MdIFX0WUzgCKxTugObL3PX3Ym9Agmy
         q6k5kb/qSbb74qMIdF7qGMeFGf2pRaP0U3eqUpA7x7vXBsIWWmPMz2s6gRnZIqUtz0DC
         7SYykwlYWSxE0AExAbgna6UXf5sUS22acDZUVYUgCIfSYW/61bi4K6v6EHiIQdjegkrR
         MYmg==
X-Gm-Message-State: AA+aEWZ3kUg0telcFlAlTAr8VcGkb6pLsIc+3F+FjVTpQ08NMEHG31CW
        Z2PD4dQ1WSi3eMn3bfjavZE1dQ==
X-Google-Smtp-Source: AFSGD/WjI1+HUMH9aq9kms5A1Pbj6V+CWf8XGWosWQfVIbZxfb6kHblWr3ys/VcxB2EJ8vQIodttUg==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr28917796pgj.410.1543313277038;
        Tue, 27 Nov 2018 02:07:57 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id y66-v6sm4006875pfy.24.2018.11.27.02.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 02:07:55 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed USB PHY binding
Date:   Tue, 27 Nov 2018 18:07:21 +0800
Message-Id: <20181127100722.9993-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181127100722.9993-1-shawn.guo@linaro.org>
References: <20181127100722.9993-1-shawn.guo@linaro.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
new file mode 100644
index 000000000000..301987e716fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
@@ -0,0 +1,87 @@
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
+
+		port {
+			ep_usb_phy: endpoint {
+				remote-endpoint = <&ep_usb_con>;
+			};
+		};
+	};
-- 
2.18.0

