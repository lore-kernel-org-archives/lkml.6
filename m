Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeCaSw4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 14:52:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55067 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753045AbeCaSwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 14:52:55 -0400
Date: Sat, 31 Mar 2018 11:52:20 -0700
From: tip-bot for Jules Maselbas <tipbot@zytor.com>
Message-ID: <tip-1b5d43cfb69759d8ef8d30469cea31d0c037aed5@git.kernel.org>
Cc: peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, stephen.kyle@arm.com,
        jules.maselbas@arm.com, hpa@zytor.com, patrick.bellasi@arm.com,
        torvalds@linux-foundation.org, chris.redpath@arm.com, mingo@kernel.org,
        efault@gmx.de, tglx@linutronix.de
Reply-To: peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, stephen.kyle@arm.com,
        jules.maselbas@arm.com, hpa@zytor.com, patrick.bellasi@arm.com,
        torvalds@linux-foundation.org, chris.redpath@arm.com, mingo@kernel.org,
        tglx@linutronix.de, efault@gmx.de
In-Reply-To: <20180329144301.38419-1-jules.maselbas@arm.com>
References: <20180329144301.38419-1-jules.maselbas@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/cpufreq/schedutil: Fix error path mutex
 unlock
Git-Commit-ID: 1b5d43cfb69759d8ef8d30469cea31d0c037aed5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1b5d43cfb69759d8ef8d30469cea31d0c037aed5
Gitweb:     https://git.kernel.org/tip/1b5d43cfb69759d8ef8d30469cea31d0c037aed5
Author:     Jules Maselbas <jules.maselbas@arm.com>
AuthorDate: Thu, 29 Mar 2018 15:43:01 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 31 Mar 2018 20:42:38 +0200

sched/cpufreq/schedutil: Fix error path mutex unlock

This patch prevents the 'global_tunables_lock' mutex from being
unlocked before being locked.  This mutex is not locked if the
sugov_kthread_create() function fails.

Signed-off-by: Jules Maselbas <jules.maselbas@arm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Dietmar Eggermann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Stephen Kyle <stephen.kyle@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: nd@arm.com
Link: http://lkml.kernel.org/r/20180329144301.38419-1-jules.maselbas@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7936f548e071..617c6741c525 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -625,10 +625,9 @@ fail:
 
 stop_kthread:
 	sugov_kthread_stop(sg_policy);
-
-free_sg_policy:
 	mutex_unlock(&global_tunables_lock);
 
+free_sg_policy:
 	sugov_policy_free(sg_policy);
 
 disable_fast_switch:
