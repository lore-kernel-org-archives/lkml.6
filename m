Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53872C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17033223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17033223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeKMIrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:47:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeKMIrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:47:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D3EF4E90D;
        Mon, 12 Nov 2018 22:52:09 +0000 (UTC)
Received: from treble (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F258119743;
        Mon, 12 Nov 2018 22:52:06 +0000 (UTC)
Date:   Mon, 12 Nov 2018 16:52:04 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH RFC 0/3] Static calls
Message-ID: <20181112225204.45q6qw3ezcb3s3r5@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <20181109072811.GB86700@gmail.com>
 <20181109144501.aqhcv3vdjuqlp7pz@treble>
 <20181112050241.GB28219@gmail.com>
 <20181112053055.hdcv5x7md47ehunv@treble>
 <CAKv+Gu8etgVmqPq+fNRBkb55ePrtY=5kxFu5+O4Wsqk=CWzG8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8etgVmqPq+fNRBkb55ePrtY=5kxFu5+O4Wsqk=CWzG8w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 12 Nov 2018 22:52:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 10:39:52AM +0100, Ard Biesheuvel wrote:
> On Mon, 12 Nov 2018 at 06:31, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Mon, Nov 12, 2018 at 06:02:41AM +0100, Ingo Molnar wrote:
> > >
> > > * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > > On Fri, Nov 09, 2018 at 08:28:11AM +0100, Ingo Molnar wrote:
> > > > > > - I'm not sure about the objtool approach.  Objtool is (currently)
> > > > > >   x86-64 only, which means we have to use the "unoptimized" version
> > > > > >   everywhere else.  I may experiment with a GCC plugin instead.
> > > > >
> > > > > I'd prefer the objtool approach. It's a pretty reliable first-principles
> > > > > approach while GCC plugin would have to be replicated for Clang and any
> > > > > other compilers, etc.
> > > >
> > > > The benefit of a plugin is that we'd only need two of them: GCC and
> > > > Clang.  And presumably, they'd share a lot of code.
> > > >
> 
> Having looked into this, I don't think they will share any code at
> all, to be honest. Perhaps some macros and string templates, that's
> all.

Oh well.  That should still be easier to maintain than objtool across
all arches at this point.

> > > > The prospect of porting objtool to all architectures is going to be much
> > > > more of a daunting task (though we are at least already considering it
> > > > for some arches).
> > >
> > > Which architectures would benefit from ORC support the most?
> >
> > According to my (limited and potentially flawed) knowledge, I think
> > arm64 would benefit the most performance-wise, whereas powerpc and s390
> > gains would be quite a bit less.
> >
> 
> What would arm64 gain from ORC and/or objtool?

Other than live patching, the biggest benefit would be an
across-the-board performance improvement from disabling frame pointers.
It would be interesting to see some arm64 performance numbers there, for
a kernel compiled with -fomit-frame-pointer.

For more details (and benefits of) ORC see
Documentation/x86/orc-unwinder.txt.

Objtool has also come in handy for other cases, like ensuring retpolines
are used everywhere.

Over time, I would like to move some objtool functionality to compiler
plugins, such that it would be easier to port it to other arches.

> > We may have to port objtool to arm64 anyway, for live patching.
> 
> Is this about the reliable stack traces, i.e., the ability to detect
> non-leaf functions that don't create stack frames? I think we should
> be able to manage this without objtool on arm64 tbh.

Hm?  How else would you ensure all functions honor CONFIG_FRAME_POINTER,
and continue to do so indefinitely?

> >  But
> > that will be a lot more work than it took for Ard to write a GCC plugin.
> >
> > > I really think that hard reliance on GCC plugins is foolish
> >
> > Funny, I feel the same way about hard reliance on objtool :-)
> >
> 
> I tend to agree here. I think objtool is a necessary evil (as are
> compiler plugins, for that matter) which I hope does not spread to
> other architectures.

I agree that it's a necessary evil, but it may be necessary on arm64 for
live patching.

> But the main difference is that the GCC plugin is only ~50 lines (for
> this particular use case, and minus another 50 lines of boilerplate),
> whereas objtool (AIUI) duplicates lots and lots of functionality of
> the compiler, assembler and/or linker, to mangle relocations, create
> new sections etc etc. Porting this to other architectures is going to
> be a major maintenance effort, especially when I think of, e.g.,
> 32-bit ARM with its Thumb2 quirks and other idiosyncrasies that are
> currently hidden in the toolchain. Other architectures should be first
> class citizens if objtool gains support for them, which means that the
> x86 people that own it currently are on the hook for testing their
> changes against architectures they are not familiar with.

Sounds like we could use you as a co-maintainer then :-)

BTW, AFAIK, there are no plans to support live patching for 32-bit ARM.

-- 
Josh
