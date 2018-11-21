Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3531FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F337821479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrW5VD0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F337821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbeKVBmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:42:15 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38981 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731247AbeKVBmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:42:14 -0500
Received: by mail-io1-f66.google.com with SMTP id j18-v6so4271382iog.6;
        Wed, 21 Nov 2018 07:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dbIQJuoNL+48HqQHud4xgmhrJCUFJQZgJZ4r/a+VH18=;
        b=ZrW5VD0ipywfPfcNkSbCpFCdo5paZlEz/yxeJKtZP/TZkAmbWBN20gkoLoaklTQY3s
         6rgEcFg66/Df9UFZ7ZBdnV3CT4eAwcCsE75KvGsTj7rsQ2tFQs6v6aPQbpcUeFNbn69U
         xAvR0WLes+vRi6jLVritWKLL6eov88L34lx8um0ILaFx4ptQF4veZvRQMaQ3kko/nFmy
         leHS7Qeu5AMKRBn0V9aqrMGcjjP9wH4C/SIWUVw+48C9Z5NyqUvmaZPw3abi4o2iVgZP
         xbJufsj1bweJtG9nOfcYamcwHapX7yjcs+yXDACgB6llv/yVmGH8EQRZdv39nl77FjqD
         /Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dbIQJuoNL+48HqQHud4xgmhrJCUFJQZgJZ4r/a+VH18=;
        b=AzGS2pVAgnfQDBMKcVll4AdvVBgZFEjIi+XI1XF7/rtMfPnygdB97hW8kqmNdj9wr0
         NmFJ6EGbAYfTRATFlIAaZrcSLwR2thbaEPdeedHpHZ2y6dskf+WKJc7fXFIouzR244Vc
         3yq40f4BHQmKa8PEc43PN925xEeVkJaQYXxA0/+vEtSzbqRE/bJ3Mr6XGHsFd7tYAE60
         ssWN0Q+PMv7uujuUYqG+WpAklSNhQy7QxPSx8Vsuxb9PpftHpTxN5gsWn8wWIVpmWs5J
         YkrIpJtnszbXiu5IwRyy3nIUPaS9KdoL1bEk8XPf4j5SARLEnSQivLonlD6zOlLpU9RG
         Bc9w==
X-Gm-Message-State: AA+aEWYQjTQWUXdFvAzf642Eep7Jt0iwD64QowlfM0GlyUNA5jmAWxsU
        78nSvGyTUi0UjA7s1oKnkwc=
X-Google-Smtp-Source: AFSGD/U8VacWKZK1fmYDR2ljj/j0l9DnfoRi8OXKmTACpRwfNUzFeyceNs/sbFXiaiYKxDodlNiM8g==
X-Received: by 2002:a6b:b345:: with SMTP id c66mr5109027iof.59.1542812845400;
        Wed, 21 Nov 2018 07:07:25 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id c3sm5113119ioi.2.2018.11.21.07.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 07:07:24 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
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
Subject: [PATCH anybus v4 4/7] dt-bindings: anybus-bridge: document devicetree binding
Date:   Wed, 21 Nov 2018 10:07:06 -0500
Message-Id: <20181121150709.6030-5-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121150709.6030-1-TheSven73@googlemail.com>
References: <20181121150709.6030-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds devicetree binding documentation for the
Arcx anybus bridge.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 .../bindings/fieldbus/arcx,anybus-bridge.txt  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybus-bridge.txt

diff --git a/Documentation/devicetree/bindings/fieldbus/arcx,anybus-bridge.txt b/Documentation/devicetree/bindings/fieldbus/arcx,anybus-bridge.txt
new file mode 100644
index 000000000000..cb801b7568b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/fieldbus/arcx,anybus-bridge.txt
@@ -0,0 +1,34 @@
+* Arcx anybus bridge
+
+This chip communicates with the SoC over a parallel bus. It is
+expected that its Device Tree node is specified as the child of a node
+corresponding to the parallel bus used for communication.
+
+Required properties:
+
+  - compatible : The following chip-specific string:
+        "arcx,anybus-bridge"
+
+  - reg : bus memory area where the cpld registers are located.
+
+  - reset-gpios : the GPIO pin connected to the reset line of the bridge.
+
+  - #reset-cells : Must be 1.
+	this bridge is a reset provider to its two embedded Anybus-S slots.
+
+Example of usage:
+
+This example places the bridge on top of the i.MX WEIM parallel bus, see:
+Documentation/devicetree/bindings/bus/imx-weim.txt
+
+&weim {
+	anybus_bridge: bridge@0,0 {
+		compatible = "arcx,anybus-bridge";
+		reg = <0 0 0x100>;
+		reset-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		#reset-cells = <1>;
+		/* fsl,weim-cs-timing is a i.MX WEIM bus specific property */
+		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
+				0x00000000 0xa0000240 0x00000000>;
+	};
+};
-- 
2.17.1

