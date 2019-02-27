Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33192C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE89A20851
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OxA0yLiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfB0KUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:20:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33320 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0KUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rvWd1d0AjTtKx1vBqqLfHDryl9uAVMLPTX2hTc9V3ls=; b=OxA0yLiIofuC3lqePQsRveUd7
        +OCTBDw5V/ws7SOJ+9M163vag5gd0+ozATlqhY9/8K6UDzJ6ljJ62p48ZaPxASqTGIM5w5wPk7KjY
        EhoCSiEqCANBdJP6jUi2XbrLbcnxmy5zm5jKTCyXgXUCz4YEYVrmRlAHH9dBrp9BzoAohIw+Jn5Ho
        ZQV2q/SY/Ts+ne2Wj+A1N6/veqaqb5jKoyB2Ji7t7+Fas8O+NFzAyTdlwZt/AmKMN8SJHckuW7zoy
        1WSno6IR2jGceCY2ZnqZmCagCDa6Ieuap/ghNiAhise45aaLUvUiGa7PNKv6/2P2NEzv93F4POYG7
        BYiGdHFfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gywJC-0007rc-JL; Wed, 27 Feb 2019 10:19:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60A172852476F; Wed, 27 Feb 2019 11:19:25 +0100 (CET)
Date:   Wed, 27 Feb 2019 11:19:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20190227101925.GK32494@hirez.programming.kicks-ass.net>
References: <20190222185026.10973-1-will.deacon@arm.com>
 <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
 <20190226182624.GC28709@fuggles.cambridge.arm.com>
 <20190226183335.GN2861@worktop.programming.kicks-ass.net>
 <CAHk-=wjx89RpPw6EV4fwSDAPbQcs=-2a4oM9N94saa9hemNbmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjx89RpPw6EV4fwSDAPbQcs=-2a4oM9N94saa9hemNbmw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:02:50AM -0800, Linus Torvalds wrote:
> On Tue, Feb 26, 2019 at 10:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Arguably we could fix that for __this_cpu_xchg(), which isn't IRQ-safe.
> 
> Yeah, I guess x86 _should_ really do __this_cpu_xchg() as just a
> read-write pair.

See the patches I just send.

> In general, a read-write pair is probably always the right thing to
> do, and the only reason we can't just do it in an
> architecture-independent way is that we'd want to avoid doing the
> address generation twice (for architectures where that is an issue).

The generic code has this right, see
include/asm-generic/percpu.h:raw_cpu_generic_xchg().

That is used in the majority of the architectures. With the patch I just
send, x86 will use two gs prefixed movs.
