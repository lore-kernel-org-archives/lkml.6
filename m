Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A27CECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1312147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1312147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbeGMCSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:18:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9987 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387972AbeGMCSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:18:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4808f20001>; Thu, 12 Jul 2018 19:05:39 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 12 Jul 2018 19:05:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 12 Jul 2018 19:05:42 -0700
Received: from [10.2.167.205] (10.2.167.205) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 13 Jul
 2018 02:05:40 +0000
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com>
 <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
From:   Daniel Lustig <dlustig@nvidia.com>
Message-ID: <11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com>
Date:   Thu, 12 Jul 2018 19:05:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
X-Originating-IP: [10.2.167.205]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/2018 11:10 AM, Linus Torvalds wrote:
> On Thu, Jul 12, 2018 at 11:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> The locking pattern is fairly simple and shows where RCpc comes apart
>> from expectation real nice.
> 
> So who does RCpc right now for the unlock-lock sequence? Somebody
> mentioned powerpc. Anybody else?
> 
> How nasty would be be to make powerpc conform? I will always advocate
> tighter locking and ordering rules over looser ones..
> 
>             Linus

RISC-V probably would have been RCpc if we weren't having this discussion.
Depending on how we map atomics/acquire/release/unlock/lock, we can end up
producing RCpc, "RCtso" (feel free to find a better name here...), or RCsc
behaviors, and we're trying to figure out which we actually need.

I think the debate is this:

Obviously programmers would prefer just to have RCsc and not have to figure out
all the complexity of the other options.  On x86 or architectures with native
RCsc operations (like ARMv8), that's generally easy enough to get.

For weakly-ordered architectures that use fences for ordering (including
PowerPC and sometimes RISC-V, see below), though, it takes extra fences to go
from RCpc to either "RCtso" or RCsc.  People using these architectures are
concerned about whether there's a negative performance impact from those extra
fences.

However, some scheduler code, some RCU code, and probably some other examples
already implicitly or explicitly assume unlock()/lock() provides stronger
ordering than RCpc.  So, we have to decide whether to:
1) define unlock()/lock() to enforce "RCtso" or RCsc, insert more fences on
PowerPC and RISC-V accordingly, and probably negatively regress PowerPC
2) leave unlock()/lock() as enforcing only RCpc, fix any code that currently
assumes something stronger than RCpc is being provided, and hope people don't
get it wrong in the future
3) some mixture like having unlock()/lock() be "RCtso" but smp_store_release()/
smp_cond_load_acquire() be only RCpc

Also, FWIW, if other weakly-ordered architectures come along in the future and
also use any kind of lightweight fence rather than native RCsc operations,
they'll likely be in the same boat as RISC-V and Power here, in the sense of
not providing RCsc by default either.

Is that a fair assessment everyone?



I can also not-so-briefly summarize RISC-V's status here, since I think there's
been a bunch of confusion about where we're coming from:

First of all, I promise we're not trying to start a fight about all this :)
We're trying to understand the LKMM requirements so we know what instructions
to use.

With that, the easy case: RISC-V is RCsc if we use AMOs or load-reserved/
store-conditional, all of which have RCsc .aq and .rl bits:

  (a) ...
  amoswap.w.rl x0, x0, [lock]  // unlock()
  ...
loop:
  amoswap.w.aq a0, t1, [lock]  // lock()
  bnez a0, loop                // lock()
  (b) ...

(a) is ordered before (b) here, regardless of (a) and (b).  Likewise for our
load-reserved/store-conditional instructions, which also have .aq and rl.
That's similiar to how ARM behaves, and is no problem.  We're happy with that
too.

Unfortunately, we don't (currently?) have plain load-acquire or store-release
opcodes in the ISA.  (That's a different discussion...)  For those, we need
fences instead.  And that's where it gets messier.

RISC-V *would* end up providing only RCpc if we use what I'd argue is the most
"natural" fence-based mapping for store-release operations, and then pair that
with LR/SC:

  (a) ...
  fence rw,w     // unlock()
  sw x0, [lock]  // unlock()
  ...
loop:
  lr.w.aq a0, [lock]  // lock()
  sc.w t1, [lock]     // lock()
  bnez loop           // lock()
  (b) ...

However, if (a) and (b) are loads to different addresses, then (a) is not
ordered before (b) here.  One unpaired RCsc operation is not a full fence.
Clearly "fence rw,w" is not sufficient if the scheduler, RCU, and elsewhere
depend on "RCtso" or RCsc.

RISC-V can get back to "RCtso", matching PowerPC, by using a stronger fence:

  (a) ...
  fence.tso      // unlock(), fence.tso == fence rw,w + fence r,r
  sw x0, [lock]  // unlock()
  ...
loop:
  lr.w.aq a0, [lock]  // lock()
  sc.w t1, [lock]     // lock()
  bnez loop           // lock()
  (b) ...

(a) is ordered before (b), unless (a) is a store and (b) is a load to a
different address.

(Modeling note: this example is why I asked for Alan's v3 patch over the v2
patch, which I believe would only have worked if the fence.tso were at the end)

To get full RCsc here, we'd need a fence rw,rw in between the unlock store and
the lock load, much like PowerPC would I believe need a heavyweight sync:

  (a) ...
  fence rw,w     // unlock()
  sw x0, [lock]  // unlock()
  ...
  fence rw,rw    // can attach either to lock() or to unlock()
  ...
loop:
  lr.w.aq a0, [lock]  // lock()
  sc.w t1, [lock]     // lock()
  bnez loop           // lock()
  (b) ...

In general, RISC-V's fence.tso will suffice wherever PowerPC's lwsync does, and
RISC-V's fence rw,rw will suffice wherever PowerPC's full sync does.  If anyone
is claiming RISC-V is suddenly proposing to go weaker than all the other major
architectures, that's a mischaracterization.

All in all: if LKMM wants RCsc, we can do it, but it's not free for RISC-V (or
Power).  If LKMM wants RCtso, we can do that too, and that's in between.  If
LKMM wants RCpc, we can do that, and it's the fastest of the bunch.  No I don't
have concrete numbers either...  And RISC-V implementations are going to vary
pretty widely anyway.

Hope that helps.  Please correct anything I screwed up or mischaracterized.

Dan
