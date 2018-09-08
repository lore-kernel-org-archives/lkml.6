Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B8C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 00:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E2520855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 00:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gSjxLHIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E2520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeIHEsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 00:48:08 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15242 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeIHEsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 00:48:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b93121a0001>; Fri, 07 Sep 2018 17:04:42 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Sep 2018 17:04:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Sep 2018 17:04:41 -0700
Received: from DRHQMAIL101.nvidia.com (10.27.9.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 8 Sep
 2018 00:04:41 +0000
Received: from [10.110.39.62] (10.124.1.5) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 8 Sep 2018
 00:04:41 +0000
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <mingo@kernel.org>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>, <akiyks@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>
References: <Pine.LNX.4.44L0.1809071256340.1547-100000@iolanthe.rowland.org>
From:   Daniel Lustig <dlustig@nvidia.com>
Message-ID: <23c8bcfe-3db1-665f-d054-1857c5b88006@nvidia.com>
Date:   Fri, 7 Sep 2018 17:04:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1809071256340.1547-100000@iolanthe.rowland.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL101.nvidia.com (10.27.9.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1536365082; bh=WiXkCRLITJeO9RdAGPRZUZbQdI7HEoMMRixxPSN2HEs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gSjxLHISsNU0xO6yQYHHBHvbK3ewkbZg0E8rNr6HfP03BiM9XD3e6nocgILi5Cl8O
         Z+6szuyrJP/Ik3GfV9Ec+EIqZAuknzhYDiUL6RPqdDa6YY5ik67Q4lp5vJDhDqri52
         9iEJCKDd0goaR0bicFXxM6UKZl9MJPGIWOxP33lwF54EgYxTooGfrgg6jMZWsnODBc
         Dypy7QJ/fPOJF01es1i3N6oyMa5Fi2x5QbazEhwOX2+dfnhYcR+1dMfKq6K8aB29LJ
         w6foK/Gr2ZEpCJBaOTPaSykWXvL1OUoU6pJxtNWpxdR58405ckBplhLDPVbLm0EoBE
         tsPej0KCL8m7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2018 10:38 AM, Alan Stern wrote:
> On Fri, 7 Sep 2018, Daniel Lustig wrote:
> 
>> On 9/7/2018 9:09 AM, Will Deacon wrote:
>>> On Fri, Sep 07, 2018 at 12:00:19PM -0400, Alan Stern wrote:
>>>> On Thu, 6 Sep 2018, Andrea Parri wrote:
>>>>
>>>>>> Have you noticed any part of the generic code that relies on ordinary 
>>>>>> acquire-release (rather than atomic RMW acquire-release) in order to 
>>>>>> implement locking constructs?
>>>>>
>>>>> There are several places in code where the "lock-acquire" seems to be
>>>>> provided by an atomic_cond_read_acquire/smp_cond_load_acquire: I have
>>>>> mentioned one in qspinlock in this thread; qrwlock and mcs_spinlock
>>>>> provide other examples (grep for the primitives...).
>>>>>
>>>>> As long as we don't consider these primitive as RMW (which would seem
>>>>> odd...) or as acquire for which "most people expect strong ordering"
>>>>> (see above), these provides other examples for the _gap_ I mentioned.
>>>>
>>>> Okay, now I understand your objection.  It does appear that on RISC-V,
>>>> if nowhere else, the current implementations of qspinlock, qrwlock,
>>>> etc. will not provide "RCtso" ordering.
>>>>
>>>> The discussions surrounding this topic have been so lengthy and 
>>>> confusing that I have lost track of any comments Palmer or Daniel may 
>>>> have made concerning this potential problem.
>>>>
>>>> One possible resolution would be to define smp_cond_load_acquire() 
>>>> specially on RISC-V so that it provided the same ordering guarantees as 
>>>> RMW-acquire.  (Plus adding a comment in the asm-generic/barrier.h 
>>>> pointing out the necessity for the stronger guarantee on all 
>>>> architectures.)
>>>>
>>>> Another would be to replace the usages of atomic/smp_cond_load_acquire 
>>>> in the locking constructs with a new function that would otherwise be 
>>>> the same but would provide the ordering guarantee we want.
>>>>
>>>> Do you think either of these would be an adequate fix?
>>>
>>> I didn't think RISC-V used qspinlock or qrwlock, so I'm not sure there's
>>> actually anything to fix, is there?
>>>
>>> Will
>>
>> I've also lost track of whether the current preference is or is not for
>> RCtso, or in which subset of cases RCtso is currently preferred.  For
>> whichever cases do in fact need to be RCtso, the RISC-V approach would
>> still be the same as what I've written in the past, as far as I can
>> tell [1].
> 
> The patch which Paul plans to send in for the next merge window makes 
> the LKMM require RCtso ordering for spinlocks, and by extension, for 
> all locking operations.  As I understand it, the current RISC-V 
> implementation of spinlocks does provide this ordering.
> 
> We have discussed creating another patch for the LKMM which would
> require RMW-acquire/ordinary-release also to have RCtso ordering.  
> Nobody has written the patch yet, but it would be straightfoward.  The
> rationale is that many types of locks are implemented in terms of
> RMW-acquire, so if the locks are required to be RCtso then so should
> the lower-level operations they are built from.
> 
> Will feels strongly (and Linus agrees) that the LKMM should not require
> ordinary acquire and release to be any stronger than RCpc.
> 
> The issue that Andrea raised has to do with qspinlock, qrwlock, and
> mcs_spinlock, which are implemented using smp_cond_load_acquire()  
> instead of RMW-acquire.  This provides only the ordering properties of
> smp_load_acquire(), namely RCpc, which means that qspinlocks etc. might
> not be RCtso.
> 
> Since we do want locks to be RCtso, the question is how to resolve this 
> discrepancy.

Thanks for the summary Alan!

I think RISC-V might actually get RCtso with smp_cond_load_acquire()
implemented using fence r,rw, believe it or not :)

The read->read and read->write requirements are covered by the fence r,rw, so
what we need to add on is the write->write ordering requirement.  On RISC-V,
we can get release semantics in three ways: fence rw,w, AMO.rl, and SC.rl.

If we use fence rw,w for release, then the "w,w" part covers it.

If we use AMO.rl for release, then the prior stores are ordered before the
AMO, and the fence r,rw orders the AMO before subsequent stores.

If we use SC.rl, then the prior stores are ordered before the SC, and the
branch to check whether the SC succeeded induces a control dependency that
keeps subsequent stores ordered after the SC.

So, it seems to work anyway.  I did a quick check of this property against
my Alloy model and it seems to agree as well.

The one combination that doesn't quite get you RCtso on RISC-V is pairing a
fence r,rw with an LR.aq.  I think everything else works, including pairing
fence r,rw with AMO.aq.  So it's really this one case we have to look out for.

Does that seem plausible to you all?

Dan

>> In a nutshell, if a data structure uses only atomics with .aq/.rl,
>> RISC-V provides RCtso already anyway.  If a data structure uses fences,
>> or mixes fences and atomics, we can replace a "fence r,rw" or a
>> "fence rw,w" with a "fence.tso" (== fence r,rw + fence rw,w) as
>> necessary, at the cost of some amount of performance.
>>
>> I suppose the answer to the question of whether smp_cond_load_acquire()
>> needs to change depends on where exactly RCtso is needed, and which
>> data structures actually use that vs. some other macro. 
>>
>> Does that answer your question Alan?  Does it make sense?
> 
> On all other architectures, as far as I know, smp_cond_load_acquire() 
> is in fact RCtso.  Any changes would only be needed on RISC-V.
> 
> A quick grep of the kernel source (not quite up-to-date, unfortunately)  
> turns up only the following additional usages of 
> smp_cond_load_acquire():
> 
> 	It is used in kernel/smp.c for csd_lock(); I don't know what 
> 	that is meant for.
> 
> 	It is also used in the scheduler core (kernel/sched/core.c).  I 
> 	don't know what ordering requirements the scheduler has for it,
> 	but Peter does.
> 
> 	There's a usage in drivers/iommu/arm-smmu-v3.c, but no comment 
> 	to explain why it is needed.
> 
> To tell the truth, I'm not aware of any code in the kernel that
> actually _needs_ RCtso ordering for locks, but Peter and Will are quite
> firm that it should be required.  Linus would actually like locks to be
> RCsc, but he recognizes that this would incur a noticeable performance
> penalty on Power so he'll settle for RCtso.
> 
> I'm not in a position to say whether smp_cond_load_acquire() should be 
> changed, but hopefully this information will help others to make that 
> determination.
> 
> Alan
> 
>> [1] https://lore.kernel.org/lkml/11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com/
>>
>> Dan
> 
