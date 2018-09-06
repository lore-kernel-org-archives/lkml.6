Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90852C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5622075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5622075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbeIFS2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:28:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbeIFS2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:28:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DqNNB312146
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:52:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DqNBh312143;
        Thu, 6 Sep 2018 06:52:23 -0700
Date:   Thu, 6 Sep 2018 06:52:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-69fa6eb7d6a64801ea261025cce9723d9442d773@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, neeraju@codeaurora.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, sudeep.holla@arm.com
Reply-To: geert+renesas@glider.be, sudeep.holla@arm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          neeraju@codeaurora.org, tglx@linutronix.de
In-Reply-To: <alpine.DEB.2.21.1809051419580.1416@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1809051419580.1416@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/urgent] cpu/hotplug: Prevent state corruption on error
 rollback
Git-Commit-ID: 69fa6eb7d6a64801ea261025cce9723d9442d773
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

Commit-ID:  69fa6eb7d6a64801ea261025cce9723d9442d773
Gitweb:     https://git.kernel.org/tip/69fa6eb7d6a64801ea261025cce9723d9442d773
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 6 Sep 2018 15:21:38 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 6 Sep 2018 15:21:38 +0200

cpu/hotplug: Prevent state corruption on error rollback

When a teardown callback fails, the CPU hotplug code brings the CPU back to
the previous state. The previous state becomes the new target state. The
rollback happens in undo_cpu_down() which increments the state
unconditionally even if the state is already the same as the target.

As a consequence the next CPU hotplug operation will start at the wrong
state. This is easily to observe when __cpu_disable() fails.

Prevent the unconditional undo by checking the state vs. target before
incrementing state and fix up the consequently wrong conditional in the
unplug code which handles the failure of the final CPU take down on the
control CPU side.

Fixes: 4dddfb5faa61 ("smp/hotplug: Rewrite AP state machine core")
Reported-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: josh@joshtriplett.org
Cc: peterz@infradead.org
Cc: jiangshanlai@gmail.com
Cc: dzickus@redhat.com
Cc: brendan.jackman@arm.com
Cc: malat@debian.org
Cc: sramana@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1809051419580.1416@nanos.tec.linutronix.de

----
---
 kernel/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index eb4041f78073..0097acec1c71 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -916,7 +916,8 @@ static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
 		if (ret) {
 			st->target = prev_state;
-			undo_cpu_down(cpu, st);
+			if (st->state < prev_state)
+				undo_cpu_down(cpu, st);
 			break;
 		}
 	}
@@ -969,7 +970,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 * to do the further cleanups.
 	 */
 	ret = cpuhp_down_callbacks(cpu, st, target);
-	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
+	if (ret && st->state == CPUHP_TEARDOWN_CPU && st->state < prev_state) {
 		cpuhp_reset_state(st, prev_state);
 		__cpuhp_kick_ap(st);
 	}
