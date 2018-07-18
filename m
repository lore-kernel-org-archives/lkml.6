Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5568FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05781206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05781206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbeGRNJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:09:06 -0400
Received: from ozlabs.org ([203.11.71.1]:43415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbeGRNJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:09:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41VxMm1PmGz9s0w;
        Wed, 18 Jul 2018 22:31:16 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire
In-Reply-To: <CA+55aFyFLzH71Tke858x0cjCiRO48vc1W9oVmVkO43rtjezqOg@mail.gmail.com>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net> <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org> <20180712172838.GU3593@linux.vnet.ibm.com> <20180712180511.GP2476@hirez.programming.kicks-ass.net> <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com> <20180713110851.GY2494@hirez.programming.kicks-ass.net> <87tvp3xonl.fsf@concordia.ellerman.id.au> <20180713164239.GZ2494@hirez.programming.kicks-ass.net> <87601fz1kc.fsf@concordia.ellerman.id.au> <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com> <87va9dyl8y.fsf@concordia.ellerman.id.au> <CA+55aFyFLzH71Tke858x0cjCiRO48vc1W9oVmVkO43rtjezqOg@mail.gmail.com>
Date:   Wed, 18 Jul 2018 22:31:14 +1000
Message-ID: <874lgwpvxp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Tue, Jul 17, 2018 at 7:45 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>>
>> Interesting. I don't see anything as high as 18%, it's more spread out:
>>
>>      7.81%  context_switch  [kernel.kallsyms]  [k] cgroup_rstat_updated
>
> Oh, see that's the difference.
>
> You're running in a non-root cgroup, I think.

I'm not much of a cgroup expert, but yeah I think so:

  # cat /proc/self/cgroup 
  7:cpuset:/
  6:cpu,cpuacct:/user.slice
  5:memory:/user.slice
  ...


I guess I need to boot with init=/bin/sh.

> That also means that your scheduler overhead has way more spinlocks,
> and in particular, you have that
>
>         raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
>         ..
>         raw_spin_lock_irqsave(cpu_lock, flags);
>
> there too.
>
> So you have at least twice the spinlocks that my case had, and yes,
> the costs are way more spread out because your case has all that
> cgroup accounting too.

Yeah OK. And our locks are known to be more expensive generally, so that
and the cgroups seems like it accounts for most of the difference vs
x86.

> That said, I don't understand the powerpc memory ordering. I thought
> the rules were "isync on lock, lwsync on unlock".
>
> That's what the AIX docs imply, at least.
>
> In particular, I find:
>
>   "isync is not a memory barrier instruction, but the
> load-compare-conditional branch-isync sequence can provide this
> ordering property"
>
> so why are you doing "sync/lwsync", when it sounds like "isync/lwsync"
> (for lock/unlock) is the right thing and would already give memory
> barrier semantics?

I think everyone else in the thread answered this already, and better
than I could.

Our options are sync/lwsync or lwsync/sync. I've been testing
lwsync/sync, because then we could also remove the conditional sync we
have in unlock (when there were IO accesses inside the lock).

These days you can download the ISA [PDF], with no registration or
anything required, here's a direct link:

  https://ibm.ent.box.com/index.php?rm=box_download_shared_file&shared_name=1hzcwkwf8rbju5h9iyf44wm94amnlcrv&file_id=f_253346319281

That has some docs on locking in Book3 appendix B.2 (page 915). It
doesn't really have that much detail, but it does talk a bit about using
lwsync vs isync.

cheers
