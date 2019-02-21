Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C98DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE64D20818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfBUVf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:35:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50981 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBUVfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:35:55 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gww0R-0004wr-4M; Thu, 21 Feb 2019 22:35:47 +0100
Date:   Thu, 21 Feb 2019 22:35:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Julien Thierry <julien.thierry@arm.com>
cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
In-Reply-To: <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
Message-ID: <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net> <20190213154532.GQ32534@hirez.programming.kicks-ass.net> <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net> <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net> <20190214101429.GD32494@hirez.programming.kicks-ass.net> <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com> <20190216103044.GR32494@hirez.programming.kicks-ass.net> <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net> <20190219124808.GG8501@fuggles.cambridge.arm.com> <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com> <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
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

On Thu, 21 Feb 2019, Julien Thierry wrote:
> On 20/02/2019 22:55, H. Peter Anvin wrote:
> > Now, __fentry__ is kind of a special beast; in some ways it is an "exception
> > implemented as a function call"; on x86 one could even consider using an INT
> > instruction in order to reduce the NOP footprint in the unarmed case.  Nor is
> > __fentry__ a C function; it has far more of an exception-like ABI.
> > *Regardless* of what else we do, I believe __fentry__ ought to
> > save/disable/restore AC, just like an exception does.
> > 
> 
> That does make sense to me. However it doesn't solve the issue of
> calling (or preventing to call) some function that rescheds.

IMNSHO any call inside a AC region is a bug lurking round the corner. The
only thing which is tolerable is an exception of some sort.

Enforce that with objtool. End of story.

Thanks,

	tglx


