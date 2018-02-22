Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBVTsB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:48:01 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19607 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeBVTr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:47:59 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 22 Feb 2018 11:47:58 -0800
Subject: Re: [RFC PATCH] riscv/locking: Strengthen spin_lock() and
 spin_unlock()
To: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Andrea Parri <parri.andrea@gmail.com>, <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-riscv@lists.infradead.org>
References: <1519301990-11766-1-git-send-email-parri.andrea@gmail.com>
 <20180222134004.GN25181@hirez.programming.kicks-ass.net>
 <20180222141249.GA14033@andrea>
 <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com>
 <20180222181317.GI2855@linux.vnet.ibm.com>
 <20180222182717.GS25181@hirez.programming.kicks-ass.net>
From: Daniel Lustig <dlustig@nvidia.com>
Message-ID: <563431d0-4fb5-9efd-c393-83cc5197e934@nvidia.com>
Date: Thu, 22 Feb 2018 11:47:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222182717.GS25181@hirez.programming.kicks-ass.net>
X-Originating-IP: [10.110.39.68]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/2018 10:27 AM, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 10:13:17AM -0800, Paul E. McKenney wrote:
>> So we have something that is not all that rare in the Linux kernel
>> community, namely two conflicting more-or-less concurrent changes.
>> This clearly needs to be resolved, either by us not strengthening the
>> Linux-kernel memory model in the way we were planning to or by you
>> strengthening RISC-V to be no weaker than PowerPC for these sorts of
>> externally viewed release-acquire situations.
>>
>> Other thoughts?
> 
> Like said in the other email, I would _much_ prefer to not go weaker
> than PPC, I find that PPC is already painfully weak at times.

Sure, and RISC-V could make this work too by using RCsc instructions
and/or by using lightweight fences instead.  It just wasn't clear at
first whether smp_load_acquire() and smp_store_release() were RCpc,
RCsc, or something else, and hence whether RISC-V would actually need
to use something stronger than pure RCpc there.  Likewise for
spin_unlock()/spin_lock() and everywhere else this comes up.

As Paul's email in the other thread observed, RCpc seems to be
OK for smp_load_acquire()/smp_store_release() at least according
to the current LKMM herd spec.  Unlock/lock are stronger already
I guess.  But if there's an active proposal to strengthen them all
to something stricter than pure RCpc, then that's good to know.

My understanding from earlier discussions is that ARM has no plans
to use their own RCpc instruction for smp_load_acquire() instead
of their RCsc instructions.  Is that still true?  If they were to
use the RCpc load there, that would cause them to have the same
problem we're discussing here, right?  Just checking.

Dan
