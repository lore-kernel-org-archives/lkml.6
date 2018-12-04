Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA58C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD28120672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BauX4A9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD28120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeLDWCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:02:39 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40907 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbeLDWCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:02:35 -0500
Received: by mail-io1-f68.google.com with SMTP id n9so14967973ioh.7;
        Tue, 04 Dec 2018 14:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KYL3KgsRyzdlXJO6mH+gF6GpkUdrPdEmyA4kTW54chE=;
        b=BauX4A9ucveCi0+t1lUWFieamvOrCWn5taKlrQeyiqV3UUAfhtyHOQDG9JoFuj+uV4
         67a5e/utHIx3QCByFHXLtWK+Zj1MSaIJP96TDSoPaIeQ18WtqKFXK0fK0Ai2sJe4hiLp
         jKJ4m6a0cizmtnurbRQ0guhEIsLbxox3jp3BEciVAxKDiEJVeCwIW5eW09onXwtF39k8
         M0EtbibA48+RbkTB6WtiGCeiiTOfNKhc9yKXYD5weyy2CjW9woQ3yqraIgFyE/1KLC28
         WV2TGsD5beA7bAQ42jMrcvyMljcAeyebDH00o2zTiOUGBeK/qhhlMv1pDlMyIbFD87Nt
         6ZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KYL3KgsRyzdlXJO6mH+gF6GpkUdrPdEmyA4kTW54chE=;
        b=HO0T6qYxo4W/2trogXM9Q8b4o4oTpxkf+YO0X5fq05mpRuy4Ow5JAVbBOwt93hOZ27
         S8G8bfz4o6dkglKoKjmqhfTlBRPZpXn8ycIbKWD+7MCSxwGkiQxuw3GKWdEDiLDr6v0z
         aOEwZkFpgoPaIfb2y7G3HWbPfJFvH5uz0Uy7+F5ktoO0GEat8u6vvjFTkzMEGBb0tvB9
         rKkNleAH7c5kcEPPKf3JhKSGcydpJohOrix7bxg28X4Wng8YhAA3XRAMBqMCs7w52MyX
         s/wW0YUMZ4glkjPljZ1m1ItAwNs98FteZ6UL/5lLNsxiyfMwc0mfE4IJeKZALH1YqkuG
         34aw==
X-Gm-Message-State: AA+aEWbsLxY7E3LyjehXVE9qN4adUwJCsNjY70GyES+JP41fA+em2gKd
        +BZNLWfSQlHsNSqTXB55t/o=
X-Google-Smtp-Source: AFSGD/VcfC8SJezygIV0hQra8j/4hYR1ABjn7DY4f+udE7EVxSRws9CexHQt4WhWmot7l2gpJHO8Lg==
X-Received: by 2002:a5d:96cc:: with SMTP id r12mr19509539iol.80.1543960954220;
        Tue, 04 Dec 2018 14:02:34 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id m2sm4962544iol.75.2018.12.04.14.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:02:33 -0800 (PST)
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
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 4/6] dt-bindings: anybus-controller: document devicetree binding
Date:   Tue,  4 Dec 2018 17:02:22 -0500
Message-Id: <20181204220224.27324-5-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204220224.27324-1-TheSven73@googlemail.com>
References: <20181204220224.27324-1-TheSven73@googlemail.com>
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

