Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29EEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9912086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="QlfbeeSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9912086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeK0CX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:23:29 -0500
Received: from plaes.org ([188.166.43.21]:50026 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbeK0CWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:22:42 -0500
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id BA6D7419F3;
        Mon, 26 Nov 2018 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1543246093; bh=2y/7SIgzDiOCzHzW9rhbAuXxYi5ONCzQRe3PFNumDZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QlfbeeSYfkpSMoKsFb72/itqF/XK4u2jnYQ2y1h6uuWjH3M1NpkqjDB9+yg02duNb
         9ms1kuxAeZuxpEx2kPaA+R2d2SiyEvDmtLd3B7HTBVIQiaehTrBwAsZ8EFu3MKTTq7
         tkVlTb5B1nxkLmG1K3h8u7NqPgLWKUXwhK7VeMnvgVkjv3o3cCjpHQlWbqOjQy4tfT
         ocqsDjJHsfsTRVfteBtZol/MtPtSAuKanetdQYO6HAni0W3cWIRvqngM0UYuduI2Cy
         cPzEIKWU8V14nHdmze9pGKFXmNmvBqyNdmxE1chQn4byYl7mUXIb8ZV9Eq9KdiSFM5
         Vciyp2yhH0Idw==
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
Subject: [PATCH 07/14] dt-bindings: mfd: axp20x: Add software based soft_start for AXP209 LDO3
Date:   Mon, 26 Nov 2018 17:27:48 +0200
Message-Id: <2cd75ee27982f3be0d86104d80eaa13efeb2c65d.1543245984.git-series.plaes@plaes.org>
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

In the past, there have been words on various lists that if LDO3 is
disabled in u-boot, but enabled in the DTS, the axp209 driver would
fail to continue/hang. Several enable/disable patches have been
issues to devicetree's in both the kernel and u-boot to address
this issue.

What really happened however, was that the AXP209 shuts down without
a notice and without setting an interrupt. This is caused when LDO3
gets overloaded, for example with large capacitors on the LDO3 output.

Normally, we would expect that AXP209 would source 200 mA as per
datasheet and set and trigger an interrupt when being overloaded.
For some reason however, this does not happen.

As a work-around, implement software-based 'regulator-soft-start'
property for AXP209 LDO3 regulator, which is used to first bring up
the LDO3 to the lowest possible voltage and then enable the LDO.

After that, we can set the requested voltage as usual.

Combining this setting with the regulator-ramp-delay allows LDO3 to
come up slowly and staggered, potentially reducing overall inrush current.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 5542212..7e97bb7 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -36,6 +36,9 @@ Supported common regulator properties, see regulator.txt for more information:
 - regulator-ramp-delay: sets the ramp up delay in uV/us
 			AXP20x/DCDC2: 1600, 800
 			AXP20x/LDO3:  1600, 800
+- regulator-soft-start:	enable the output at the lowest possible voltage and
+			only then set the desired voltage
+			AXP20x/LDO3
 
 Optional properties:
 - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
-- 
git-series 0.9.1
