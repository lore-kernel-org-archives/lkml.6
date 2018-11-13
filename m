Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7F5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B99F2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GUd/iKUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B99F2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbeKMOKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:10:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35041 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMOKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:10:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15-v6so10097117wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 20:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4vtPT1ZqHINrsov+4fmRl7vXniE1/avTYUvgomTImas=;
        b=GUd/iKUaL0AwoSpdmXyk+30lOZbrqP9f80EQcF5BRHomX/eS1DmJ5QBKe4d5QMA/yb
         FCeguS6a4UVW+Isz6FkCVs/eNeYURyfw7T75o+JfpGU/W5WXUuzqBv2lJreyqB6Lo4Fe
         ip28zMQht/crTpVO8js04ZK09DRblmGkcOgvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4vtPT1ZqHINrsov+4fmRl7vXniE1/avTYUvgomTImas=;
        b=ErPy/Pjt9tGUvyknaRSMvi5J5adgnyL1h95fK6Cu538+D/X4PSkeSAYOwjxfUeDCX6
         h5IOJ5CmRjP6XYwnFLjhQOnppXtD2tXAAnrcY+9dpi3SzKiL4ybElY1VKL4XCOsP0eSR
         XbqWMdT6jzwQ6isdt1UVAMCyhq0fNEicAR1hKEhBjLNHYe+xCA7LP8WIQRZAAtidg1WE
         cR4RoBNm2ZsZ12vjgEQs9oRcbAmQh3oxKw1OxDViMyslc7njLSrMiJ4kZv8l7+5KeRl8
         SKNcBUCYKCrHNcr/Z5IDMFGo0s9INqMQMhCjy3qMwOGThAdKwHwYgzx4Jr/aomxFMA4J
         dr6A==
X-Gm-Message-State: AGRZ1gLwAZSMDTVoDkJW+K/OCf6D92gNLchUeSA4skQujv+9BQ8qgdec
        MfH4/1Wk/3aiJ92ou8SahBb1vw==
X-Google-Smtp-Source: AJdET5cpkygtkEZCslNm0FJIU9xdBKMnuNAsp9WOWhxnh/qE7TAJdud7ZfaU9Pm00mD4IkVN7Jq17g==
X-Received: by 2002:a1c:e004:: with SMTP id x4-v6mr1749304wmg.71.1542082439318;
        Mon, 12 Nov 2018 20:13:59 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x2-v6sm12206193wrw.42.2018.11.12.20.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 20:13:58 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Jayachandran C --cc=devicetree @ vger . kernel . org" 
        <jnair@caviumnetworks.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 1/3] dt-bindings: phy: Add binding document for stingray usb phy
Date:   Tue, 13 Nov 2018 09:43:36 +0530
Message-Id: <1542082418-16675-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542082418-16675-1-git-send-email-srinath.mannam@broadcom.com>
References: <1542082418-16675-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding document for stingray usb phy.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../bindings/phy/brcm,stingray-usb-phy.txt         | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
new file mode 100644
index 0000000..bfe1367
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
@@ -0,0 +1,62 @@
+Broadcom Stingray USB PHY
+
+Required properties:
+ - compatible : should be one of the listed compatibles
+	- "brcm,sr-usb-phy"
+	- "brcm,sr-usb-phy-v2"
+ - reg: offset and length of the PHY blocks registers
+ - address-cells: should be 1
+ - size-cells: should be 0
+
+Sub-nodes:
+  Each port's PHY should be represented as a sub-node.
+
+Sub-nodes required properties:
+ - reg: required for brcm,sr-usb-phy model phy.
+	reg value 0 is HS phy and 1 is SS phy.
+ - phy-cells: generic PHY binding; must be 0
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Example:
+	usbphy0: usb-phy@0 {
+		compatible = "brcm,sr-usb-phy";
+		reg = <0x00000000 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb0_phy0: phy@0 {
+			reg = <0>;
+			#phy-cells = <0>;
+		};
+
+		usb0_phy1: phy@1 {
+			reg = <1>;
+			#phy-cells = <0>;
+		};
+	};
+
+	usbphy1: usb-phy@10000 {
+		compatible = "brcm,sr-usb-phy";
+		reg = <0x00010000 0x100>,
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb1_phy0: phy@0 {
+			reg = <0>;
+			#phy-cells = <0>;
+		};
+
+		usb1_phy1: phy@1 {
+			reg = <1>;
+			#phy-cells = <0>;
+		};
+	};
+
+	usbphy2: usb-phy@20000 {
+		compatible = "brcm,sr-usb-phy-v2";
+		reg = <0x00020000 0x100>,
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#phy-cells = <0>;
+	};
-- 
2.7.4

