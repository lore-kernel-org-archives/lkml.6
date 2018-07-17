Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA4FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29F62077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a7lBy4oz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29F62077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeGQTRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:17:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49506 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQTRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mbhi9UOHjJoUMSiF5CPD0d0YTUQMuKa7eRANov79eqU=; b=a7lBy4ozIeW6L6lDPksDRnHzF
        m/N2Dv9jrQVf/diClKhXtznADcoa71ng0NV8ke1e6jfDrWulSW0////f8ei7VZYRuYflP552CBaVh
        N3LpqG1UX2aFIyLej2j7a4Fwc1mv5jQZIueLSBQxoChziRXYn1kHomCv8VwOPDWN+O9rH+Yyk95m4
        zNqRxkfg5zBvAaeXK2SuUmLF+aEX4KPs9EbRvyyOZPOgeSQQ2rChjT7q84/BfV6PHxweQoB3kTBsa
        GTnfTE/9mrkkcdJcY1czv0+CURUbdJq12dhnBW4qhVvSMsnoR2n6K/QTAgLOfiRv9fpJsnvKwufJE
        RutOqkdOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffUw5-0002rJ-3W; Tue, 17 Jul 2018 18:42:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7C5220275F36; Tue, 17 Jul 2018 20:42:55 +0200 (CEST)
Date:   Tue, 17 Jul 2018 20:42:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180717184255.GM2494@hirez.programming.kicks-ass.net>
References: <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180713110851.GY2494@hirez.programming.kicks-ass.net>
 <87tvp3xonl.fsf@concordia.ellerman.id.au>
 <20180713164239.GZ2494@hirez.programming.kicks-ass.net>
 <87601fz1kc.fsf@concordia.ellerman.id.au>
 <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com>
 <87va9dyl8y.fsf@concordia.ellerman.id.au>
 <CA+55aFyFLzH71Tke858x0cjCiRO48vc1W9oVmVkO43rtjezqOg@mail.gmail.com>
 <20180717183341.GQ12945@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717183341.GQ12945@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:33:41AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 17, 2018 at 09:19:15AM -0700, Linus Torvalds wrote:
> > 
> > In particular, I find:
> > 
> >   "isync is not a memory barrier instruction, but the
> > load-compare-conditional branch-isync sequence can provide this
> > ordering property"
> > 
> > so why are you doing "sync/lwsync", when it sounds like "isync/lwsync"
> > (for lock/unlock) is the right thing and would already give memory
> > barrier semantics?
> 
> The PowerPC guys will correct me if I miss something here...
> 
> The isync provides ordering roughly similar to lwsync, but nowhere near
> as strong as sync, and it is sync that would be needed to cause lock
> acquisition to provide full ordering.  The reason for using lwsync instead
> of isync is that the former proved to be faster on recent hardware.
> The reason that the kernel still has the ability to instead generate
> isync instructions is that some older PowerPC hardware does not provide
> the lwsync instruction.  If the hardware does support lwsync, the isync
> instructions are overwritten with lwsync at boot time.

Isn't ISYNC the instruction-sync pipeline flush instruction? That is
used as an smp_rmb() here to, together with the control dependency from the
LL/SC, to form a LOAD->{LOAD,STORE} (aka LOAD-ACQUIRE) ordering?

Where LWSYNC provides a TSO like ordering and SYNC provides a full
transitive barrier aka. smp_mb() (althgouh I think it is strictly
stronger than smp_mb() since it also implies completion, which smp_mb()
does not).

And since both LL/SC-CTRL + ISYNC / LWSYNC are strictly CPU local, they
cannot be used to create RCsc ordering.

