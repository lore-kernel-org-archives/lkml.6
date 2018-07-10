Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28386C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92C520834
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92C520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbeGJURS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:17:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36433 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732246AbeGJURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:17:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6AKGVm33265200
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Jul 2018 13:16:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6AKGU7l3265197;
        Tue, 10 Jul 2018 13:16:30 -0700
Date:   Tue, 10 Jul 2018 13:16:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sudeep Holla <tipbot@zytor.com>
Message-ID: <tip-5e18e412973d6bb1804de1d4d30a891c774b006e@git.kernel.org>
Cc:     marc.zyngier@arm.com, tglx@linutronix.de, mingo@kernel.org,
        sudeep.holla@arm.com, hpa@zytor.com, mark.rutland@arm.com,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-kernel@vger.kernel.org
Reply-To: khilman@baylibre.com, martin.blumenstingl@googlemail.com,
          linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
          mingo@kernel.org, tglx@linutronix.de, sudeep.holla@arm.com,
          hpa@zytor.com, mark.rutland@arm.com
In-Reply-To: <1531151136-18297-2-git-send-email-sudeep.holla@arm.com>
References: <1531151136-18297-2-git-send-email-sudeep.holla@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource: arm_arch_timer: Set arch_mem_timer
 cpumask to cpu_possible_mask
Git-Commit-ID: 5e18e412973d6bb1804de1d4d30a891c774b006e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5e18e412973d6bb1804de1d4d30a891c774b006e
Gitweb:     https://git.kernel.org/tip/5e18e412973d6bb1804de1d4d30a891c774b006e
Author:     Sudeep Holla <sudeep.holla@arm.com>
AuthorDate: Mon, 9 Jul 2018 16:45:36 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 10 Jul 2018 22:12:47 +0200

clocksource: arm_arch_timer: Set arch_mem_timer cpumask to cpu_possible_mask

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

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/1531151136-18297-2-git-send-email-sudeep.holla@arm.com

---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
