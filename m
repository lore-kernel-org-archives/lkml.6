Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FFFC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE232098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE232098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJCRbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:31:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33432 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeJCRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:31:52 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7edK-000274-2j; Wed, 03 Oct 2018 12:43:58 +0200
Date:   Wed, 3 Oct 2018 12:43:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Catalin Marinas <catalin.marinas@arm.com>, bigeasy@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        daniel.wagner@siemens.com, Will Deacon <will.deacon@arm.com>,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, boqun.feng@gmail.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [Problem] Cache line starvation
In-Reply-To: <20181003082842.GN26858@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1810031242320.1435@nanos.tec.linutronix.de>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de> <20180921122058.GB24124@hirez.programming.kicks-ass.net> <CAHkRjk4Vvv5rc+habecu2xPiFGZ37onRzy1kCnFcBH2115U8jQ@mail.gmail.com> <alpine.DEB.2.21.1810031005210.1435@nanos.tec.linutronix.de>
 <20181003082842.GN26858@hirez.programming.kicks-ass.net>
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

On Wed, 3 Oct 2018, Peter Zijlstra wrote:
> On Wed, Oct 03, 2018 at 10:07:05AM +0200, Thomas Gleixner wrote:
> > On Wed, 3 Oct 2018, Catalin Marinas wrote:
> > 
> > > On Fri, 21 Sep 2018 at 13:22, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > We reproducibly observe cache line starvation on a Core2Duo E6850 (2
> > > > > cores), a i5-6400 SKL (4 cores) and on a NXP LS2044A ARM Cortex-A72 (4
> > > > > cores).
> 
> > Except that the ARM64 ticket locks are not preventing the starvation
> > issue. Neither do the qrlocks on ARM64 on later kernels.
> 
> That A72 is ARMv8-A afaict, that doesn't have the fancy LSE bits (which
> are new in ARMv8.1) on and thus ends up using LL/SC. And LL/SC has
> similar issues as cmpxchg loops.
> 
> AFAICT Cortex-A75 is the first that has LSE on (that's an ARMv8.2-A).

I know. That doesn't help though. We need a solution for the v8-A and the
magic delay loop we have right now to work around it is more that
disturbing.

Thanks,

	tglx
