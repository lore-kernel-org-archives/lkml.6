Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEE5C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59762084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="c7MgmDx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59762084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeLKPR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:17:26 -0500
Received: from plaes.org ([188.166.43.21]:59618 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbeLKPRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:17:23 -0500
Received: from localhost (unknown [213.204.46.240])
        by plaes.org (Postfix) with ESMTPSA id 5DE9541289;
        Tue, 11 Dec 2018 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1544541441; bh=snlyZLidIJEaCnhVA6nQ3LGjhvn8FydspTFdTImmP0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7MgmDx9DJLinzSnvgYeehR6oxBBjhN6sfII3g77a3+YcmFKIc2+DW71ABMJ7XZBO
         BPyrnGgsqFnp9MLtW3O21DWnFNhpW9CvtFyJJfy5xuVGqkhRPYUlG0PhMPrcNEOtTd
         77rquDIP6CxjtiV6wfRbaLYrGrBr0LBRjeXw4Z3q6Nf6EBb8eN7A8rZ8rQaw9q72Cl
         6UlrmOkbXazg76Hmym3D5tz0VVWkX1pHHBGYyQ+bJbJo4OidLk6InKxMWM5Avcs1Um
         KBlNg7Pnb+sTv6a3QT+6baskHeCOqaJT5k4JrEDAFC19kwfr5Gnu1CrSOM/LWrdf0E
         R7dxb9fA+W2ig==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH v2 5/8] dt-bindings: mfd: axp20x: Add software based soft_start for AXP209 LDO3
Date:   Tue, 11 Dec 2018 17:17:09 +0200
Message-Id: <25e67fe9b5397aa5f11bdd7026e4ae6be51dd18b.1544512919.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
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
index c626605..2af4ff9 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -37,6 +37,9 @@ more information:
 - regulator-ramp-delay: sets the ramp up delay in uV/us
 			AXP20x/DCDC2: 1600, 800
 			AXP20x/LDO3:  1600, 800
+- regulator-soft-start:	enable the output at the lowest possible voltage and
+			only then set the desired voltage
+			AXP20x/LDO3: software-based implementation
 
 Optional properties:
 - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
-- 
git-series 0.9.1
