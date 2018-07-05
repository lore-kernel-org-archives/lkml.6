Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5F7C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC19523F51
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC19523F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753922AbeGESM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:12:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4370 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeGESM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:12:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3e5f640000>; Thu, 05 Jul 2018 11:11:48 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Jul 2018 11:12:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Jul 2018 11:12:26 -0700
Received: from [10.110.39.62] (10.110.39.62) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 18:12:25 +0000
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
To:     <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
 <20180705153140.GO3593@linux.vnet.ibm.com>
 <b41849a8-76cd-2375-dd80-c1bdeb9ea7d2@nvidia.com>
 <20180705162225.GH14470@arm.com> <20180705165602.GQ3593@linux.vnet.ibm.com>
From:   Daniel Lustig <dlustig@nvidia.com>
Message-ID: <eeaf2ad2-39a0-2ce9-b628-6775baad4e8a@nvidia.com>
Date:   Thu, 5 Jul 2018 11:12:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705165602.GQ3593@linux.vnet.ibm.com>
X-Originating-IP: [10.110.39.62]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/2018 9:56 AM, Paul E. McKenney wrote:
> On Thu, Jul 05, 2018 at 05:22:26PM +0100, Will Deacon wrote:
>> On Thu, Jul 05, 2018 at 08:44:39AM -0700, Daniel Lustig wrote:
>>> On 7/5/2018 8:31 AM, Paul E. McKenney wrote:
>>>> On Thu, Jul 05, 2018 at 10:21:36AM -0400, Alan Stern wrote:
>>>>> At any rate, it looks like instead of strengthening the relation, I
>>>>> should write a patch that removes it entirely.  I also will add new,
>>>>> stronger relations for use with locking, essentially making spin_lock
>>>>> and spin_unlock be RCsc.
>>>>
>>>> Only in the presence of smp_mb__after_unlock_lock() or
>>>> smp_mb__after_spinlock(), correct?  Or am I confused about RCsc?
>>>>
>>>> 							Thanx, Paul
>>>>
>>>
>>> In terms of naming...is what you're asking for really RCsc?  To me,
>>> that would imply that even stores in the first critical section would
>>> need to be ordered before loads in the second critical section.
>>> Meaning that even x86 would need an mfence in either lock() or unlock()?
>>
>> I think a LOCK operation always implies an atomic RmW, which will give
>> full ordering guarantees on x86. I know there have been interesting issues
>> involving I/O accesses in the past, but I think that's still out of scope
>> for the memory model.

Yes, you're right about atomic RMWs on x86, and I'm not worried about I/O
here either.  But see below.

>>
>> Peter will know.
> 
> Agreed, x86 locked operations imply full fences, so x86 will order the
> accesses in consecutive critical sections with respect to an observer
> not holding the lock, even stores in earlier critical sections against
> loads in later critical sections.  We have been discussing tightening
> LKMM to make an unlock-lock pair order everything except earlier stores
> vs. later loads.  (Of course, if everyone holds the lock, they will see
> full ordering against both earlier and later critical sections.)
> 
> Or are you pushing for something stronger?
> 
> 							Thanx, Paul
> 

No, I'm definitely not pushing for anything stronger.  I'm still just
wondering if the name "RCsc" is right for what you described.  For
example, Andrea just said this in a parallel email:

> "RCsc" as ordering everything except for W -> R, without the [extra]
> barriers

If it's "RCsc with exceptions", doesn't it make sense to find a
different name, rather than simply overloading the term "RCsc" with
a subtly different meaning, and hoping nobody gets confused?

I suppose on x86 and ARM you'd happen to get "true RCsc" anyway, just
due to the way things are currently mapped: LOCKed RMWs and "true RCsc"
instructions, respectively.  But on Power and RISC-V, it would really
be more "RCsc with a W->R exception", right?

In fact, the more I think about it, this doesn't seem to be RCsc at all.
It seems closer to "RCpc plus extra PC ordering between critical
sections".  No?

The synchronization accesses themselves aren't sequentially consistent
with respect to each other under the Power or RISC-V mappings, unless
there's a hwsync in there somewhere that I missed?  Or a rule
preventing stw from forwarding to lwarx?  Or some other higher-order
effect preventing it from being observed anyway?

So that's all I'm suggesting here.  If you all buy that, maybe "RCpccs"
for "RCpc with processor consistent critical section ordering"?
I don't have a strong opinion on the name itself; I just want to find
a name that's less ambiguous or overloaded.

Dan
