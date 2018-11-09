Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690BAC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D95F20989
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGQ8hlAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D95F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeKIXwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:52:17 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38444 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeKIXwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:52:16 -0500
Received: by mail-yw1-f65.google.com with SMTP id i65-v6so1670446ywc.5;
        Fri, 09 Nov 2018 06:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AoHUTHGA1zpUa8UUDtSFA1T498oTPkU+IGtUNuwWsLg=;
        b=SGQ8hlAQ+i/j89KGKLpjQoSfrL64jJyXmL/0NAS++2WDmMG5fPyu8RWIS6QGtBI2Np
         +oOcGiaD1HLQgRHnzUt1DiM87+49B70e8INoHbc0qUIYXXT0l3Q1ENgpQMkshJ4bSRVy
         qxjEUaTeoOfMb9A6GtSvPv7juFEqP+0CKr0V8xrPo0080ywVvXRAaHHUWQv+DMqXC/3V
         ZROzHgczg41K2+XReSIw/NbI+k6Tj3Wqylw8k007wYDBw4MzsQADBxLh0WWAYdnQMYs8
         /1P53IO7qnVa8V1ac3b6NJhrWw/JZyYtxFwvL0eloyFTIeTr0fjO/pOpS1DyHIIfTeSM
         3hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AoHUTHGA1zpUa8UUDtSFA1T498oTPkU+IGtUNuwWsLg=;
        b=SOi4pPlF+2428n0yCp/4mw+sOeApusWWWuNvuF1nIgeI7Hgb9bKqR/L/oi1wFyomg0
         Xd5kBC8UnqQC8UkqaqH1e7dfJDXkXUj6vMzMUIiB6tQEJC1vqXgvtyOgk0sq9CamAAOK
         /BkhX5BdIl0fwwyIJoZelxEnjuk2TnY3iPNQ1zvKNfc6zgQLdZ9K2B/Vxx7BjcJhA4ce
         RWUTazHLBgZt8VS+ZKfqTqJOHAres8F73mdt07KZARmzeoCcBdWTu2JZOiVTgb21kBjz
         55dRtGbgNECQFnCQNp026Mg3aofI81AIFG/nGqD+Q5DLJao8y547SwukKVzaKTvFm2Et
         K8Gg==
X-Gm-Message-State: AGRZ1gKIYqOSSYHYnvnx2Uq5vjVSd6Lwjwyp55UvyxyxYMMAu94iB+s5
        4pUlGokmTggMcG6YuD2bhZQPsDGG6E8=
X-Google-Smtp-Source: AJdET5diYASp+julG1aE6VQS9GIIna9dVSjcBqXdSxSKsaaWT9u7TG35P+XbPOhmzEvSQH1yeBfXew==
X-Received: by 2002:a81:498a:: with SMTP id w132-v6mr8637528ywa.232.1541772689513;
        Fri, 09 Nov 2018 06:11:29 -0800 (PST)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c6-v6sm7301965ywh.34.2018.11.09.06.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 06:11:29 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH V4 1/5] dt-bindings: Add Broadcom STB USB support
Date:   Fri,  9 Nov 2018 09:01:56 -0500
Message-Id: <1541772120-40394-2-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1541772120-40394-1-git-send-email-alcooperx@gmail.com>
References: <1541772120-40394-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Broadcom STB USB EHCI and XHCI drivers.
Add "phy-supplies-usb-clock" property description to usb-hcd.txt

NOTE: The OHCI driver is not included because it uses the generic
      platform driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../devicetree/bindings/usb/brcm,bcm7445-ehci.txt  | 24 ++++++++++++++++++++++
 Documentation/devicetree/bindings/usb/usb-hcd.txt  |  3 +++
 Documentation/devicetree/bindings/usb/usb-xhci.txt |  1 +
 3 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt

diff --git a/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt
new file mode 100644
index 000000000000..4dea956f2705
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt
@@ -0,0 +1,24 @@
+Broadcom STB USB EHCI controller
+
+Required properties:
+- compatible: should be "brcm,bcm7445-ehci"
+- reg: should contain one register range i.e. start and length
+- interrupts: description of the interrupt line
+- phys: phandle + phy specifier pair
+  The specifier should be 0 for the OHCI/EHCI PHY
+- phy-supplies-usb-clock: See usb-hcd.txt for details.
+
+Optional properties:
+- clocks: A phandle for the EHCI clock
+
+Example:
+
+ehci@f0b00300 {
+	compatible = "brcm,bcm7445-ehci";
+	reg = <0xf0b00300 0xa8>;
+	interrupts = <0x0 0x5a 0x0>;
+	interrupt-names = "usb0_ehci_0";
+	phys = <&usbphy_0 0x0>;
+	clocks = <&usb20>;
+	phy-supplies-usb-clock;
+};
diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.txt b/Documentation/devicetree/bindings/usb/usb-hcd.txt
index 50529b838c9c..6b4755924b15 100644
--- a/Documentation/devicetree/bindings/usb/usb-hcd.txt
+++ b/Documentation/devicetree/bindings/usb/usb-hcd.txt
@@ -2,6 +2,9 @@ Generic USB HCD (Host Controller Device) Properties
 
 Optional properties:
 - phys: a list of all USB PHYs on this HCD
+- phy-supplies-usb-clock: boolean, used for SoCs where the PHY supplies
+  the usb controller clock. This will prevent the PHY exit from being
+  called on suspend.
 
 Example:
 	&usb1 {
diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index fea8b1545751..f58e617ee54c 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -21,6 +21,7 @@ Required properties:
       device
     - "renesas,rcar-gen3-xhci" for a generic R-Car Gen3 or RZ/G2 compatible
       device
+    - "brcm,bcm7445-xhci" for Broadcom STB SoCs
     - "xhci-platform" (deprecated)
 
     When compatible with the generic version, nodes must list the
-- 
1.9.0.138.g2de3478

