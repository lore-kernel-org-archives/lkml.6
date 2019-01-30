Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E42C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C4020989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFDxQf+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733295AbfA3Sup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:50:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39390 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733269AbfA3Sum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:50:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so628165wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b8M0eSUZUgsVMGxbQEiMn7Shg3Ln/ABC8nhad3aEAW8=;
        b=dFDxQf+czaJhUfGeIlbm70Wl9zp/5W1fiO5HXUnNF2AMiVHO0EhU23lql7yB/Z0f+I
         SpdhfHqPOpr+RjZMAIKeT7MDhSIO/78jUyICa+tBMVrZRajRAOeXdSMLUtev57k1q+Xl
         MO+RwsBYQoB8DOETq66dEJllaU03UjJfG6gNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b8M0eSUZUgsVMGxbQEiMn7Shg3Ln/ABC8nhad3aEAW8=;
        b=IaXNECGHuxNEKo44SGqiYZ9JIJjhkA5T3gzCIjoIGbfGdKZdjjzUHfvSKmrXR5W/qZ
         B29WKAHqnwA7sCFsLQm5xZAAszjqZNp0iFT29McJFTHMk1vuu0FoR9vZy7qk5PyMIdyp
         TeR04rVqgTu8K0mZiBg8aAwAeVKeFcNuDMnywhBDeyms4+CGN4OtWUVxzJApIEPAnl4M
         /1vxohjjBIyzlDOHsXlxeIBD4aqMKBIflHzeDz0+dWQSjvIHEuFKeIBBX7yFUH1Dh167
         bWh2GM76jMbgq/lVM6rrBNJUEJUDvmzWTnpA7WTVZuUjyfUsQMmZUs29lyCPc3pPJh8h
         aUZA==
X-Gm-Message-State: AHQUAuZ5912ZOLFbRZVQ1irAAwEMmSo1hOwnn+gKtZjIQnuDTWac1z7F
        6qUQ8my1XT4aAeAHqV5MEn9G3w==
X-Google-Smtp-Source: AHgI3Ia4JDkY7jy1nqI65XPeHAMK3bonriibvkW57xRkiJeNQzfJsiPjMIfqqrcwnLxbVqvNsPFYiA==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr10756623wrp.92.1548874241097;
        Wed, 30 Jan 2019 10:50:41 -0800 (PST)
Received: from localhost.localdomain (99.red-79-146-83.dynamicip.rima-tde.net. [79.146.83.99])
        by smtp.gmail.com with ESMTPSA id a17sm2802575wrs.58.2019.01.30.10.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 10:50:40 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org
Cc:     shawn.guo@linaro.org, vkoul@kernel.org, khasim.mohammed@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
Date:   Wed, 30 Jan 2019 19:50:30 +0100
Message-Id: <20190130185031.24798-2-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130185031.24798-1-jorge.ramirez-ortiz@linaro.org>
References: <20190130185031.24798-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding description for Qualcomm's 1.0.0 SuperSpeed phy controller 
embedded in QCS404.

Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
definitions.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 .../bindings/usb/qcom,usb-ssphy.txt           | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt

diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
new file mode 100644
index 000000000000..83748a07d665
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
@@ -0,0 +1,74 @@
+Qualcomm Synopsys 1.0.0 SS phy controller
+===========================================
+
+Qualcomm 1.0.0 SS phy controller supports SuperSpeed USB connectivity on
+some Qualcomm platforms.
+
+Required properties:
+
+- compatible:
+    Value type: <string>
+    Definition: Should contain "qcom,usb-ssphy".
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
+		 three clock specifiers for reference, phy core and
+		 pipe clocks.
+
+- clock-names:
+    Value type: <string>
+    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
+		 property. Must contain "ref", "phy" and "pipe".
+
+- vdd-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator VDD supply node.
+
+- vdda1p8-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator 1.8V supply node.
+
+
+Optional child nodes:
+
+- vbus-supply:
+    Value type: <phandle>
+    Definition: phandle to the VBUS supply node.
+
+- resets:
+    Value type: <prop-encoded-array>
+    Definition: See reset.txt section "consumers". PHY reset specifiers
+		 for phy core and COR resets.
+
+- reset-names:
+    Value type: <string>
+    Definition: Names of the resets in 1-1 correspondence with the "resets"
+		 property. Must contain "com" and "phy" if the property is
+		 specified.
+
+Example:
+
+usb3_phy: phy@78000 {
+	compatible = "qcom,usb-ssphy";
+	reg = <0x78000 0x400>;
+	#phy-cells = <0>;
+	clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+		 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+		 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+	clock-names = "ref", "phy", "pipe";
+	resets = <&gcc GCC_USB3_PHY_BCR>,
+		 <&gcc GCC_USB3PHY_PHY_BCR>;
+	reset-names = "com", "phy";
+	vdd-supply = <&vreg_l3_1p05>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	vbus-supply = <&usb3_vbus_reg>;
+};
-- 
2.20.1

