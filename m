Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88C1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9671024116
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9671024116
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeGEPfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:35:33 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15873 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbeGEPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:35:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3e3a9e0000>; Thu, 05 Jul 2018 08:34:54 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Jul 2018 08:35:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Jul 2018 08:35:32 -0700
Received: from [10.2.171.197] (10.2.171.197) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 15:35:31 +0000
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
From:   Daniel Lustig <dlustig@nvidia.com>
To:     Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <20180625081920.GA5619@andrea>
 <Pine.LNX.4.44L0.1807031228250.1513-100000@iolanthe.rowland.org>
 <20180704121103.GB26941@arm.com> <20180705140029.GA5346@andrea>
 <20180705144424.GE14470@arm.com>
 <b8728bed-67da-a204-d5d2-8341ad7d5a57@nvidia.com>
Message-ID: <26923846-94c1-f08d-76aa-271f27bc83a3@nvidia.com>
Date:   Thu, 5 Jul 2018 08:35:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b8728bed-67da-a204-d5d2-8341ad7d5a57@nvidia.com>
X-Originating-IP: [10.2.171.197]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/2018 8:16 AM, Daniel Lustig wrote:
> On 7/5/2018 7:44 AM, Will Deacon wrote:
>> Andrea,
>>
>> On Thu, Jul 05, 2018 at 04:00:29PM +0200, Andrea Parri wrote:
>>> On Wed, Jul 04, 2018 at 01:11:04PM +0100, Will Deacon wrote:
>>>> On Tue, Jul 03, 2018 at 01:28:17PM -0400, Alan Stern wrote:
>>>>> There's also read-write ordering, in the form of the LB pattern:
>>>>>
>>>>> P0(int *x, int *y, int *z)
>>>>> {
>>>>> 	r0 = READ_ONCE(*x);
>>>>> 	smp_store_release(z, 1);
>>>>> 	r1 = smp_load_acquire(z);
>>>>> 	WRITE_ONCE(*y, 1);
>>>>> }
>>>>>
>>>>> P1(int *x, int *y)
>>>>> {
>>>>> 	r2 = READ_ONCE(*y);
>>>>> 	smp_mp();
>>>>> 	WRITE_ONCE(*x, 1);
>>>>> }
>>>>>
>>>>> exists (0:r0=1 /\ 1:r2=1)
>>>>
>>>> The access types are irrelevant to the acquire/release primitives, so yes
>>>> that's also allowed.
>>>>
>>>>> Would this be allowed if smp_load_acquire() was implemented with LDAPR?
>>>>> If the answer is yes then we will have to remove the rfi-rel-acq and
>>>>> rel-rf-acq-po relations from the memory model entirely.
>>>>
>>>> I don't understand what you mean by "rfi-rel-acq-po", and I assume you mean
>>>> rel-rfi-acq-po for the other? Sounds like I'm confused here.
>>>
>>> [Your reply about 1/2 suggests that you've figured this out now, IAC ...]
>>
>> Yeah, the naming threw me because it's not the same order as the composition
>> in the actual definition (why not?). I typoed an extra 'po' suffix. Well
>> done for spotting it.
>>
>>> "rfi-rel-acq" (as Alan wrote, and as I wrote before my question above...)
>>> is defined and currently used in linux-kernel.cat (and, FWIW, it has been
>>> so since when we upstreamed LKMM).
>>>
>>> My point is that, as exemplified by the two tests I reported above, this
>>> relation already prevents you from implementing your acquire with LDAPR;
>>> so my/our question was not "can you run herd7 for me?" but rather "do you
>>> think that changes are needed to the .cat file?".
>>
>> I mean, you can run herd on the armv8 memory model and see the answer to the
>> litmus test. So we have two options for the LKMM .cat file (the Arm one is
>> baked in silicon):
>>
>>   1. Say that architectures with RCpc acquire/release instructions must
>>      instead use RCsc instructions (if they have them) or full fences
>>
>>   2. Change the LKMM .cat file to allow RCpc acquire/release (note that I'd
>>      still like RCsc lock/unlock semantics, and I think that's actually the
>>      real case that matters here, but the currently difficulty in
>>      distinguishing the two in the .cat file has led to this broader
>>      ordering being enforced as a side-effect)
>>
>> I prefer (2), because I think it's a safe and sensible relaxation to make
>> and accomodates what I consider to be a likely extension to weakly ordered
>> architectures that we might want to support efficiently. So yes, I think
>> changes are needed to the LKMM .cat file, but please don't view that as a
>> criticism. We change stuff all the time as long as it doesn't break userspace.
>>
>>> This question goes back _at least_ to:
>>>
>>>   http://lkml.kernel.org/r/1519301990-11766-1-git-send-email-parri.andrea@gmail.com
>>>
>>> (see, in part., the "IMPORTANT" note at the bottom of the commit message)
>>> and that discussion later resulted in:
>>>
>>>   0123f4d76ca63b ("riscv/spinlock: Strengthen implementations with fences")
>>>   5ce6c1f3535fa8 ("riscv/atomic: Strengthen implementations with fences")
>>>
>>> (the latest _draft_ of the RISC-V specification, as pointed out by Daniel,
>>>
>>>   https://github.com/riscv/riscv-isa-manual, Appendix A.5
>>>
>>>  includes our "Linux mapping", although the currently-recommended mapping
>>>  differs and involves a "fence.tso [+ any acquire, including RCpc .aq]").
>>
>> [I think the discussion at hand is broader than RISC-V, and I looped in
>>  Daniel already]
> 
> Sorry for the delay, it was Independence Day here in the US.
> 
> I'm aligned with Will on all this so far.  As mentioned above, this issue
> definitely comes up on RISC-V, but for reasons even beyond RCpc vs. RCsc.
> Why?  On RISC-V, we have RCsc atomics, but no native load-acquire or
> store-release opcodes.  You might expect you can use "ld; fence r,rw"
> and "fence rw,w; sd", respectively, but those don't interact with the
> RCsc .aq/.rl mappings.  For example, suppose we did this:
> 
> (a)
> amoswap.w.rl x0, x0, 0(a1)   // st-rel using amoswap with dummy dest
> ...
> lw a0, 0(a1)                 // ld-acq using fence-based mapping
> fence r,rw
> (b)
> 
> Nothing here orders (a) before (b) in general.  A mapping always using

And here, I should have said that (a) and (b) are stores.  But then
flip it around, so that the release uses fences and the acquire uses
RCsc, and then there's a similar lack of read->read ordering between
(a) and (b).  That's what I really meant to say here.  Depending on
which particular mapping you use in each case, you may or may not get
R->R or W->W ordering.

> fences would cover what's being asked for (I believe), and using only
> RCsc operations (like ARM does) would also work if we had native
> load-acquire and store-release operations, but this mixed mapping
> doesn't.  That's why the spec currently recommends the stronger
> fence.tso (~= multi-copy atomic Power lwsync) instead.
> 
> ...but it's very non-obvious.  Is there really a hurry to rush all
> this in?
> 
>>> My understanding is that your answer to this question is "Yes", but I am
>>> not sure about the "How/Which changes?"; of course, an answer his question
>>> _in the form_ of PATCHes would be appreciated! (but please also consider
>>> that I'll be offline for most of the time until next Monday.)
>>
>> C'mon, I'm reviewing patches here. The onus shouldn't be on the reviewer to
>> come back with the correct version of the patch. I'm also not terribly
>> worried if LKMM says the wrong thing whilst we work out what the right
>> thing should be, but I /would/ be worried if we started adding full fences to
>> an architecture that has acquire/release instructions just because they're
>> RCpc. If it turns out that no other arch maintainers care, then fine,
>> because frankly this doesn't affect me, but so far it's basically been
>> silence and I'd really like some more input before we close the door on
>> them
> 
> I care!  Thanks for speaking up Will!
> 
> Dan
> 
>>
>> Will
>>
