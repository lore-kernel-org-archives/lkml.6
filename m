Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE857C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA0D20864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA0D20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933875AbeGIR35 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:29:57 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13131 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933425AbeGIR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:29:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b439b910000>; Mon, 09 Jul 2018 10:29:53 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 09 Jul 2018 10:29:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 09 Jul 2018 10:29:55 -0700
Received: from [10.110.39.62] (10.110.39.62) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 9 Jul
 2018 17:29:54 +0000
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
To:     Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
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
References: <20180705150945.GA3699@andrea>
 <Pine.LNX.4.44L0.1807061629280.1396-100000@iolanthe.rowland.org>
 <20180706211055.GN3593@linux.vnet.ibm.com> <20180709165200.GA4689@arm.com>
From:   Daniel Lustig <dlustig@nvidia.com>
Message-ID: <01c35480-e207-c916-078b-de53df0e2645@nvidia.com>
Date:   Mon, 9 Jul 2018 10:29:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180709165200.GA4689@arm.com>
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

On 7/9/2018 9:52 AM, Will Deacon wrote:
> On Fri, Jul 06, 2018 at 02:10:55PM -0700, Paul E. McKenney wrote:
>> On Fri, Jul 06, 2018 at 04:37:21PM -0400, Alan Stern wrote:
>>> On Thu, 5 Jul 2018, Andrea Parri wrote:
>>>
>>>>> At any rate, it looks like instead of strengthening the relation, I
>>>>> should write a patch that removes it entirely.  I also will add new,
>>>>> stronger relations for use with locking, essentially making spin_lock
>>>>> and spin_unlock be RCsc.
>>>>
>>>> Thank you.
>>>>
>>>> Ah let me put this forward: please keep an eye on the (generic)
>>>>
>>>>   queued_spin_lock()
>>>>   queued_spin_unlock()
>>>>
>>>> (just to point out an example). Their implementation (in part.,
>>>> the fast-path) suggests that if we will stick to RCsc lock then
>>>> we should also stick to RCsc acq. load from RMW and rel. store.

Just to be clear, this is "RCsc with W->R exception" again, right?

>>> A very good point.  The implementation of those routines uses
>>> atomic_cmpxchg_acquire() to acquire the lock.  Unless this is
>>> implemented with an operation or fence that provides write-write
>>> ordering (in conjunction with a suitable release), qspinlocks won't
>>> have the ordering properties that we want.
>>>
>>> I'm going to assume that the release operations used for unlocking
>>> don't need to have any extra properties; only the lock-acquire
>>> operations need to be special (i.e., stronger than a normal
>>> smp_load_acquire). This suggests that atomic RMW functions with acquire
>>> semantics should also use this stronger form of acquire.

It's not clear to me that the burden of enforcing "RCsc with W->R
ordering" should always be placed only on the acquire half.
RISC-V currently places some of the burden on the release half, as
we discussed last week.  Specifically, there are a few cases where
fence.tso is used instead of fence rw,w on the release side.

If we always use fence.tso here, following the current recommendation,
we'll still be fine.  If LKMM introduces an RCpc vs. RCsc distinction
of some kind, though, I think we would want to distinguish the two
types of release accordingly as well.

>>> Does anybody have a different suggestion?
>>
>> The approach you suggest makes sense to me.  Will, Peter, Daniel, any
>> reasons why this approach would be a problem for you guys?
> 
> qspinlock is very much opt-in per arch, so we can simply require that
> an architecture must have RCsc RmW atomics if they want to use qspinlock.
> Should an architecture arise where that isn't the case, then we could
> consider an arch hook in the qspinlock code, but I don't think we have
> to solve that yet.
> 
> Will

This sounds reasonable to me.

Dan

