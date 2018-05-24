Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033383AbeEXOgh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:36:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50265 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970449AbeEXOgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:36:33 -0400
Date: Thu, 24 May 2018 16:36:30 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@suse.cz>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] signal: Revert ptrace preempt magic
Message-ID: <20180524143629.2ofsg7mhjixr5pnm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Upstream commit '53da1d9456fe7f8 fix ptrace slowness' is nothing more
than a bandaid around the ptrace design trainwreck. It's not a
correctness issue, it's merily a cosmetic bandaid.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/signal.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1876,15 +1876,7 @@ static void ptrace_stop(int exit_code, i
 		if (gstop_done && ptrace_reparented(current))
 			do_notify_parent_cldstop(current, false, why);
 
-		/*
-		 * Don't want to allow preemption here, because
-		 * sys_ptrace() needs this task to be inactive.
-		 *
-		 * XXX: implement read_unlock_no_resched().
-		 */
-		preempt_disable();
 		read_unlock(&tasklist_lock);
-		preempt_enable_no_resched();
 		freezable_schedule();
 	} else {
 		/*
