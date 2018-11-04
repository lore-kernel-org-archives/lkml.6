Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660A3C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A682082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A682082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeKDJ0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 04:26:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeKDJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 04:26:54 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA40DcJO3851446
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Nov 2018 17:13:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA40Dcki3851443;
        Sat, 3 Nov 2018 17:13:38 -0700
Date:   Sat, 3 Nov 2018 17:13:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-3f130a37c442d5c4d66531b240ebe9abfef426b5@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, valentin.schneider@arm.com
Reply-To: mingo@kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, valentin.schneider@arm.com, tglx@linutronix.de
In-Reply-To: <1537974727-30788-2-git-send-email-valentin.schneider@arm.com>
References: <1537974727-30788-2-git-send-email-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Don't increase sd->balance_interval on
 newidle balance
Git-Commit-ID: 3f130a37c442d5c4d66531b240ebe9abfef426b5
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

Commit-ID:  3f130a37c442d5c4d66531b240ebe9abfef426b5
Gitweb:     https://git.kernel.org/tip/3f130a37c442d5c4d66531b240ebe9abfef426b5
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Wed, 26 Sep 2018 16:12:07 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 4 Nov 2018 00:59:23 +0100

sched/fair: Don't increase sd->balance_interval on newidle balance

When load_balance() fails to move some load because of task affinity,
we end up increasing sd->balance_interval to delay the next periodic
balance in the hopes that next time we look, that annoying pinned
task(s) will be gone.

However, idle_balance() pays no attention to sd->balance_interval, yet
it will still lead to an increase in balance_interval in case of
pinned tasks.

If we're going through several newidle balances (e.g. we have a
periodic task), this can lead to a huge increase of the
balance_interval in a very small amount of time.

To prevent that, don't increase the balance interval when going
through a newidle balance.

This is a similar approach to what is done in commit 58b26c4c0257
("sched: Increment cache_nice_tries only on periodic lb"), where we
disregard newidle balance and rely on periodic balance for more stable
results.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: patrick.bellasi@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1537974727-30788-2-git-send-email-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4e298931a715..a17ca4254427 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8876,13 +8876,22 @@ out_all_pinned:
 	sd->nr_balance_failed = 0;
 
 out_one_pinned:
+	ld_moved = 0;
+
+	/*
+	 * idle_balance() disregards balance intervals, so we could repeatedly
+	 * reach this code, which would lead to balance_interval skyrocketting
+	 * in a short amount of time. Skip the balance_interval increase logic
+	 * to avoid that.
+	 */
+	if (env.idle == CPU_NEWLY_IDLE)
+		goto out;
+
 	/* tune up the balancing interval */
 	if ((env.flags & LBF_ALL_PINNED &&
 	     sd->balance_interval < MAX_PINNED_INTERVAL) ||
 	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
-
-	ld_moved = 0;
 out:
 	return ld_moved;
 }
