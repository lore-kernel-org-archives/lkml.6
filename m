Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7508C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D2D21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/GGycTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D2D21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390578AbeKTDQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbeKTDQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:16:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B93DF206BA;
        Mon, 19 Nov 2018 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646344;
        bh=ZaTqkRDzuX80bSaBw9o7WamHx8Cg2aMsEJ3I/uvKuCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/GGycTr1wkyqrJgXhKhGhYlGgeWoulV30JkUH16KnrWjwWwcpUrxBFPLaznayEbT
         T8b1yIXHO9BfgDAGOwuegtAPSiFoQ/WPEJW+MbNRubh0wHZux3JQf9JHlYj8CZEPu5
         CGLuAoNYTmsqtwayhe4Ln1yGCp11JrqEdvv3UsZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 122/124] printk: Never set console_may_schedule in console_trylock()
Date:   Mon, 19 Nov 2018 17:29:36 +0100
Message-Id: <20181119162634.061753162@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

commit fd5f7cde1b85d4c8e09ca46ce948e008a2377f64 upstream.

This patch, basically, reverts commit 6b97a20d3a79 ("printk:
set may_schedule for some of console_trylock() callers").
That commit was a mistake, it introduced a big dependency
on the scheduler, by enabling preemption under console_sem
in printk()->console_unlock() path, which is rather too
critical. The patch did not significantly reduce the
possibilities of printk() lockups, but made it possible to
stall printk(), as has been reported by Tetsuo Handa [1].

Another issues is that preemption under console_sem also
messes up with Steven Rostedt's hand off scheme, by making
it possible to sleep with console_sem both in console_unlock()
and in vprintk_emit(), after acquiring the console_sem
ownership (anywhere between printk_safe_exit_irqrestore() in
console_trylock_spinning() and printk_safe_enter_irqsave()
in console_unlock()). This makes hand off less likely and,
at the same time, may result in a significant amount of
pending logbuf messages. Preempted console_sem owner makes
it impossible for other CPUs to emit logbuf messages, but
does not make it impossible for other CPUs to append new
messages to the logbuf.

Reinstate the old behavior and make printk() non-preemptible.
Should any printk() lockup reports arrive they must be handled
in a different way.

[1] http://lkml.kernel.org/r/201603022101.CAH73907.OVOOMFHFFtQJSL%20()%20I-love%20!%20SAKURA%20!%20ne%20!%20jp
Fixes: 6b97a20d3a79 ("printk: set may_schedule for some of console_trylock() callers")
Link: http://lkml.kernel.org/r/20180116044716.GE6607@jagdpanzerIV
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org
Cc: linux-mm@kvack.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/printk/printk.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1763,12 +1763,19 @@ asmlinkage int vprintk_emit(int facility
 	/* If called from the scheduler, we can not call up(). */
 	if (!in_sched) {
 		/*
+		 * Disable preemption to avoid being preempted while holding
+		 * console_sem which would prevent anyone from printing to
+		 * console
+		 */
+		preempt_disable();
+		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore.  The release will print out buffers and wake up
 		 * /dev/kmsg and syslog() users.
 		 */
 		if (console_trylock())
 			console_unlock();
+		preempt_enable();
 	}
 
 	return printed_len;
@@ -2083,20 +2090,7 @@ int console_trylock(void)
 		return 0;
 	}
 	console_locked = 1;
-	/*
-	 * When PREEMPT_COUNT disabled we can't reliably detect if it's
-	 * safe to schedule (e.g. calling printk while holding a spin_lock),
-	 * because preempt_disable()/preempt_enable() are just barriers there
-	 * and preempt_count() is always 0.
-	 *
-	 * RCU read sections have a separate preemption counter when
-	 * PREEMPT_RCU enabled thus we must take extra care and check
-	 * rcu_preempt_depth(), otherwise RCU read sections modify
-	 * preempt_count().
-	 */
-	console_may_schedule = !oops_in_progress &&
-			preemptible() &&
-			!rcu_preempt_depth();
+	console_may_schedule = 0;
 	return 1;
 }
 EXPORT_SYMBOL(console_trylock);


