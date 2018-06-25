Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDB3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54E1246AC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54E1246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeFYPoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:44:18 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1098 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeFYPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:44:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b310db40000>; Mon, 25 Jun 2018 08:43:48 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 Jun 2018 08:44:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 Jun 2018 08:44:16 -0700
Received: from [10.2.161.48] (10.2.161.48) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Jun
 2018 15:44:15 +0000
Subject: Re: [PATCH] doc: Update wake_up() & co. memory-barrier guarantees
To:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180625095031.GX2494@hirez.programming.kicks-ass.net>
 <20180625105618.GA12676@andrea>
 <20180625123121.GY2494@hirez.programming.kicks-ass.net>
 <20180625131643.GA15126@andrea>
 <20180625141830.GC2494@hirez.programming.kicks-ass.net>
 <20180625145611.GA16333@andrea>
From:   Daniel Lustig <dlustig@nvidia.com>
Message-ID: <bad7783b-9510-0049-b10a-a0d7f7273b57@nvidia.com>
Date:   Mon, 25 Jun 2018 08:44:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625145611.GA16333@andrea>
X-Originating-IP: [10.2.161.48]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/2018 7:56 AM, Andrea Parri wrote:
> On Mon, Jun 25, 2018 at 04:18:30PM +0200, Peter Zijlstra wrote:
>> On Mon, Jun 25, 2018 at 03:16:43PM +0200, Andrea Parri wrote:
>>>>> A concrete example being the store-buffering pattern reported in [1].
>>>>
>>>> Well, that example only needs a store->load barrier. It so happens
>>>> smp_mb() is the only one actually doing that, but imagine we had a
>>>> weaker barrier that did just that, one that did not imply the full
>>>> transitivity smp_mb() does.
>>>>
>>>> Then the example from [1] could use that weaker thing.
>>>
>>> Absolutely (and that would be "fence w,r" on RISC-V, IIUC).
>>
>> Ah cute. What is the transitivity model of those "fence" instructions? I
>> see their smp_mb() is "fence rw,rw" and smp_mb() must be RSsc. Otoh
>> their smp_wmb() is "fence w,w" which is only only required to be RCpc.
>>
>> So what does RISC-V do for "w,w" and "w,r" like things?
> 
> I'd defer to Daniel (in Cc:) for this ;-)  I simply checked the SB pattern
> plus w,r fences against the following models:
> 
>   http://www.cl.cam.ac.uk/~sf502/regressions/rmem/
>   http://moscova.inria.fr/~maranget/cats7/riscv/ 
> 

First off, the latest RISC-V spec is here, in case anyone hasn't seen it:
https://github.com/riscv/riscv-isa-manual.  It's all public now,
fortunately.  There's a PDF link at the bottom of that page too.  The
spec now has proposed Linux mappings (not all of which have actually made
it upstream...) in Appendix A.5 as well.  We'd welcome general feedback
on those.

Now to the question above:

RISC-V is (other-)multi-copy-atomic, so I don't think transitivity
should be an issue here.

We do have a "fence w,r", but we decided to warn against actually using
it for a few reasons: 1) lack of known common use cases :), 2) IIRC
there was some corner case discrepancy between the axiomatic and
operational models if we allowed it, and 3) in practice, it's already
both expensive enough and obscure enough that many or most
implementations will simply just treat it as "fence rw,rw" anyway.

So, in theory, "fence w,r" should be enough to prevent SB-like patterns.
It's just not yet clear that it's a big enough win that it's worth
creating a new fence macro for it, or pulling the current RISC-V
recommendation against its use.  What do you all think?

Are there other known use cases where you really do want a "fence w,r"
that's intentionally not also something stronger?  How common would the
pattern be?

Dan
