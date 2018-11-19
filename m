Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FC2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6236D206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6236D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeKTB4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:56:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34529 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbeKTB4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:56:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so4167152wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 07:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fb5RzYfmT5j55PXjoyC4ueYbTbIPYZfitBOOX0J+o9Q=;
        b=Fsk0QycFyV3qkp2c0gw2cX3r63PUmypsZKAV6jjgt0dDpj+m6V/GfH1tXOzxMBOhVv
         SbwTekzVDS+O1kyxpImlHDTmbPsPu2a7LjhHHJsQ3vtJDH9Yl3ORvt3Ey3eTfaT/kT4O
         2esS2f5PgpLLIcXmR3SAW+tqLhosd3BUok2KmyAPN17oPIbG0tQjW12VBzd88Geww16w
         5zmuiMjrRMcDMLabg70APFhQU/RxKlzhQdtfb4TAveHUyJS6yYINcMC+GG/uYVQ7GHTc
         HmNotwHfCShbyg58Be0tsk0O6J5649sokXUotp8cQOXFfqnwxm9tfoao6vt02R7xVK3O
         xFVA==
X-Gm-Message-State: AA+aEWa7w1zU97XW+ESMPupOU2R332d1IRkbi+qPOYVlPN3tDahfaND9
        33Bni1QFYJiDCKwXTFoaVlETZQ==
X-Google-Smtp-Source: AFSGD/UMa77crNOXZw/gmClQVHXuzYxsQKnYUDut9oNmkqK6ri6C4DWxmJvEZjbfBWRTq4M131Vs/A==
X-Received: by 2002:adf:9467:: with SMTP id 94mr9789458wrq.305.1542641525039;
        Mon, 19 Nov 2018 07:32:05 -0800 (PST)
Received: from localhost.localdomain ([151.15.226.84])
        by smtp.gmail.com with ESMTPSA id t4sm19520601wrm.6.2018.11.19.07.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 07:32:03 -0800 (PST)
Date:   Mon, 19 Nov 2018 16:32:01 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, x86@kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: WARNING in enqueue_task_dl
Message-ID: <20181119153201.GB2119@localhost.localdomain>
References: <000000000000b5e346057af4da06@google.com>
 <alpine.DEB.2.21.1811190921190.9459@nanos.tec.linutronix.de>
 <20181119130718.69eddf46@luca64>
 <20181119125241.GC9761@hirez.programming.kicks-ass.net>
 <20181119134349.GA2119@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119134349.GA2119@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/18 14:43, Juri Lelli wrote:
> On 19/11/18 13:52, Peter Zijlstra wrote:
> > On Mon, Nov 19, 2018 at 01:07:18PM +0100, luca abeni wrote:
> > 
> > > > On Sun, 18 Nov 2018, syzbot wrote:
> > 
> > > > > WARNING: CPU: 1 PID: 6351 at kernel/sched/deadline.c:628
> > > > > enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504
> > > 
> > > Here, it looks like a task is invoking sched_setattr() to become
> > > SCHED_DEADLINE when dl_boosted is set...
> > > 
> > > Is this possible / correct?
> > 
> > Possible, clearly. Correct, only in so far as that it is not a malformed
> > program, but it is very poor design to actually trigger this (of course
> > the fuzzer doesn't care about that).
> > 
> > > If this (sched_setattr() with dl_boosted set) should not be possible,
> > > then we have a bug that we need to investigate...
> > > 
> > > Otherwise, I suspect we can just remove the WARN_ON at line 628 of
> > > deadline.c
> > 
> > I wonder why we put that WARN in there to begin with... git-blame gives
> > us:
> > 
> >   98b0a8578050 ("sched/deadline: Remove useless parameter from setup_new_dl_entity()")
> > 
> > So the problem seems to be that if we're boosted, we should maybe not be
> > using our own (newly set) parameters, but those of the donor task.
> > 
> > Specifically, our 'suboptimal' deadline inheritance scheme 'requires' us
> > to use the inherited deadline, not our own. So in that respect I think
> > the WARN is valid, although I'm not sure what, apart from actually
> > finishing that PE patch-set we can do about it just now.
> 
> Mmm, but, as it was written in the comment that was removed by 295d6d5
> ("sched/deadline: Fix switching to -deadline"), I was still expecting
> that for a boosted task setup_new_dl_entity() shouldn't be called.
> Wonder if this is another manifestation of the problems we have with
> clocks. Need to think more about it.

So, while this looks like nothing more than a stop-gap solution until we
get PE in place, would the following make any sense? It seems I can't
reproduce the warning anymore with it (w/o it usually takes a few secs
to reproduce).

--->8---

From 9326fd2b20269cffef7290bdc5b8173460d3c870 Mon Sep 17 00:00:00 2001
From: Juri Lelli <juri.lelli@redhat.com>
Date: Mon, 19 Nov 2018 16:04:42 +0100
Subject: [PATCH] sched/core: Fix PI boosting between RT and DEADLINE

syzbot reported the following warning:

 WARNING: CPU: 1 PID: 6351 at kernel/sched/deadline.c:628
 enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504
 PM: Basic memory bitmaps freed
 Kernel panic - not syncing: panic_on_warn set ...
 CPU: 1 PID: 6351 Comm: syz-executor0 Not tainted 4.20.0-rc2+ #338
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
 Google 01/01/2011
 Call Trace:
   __dump_stack lib/dump_stack.c:77 [inline]
   dump_stack+0x244/0x39d lib/dump_stack.c:113
   panic+0x2ad/0x55c kernel/panic.c:188
   __warn.cold.8+0x20/0x45 kernel/panic.c:540
   report_bug+0x254/0x2d0 lib/bug.c:186
   fixup_bug arch/x86/kernel/traps.c:178 [inline]
   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
   do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
 RIP: 0010:enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504
 Code: ff 48 8b 8d c8 fe ff ff 48 c1 e6 2a 4c 8b 9d d0 fe ff ff 8b 95 d8 fe
 ff ff 48 8b 85 e0 fe ff ff e9 16 e4 ff ff e8 16 d0 ea ff <0f> 0b e9 17 f1
 ff ff 48 8b bd e8 fe ff ff 4c 89 95 c8 fe ff ff 48
 RSP: 0018:ffff8881ba39fa18 EFLAGS: 00010002
 RAX: 0000000000000000 RBX: ffff8881b9d6c000 RCX: ffff8881b9d6c278
 RDX: ffff8881b9d6c03c RSI: 0000000000000002 RDI: ffff8881daf2d710
 RBP: ffff8881ba39fb78 R08: 0000000000000001 R09: ffff8881daf00000
 R10: 0000001a4d4f1987 R11: ffff8881daf2db3b R12: 1ffff11037473f4e
 R13: ffff8881b9d6c2cc R14: ffff8881daf2ccc0 R15: ffff8881daf2ccc0
   enqueue_task+0x184/0x390 kernel/sched/core.c:730
   __sched_setscheduler+0xe99/0x2190 kernel/sched/core.c:4336
   sched_setattr kernel/sched/core.c:4394 [inline]
   __do_sys_sched_setattr kernel/sched/core.c:4570 [inline]
   __se_sys_sched_setattr kernel/sched/core.c:4549 [inline]
   __x64_sys_sched_setattr+0x1b2/0x2f0 kernel/sched/core.c:4549
   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
 RIP: 0033:0x457569
 Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
 ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
 RSP: 002b:00007f05ce0a2c78 EFLAGS: 00000246 ORIG_RAX: 000000000000013a
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
 RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000000
 RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 00007f05ce0a36d4
 R13: 00000000004c369f R14: 00000000004d5730 R15: 00000000ffffffff

At deadline.c:628 we have:

 623 static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 624 {
 625 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 626 	struct rq *rq = rq_of_dl_rq(dl_rq);
 627
 628 	WARN_ON(dl_se->dl_boosted);
 629 	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
        [...]
     }

Which means that setup_new_dl_entity() has been called on a task
currently boosted. This shouldn't happen though, as setup_new_
dl_entity() is only called when the 'dynamic' deadline of the new entity
is in the past w.r.t. rq_clock and boosted tasks shouldn't verify this
condition.

Digging through PI code I noticed that what above might in fact happen
if an RT tasks blocks on an rt_mutex hold by a DEADLINE task. In the
first branch of boosting conditions we check only if a pi_task 'dynamic'
deadline is earlier than mutex holder's and in this case we set mutex
holder to be dl_boosted. However, since RT 'dynamic' deadlines are only
initialized if such tasks get boosted at some point (or if they become
DEADLINE of course), in general RT 'dynamic' deadlines are usually equal
to 0 and this verifies the aforementioned condition.

Fix it by checking that the potential donor task is actually (even if
temporary because in turn boosted) running at DEADLINE priority before
using its 'dynamic' deadline value.

Reported-by: syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5afb868f7339..d17257613f10 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3827,7 +3827,8 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	 */
 	if (dl_prio(prio)) {
 		if (!dl_prio(p->normal_prio) ||
-		    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
+		    (pi_task && dl_prio(pi_task->prio) &&
+		     dl_entity_preempt(&pi_task->dl, &p->dl))) {
 			p->dl.dl_boosted = 1;
 			queue_flag |= ENQUEUE_REPLENISH;
 		} else
-- 
2.17.2

