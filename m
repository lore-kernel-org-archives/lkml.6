Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5D3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41012145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41012145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeLCO6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:58:34 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:50694 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbeLCO6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:58:34 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 4E66A5FD80; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v2 02/14] dt-bindings: rtc: sun6i-rtc: Add compatible strings for pre-H6 variants
Date:   Mon,  3 Dec 2018 22:58:13 +0800
Message-Id: <20181203145825.20511-3-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
References: <20181203145825.20511-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing Bluetooth enablement for various boards based on various
Allwinner SoCs, minor differences in the RTC modules were found. These
include a lack of an external clock output (A31), different internal
oscillator frequencies (H3/H5/A64/V3/V3s), different regulator voltage
settings (H5/H6), and the presence of miscellaneous registers unrelated
to the RTC (A64/R40/H5/H6). The datasheet also describes different number
of registers for non-volatile storage, though based on actual experiments
the actual number is the same across the board.

This patch adds a list of all pre-H6 variants, grouped by the internal
oscillator's clock rate, regulator settings, and the presence of the
external clock output. Combinations are introduced for the variants that
have miscellaneous registers.

The RTC block in the H6 also handles the 24 MHz DCXO. This will require
more device tree binding changes and will be done later.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/rtc/sun6i-rtc.txt        | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index fed0d58cbfec..037ec475f412 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -3,7 +3,21 @@
 RTC controller for the Allwinner A31
 
 Required properties:
-- compatible	: Should be "allwinner,sun6i-a31-rtc"
+- compatible	: Should be one of the following combinations:
+		    - "allwinner,sun6i-a31-rtc"
+		    - "allwinner,sun8i-a23-rtc"
+		    - "allwinner,sun8i-h3-rtc"
+		    - "allwinner,sun8i-r40-rtc", "allwinner,sun8i-h3-rtc"
+		    - "allwinner,sun8i-v3-rtc"
+		    - "allwinner,sun50i-a64-rtc", "allwinner,sun8i-h3-rtc"
+		    - "allwinner,sun50i-h5-rtc"
+
+		  Where there are two or more compatible strings, this
+		  denotes the hardware covered by the most specific one
+		  is backward-compatible with the latter ones, and the
+		  implementation for the latter ones can be used, albeit
+		  with reduced functionality.
+
 - reg		: physical base address of the controller and length of
 		  memory mapped region.
 - interrupts	: IRQ lines for the RTC alarm 0 and alarm 1, in that order.
-- 
2.20.0.rc1

