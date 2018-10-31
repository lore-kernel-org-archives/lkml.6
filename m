Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44372ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26B320664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll5Ij45U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26B320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbeKAEoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:44:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39501 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbeKAEoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:44:03 -0400
Received: by mail-io1-f67.google.com with SMTP id n11-v6so10592820iob.6;
        Wed, 31 Oct 2018 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NAq4ELEXCMzh9jINLadcRxpvfiGusbEr8xPYf6DHyyI=;
        b=ll5Ij45U+IjWu+ZCV6R1Acqogt3GVnQKVdBqa2fitEvGojB+tJVTgueEfQ+4dDiLsv
         doijyOr3tu+1CJ039eChLx8jLcilk9xzS7YmLlsn+YaFcBCqR/WFjxRFy6zn3evoNS7d
         2s4ZraAL4UXG0NTPvgs5N37nbEESnuZcyfExOm5YeLNmOR6t0mpTBLQDNwEjQ3VYt7rV
         P8zTGdENveWUud94yhZPjvPWgKGcnUTWYkGtIjEmAiojzUxsClOp3/qqEXuy31j7CXV6
         Uq5fJdnVokleD/N6dREIirf0CXFrlF0x+CtA4l2b+mLb4lhPtjYJse/4PD3AO/p34qxF
         nsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NAq4ELEXCMzh9jINLadcRxpvfiGusbEr8xPYf6DHyyI=;
        b=H1Ec/KieVR9QDbES+EpSR/lH6lDs12zMpPLSqhPKXwkyHPqNrRefOW9J136CBLphkE
         XJCT/jCZK3+fYwg4veGNw0/qX3VKg5M7YI1oy0teBesATYmLh3AZiuQIWZlBzQwEq/o3
         m9QS6Fq7PnwTlw4FyufVw/wvy3YmdpOk6ZL9pQOv94ohHybSMAYddyY3L79lYJ/d65Gy
         CsxTNnt108TqS70fsHeCkRSxlL7UDx4sWFjwzFy4SjjX6LzuGl7Sf1zBatzya43t93SP
         IEnYwgDpJ1Db1CIZsMV5fHCpOTTtr63YEJY0AYjuNqFOqf94xFveGzcgnkmNdsAn+dkL
         YCTQ==
X-Gm-Message-State: AGRZ1gLaCtH7XGsGhdxwBW9/cHmsJ0K6yPuOnv3crKS3jdUiLr+AdLOe
        JOGbZetmnVrrH1eP7IujYFI=
X-Google-Smtp-Source: AJdET5ef0wtxxjg2mFBlxp+fUT1smq5k5/Zl/NmeROnyqlXQG7eZoCEyPueyNTWo77uOHUAy8YQ9KA==
X-Received: by 2002:a6b:9246:: with SMTP id u67-v6mr3056403iod.289.1541015072379;
        Wed, 31 Oct 2018 12:44:32 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id u142-v6sm7136606itb.13.2018.10.31.12.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:44:31 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, linus.walleij@linaro.org,
        maxime.ripard@bootlin.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH anybus v2 2/5] dt-bindings: anybus-bridge: document devicetree binding.
Date:   Wed, 31 Oct 2018 15:44:22 -0400
Message-Id: <20181031194425.32132-3-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031194425.32132-1-TheSven73@googlemail.com>
References: <20181031194425.32132-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

This patch adds devicetree binding documentation for the
Arcx anybus bridge.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 .../bindings/misc/arcx,anybus-bridge.txt      | 34 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/arcx,anybus-bridge.txt

diff --git a/Documentation/devicetree/bindings/misc/arcx,anybus-bridge.txt b/Documentation/devicetree/bindings/misc/arcx,anybus-bridge.txt
new file mode 100644
index 000000000000..cb801b7568b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/arcx,anybus-bridge.txt
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
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc512e746..1bf07b20a8af 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -35,6 +35,7 @@ aptina	Aptina Imaging
 arasan	Arasan Chip Systems
 archermind ArcherMind Technology (Nanjing) Co., Ltd.
 arctic	Arctic Sand
+arcx	Arcx/Archronix Inc.
 aries	Aries Embedded GmbH
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
-- 
2.17.1

