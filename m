Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836F7C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A934247D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A934247D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934500AbeFVT3v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:29:51 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:49468 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934403AbeFVT3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:29:48 -0400
Received: from belgarion.home ([90.55.203.186])
        by mwinf5d28 with ME
        id 1vUj1y00T41oiFu03vVVZU; Fri, 22 Jun 2018 21:29:47 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 22 Jun 2018 21:29:47 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 1/2] ALSA: ac97: add bus binding for codecs
Date:   Fri, 22 Jun 2018 21:28:33 +0200
Message-Id: <20180622192834.7797-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the generic ac97 bus binding, especially for ac97 codecs discovered
by ac97 hardware probing.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 .../devicetree/bindings/sound/ac97-bus.txt         | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ac97-bus.txt

diff --git a/Documentation/devicetree/bindings/sound/ac97-bus.txt b/Documentation/devicetree/bindings/sound/ac97-bus.txt
new file mode 100644
index 000000000000..103c428f2595
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ac97-bus.txt
@@ -0,0 +1,32 @@
+Generic AC97 Device Properties
+
+This documents describes the devicetree bindings for an ac97 controller child
+node describing ac97 codecs.
+
+Required properties:
+-compatible : Must be "ac97,vendor_id1,vendor_id2
+	      The ids shall be the 4 characters hexadecimal encoding, such as
+	      given by "%04x" formatting of printf
+-reg	    : Must be the ac97 codec number, between 0 and 3
+
+Example:
+ac97: sound@40500000 {
+	compatible = "marvell,pxa270-ac97";
+	reg = < 0x40500000 0x1000 >;
+	interrupts = <14>;
+	reset-gpios = <&gpio 95 GPIO_ACTIVE_HIGH>;
+	#sound-dai-cells = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = < &pinctrl_ac97_default >;
+	clocks = <&clks CLK_AC97>, <&clks CLK_AC97CONF>;
+	clock-names = "AC97CLK", "AC97CONFCLK";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	audio-codec@0 {
+		reg = <0>;
+		compatible = "ac97,574d,4c13";
+		clocks = <&fixed_wm9713_clock>;
+		clock-names = "ac97_clk";
+	}
+};
-- 
2.11.0

