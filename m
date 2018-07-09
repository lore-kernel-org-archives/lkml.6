Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64335C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9172087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9172087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeGIPpy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:45:54 -0400
Received: from foss.arm.com ([217.140.101.70]:33458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932688AbeGIPpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:45:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20C061682;
        Mon,  9 Jul 2018 08:45:52 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.211.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D5163F589;
        Mon,  9 Jul 2018 08:45:50 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] clocksource: arm_arch_timer: set arch_mem_timer cpumask to cpu_possible_mask
Date:   Mon,  9 Jul 2018 16:45:36 +0100
Message-Id: <1531151136-18297-2-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, arch_mem_timer cpumask is set to cpu_all_mask which should be
fine. However, cpu_possible_mask is more accurate and if there are other
clockevent source in the system which are set to cpu_possible_mask, then
having cpu_all_mask may result in issue.

E.g. on a platform with arm,sp804 timer with rating 300 and
cpu_possible_mask and this arch_mem_timer timer with rating 400 and
cpu_all_mask, tick_check_preferred may choose both preferred as the
cpumasks are not equal though they must be.

This issue was root caused incorrectly initially and a fix was merged as
commit 1332a9055801 ("tick: Prefer a lower rating device only if it's CPU
local device").

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

There are few more drivers that set cpu_all_mask, should they also be
changed ? It should be fine as long as it's not compared against
someother non per-CPU timer with shorter cpumask.

Regards,
Sudeep

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 57cb2f00fc07..d8c7f5750cdb 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -735,7 +735,7 @@ static void __arch_timer_setup(unsigned type,
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
 		clk->rating = 400;
-		clk->cpumask = cpu_all_mask;
+		clk->cpumask = cpu_possible_mask;
 		if (arch_timer_mem_use_virtual) {
 			clk->set_state_shutdown = arch_timer_shutdown_virt_mem;
 			clk->set_state_oneshot_stopped = arch_timer_shutdown_virt_mem;
--
2.7.4

