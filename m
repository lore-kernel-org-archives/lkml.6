Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0CFC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5320720840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSwKzIbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5320720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeKIHcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbeKIHcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:19 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B7E2089A;
        Thu,  8 Nov 2018 21:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714092;
        bh=BeLVChnVXDHzUSthqTLIyrnuMu35NDKvyAwkBGLJ17U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSwKzIbcml7R1kn2tJZNL6r6Z6OxsAxf8wGPQq9vyMtPKYzp1vAdHu8dagDsqiK2p
         NPoTZ9VIdZIPYZMKL65u8f9cgHqIBe0zXSlyA6etoK3s2ddywQLWCGCC1008ksFTcS
         pzdy9nheJ4lG2Ig5iuiwxdN05Dfar9q9U31WiW/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Len Sorensen <lsorense@csclub.uwaterloo.ca>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 052/144] ARM: dra7xx: Fix counter frequency drift for AM572x errata i856
Date:   Thu,  8 Nov 2018 13:50:23 -0800
Message-Id: <20181108215058.607934222@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit afc9d590b8a150cfeaac0078ef5de6fb21a5ea6a ]

Errata i856 for the AM572x (DRA7xx) points out that the 32.768KHz external
crystal is not enabled at power up.  Instead the CPU falls back to using
an emulation for the 32KHz clock which is SYSCLK1/610.  SYSCLK1 is usually
20MHz on boards so far (which gives an emulated frequency of 32.786KHz),
but can also be 19.2 or 27MHz which result in much larger drift.

Since this is used to drive the master counter at 32.768KHz * 375 /
2 = 6.144MHz, the emulated speed for 20MHz is of by 570ppm, or about 43
seconds per day, and more than the 500ppm NTP is able to tolerate.

Checking the CTRL_CORE_BOOTSTRAP register can determine if the CPU
is using the real 32.768KHz crystal or the emulated SYSCLK1/610, and
by known that the real counter frequency can be determined and used.
The real speed is then SYSCLK1 / 610 * 375 / 2 or SYSCLK1 * 75 / 244.

Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>
Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/control.h |  4 ++++
 arch/arm/mach-omap2/timer.c   | 36 +++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a3c013345c45..a80ac2d70bb1 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -286,6 +286,10 @@
 #define OMAP5XXX_CONTROL_STATUS                0x134
 #define OMAP5_DEVICETYPE_MASK          (0x7 << 6)
 
+/* DRA7XX CONTROL CORE BOOTSTRAP */
+#define DRA7_CTRL_CORE_BOOTSTRAP	0x6c4
+#define DRA7_SPEEDSELECT_MASK		(0x3 << 8)
+
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
  * that should be added.
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index fb0cb2b817a9..7d45c84c69ba 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -54,6 +54,7 @@
 
 #include "soc.h"
 #include "common.h"
+#include "control.h"
 #include "powerdomain.h"
 #include "omap-secure.h"
 
@@ -496,7 +497,8 @@ static void __init realtime_counter_init(void)
 	void __iomem *base;
 	static struct clk *sys_clk;
 	unsigned long rate;
-	unsigned int reg, num, den;
+	unsigned int reg;
+	unsigned long long num, den;
 
 	base = ioremap(REALTIME_COUNTER_BASE, SZ_32);
 	if (!base) {
@@ -511,6 +513,35 @@ static void __init realtime_counter_init(void)
 	}
 
 	rate = clk_get_rate(sys_clk);
+
+	if (soc_is_dra7xx()) {
+		/*
+		 * Errata i856 says the 32.768KHz crystal does not start at
+		 * power on, so the CPU falls back to an emulated 32KHz clock
+		 * based on sysclk / 610 instead. This causes the master counter
+		 * frequency to not be 6.144MHz but at sysclk / 610 * 375 / 2
+		 * (OR sysclk * 75 / 244)
+		 *
+		 * This affects at least the DRA7/AM572x 1.0, 1.1 revisions.
+		 * Of course any board built without a populated 32.768KHz
+		 * crystal would also need this fix even if the CPU is fixed
+		 * later.
+		 *
+		 * Either case can be detected by using the two speedselect bits
+		 * If they are not 0, then the 32.768KHz clock driving the
+		 * coarse counter that corrects the fine counter every time it
+		 * ticks is actually rate/610 rather than 32.768KHz and we
+		 * should compensate to avoid the 570ppm (at 20MHz, much worse
+		 * at other rates) too fast system time.
+		 */
+		reg = omap_ctrl_readl(DRA7_CTRL_CORE_BOOTSTRAP);
+		if (reg & DRA7_SPEEDSELECT_MASK) {
+			num = 75;
+			den = 244;
+			goto sysclk1_based;
+		}
+	}
+
 	/* Numerator/denumerator values refer TRM Realtime Counter section */
 	switch (rate) {
 	case 12000000:
@@ -545,6 +576,7 @@ static void __init realtime_counter_init(void)
 		break;
 	}
 
+sysclk1_based:
 	/* Program numerator and denumerator registers */
 	reg = readl_relaxed(base + INCREMENTER_NUMERATOR_OFFSET) &
 			NUMERATOR_DENUMERATOR_MASK;
@@ -556,7 +588,7 @@ static void __init realtime_counter_init(void)
 	reg |= den;
 	writel_relaxed(reg, base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET);
 
-	arch_timer_freq = (rate / den) * num;
+	arch_timer_freq = DIV_ROUND_UP_ULL(rate * num, den);
 	set_cntfreq();
 
 	iounmap(base);
-- 
2.17.1



