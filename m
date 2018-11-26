Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A538CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D08213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="DAeLnSct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D08213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeK0CWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:22:41 -0500
Received: from plaes.org ([188.166.43.21]:49992 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbeK0CWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:22:40 -0500
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id 5660841437;
        Mon, 26 Nov 2018 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1543246092; bh=6EKNczPzAeRmYVbTYMAGxPpSb8ylewUfArbtCQEqQ8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DAeLnSctjEHrv0VtbEodU5v6ZrERG4na7i1pWutAANPvY8uotH+LpBiYIfhhBvSZl
         3D0le5p2qa9Eb0EU3tcKuSNWtlC9KsK+GZlZeEKm4m2IrnFI3E2GHcXND3eurvrIWb
         V0rYeR2B4LF//dWntXY1yIW1GulN0NjbS9nATXJru8AQQqcJQOx1iu+8TBl3HIUqmy
         8TRGQAn9JUDoMFufdJbT0tlxixqCATFJZGCk0lyX9zmN8N6Cj+UXec6+zqI0/znr/6
         tSPTMofvVoDfg4dDB/GuJBayXiCdcs4wJXWYrKXLNJOe630B6QTFW69fMskb/FULCl
         zgJADnjpHevrg==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH 05/14] dt-bindings: mfd: axp20x: add support for regulator-ramp-delay for AXP209
Date:   Mon, 26 Nov 2018 17:27:46 +0200
Message-Id: <4333f81dfa1d9be082b09ab9ddf2694cb56285e2.1543245984.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

The AXP209 supports ramping up voltages on several regulators such as
DCDC2 and LDO3, therefore we can use the standard 'regulator-ramp-delay'
property for those 2 regulators.

Note that the voltage ramp only works when the regulator is already
enabled. E.g. when going from say 0.7 V to 3.6 V.

When turning on the regulator, no voltage ramp is performed in hardware.

What this means, is that if the bootloader brings up the voltage at 0.7 V,
the ramp delay property is properly applied. If however, the bootloader
leaves the power off, no ramp delay is applied when the power is
enabled by the regulator framework.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 188f037..5542212 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -32,6 +32,11 @@ Required properties:
 - interrupt-controller: The PMIC has its own internal IRQs
 - #interrupt-cells: Should be set to 1
 
+Supported common regulator properties, see regulator.txt for more information:
+- regulator-ramp-delay: sets the ramp up delay in uV/us
+			AXP20x/DCDC2: 1600, 800
+			AXP20x/LDO3:  1600, 800
+
 Optional properties:
 - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
 		      AXP152/20X: range:  750-1875, Default: 1.5 MHz
-- 
git-series 0.9.1
