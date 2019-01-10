Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA394C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2D8208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfAJU5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:57:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730777AbfAJU5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:57:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CC4DA0918;
        Thu, 10 Jan 2019 20:57:44 +0000 (UTC)
Received: from treble (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B4D85D9C6;
        Thu, 10 Jan 2019 20:57:38 +0000 (UTC)
Date:   Thu, 10 Jan 2019 14:57:36 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Message-ID: <20190110205736.pv3bt5chkgpep4kq@treble>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <A42784EF-3215-4ED9-8D35-1A2C38A0711F@vmware.com>
 <20190110164401.g747vifrppbhbo3o@treble>
 <D8481FBB-4873-43B2-9187-C0896E859191@vmware.com>
 <20190110181807.irh2b7fk6at43rdl@treble>
 <3F89FB6B-DA8B-4C71-B825-2B7EB86F274E@vmware.com>
 <20190110203207.3k43gt4kcvry7us7@treble>
 <F773CB3F-992B-4BC9-9376-72300BBA550B@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F773CB3F-992B-4BC9-9376-72300BBA550B@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 10 Jan 2019 20:57:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 08:48:31PM +0000, Nadav Amit wrote:
> > On Jan 10, 2019, at 12:32 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > On Thu, Jan 10, 2019 at 07:45:26PM +0000, Nadav Amit wrote:
> >>>> I’m not GCC expert either and writing this code was not making me full of
> >>>> joy, etc.. I’ll be happy that my code would be reviewed, but it does work. I
> >>>> don’t think an early pass is needed, as long as hardware registers were not
> >>>> allocated.
> >>>> 
> >>>>> Would it work with more than 5 arguments, where args get passed on the
> >>>>> stack?
> >>>> 
> >>>> It does.
> >>>> 
> >>>>> At the very least, it would (at least partially) defeat the point of the
> >>>>> callee-saved paravirt ops.
> >>>> 
> >>>> Actually, I think you can even deal with callee-saved functions and remove
> >>>> all the (terrible) macros. You would need to tell the extension not to
> >>>> clobber the registers through a new attribute.
> >>> 
> >>> Ok, it does sound interesting then.  I assume you'll be sharing the
> >>> code?
> >> 
> >> Of course. If this what is going to convince, I’ll make a small version for
> >> PV callee-saved first.
> > 
> > It wasn't *only* the PV callee-saved part which interested me, so if you
> > already have something which implements the other parts, I'd still like
> > to see it.
> 
> Did you have a look at https://lore.kernel.org/lkml/20181231072112.21051-4-namit@vmware.com/ ?
> 
> See the changes to x86_call_markup_plugin.c .
> 
> The missing part (that I just finished but need to cleanup) is attributes
> that allow you to provide key and dynamically enable the patching.

Aha, so it's the basically the same plugin you had for optpolines.  I
missed that.  I'll need to stare at the code for a little bit.

> >>>>> What if we just used a plugin in a simpler fashion -- to do call site
> >>>>> alignment, if necessary, to ensure the instruction doesn't cross
> >>>>> cacheline boundaries.  This could be done in a later pass, with no side
> >>>>> effects other than code layout.  And it would allow us to avoid
> >>>>> breakpoints altogether -- again, assuming somebody can verify that
> >>>>> intra-cacheline call destination writes are atomic with respect to
> >>>>> instruction decoder reads.
> >>>> 
> >>>> The plugin should not be able to do so. Layout of the bytecode is done by
> >>>> the assembler, so I don’t think a plugin would help you with this one.
> >>> 
> >>> Actually I think we could use .bundle_align_mode for this purpose:
> >>> 
> >>> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsourceware.org%2Fbinutils%2Fdocs-2.31%2Fas%2FBundle-directives.html&amp;data=02%7C01%7Cnamit%40vmware.com%7Cbc4dcc541474462da00b08d6773ab61f%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636827491388051263&amp;sdata=HZNPN4UygwQCqsX8dOajaNeDZyy1O0O4cYeSwu%2BIdO0%3D&amp;reserved=0
> >> 
> >> Hm… I don’t understand what you have in mind (i.e., when would this
> >> assembly directives would be emitted).
> > 
> > For example, it could replace
> > 
> >  callq ____static_call_tramp_my_key
> > 
> > with
> > 
> >  .bundle_align_mode 6
> >  callq ____static_call_tramp_my_key
> >  .bundle_align_mode 0
> > 
> > which ensures the instruction is within a cache line, aligning it with
> > NOPs if necessary.  That would allow my current implementation to
> > upgrade out-of-line calls to inline calls 100% of the time, instead of
> > 95% of the time.
> 
> Heh. I almost wrote based no the feature description that this will add
> unnecessary padding no matter what, but actually (experimentally) it works
> well…

Yeah, based on the poorly worded docs, I made the same assumption, until
I tried it.

-- 
Josh
