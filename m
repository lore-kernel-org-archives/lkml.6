Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32C9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC03E2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m2dNdYtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfBVOUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:20:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48128 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cLLafuW3RFjalN77EqZqiogM2PFiUm3KfauqCgeJjg0=; b=m2dNdYtnZ6f7t9JkpE71tns6y
        edgzVdazOgAWrxtDQREo9ylGeVRmkJ5qLTqhD6YVMwE6Fvrq52D0AB/Mr6bxacQUhMJ50Jq/KDUju
        iXVsHpmCWdEDmly8j8Hhft2nBGwpEWkkZPYOt8hB9QNeiwgGhNLu/ohhU0WjrOHhLJM+/J/azVqij
        PkQ5oO5GpT9nqUoeGGziDs/7SC4tJ7J3WkFS/AZ2f07tjDVCKDhM4qR0nG8NmKvR7gFneL2BmJ3Nz
        wqc+DXF3IGKncs2Gz8tqO2a/RWO+eE2PnLCXXaJR1RMeU+Oz6yCl4DuXGH9qQgb5FRxz2w1tdxBE5
        nMXX5krtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxBgm-0003LN-0h; Fri, 22 Feb 2019 14:20:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C29F2871C0AD; Fri, 22 Feb 2019 15:20:30 +0100 (CET)
Date:   Fri, 22 Feb 2019 15:20:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        subhra.mazumdar@oracle.com,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
Message-ID: <20190222142030.GA32494@hirez.programming.kicks-ass.net>
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190218204020.GV32494@hirez.programming.kicks-ass.net>
 <407b6589-1801-20b5-e3b7-d7458370cfc0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407b6589-1801-20b5-e3b7-d7458370cfc0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 01:17:01PM +0100, Paolo Bonzini wrote:
> On 18/02/19 21:40, Peter Zijlstra wrote:
> > On Mon, Feb 18, 2019 at 09:49:10AM -0800, Linus Torvalds wrote:
> >> On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>>
> >>> However; whichever way around you turn this cookie; it is expensive and nasty.
> >>
> >> Do you (or anybody else) have numbers for real loads?
> >>
> >> Because performance is all that matters. If performance is bad, then
> >> it's pointless, since just turning off SMT is the answer.
> > 
> > Not for these patches; they stopped crashing only yesterday and I
> > cleaned them up and send them out.
> > 
> > The previous version; which was more horrible; but L1TF complete, was
> > between OK-ish and horrible depending on the number of VMEXITs a
> > workload had.
> >
> > If there were close to no VMEXITs, it beat smt=off, if there were lots
> > of VMEXITs it was far far worse. Supposedly hosting people try their
> > very bestest to have no VMEXITs so it mostly works for them (with the
> > obvious exception of single VCPU guests).
> 
> If you are giving access to dedicated cores to guests, you also let them
> do PAUSE/HLT/MWAIT without vmexits and the host just thinks it's a CPU
> bound workload.
> 
> In any case, IIUC what you are looking for is:
> 
> 1) take a benchmark that *is* helped by SMT, this will be something CPU
> bound.
> 
> 2) compare two runs, one without SMT and without core scheduler, and one
> with SMT+core scheduler.
> 
> 3) find out whether performance is helped by SMT despite the increased
> overhead of the core scheduler
> 
> Do you want some other load in the host, so that the scheduler actually
> does do something?  Or is the point just that you show that the
> performance isn't affected when the scheduler does not have anything to
> do (which should be obvious, but having numbers is always better)?

Well, what _I_ want is for all this to just go away :-)

Tim did much of testing last time around; and I don't think he did
core-pinning of VMs much (although I'm sure he did some of that). I'm
still a complete virt noob; I can barely boot a VM to save my life.

(you should be glad to not have heard my cursing at qemu cmdline when
trying to reproduce some of Tim's results -- lets just say that I can
deal with gpg)

I'm sure he tried some oversubscribed scenarios without pinning. But
even there, when all the vCPU threads are runnable, they don't schedule
that much. Sure we take the preemption tick and thus schedule 100-1000
times a second, but that's managable.

We spend quite some time tracing workloads and fixing funny behaviour --
none of that has been done for these patches yet.

The moment KVM needed user space assist for things (and thus VMEXITs
happened) things came apart real quick.


Anyway, Tim, can you tell these fine folks what you did and for what
scenarios the last incarnation did show promise?
