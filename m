Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC339C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796452083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F085Zxfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfBUOD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:03:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUODz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=klWCvpVJzf+2E7HDyey71HmxgC6eXbbYI0ZCLdRtHHg=; b=F085ZxfoD4bc9TdK1gosCaWhsE
        L//6+mexjf2KMTl7epUL6PV0+Lb/cOEIYEiSeC7/rFaNJPfF/Fk4KBcGSRi6ko9/uKQanfdFfodZM
        WkzRRnxs5FV0uhfhJ9KpeEbI+7BGVPiqyI2Awp7KmB/2MEnkIRGLWQfAH0542VgCUbwO/PYAnISvl
        5LhoucCsCjwPCt2eVvUkvohKoU4774L1sk5GRDDAJak9/SNYCf1yvL2r0bZ2w2EL2r0F4LSebQLlp
        w7Yy+Ex+GHnYT5s7A0DP7CnpYHblKGWIOOXRU6OrD3R+rcypltwNdiog1CztVID4LtKfrOiTAHmDz
        KNGp3qpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwox5-0005AC-90; Thu, 21 Feb 2019 14:03:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E712922BBEAF4; Thu, 21 Feb 2019 15:03:48 +0100 (CET)
Date:   Thu, 21 Feb 2019 15:03:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
Message-ID: <20190221140348.GR32494@hirez.programming.kicks-ass.net>
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <e73e1b19-5418-32c8-584c-823618de67ce@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e73e1b19-5418-32c8-584c-823618de67ce@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 06:53:08PM -0800, Subhra Mazumdar wrote:
> 
> On 2/18/19 9:49 AM, Linus Torvalds wrote:
> > On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > However; whichever way around you turn this cookie; it is expensive and nasty.
> > Do you (or anybody else) have numbers for real loads?
> > 
> > Because performance is all that matters. If performance is bad, then
> > it's pointless, since just turning off SMT is the answer.
> > 
> >                    Linus
> I tested 2 Oracle DB instances running OLTP on a 2 socket 44 cores system.
> This is on baremetal, no virtualization.  

I'm thinking oracle schedules quite a bit, right? Then you get massive
overhead (as shown).

The thing with virt workloads is that if they don't VMEXIT lots, they
also don't schedule lots (the vCPU stays running, nested scheduler
etc..).

Also; like I wrote, it is quite possible there is some sibling rivalry
here, which can cause excessive rescheduling. Someone would have to
trace a workload and check.

My older patches had a condition that would not preempt a task for a
little while, such that it might make _some_ progress, these patches
don't have that (yet).

