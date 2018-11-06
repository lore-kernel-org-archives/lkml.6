Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9595DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E2420862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P6PMpXlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E2420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbeKFWrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:47:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387913AbeKFWre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wbIn8GU05WJa2XFyDcwdSOcKrKljhtrszklo+eF2V3s=; b=P6PMpXlo/JcmtBZZoj22XPyAe
        90shmpgSX6xb+Nj0epR9fP02bmd2PmIFTfB67G/E9Le4Oxtt1Tmfx+TjT/o1W2755WA4wrTBnc+aF
        +sqQoGzmcAPyZcFYfZ2msmHcxxoQPXWA8udEPoOlWUaoTEnim82GniVnycx9LzT6FQBpyC9nWo+M3
        751A8XE0Y4SOhQ5JUY4ogGxTjzglog5X7TOZdFvl2DTY8WRmGnHXZePx7kXeb/RCoopba+sr4IrRo
        NKcnHdhnXY1lO5YNXBuPTrscKOdxaxz1gGDEyWlvJUKIPrhzXWgK1V4OIAom5YBEOFZQbfJP3iebg
        SBAgBGxhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK1J6-0003de-GZ; Tue, 06 Nov 2018 13:22:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC42D2029F87F; Tue,  6 Nov 2018 14:22:10 +0100 (CET)
Date:   Tue, 6 Nov 2018 14:22:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Henrik Austad <haustad@cisco.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>,
        juri.lelli@arm.com, bigeasy@linutronix.de,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        bristot@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] backport: sched/rtmutex/deadline: Fix a PI crash for
 deadline tasks
Message-ID: <20181106132210.GA9781@hirez.programming.kicks-ass.net>
References: <20181106124721.7516-1-haustad@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106124721.7516-1-haustad@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 01:47:21PM +0100, Henrik Austad wrote:
> From: Xunlei Pang <xlpang@redhat.com>
> 
> On some of our systems, we notice this error popping up on occasion,
> completely hanging the system.
> 
>    [<ffffffc0000ee398>] enqueue_task_dl+0x1f0/0x420
>    [<ffffffc0000d0f14>] activate_task+0x7c/0x90
>    [<ffffffc0000edbdc>] push_dl_task+0x164/0x1c8
>    [<ffffffc0000edc60>] push_dl_tasks+0x20/0x30
>    [<ffffffc0000cc00c>] __balance_callback+0x44/0x68
>    [<ffffffc000d2c018>] __schedule+0x6f0/0x728
>    [<ffffffc000d2c278>] schedule+0x78/0x98
>    [<ffffffc000d2e76c>] __rt_mutex_slowlock+0x9c/0x108
>    [<ffffffc000d2e9d0>] rt_mutex_slowlock+0xd8/0x198
>    [<ffffffc0000f7f28>] rt_mutex_timed_futex_lock+0x30/0x40
>    [<ffffffc00012c1a8>] futex_lock_pi+0x200/0x3b0
>    [<ffffffc00012cf84>] do_futex+0x1c4/0x550
> 
> It runs an 4.4 kernel on an arm64 rig. The signature looks suspciously
> similar to what Xuneli Pang observed in his crash, and with this fix, my
> issue goes away (my system has survivied approx 1500 reboots and a few
> nasty tests so far)
> 
> Alongside this patch in the tree, there are a few other bits and pieces
> pertaining to futex, rtmutex and kernel/sched/, but those patches
> creates
> weird crashes that I have not been able to dissect yet. Once (if) I have
> been able to figure those out (and test), they will be sent later.
> 
> I am sure other users of LTS that also use sched_deadline will run into
> this issue, so I think it is a good candidate for 4.4-stable. Possibly
> also
> to 4.9 and 4.14, but I have not had time to test for those versions.

But this patch relies on:

  2a1c60299406 ("rtmutex: Deboost before waking up the top waiter")

for pointer stability, but that patch in turn relies on the whole
FUTEX_UNLOCK_PI patch set:

 $ git log --oneline 499f5aca2cdd5e958b27e2655e7e7f82524f46b1..56222b212e8edb1cf51f5dd73ff645809b082b40

  56222b212e8e futex: Drop hb->lock before enqueueing on the rtmutex
  bebe5b514345 futex: Futex_unlock_pi() determinism
  cfafcd117da0 futex: Rework futex_lock_pi() to use rt_mutex_*_proxy_lock()
  38d589f2fd08 futex,rt_mutex: Restructure rt_mutex_finish_proxy_lock()
  50809358dd71 futex,rt_mutex: Introduce rt_mutex_init_waiter()
  16ffa12d7425 futex: Pull rt_mutex_futex_unlock() out from under hb->lock
  73d786bd043e futex: Rework inconsistent rt_mutex/futex_q state
  bf92cf3a5100 futex: Cleanup refcounting
  734009e96d19 futex: Change locking rules
  5293c2efda37 futex,rt_mutex: Provide futex specific rt_mutex API
  fffa954fb528 futex: Remove rt_mutex_deadlock_account_*()
  1b367ece0d7e futex: Use smp_store_release() in mark_wake_futex()

and possibly some follow-up fixes on that (I have vague memories of
that).

As is, just the one patch you propose isn't correct :/

Yes, that was a ginormous amount of work to fix a seemingly simple splat
:-(
