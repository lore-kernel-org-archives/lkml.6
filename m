Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6ACECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226DC20850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226DC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbeGVWSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:18:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:38772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387732AbeGVWS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:18:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8540BADC0;
        Sun, 22 Jul 2018 21:20:24 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 15/15] clk: pistachio: Fix wrong SDHost card speed
Date:   Sun, 22 Jul 2018 23:20:10 +0200
Message-Id: <20180722212010.3979-16-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Govindraj Raja <Govindraj.Raja@imgtec.com>

The SDHost currently clocks the card 4x slower than it
should do, because there is a fixed divide by 4 in the
sdhost wrapper that is not present in the clock tree.
To model this, add a fixed divide by 4 clock node in
the SDHost clock path.

This will ensure the right clock frequency is selected when
the mmc driver tries to configure frequency on card insert.

Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/clk/pistachio/clk-pistachio.c     | 3 ++-
 include/dt-bindings/clock/pistachio-clk.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/pistachio/clk-pistachio.c b/drivers/clk/pistachio/clk-pistachio.c
index c4ceb5eaf46c..1c968d9a6e17 100644
--- a/drivers/clk/pistachio/clk-pistachio.c
+++ b/drivers/clk/pistachio/clk-pistachio.c
@@ -44,7 +44,7 @@ static struct pistachio_gate pistachio_gates[] __initdata = {
 	GATE(CLK_AUX_ADC_INTERNAL, "aux_adc_internal", "sys_internal_div",
 	     0x104, 22),
 	GATE(CLK_AUX_ADC, "aux_adc", "aux_adc_div", 0x104, 23),
-	GATE(CLK_SD_HOST, "sd_host", "sd_host_div", 0x104, 24),
+	GATE(CLK_SD_HOST, "sd_host", "sd_host_div4", 0x104, 24),
 	GATE(CLK_BT, "bt", "bt_div", 0x104, 25),
 	GATE(CLK_BT_DIV4, "bt_div4", "bt_div4_div", 0x104, 26),
 	GATE(CLK_BT_DIV8, "bt_div8", "bt_div8_div", 0x104, 27),
@@ -54,6 +54,7 @@ static struct pistachio_gate pistachio_gates[] __initdata = {
 static struct pistachio_fixed_factor pistachio_ffs[] __initdata = {
 	FIXED_FACTOR(CLK_WIFI_DIV4, "wifi_div4", "wifi_pll", 4),
 	FIXED_FACTOR(CLK_WIFI_DIV8, "wifi_div8", "wifi_pll", 8),
+	FIXED_FACTOR(CLK_SDHOST_DIV4, "sd_host_div4", "sd_host_div", 4),
 };
 
 static struct pistachio_div pistachio_divs[] __initdata = {
diff --git a/include/dt-bindings/clock/pistachio-clk.h b/include/dt-bindings/clock/pistachio-clk.h
index 039f83facb68..77b92aed241d 100644
--- a/include/dt-bindings/clock/pistachio-clk.h
+++ b/include/dt-bindings/clock/pistachio-clk.h
@@ -21,6 +21,7 @@
 /* Fixed-factor clocks */
 #define CLK_WIFI_DIV4			16
 #define CLK_WIFI_DIV8			17
+#define CLK_SDHOST_DIV4			18
 
 /* Gate clocks */
 #define CLK_MIPS			32
-- 
2.16.4

