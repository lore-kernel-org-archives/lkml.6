Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EC320844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EC320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeIHAgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:36:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36971 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIHAgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:36:46 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyMpX-0000zh-UA; Fri, 07 Sep 2018 21:54:12 +0200
Date:   Fri, 7 Sep 2018 21:54:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 3/3] x86/pti/64: Remove the SYSCALL64 entry
 trampoline
In-Reply-To: <CALCETrUZm3KsonYVd5sn=LhoGZ2ciO7xT_Fz=jD_HZ04tB9o=Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809072145460.1402@nanos.tec.linutronix.de>
References: <cover.1536015544.git.luto@kernel.org> <8c7c6e483612c3e4e10ca89495dc160b1aa66878.1536015544.git.luto@kernel.org> <20180904070455.GX24124@hirez.programming.kicks-ass.net> <CALCETrUZm3KsonYVd5sn=LhoGZ2ciO7xT_Fz=jD_HZ04tB9o=Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Andy Lutomirski wrote:
> On Tue, Sep 4, 2018 at 12:04 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > Can we have a few words on why this solution and not this alternative? I
> > mean, you raise the possibility, but then surely you chose not to
> > implement that. Might as well share that with us.
> 
> I can give some pros and cons.  With the other approach:
> 
>  - We avoid a pipeline stall.

Which is good.

>  - We execute from an extra page and read from another extra page
> during the syscall.  (The latter is because we need to use a relative
> addressing mode to find sp1 -- it's the same *cacheline* we'd use
> anyway, but we're accessing it using an alias, so it's an extra TLB
> entry.)

Ok, but is this really an issue with PTI?

>  - We use more memory.  This would be one page per CPU for a simple
> implementation and 64-ish bytes per CPU or one page per node for a
> more complex implementation.

That's the least interesting argument really.

>  - More code complexity.

Ok, but how much complex code is that?

> I'm not convinced this is a good tradeoff.

Well, the real question here is whether this has any advantage vs. the
percpu area exposure?

Thanks,

	tglx



