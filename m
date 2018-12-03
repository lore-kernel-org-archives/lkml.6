Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C336DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862AD20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KIkbY1UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862AD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeLCIhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:37:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33784 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeLCIhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:37:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so6004334pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 00:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4vtPT1ZqHINrsov+4fmRl7vXniE1/avTYUvgomTImas=;
        b=KIkbY1UFcMvlONe/AAdaZIJFccDwoYh8DXhqLPyc9hpthrrt1bxWItXH240JVRvNb2
         hHHFeRGLkQBofgF+8YzigYKrYfnIzRxqXQePX7RI/29rl+BGho5s9BZxd771zYCcVq6a
         QIszAJAO1ziH02foKK9Pc2Ae5ZDcIcf0DJ05s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4vtPT1ZqHINrsov+4fmRl7vXniE1/avTYUvgomTImas=;
        b=oAq98vi4WMryZetPyOQjGVRs0cO4FjfKHXK7iaqzLAcaDKtl9cW31f6nPjxkm++6NL
         ZZHNXDd7/Gs2UStU5kGuC47HpqRqs4PmYweXv4uD1gZB2NL9tOySL+7O7IqN1OMNQ16B
         sFkTBnnyOfzPL4YnJfZkHjgzcbyLOjo10SkVhwB+NlxjHIny4rFMNdfSZeWcxAg/n07u
         +TCISotjLZg2qYH7mEIBM/FosXa0CBCWDKQe/FYQIQUk9zsjSxGbWnz1b6NzLaC5zsF1
         nu93WTh6tTpJ9P74+bPC0LGlRvye2omJ9ajyrMbKCjRfB99yE9CvhrHJAPlwdq2oLIHJ
         9OuQ==
X-Gm-Message-State: AA+aEWbOt2PYlYu71S+JSYfeoKPk7VvJnE5CUTsYB7GedKw4Eg/ETwet
        zZYOzo3u1Qoeb09l38O7e1DRiA==
X-Google-Smtp-Source: AFSGD/UrCftN9hS1R0fKXFfLHNnbbaUBQ8lomkT3v3ep26h9+hxXdyp4eaYvfM2VWTZP6zMmZexZqQ==
X-Received: by 2002:a62:47d9:: with SMTP id p86mr14689186pfi.95.1543826228998;
        Mon, 03 Dec 2018 00:37:08 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 78sm17304426pft.184.2018.12.03.00.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 00:37:08 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Jayachandran C --cc=devicetree @ vger . kernel . org" 
        <jnair@caviumnetworks.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 1/3] dt-bindings: phy: Add binding document for stingray usb phy
Date:   Mon,  3 Dec 2018 14:06:46 +0530
Message-Id: <1543826208-22742-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543826208-22742-1-git-send-email-srinath.mannam@broadcom.com>
References: <1543826208-22742-1-git-send-email-srinath.mannam@broadcom.com>
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

