Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B294C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0D52173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NgsAe6kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfBZSd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:33:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfBZSd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yMjr9P9q7f4UeMLgQtoS/kYz9gHPzsPW36yOTRN+6zs=; b=NgsAe6kjMFgvzv8B7lIgBbeib
        51KkbiWjh24fY41XtyeSI4GggO8dJPb8oXh+LmLfZWMV/I8Rdawikou3209ihcL/KSaBGo+y9c3+9
        dTXKN1YpPpoYQ7AGhCX5VR11JX4UpASsp/lkjVkTmL/5os59Aq3+Z3FewZV0nLA5vQztacD5Karah
        GI/NroIH5Ype+qylijX7sealpi9ef4LEjRPddI2mBeNaDt2mKeVxrxgXYgB8KS4h10e39I3m0y+bh
        +WuNTI9J6jFmSi2RN9IjC9wfHj1s1TAndM5S8xEMSDbU1zlxLZ7TErJZLFXqUtPR1MSHoKXhWXRGA
        qhwNqYr8w==;
Received: from [188.207.104.89] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyhXq-0005Jw-CF; Tue, 26 Feb 2019 18:33:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7490E984351; Tue, 26 Feb 2019 19:33:35 +0100 (CET)
Date:   Tue, 26 Feb 2019 19:33:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20190226183335.GN2861@worktop.programming.kicks-ass.net>
References: <20190222185026.10973-1-will.deacon@arm.com>
 <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
 <20190226182624.GC28709@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226182624.GC28709@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 06:26:24PM +0000, Will Deacon wrote:
> On Fri, Feb 22, 2019 at 01:49:32PM -0800, Linus Torvalds wrote:
> So I *am* using __this_cpu_xchg() here, which means the architecture can
> get away with plain old loads and stores (which is what RISC-V does, for
> example), but I see that's not the case on e.g. x86 so I'll rework using
> read() and write() because it doesn't hurt.

Right, so the problem on x86 is that XCHG has an implicit LOCK prefix,
so there no !atomic variant. So even the cpu-local xchg gets the LOCK
prefix penalty, even though all we really wanted is a single
instruction.

Arguably we could fix that for __this_cpu_xchg(), which isn't IRQ-safe.
