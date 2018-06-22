Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6B3C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8CD23EAC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8CD23EAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeFVIIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:08:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59422 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbeFVIIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:08:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 527CB1435;
        Fri, 22 Jun 2018 01:08:52 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23EA83F557;
        Fri, 22 Jun 2018 01:08:52 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 866DE1AE2E48; Fri, 22 Jun 2018 09:09:28 +0100 (BST)
Date:   Fri, 22 Jun 2018 09:09:28 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180622080928.GB7601@arm.com>
References: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Thu, Jun 21, 2018 at 01:27:12PM -0400, Alan Stern wrote:
> More than one kernel developer has expressed the opinion that the LKMM
> should enforce ordering of writes by release-acquire chains and by
> locking.  In other words, given the following code:
> 
> 	WRITE_ONCE(x, 1);
> 	spin_unlock(&s):
> 	spin_lock(&s);
> 	WRITE_ONCE(y, 1);
> 
> or the following:
> 
> 	smp_store_release(&x, 1);
> 	r1 = smp_load_acquire(&x);	// r1 = 1
> 	WRITE_ONCE(y, 1);
> 
> the stores to x and y should be propagated in order to all other CPUs,
> even though those other CPUs might not access the lock s or be part of
> the release-acquire chain.  In terms of the memory model, this means
> that rel-rf-acq-po should be part of the cumul-fence relation.
> 
> All the architectures supported by the Linux kernel (including RISC-V)
> do behave this way, albeit for varying reasons.  Therefore this patch
> changes the model in accordance with the developers' wishes.

Interesting...

I think the second example would preclude us using LDAPR for load-acquire,
so I'm surprised that RISC-V is ok with this. For example, the first test
below is allowed on arm64.

I also think this would break if we used DMB LD to implement load-acquire
(second test below).

So I'm not a big fan of this change, and I'm surprised this works on all
architectures. What's the justification?

Will

--->8

AArch64 MP+poslq-poqp+poap
"PosWRLQ PodRWQP RfePA PodRRAP FrePL"
Generator=diyone7 (version 7.46+3)
Prefetch=0:x=F,0:y=W,1:y=F,1:x=T
Com=Rf Fr
Orig=PosWRLQ PodRWQP RfePA PodRRAP FrePL
{
0:X1=x; 0:X4=y;
1:X1=y; 1:X3=x;
}
 P0            | P1           ;
 MOV W0,#1     | LDAR W0,[X1] ;
 STLR W0,[X1]  | LDR W2,[X3]  ;
 LDAPR W2,[X1] |              ;
 MOV W3,#1     |              ;
 STR W3,[X4]   |              ;
exists
(1:X0=1 /\ 1:X2=0)


AArch64 MP+pos-dmb.ld+poap
"PosWR DMB.LDdRW RfePA PodRRAP Fre"
Generator=diyone7 (version 7.46+3)
Prefetch=0:x=F,0:y=W,1:y=F,1:x=T
Com=Rf Fr
Orig=PosWR DMB.LDdRW RfePA PodRRAP Fre
{
0:X1=x; 0:X4=y;
1:X1=y; 1:X3=x;
}
 P0          | P1           ;
 MOV W0,#1   | LDAR W0,[X1] ;
 STR W0,[X1] | LDR W2,[X3]  ;
 LDR W2,[X1] |              ;
 DMB LD      |              ;
 MOV W3,#1   |              ;
 STR W3,[X4] |              ;
exists
(1:X0=1 /\ 1:X2=0)
