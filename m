Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD38C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3262086B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3262086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbeFTBQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:16:01 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57865 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbeFTBP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:15:56 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5K1FgIV084424;
        Wed, 20 Jun 2018 10:15:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Wed, 20 Jun 2018 10:15:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5K1FgEb084420;
        Wed, 20 Jun 2018 10:15:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w5K1FgnG084419;
        Wed, 20 Jun 2018 10:15:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201806200115.w5K1FgnG084419@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: INFO: task hung in =?ISO-2022-JP?B?X19nZXRfc3VwZXI=?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Date:   Wed, 20 Jun 2018 10:15:42 +0900
References: <9d0092e6-142a-7168-7b3c-084faa9268d5@i-love.sakura.ne.jp> <CACT4Y+b=7Kt5iVj+jMcWwfFGmYQ5D0SpF_iaBK+pjMJLUfKFpw@mail.gmail.com>
In-Reply-To: <CACT4Y+b=7Kt5iVj+jMcWwfFGmYQ5D0SpF_iaBK+pjMJLUfKFpw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> On Tue, Jun 19, 2018 at 4:10 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > On 2018/06/19 20:53, Dmitry Vyukov wrote:
> >> On Tue, Jun 19, 2018 at 1:44 PM, Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>> This bug report is getting no feedback, but I guess that this bug is in
> >>> block or mm or locking layer rather than fs layer.
> >>>
> >>> NMI backtrace for this bug tends to report that sb_bread() from fill_super()
> >>>  from mount_bdev() is stalling is the cause of keep holding s_umount_key for
> >>> more than 120 seconds. What is strange is that NMI backtrace for this bug tends
> >>> to point at rcu_read_lock()/pagecache_get_page()/radix_tree_deref_slot()/
> >>> rcu_read_unlock() which is expected not to stall.
> >>>
> >>> Since CONFIG_RCU_CPU_STALL_TIMEOUT is set to 120 (and actually +5 due to
> >>> CONFIG_PROVE_RCU=y) which is longer than CONFIG_DEFAULT_HUNG_TASK_TIMEOUT,
> >>> maybe setting CONFIG_RCU_CPU_STALL_TIMEOUT to smaller values (e.g. 25) can
> >>> give us some hints...
> >>
> >> If an rcu stall is the true root cause of this, then I guess would see
> >> "rcu stall" bug too. Rcu stall is detected after 120 seconds, but task
> >> hang after 120-240 seconds. So rcu stall has much higher chances to be
> >> detected. Do you see the corresponding "rcu stall" bug?
> >
> > RCU stall is detected after 125 seconds due to CONFIG_PROVE_RCU=y
> > (e.g. https://syzkaller.appspot.com/bug?id=1fac0fd91219f3f2a03d6fa7deafc95fbed79cc2 ).
> >
> > I didn't find the corresponding "rcu stall" bug. But it is not required
> > that one RCU stall takes longer than 120 seconds.
> >
> > down(); // Will take 120 seconds due to multiple RCU stalls
> >   rcu_read_lock():
> >   do_something();
> >   rcu_read_unlock(): // Took 30 seconds for unknown reason.
> >   rcu_read_lock():
> >   do_something();
> >   rcu_read_unlock(): // Took 30 seconds for unknown reason.
> >   rcu_read_lock():
> >   do_something();
> >   rcu_read_unlock(): // Took 30 seconds for unknown reason.
> >   rcu_read_lock():
> >   do_something();
> >   rcu_read_unlock(): // Took 30 seconds for unknown reason.
> > up();
> 
> 
> You think this is another false positive?
> Like this one https://github.com/google/syzkaller/issues/516#issuecomment-395685629
> ?

According to https://syzkaller.appspot.com/text?tag=CrashLog&x=11db16c4400000 from
"INFO: rcu detected stall in __process_echoes":

[  859.630022] INFO: rcu_sched self-detected stall on CPU
[  859.635509] 	0-....: (124999 ticks this GP) idle=30e/1/4611686018427387906 softirq=287964/287964 fqs=31234 
[  859.645716] 	 (t=125000 jiffies g=156333 c=156332 q=555)
(...snipped...)
[  860.266660]  ? process_one_work+0x1ba0/0x1ba0
[  860.271135]  ? kthread_bind+0x40/0x40
[  860.274927]  ret_from_fork+0x3a/0x50
[  861.152252] INFO: task kworker/u4:2:59 blocked for more than 120 seconds.
[  861.159245]       Not tainted 4.18.0-rc1+ #109
[  861.163851] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.

RCU stall was reported immediately before khungtaskd fires. Since syzbot assigns
only 2 CPUs, it might not be rare case that a hung process was unable to run just
because somebody else kept occupying CPU resources.

Well, "BUG: soft lockup in __process_echoes" will be a dup of
"INFO: rcu detected stall in __process_echoes". I wonder why
softlockup detector waited for 135 seconds.

Well, "BUG: soft lockup in shrink_dcache_parent (2)" and
"BUG: soft lockup in snd_virmidi_output_trigger" and
"BUG: soft lockup in smp_call_function_many" and
"BUG: soft lockup in do_raw_spin_unlock (2)" as well waited for 134 seconds
while "BUG: soft lockup in d_walk" waited for only 22 seconds...

Anyway, I think that in some cases RCU stalls/soft lockups are the cause of hung tasks.
