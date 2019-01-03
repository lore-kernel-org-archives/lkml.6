Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2E2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F963208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0uwJ9+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbfACQQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:16:11 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46738 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfACQPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:15:53 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so27378324ios.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KYL3KgsRyzdlXJO6mH+gF6GpkUdrPdEmyA4kTW54chE=;
        b=r0uwJ9+W0CSxyn4caSw2/SJJAR7qkpJtgdUK/ptrxoFfnv+gk9SmIOCVqTvLcWnvW6
         12vAyrAWVAuWUQD5UNLfcBkDcVV80yJlnS/9lgiTVZeLkhiX8R+uebKrjBEcM3rY7UwE
         AfBeX8zcvZmz+gaLgp/E0c+MyMUBsrhNbR9/o3+oYl8zIc+icKBwdw5ZTKGF77KBC/iY
         ltrktn9bqus/n+FxjqKvGFCUBlCeP24EsfNtZ+2eHaMcDypgD22Pqon0O2sGoP8KOVKZ
         vzNlO5JBfMkmP68x1DeWkpXGZji6ZydIX/G4ClJ6wobIxyi2weVFI8SdZayKq7Ky/yV/
         V+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KYL3KgsRyzdlXJO6mH+gF6GpkUdrPdEmyA4kTW54chE=;
        b=T8DWUTg58SGkqLFIIdMcWpFMRPubAxohKmRM8yXRkLzXUVGUwpJxWGaaEUl0a/b964
         hjjM9qNEGeKKUWOvQedCslT17QakWg+RTJiwb31WYVDP/a7fdQU6MMz4U86aFzaPISWm
         b680OhLhtkW5N7BHxYrZDjkZ3+o5cwDP/NrpCLj2wiqnwuez9XNSDsGaHJTLhWvrSKqI
         k7HWIAfk0o8L2+tKBaVISDGVw1b2GiRFkomDb1DAc0XF6Dx2FgewwSorOg1bcIyWvUxs
         QK8RxK4bUR+kk5jbufuXOZKrfPWAXhEKFEUb0/KteFUn52DC9maWURYDbNAUTXYSdavN
         Cp5g==
X-Gm-Message-State: AJcUukcyUP7yspJ1EhdcbkHmQPXa1T4yFy7B2E+sSliDiWOW6g47PnEr
        IIc6Q5nh+u5SJZveg70Gh/k=
X-Google-Smtp-Source: ALg8bN4qyBlYolXlt7kfpo4uWBjstBomqM12AP4ehRYPZGASltgNchF2F2l1G8n3wzzB7rwSSBjGtw==
X-Received: by 2002:a5e:dd02:: with SMTP id t2mr2888275iop.106.1546532153116;
        Thu, 03 Jan 2019 08:15:53 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id d11sm6018423ioq.31.2019.01.03.08.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 08:15:52 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH fieldbus v6 4/6] dt-bindings: anybus-controller: document devicetree binding
Date:   Thu,  3 Jan 2019 11:15:36 -0500
Message-Id: <20190103161538.20637-5-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190103161538.20637-1-TheSven73@googlemail.com>
References: <20190103161538.20637-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

This patch adds devicetree binding documentation for the
Arcx anybus controller.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 .../fieldbus/arcx,anybus-controller.txt       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt

diff --git a/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt b/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
new file mode 100644
index 000000000000..b1f9474f36d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
@@ -0,0 +1,71 @@
+* Arcx Anybus-S controller
+
+This chip communicates with the SoC over a parallel bus. It is
+expected that its Device Tree node is specified as the child of a node
+corresponding to the parallel bus used for communication.
+
+Required properties:
+--------------------
+
+  - compatible : The following chip-specific string:
+        "arcx,anybus-controller"
+
+  - reg : three areas:
+	index 0: bus memory area where the cpld registers are located.
+	index 1: bus memory area of the first  host's dual-port ram.
+	index 2: bus memory area of the second host's dual-port ram.
+
+  - reset-gpios : the GPIO pin connected to the reset line of the controller.
+
+  - interrupts : two interrupts:
+		index 0: interrupt connected to the first  host
+		index 1: interrupt connected to the second host
+	Generic interrupt client node bindings are described in
+	interrupt-controller/interrupts.txt
+
+Optional: use of subnodes
+-------------------------
+
+The card connected to a host may need additional properties. These can be
+specified in subnodes to the controller node.
+
+The subnodes are identified by the standard 'reg' property. Which information
+exactly can be specified depends on the bindings for the function driver
+for the subnode.
+
+Required controller node properties when using subnodes:
+- #address-cells: should be one.
+- #size-cells: should be zero.
+
+Required subnode properties:
+- reg: Must contain the host index of the card this subnode describes:
+		<0>	for the first  host on the controller
+		<1>	for the second host on the controller
+	Note that only a single card can be plugged into a host, so the host
+	index uniquely describes the card location.
+
+Example of usage:
+-----------------
+
+This example places the bridge on top of the i.MX WEIM parallel bus, see:
+Documentation/devicetree/bindings/bus/imx-weim.txt
+
+&weim {
+	controller@0,0 {
+		compatible = "arcx,anybus-controller";
+		reg = <0 0 0x100>, <0 0x400000 0x800>, <1 0x400000 0x800>;
+		reset-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>, <5 IRQ_TYPE_LEVEL_LOW>;
+		/* fsl,weim-cs-timing is a i.MX WEIM bus specific property */
+		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
+				0x00000000 0xa0000240 0x00000000>;
+		/* optional subnode for a card plugged into the first host */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		card@0 {
+			reg = <0>;
+			/* card specific properties go here */
+		};
+	};
+};
-- 
2.17.1

