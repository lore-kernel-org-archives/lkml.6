Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9299FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62146223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62146223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbeKLUyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:54:13 -0500
Received: from verein.lst.de ([213.95.11.211]:49788 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbeKLUyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:54:13 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 931DE67358; Mon, 12 Nov 2018 12:01:27 +0100 (CET)
Date:   Mon, 12 Nov 2018 12:01:27 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v4 2/3] arm64: implement live patching
Message-ID: <20181112110127.GA30967@lst.de>
References: <20181026142008.D922868C94@newverein.lst.de> <20181026142152.5F0D868C95@newverein.lst.de> <CAKv+Gu_D2vzk-sBkufK7JvaPawC+QnpZwkC0+ikTb7A6qko8ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_D2vzk-sBkufK7JvaPawC+QnpZwkC0+ikTb7A6qko8ng@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:42:35PM +0100, Ard Biesheuvel wrote:
> On 26 October 2018 at 16:21, Torsten Duwe <duwe@lst.de> wrote:
> >         /* The program counter just after the ftrace call site */
> >         str     lr, [x9, #S_PC]
> > +
> >         /* The stack pointer as it was on ftrace_caller entry... */
> >         add     x28, fp, #16
> >         str     x28, [x9, #S_SP]
> 
> Please drop this hunk

Sure. I missed that one during cleanup.

> > @@ -233,6 +234,10 @@ ftrace_common:
                         ^^^^^^^^^^^^^^
> >         ldr     x28, [fp, 8]
> >         str     x28, [x9, #S_LR]        /* to pt_regs.r[30] */
> >
> > +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
> > +       mov     x28, lr         /* remember old return address */
> > +#endif
> > +
> >         ldr_l   x2, function_trace_op, x0
> >         ldr     x1, [fp, #8]
> >         sub     x0, lr, #8      /* function entry == IP */
> > @@ -245,6 +250,17 @@ ftrace_call:
> >
> >         bl      ftrace_stub
> >
> > +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
> > +       /* Is the trace function a live patcher an has messed with
> > +        * the return address?
> > +        */
> > +       add     x9, sp, #16     /* advance to pt_regs for restore */
> > +       ldr     x0, [x9, #S_PC]
> > +       cmp     x0, x28         /* compare with the value we remembered */
> > +       /* to not call graph tracer's "call" mechanism twice! */
> > +       b.ne    ftrace_common_return
> 
> Is ftrace_common_return guaranteed to be in range? Conditional
> branches have only -/+ 1 MB range IIRC.

It's the same function. A "1f" would do the same job, but the long label
is a talking identifier that saves a comment. I'd more be worried about
the return from the graph trace caller, which happens to be the _next_
function ;-)

If ftrace_caller or graph_caller grow larger than a meg, something else is
_very_ wrong.

> > +#endif
> > +
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> 
> Can we fold these #ifdef blocks together (i.e, incorporate the
> conditional livepatch sequence here)

I'll see how to make it fit. But remember some people might want ftrace
but no live patching capability.

Thanks for the review!

	Torsten
