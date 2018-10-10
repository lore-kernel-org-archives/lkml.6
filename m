Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30741C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AA62064E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AA62064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJJPQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:16:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:34368 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbeJJPQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:16:23 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9A7s3Fq020517;
        Wed, 10 Oct 2018 02:54:04 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w9A7rsA7020412;
        Wed, 10 Oct 2018 02:53:54 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 10 Oct 2018 02:53:54 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Richard Biener <rguenther@suse.de>
Cc:     Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>,
        gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Message-ID: <20181010075353.GU29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr> <20181009145330.GT29268@gate.crashing.org> <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 09:12:48AM +0200, Richard Biener wrote:
> On Tue, 9 Oct 2018, Segher Boessenkool wrote:
> > On Mon, Oct 08, 2018 at 11:07:46AM +0200, Richard Biener wrote:
> > > On Mon, 8 Oct 2018, Segher Boessenkool wrote:
> > > > On Sun, Oct 07, 2018 at 03:53:26PM +0000, Michael Matz wrote:
> > > > > On Sun, 7 Oct 2018, Segher Boessenkool wrote:
> > > > > > On Sun, Oct 07, 2018 at 11:18:06AM +0200, Borislav Petkov wrote:
> > > > > > > Now, Richard suggested doing something like:
> > > > > > > 
> > > > > > >  1) inline asm ("...")
> > > > > > 
> > > > > > What would the semantics of this be?
> > > > > 
> > > > > The size of the inline asm wouldn't be counted towards the inliner size 
> > > > > limits (or be counted as "1").
> > > > 
> > > > That sounds like a good option.
> > > 
> > > Yes, I also like it for simplicity.  It also avoids the requirement
> > > of translating the number (in bytes?) given by the user to
> > > "number of GIMPLE instructions" as needed by the inliner.
> > 
> > This patch implements this, for C only so far.  And the syntax is
> > "asm inline", which is more in line with other syntax.
> > 
> > How does this look?
> 
> Looks good.  A few nits - you need to document this in extend.texi, the

Yup.

> tree flag use needs documenting in tree-core.h,

Ah yes.

> and we need a testcase
> (I'd suggest one that shows we inline a function with "large" asm inline 
> () even at -Os).

I have one.  Oh, and I probably should do a comment at the one line of
code that isn't just bookkeeping ;-)

> Oh, and I don't think we want C and C++ to diverge - so you need to
> cook up C++ support as well.

Right, that's why I said "C only so far".

> Can kernel folks give this a second and third thought please so we
> don't implement sth that in the end won't satisfy you guys?

Or actually try it out and see if it has the desired effect!  Nothing
beats field trials.

I'll do the C++ thing today hopefully, and send things to gcc-patches@.


Segher
