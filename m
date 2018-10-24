Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URI_TRY_3LD,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B05ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C61920831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C61920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeJYDM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:12:29 -0400
Received: from anholt.net ([50.246.234.109]:53120 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbeJYDM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:12:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D4B0010A1311;
        Wed, 24 Oct 2018 11:43:17 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id n0wQEuPwoHv0; Wed, 24 Oct 2018 11:43:14 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C5B3110A1218;
        Wed, 24 Oct 2018 11:43:14 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 741BC2FE1BEF; Wed, 24 Oct 2018 11:43:13 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/3] dt-bindings: new binding for Himax HX8357D display panels
Date:   Wed, 24 Oct 2018 11:43:11 -0700
Message-Id: <20181024184313.2967-2-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181024184313.2967-1-eric@anholt.net>
References: <20181024184313.2967-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new binding for Himax HX8357D display panels. It includes
a compatible string for one display (more can be added in the future).

The YX350HV15 panel[1] is found in the Adafruit PiTFT 3.5" Touch
Screen for Raspberry Pi.

[1] https://learn.adafruit.com/adafruit-pitft-3-dot-5-touch-screen-for-raspberry-pi/downloads

This binding is closely modeled after the ili9341 binding, for a
similar product from adafruit.  The primary difference is that the
hx8367d doesn't have a reset line that I can find in the schematics.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/display/himax,hx8357d.txt        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/himax,hx8357d.txt

diff --git a/Documentation/devicetree/bindings/display/himax,hx8357d.txt b/Documentation/devicetree/bindings/display/himax,hx8357d.txt
new file mode 100644
index 000000000000..48586e570be0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/himax,hx8357d.txt
@@ -0,0 +1,25 @@
+Himax HX8357D display panels
+
+This binding is for display panels using a Himax HX8357D controller in SPI
+mode, such as the Adafruit 3.5" TFT for Raspberry Pi.
+
+Required properties:
+- compatible:	"adafruit,yx350hv15", "himax,hx8357d"
+- dc-gpios:	D/C pin
+
+The node for this driver must be a child node of a SPI controller, hence
+all mandatory properties described in ../spi/spi-bus.txt must be specified.
+
+Optional properties:
+- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
+- backlight:	phandle of the backlight device attached to the panel
+
+Example:
+	display@0{
+		compatible = "adafruit,yx350hv15", "himax,hx8357d";
+		reg = <0>;
+		spi-max-frequency = <32000000>;
+		dc-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
+		rotation = <90>;
+		backlight = <&backlight>;
+	};
-- 
2.19.1

