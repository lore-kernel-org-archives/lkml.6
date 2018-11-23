Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B03DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD6120685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD6120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409189AbeKWUg4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:36:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49901 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394558AbeKWUg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:36:56 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gQ89C-0003PF-VU; Fri, 23 Nov 2018 10:53:15 +0100
Date:   Fri, 23 Nov 2018 10:53:14 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zhe.he@windriver.com
Cc:     catalin.marinas@arm.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Message-ID: <20181123095314.hervxkxtqoixovro@linutronix.de>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-22 17:04:19 [+0800], zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> kmemleak_lock, as a rwlock on RT, can possibly be held in atomic context and
> causes the follow BUG.
> 
> BUG: scheduling while atomic: migration/15/132/0x00000002
…
> Preemption disabled at:
> [<ffffffff8c927c11>] cpu_stopper_thread+0x71/0x100
> CPU: 15 PID: 132 Comm: migration/15 Not tainted 4.19.0-rt1-preempt-rt #1
> Hardware name: Intel Corp. Harcuvar/Server, BIOS HAVLCRB1.X64.0015.D62.1708310404 08/31/2017
> Call Trace:
>  dump_stack+0x4f/0x6a
>  ? cpu_stopper_thread+0x71/0x100
>  __schedule_bug.cold.16+0x38/0x55
>  __schedule+0x484/0x6c0
>  schedule+0x3d/0xe0
>  rt_spin_lock_slowlock_locked+0x118/0x2a0
>  rt_spin_lock_slowlock+0x57/0x90
>  __rt_spin_lock+0x26/0x30
>  __write_rt_lock+0x23/0x1a0
>  ? intel_pmu_cpu_dying+0x67/0x70
>  rt_write_lock+0x2a/0x30
>  find_and_remove_object+0x1e/0x80
>  delete_object_full+0x10/0x20
>  kmemleak_free+0x32/0x50
>  kfree+0x104/0x1f0
>  ? x86_pmu_starting_cpu+0x30/0x30
>  intel_pmu_cpu_dying+0x67/0x70
>  x86_pmu_dying_cpu+0x1a/0x30
>  cpuhp_invoke_callback+0x92/0x700
>  take_cpu_down+0x70/0xa0
>  multi_cpu_stop+0x62/0xc0
>  ? cpu_stop_queue_work+0x130/0x130
>  cpu_stopper_thread+0x79/0x100
>  smpboot_thread_fn+0x20f/0x2d0
>  kthread+0x121/0x140
>  ? sort_range+0x30/0x30
>  ? kthread_park+0x90/0x90
>  ret_from_fork+0x35/0x40

If this is the only problem? kfree() from a preempt-disabled section
should cause a warning even without kmemleak.

> And on v4.18 stable tree the following call trace, caused by grabbing
> kmemleak_lock again, is also observed.
> 
> kernel BUG at kernel/locking/rtmutex.c:1048! 
> invalid opcode: 0000 [#1] PREEMPT SMP PTI 
> CPU: 5 PID: 689 Comm: mkfs.ext4 Not tainted 4.18.16-rt9-preempt-rt #1 
…
> Call Trace: 
>  ? preempt_count_add+0x74/0xc0 
>  rt_spin_lock_slowlock+0x57/0x90 
>  ? __kernel_text_address+0x12/0x40 
>  ? __save_stack_trace+0x75/0x100 
>  __rt_spin_lock+0x26/0x30 
>  __write_rt_lock+0x23/0x1a0 
>  rt_write_lock+0x2a/0x30 
>  create_object+0x17d/0x2b0 
…

is this an RT-only problem? Because mainline should not allow read->read
locking or read->write locking for reader-writer locks. If this only
happens on v4.18 and not on v4.19 then something must have fixed it.
 

Sebastian
