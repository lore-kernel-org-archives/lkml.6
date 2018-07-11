Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB77BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D18F20C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D18F20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbeGKR4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:56:23 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19296 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732456AbeGKR4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:56:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b46437e0001>; Wed, 11 Jul 2018 10:50:55 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Jul 2018 10:50:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Jul 2018 10:50:57 -0700
Received: from [10.110.39.62] (10.110.39.62) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 17:50:57 +0000
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
CC:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea> <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea> <20180711155751.GC18477@arm.com>
 <20180711170053.GM2476@hirez.programming.kicks-ass.net>
From:   Daniel Lustig <dlustig@nvidia.com>
Message-ID: <e5148058-c551-ca65-eef3-4259badecf57@nvidia.com>
Date:   Wed, 11 Jul 2018 10:50:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180711170053.GM2476@hirez.programming.kicks-ass.net>
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

On 7/11/2018 10:00 AM, Peter Zijlstra wrote:
> On Wed, Jul 11, 2018 at 04:57:51PM +0100, Will Deacon wrote:
> 
>> It might be simple to model, but I worry this weakens our locking
>> implementations to a point where they will not be understood by the average
>> kernel developer. As I've said before, I would prefer "full" RCsc locking,
> 
> Another vote for RCsc locks. The (in)famous hold-out is of course
> PowerPC, but it now looks like RISC-V is following where they I really
> rather wish they didn't.

That's not entirely fair.  We came in wanting to do the "natural" or
"expected" thing: use RCsc atomics where we have them available in the
ISA, and use "fence r,rw" and "fence rw,w" where we don't.

I would argue that the idea of having data races on variables that are
also protected by locks is equally if not more counterintuitive and
unexpected than the "natural" mapping we had originally proposed to use.

All the discussion here[1] for example is about having ordering and
doing an smp_cond_load_acquire() on a variable which is sometimes
protected by a CPU's rq->lock and sometimes not?  Isn't that one of the
key use cases for this whole discussion?

FWIW, this code also mixes locking, smp_rmb(), and
smp_cond_load_acquire() all in very close proximity with each other...
I suppose there's no mixing and matching on the same variable, but
we are here trying to reason about how all those pieces interact, no?

[1] https://lkml.org/lkml/2015/10/6/805

Dan
