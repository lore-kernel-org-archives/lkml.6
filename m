Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B26C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA16218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uZ1ayEKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfB0QsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:48:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35842 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0QsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KlgGlH0vyJgIWJ5ptP0cVzN5hIiwpYj1Ku9/HbY2Nts=; b=uZ1ayEKOCfMdXEM03pA87JVZK
        5FeHljmYLx4gYsqGFI2W/YhEw/GQxieBdduapBhVe1LSPFtlC6ILXZ0lYEh0Pc/u8MWd9Bjzspv2R
        zynhbnmdxkRTPY5dXuirOTEUm6pzvrMGGrT4e/ADi7F7rdy6fBzBsGsFSiYX3YdbNH4XiLR+PztW3
        EwosPmgRPQEvYgsOkbbD1MrPsJLlgWjOXzQtCcm2mjSZ5OhyuQreIhH1j+2GUt8KqTwIHJ2LeXxpI
        ub6apoUIOf4eJrEDgHlwR7427o3dGeuBDllxFLRAjbJDfafAiEpO/t/+gNh8JHUZzEtlKHt7YbGkv
        CN2A5m8zA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gz2NM-0005DP-MC; Wed, 27 Feb 2019 16:48:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60971202CAE24; Wed, 27 Feb 2019 17:48:06 +0100 (CET)
Date:   Wed, 27 Feb 2019 17:48:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and
 __this_cpu_{}()
Message-ID: <20190227164806.GS32494@hirez.programming.kicks-ass.net>
References: <20190227101252.413192716@infradead.org>
 <20190227101544.210748832@infradead.org>
 <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:14:09AM -0800, Linus Torvalds wrote:
> On Wed, Feb 27, 2019 at 2:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Nadav Amit reported that commit:
> >
> >   b59167ac7baf ("x86/percpu: Fix this_cpu_read()")
> >
> > added a bunch of constraints to all sorts of code; and while some of
> > that was correct and desired, some of that seems superfluous.
> 
> Hmm.
> 
> I have the strong feeling that we should instead relax this_cpu_read()
> again a bit.
> 
> In particular, making it "asm volatile" really is a big hammer
> approach. It's worth noting that the *other* this_cpu_xyz ops don't
> even do that.

Right, this patch 'fixes' that :-)

> I would suggest that instead of making "this_cpu_read()" be asm
> volatile, we mark it as potentially changing the memory location it is
> touching - the same way the modify/write ops do.
> 
> That still means that the read will be forced (like READ_ONCE()), but
> allows gcc a bit more flexibility in instruction scheduling, I think.

Ah, fair enough, I'll spin a version of this patch with "+m" for
this_cpu and "m" for raw_cpu.

> That said, I didn't actually check how it affects code generation.
> Nadav, would you check the code sequences you originally noticed?

Much of it was the ONCE behaviour defeating CSE I think, but yes, it
would be good to have another look.
