Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7069920665
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975830;
	bh=DjmsFRFUWKVngoXY2X+mP62jscbsOIGcYfnwvsX/qVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O2C6wXnxDCoQUuDP9nRRJe1oa/UszSn27vMsVgd89O06InbT3nSc9B6sT0EkWHUAk
	 1swXMPHj7f/UqthM5YSFLRaHREMTfiyok5dla/Ta34HYiMPLfftJhLbFcJFDDFEFjI
	 /ygV3jiG8RCBDuXHxILX0YsiAUNU7H7iob5Ids1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbfAHTa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:30:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730051AbfAHTaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031E82070B;
        Tue,  8 Jan 2019 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975821;
        bh=DjmsFRFUWKVngoXY2X+mP62jscbsOIGcYfnwvsX/qVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSg4O2mrFGW5PCvuHR2nzaxrtD6WfMl69SzJcQWqf+sFO1fTnfilIr5zSNjeCyNIH
         2RMwcyxv97k1UUObuGzWudYe9pn18kVjJsMHP/TOr6XQ1BtPZzI/7pspqxWmAhhLAJ
         w6Eyf6YurXL04m6H80cdv8xTxVeA61ZsBv203fQc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 21/97] clk: meson: meson8b: fix incorrect divider mapping in cpu_scale_table
Date:   Tue,  8 Jan 2019 14:28:30 -0500
Message-Id: <20190108192949.122407-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit ad9b2b8e53af61375322e3c7d624acf3a3ef53b0 ]

The public S805 datasheet only mentions that
HHI_SYS_CPU_CLK_CNTL1[20:29] contains a divider called "cpu_scale_div".
Unfortunately it does not mention how to use the register contents.

The Amlogic 3.10 GPL kernel sources are using the following code to
calculate the CPU clock based on that register (taken from
arch/arm/mach-meson8/clock.c in the 3.10 Amlogic kernel, shortened to
make it easier to read):
N = (aml_read_reg32(P_HHI_SYS_CPU_CLK_CNTL1) >> 20) & 0x3FF;
if (sel == 3) /* use cpu_scale_div */
  div = 2 * N;
else
  div = ... /* not relevant for this example */
cpu_clk = parent_clk / div;

This suggests that the formula is: parent_rate / 2 * register_value
However, running perf (which can measure the CPU clock rate thanks to
the ARM PMU) shows that this formula is not correct.
This can be reproduced with the following steps:
1. boot into u-boot
2. let the CPU clock run off the XTAL clock:
   mw.l 0xC110419C 0x30 1
3. set the cpu_scale_div register:
   to value 0x1: mw.l 0xC110415C 0x801016A2 1
   to value 0x2: mw.l 0xC110415C 0x802016A2 1
   to value 0x5: mw.l 0xC110415C 0x805016A2 1
4. let the CPU clock run off cpu_scale_div:
   mw.l 0xC110419C 0xbd 1
5. boot Linux
6. run: perf stat -aB stress --cpu 4 --timeout 10
7. check the "cycles" value

I get the following results depending on the cpu_scale_div value:
- (cpu_in_sel - this is the input clock for cpu_scale_div - runs at
   1.2GHz)
- 0x1 = 300MHz
- 0x2 = 200MHz
- 0x5 = 100MHz

This means that the actual formula to calculate the output of the
cpu_scale_div clock is: parent_rate / 2 * (register value + 1).

The register value 0x0 is reserved. When letting the CPU clock run off
the cpu_scale_div while the value is 0x0 the whole board hangs (even in
u-boot).

I also verified this with the TWD timer: when adding this to the .dts
without specifying it's clock it will auto-detect the PERIPH (which is
the input clock of the TWD) clock rate (and the result is shown in the
kernel log). On Meson8, Meson8b and Meson8m2 the PERIPH clock is CPUCLK
divided by 4. This also matched for all three test-cases from above (in
all cases the TWD timer clock rate was approx. one fourth of the CPU
clock rate).

A small note regarding the "fixes" tag: the original issue seems to
exist virtually since forever. Even commit 28b9fcd016126e ("clk:
meson8b: Add support for Meson8b clocks") seems to handle this wrong. I
still decided to use commit 251b6fd38bcb9c ("clk: meson: rework meson8b
cpu clock") because this is the first commit which gets the CPU hiearchy
correct and thus it's the first commit where the cpu_scale_div register
is used correctly (apart from the bug in the cpu_scale_table).

Fixes: 251b6fd38bcb9c ("clk: meson: rework meson8b cpu clock")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lkml.kernel.org/r/20180927085921.24627-2-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/meson8b.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 74697e145dde..50060e895e7a 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -568,13 +568,14 @@ static struct clk_fixed_factor meson8b_cpu_div3 = {
 };
 
 static const struct clk_div_table cpu_scale_table[] = {
-	{ .val = 2, .div = 4 },
-	{ .val = 3, .div = 6 },
-	{ .val = 4, .div = 8 },
-	{ .val = 5, .div = 10 },
-	{ .val = 6, .div = 12 },
-	{ .val = 7, .div = 14 },
-	{ .val = 8, .div = 16 },
+	{ .val = 1, .div = 4 },
+	{ .val = 2, .div = 6 },
+	{ .val = 3, .div = 8 },
+	{ .val = 4, .div = 10 },
+	{ .val = 5, .div = 12 },
+	{ .val = 6, .div = 14 },
+	{ .val = 7, .div = 16 },
+	{ .val = 8, .div = 18 },
 	{ /* sentinel */ },
 };
 
-- 
2.19.1

