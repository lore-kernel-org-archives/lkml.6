Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A750C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285D520850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285D520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeLETOL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:14:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49712 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLETOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:14:10 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gUccT-0000sm-4o; Wed, 05 Dec 2018 20:14:01 +0100
Date:   Wed, 5 Dec 2018 20:14:01 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     catalin.marinas@arm.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Message-ID: <20181205191400.qrhim3m3ak5hcsuh@linutronix.de>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
 <20181123095314.hervxkxtqoixovro@linutronix.de>
 <40a63aa5-edb6-4673-b4cc-1bc10e7b3953@windriver.com>
 <20181130181956.eewrlaabtceekzyu@linutronix.de>
 <e7795912-7d93-8f4e-b997-67c4ac1f3549@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <e7795912-7d93-8f4e-b997-67c4ac1f3549@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-05 21:53:37 [+0800], He Zhe wrote:
> For call trace 1:
…
> Since kmemleak would most likely be used to debug in environments where
> we would not expect as great performance as without it, and kfree() has raw locks
> in its main path and other debug function paths, I suppose it wouldn't hurt that
> we change to raw locks.
okay.

> >> >From what I reached above, this is RT-only and happens on v4.18 and v4.19.
> >>
> >> The call trace above is caused by grabbing kmemleak_lock and then getting
> >> scheduled and then re-grabbing kmemleak_lock. Using raw lock can also solve
> >> this problem.
> > But this is a reader / writer lock. And if I understand the other part
> > of the thread then it needs multiple readers.
> 
> For call trace 2:
> 
> I don't get what "it needs multiple readers" exactly means here.
> 
> In this call trace, the kmemleak_lock is grabbed as write lock, and then scheduled
> away, and then grabbed again as write lock from another path. It's a
> write->write locking, compared to the discussion in the other part of the thread.
> 
> This is essentially because kmemleak hooks on the very low level memory
> allocation and free operations. After scheduled away, it can easily re-enter itself.
> We need raw locks to prevent this from happening.

With raw locks you wouldn't have multiple readers at the same time.
Maybe you wouldn't have recursion but since you can't have multiple
readers you would add lock contention where was none (because you could
have two readers at the same time).

> > Couldn't we just get rid of that kfree() or move it somewhere else?
> > I mean if the free() memory on CPU-down and allocate it again CPU-up
> > then we could skip that, rigth? Just allocate it and don't free it
> > because the CPU will likely get up again.
> 
> For call trace 1:
> 
> I went through the CPU hotplug code and found that the allocation of the
> problematic data, cpuc->shared_regs, is done in intel_pmu_cpu_prepare. And
> the free is done in intel_pmu_cpu_dying. They are handlers triggered by two
> different perf events.
> 
> It seems we can hardly form a convincing method that holds the data while
> CPUs are off and then uses it again. raw locks would be easy and good enough.

Why not allocate the memory in intel_pmu_cpu_prepare() if it is not
already there (otherwise skip the allocation) and in
intel_pmu_cpu_dying() not free it. It looks easy.

> Thanks,
> Zhe

Sebastian
