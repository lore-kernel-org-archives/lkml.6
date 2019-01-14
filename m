Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E4220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N19jlG00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfANM3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:29:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46552 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfANM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9V0ZAsoeAYTSduRcGFY8SyfLNtfuURvuYsRLM+EYUN8=; b=N19jlG00TXkngzNw+GR/iVXnC
        eW7RWfBSXCoTKZb3Xju6t0rsMBQH88ratImZnBXZQSDenuFVObEQtSxEyMwOLMToNeAcmg8e2PInN
        bSh72i2eNe3wZt5Ifk6wgevV1TBBBH1LJD30cmO/gK7fs2elwCnq7ejNt68FIoRehlUe7NN9FYdo6
        EjGYZTAFEPd3yl2xHpmYDVxESAz7t02a6cM1VdLCWOEUykGTPSCqR/3axnmAXu99zeAB8O6MR5uVP
        btZ8Pt1OLnumMFx8Q9AtLZF+Zl1bjkmmIREk8WcP2cPrvvGdFKzcJGWO9K6zs0S2c2cuGdvgeB2Ja
        dgkvVHJsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj1MS-0004mA-Hm; Mon, 14 Jan 2019 12:29:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73488200B8C82; Mon, 14 Jan 2019 13:28:56 +0100 (CET)
Date:   Mon, 14 Jan 2019 13:28:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Message-ID: <20190114122856.GA20726@hirez.programming.kicks-ass.net>
References: <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble>
 <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
 <20190111203135.5clurevf34bkiy3o@treble>
 <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
 <CALCETrXZdzNS=Bbv=qyM8iBC82QWOQqcfN1GFfcn6UHvePatHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXZdzNS=Bbv=qyM8iBC82QWOQqcfN1GFfcn6UHvePatHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:05:20PM -0800, Andy Lutomirski wrote:
> On Fri, Jan 11, 2019 at 12:54 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, Jan 11, 2019 at 12:31 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > I was referring to the fact that a single static call key update will
> > > usually result in patching multiple call sites.  But you're right, it's
> > > only 1-2 trampolines per text_poke_bp() invocation.  Though eventually
> > > we may want to batch all the writes like what Daniel has proposed for
> > > jump labels, to reduce IPIs.
> >
> > Yeah, my suggestion doesn't allow for batching, since it would
> > basically generate one trampoline for every rewritten instruction.
> 
> Sure it does.  Just make 1000 trampolines and patch 1000 sites in a
> batch :)  As long as the number of trampolines is smallish (e.g. fits
> in a page), then we should be in good shape.

Much easier still would be to make the ARCH_DEFINE_STATIC_TRAMP thing
generate the two trampolines per callsite and simply keep them around.

Another advantage is that you then only have to patch the JMP target,
since the return address will always stay the same (since these things
are generated per call-site).


Anyway... the STI-shadow thing is very clever. But I'm with Josh in that
I think I prefer the IRET frame offset thing -- but yes, I've read
Linus' argument against that.
