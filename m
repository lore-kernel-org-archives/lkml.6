Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7822CC64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483F02064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483F02064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJHRY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:24:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:38326 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeJHRY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:24:27 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w987r6FO003565;
        Mon, 8 Oct 2018 02:53:06 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w987r101003504;
        Mon, 8 Oct 2018 02:53:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 8 Oct 2018 02:53:00 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org,
        Richard Biener <rguenther@suse.de>,
        Michael Matz <matz@suse.de>, Nadav Amit <namit@vmware.com>,
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
Message-ID: <20181008075300.GN29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <20181007141349.GD30687@zn.tnic> <20181007151427.GK29268@gate.crashing.org> <20181008055838.GA66819@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008055838.GA66819@gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 07:58:38AM +0200, Ingo Molnar wrote:
> * Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > > > More precise *size* estimates, yes.  And if the user lies he should not
> > > > be surprised to get assembler errors, etc.
> > > 
> > > Yes.
> > > 
> > > Another option would be if gcc parses the inline asm directly and
> > > does a more precise size estimation. Which is a lot more involved and
> > > complicated solution so I guess we wanna look at the simpler ones first.
> > > 
> > > :-)
> > 
> > Which is *impossible* to do.  Inline assembler is free-form text.
> 
> "Impossible" is false: only under GCC's model and semantics of inline
> asm that is, and only under the (false) assumption that the semantics
> of the asm statement (which is a GCC extension to begin with) cannot
> be changed like it has been changed multiple times in the past.
> 
> "Difficult", "not worth our while", perhaps.

If we throw out our current definition of inline assembler, and of the
internal backend interfaces, then sure you can do it.  This of course
invalidates all code that uses GCC inline assembler, and all GCC backends
(both in-tree and out-of-tree, both current and historical).

If other compilers think everyone should rewrite all of their code because
those compiler do inline asm wro^H^H^Hdifferently, that is their problem;
GCC should not deny all history and screw over all its users.


Segher
