Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E33C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B4321726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359873;
	bh=ZUIXYlxf1rOJWPYCLgQks+zOKGe6I3Fu9tFxUv6e/9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vRGK5aj4q7U3YKHc2gBSM8Y2jOLPUNwqP9JLmYCYWvSlNcX+jEF6grmIK1j3quTdn
	 hLGANGnrGFGHmZEnAPr6pNSHeuY2d49fQN9c3R1+WZe9NmBEKcuSn5f5Wenu77OkiK
	 REDiXNHGsmJ90FuzQXW2inYbrgFgd9XUq65++V9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfAXT5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:57:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731617AbfAXTe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:34:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F38A21907;
        Thu, 24 Jan 2019 19:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358495;
        bh=ZUIXYlxf1rOJWPYCLgQks+zOKGe6I3Fu9tFxUv6e/9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oq6Uai78cqYAFqFUyZmQ2hVH06OKkFcvSMipGm4QGwU5ffgX8hyy63RdU21OMG8hi
         ARkGyMAJz5xwRusj+LE0duO11g1w/qZ+xJwd3JRY36YoDOeDvgXo814F9d3AzcTEgN
         WzwVBmJWOXufcbSQl10l/VyFV8ctJcCIE18ZMmJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/106] clk: meson: meson8b: fix incorrect divider mapping in cpu_scale_table
Date:   Thu, 24 Jan 2019 20:19:46 +0100
Message-Id: <20190124190208.221859163@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



