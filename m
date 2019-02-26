Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7867217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfBZSZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:25:46 -0500
Received: from foss.arm.com ([217.140.101.70]:51886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbfBZSZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:25:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A122C80D;
        Tue, 26 Feb 2019 10:25:44 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85F943F738;
        Tue, 26 Feb 2019 10:25:41 -0800 (PST)
Date:   Tue, 26 Feb 2019 18:25:39 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
Message-ID: <20190226182539.GB28709@fuggles.cambridge.arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
 <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
 <CAHk-=whK=Pb9QZhYkqFGUjK1Sas620qjO1Y_EzSBiHSXxJfTYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whK=Pb9QZhYkqFGUjK1Sas620qjO1Y_EzSBiHSXxJfTYQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 01:55:20PM -0800, Linus Torvalds wrote:
> On Fri, Feb 22, 2019 at 1:49 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The case we want to go fast is the spin-lock and unlock case, not the
> > "set pending" case.
> >
> > And the way you implemented this, it's exactly the wrong way around.
> 
> Oh, one more comment: couldn't we make that mmiowb flag be right next
> to the preemption count?
> 
> Because that's the common case anyway, where a spinlock increments the
> preemption count too. If we put the mmiowb state in the same
> cacheline, we don't cause extra cache effects, which is what really
> matters, I guess.
> 
> I realize this is somewhat inconvenient, because some architectures
> put preempt count in the thread structure, and others do it as a
> percpu variable. But maybe the architecture could just declare where
> the mmiowb state is?

I think that should be doable... I'll have a play.

Will
