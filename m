Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E32C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBB920675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfAJSSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:18:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729791AbfAJSSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:18:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E808445DE;
        Thu, 10 Jan 2019 18:18:15 +0000 (UTC)
Received: from treble (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F848601A9;
        Thu, 10 Jan 2019 18:18:09 +0000 (UTC)
Date:   Thu, 10 Jan 2019 12:18:07 -0600
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
Message-ID: <20190110181807.irh2b7fk6at43rdl@treble>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <A42784EF-3215-4ED9-8D35-1A2C38A0711F@vmware.com>
 <20190110164401.g747vifrppbhbo3o@treble>
 <D8481FBB-4873-43B2-9187-C0896E859191@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8481FBB-4873-43B2-9187-C0896E859191@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 10 Jan 2019 18:18:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:32:08PM +0000, Nadav Amit wrote:
> > On Jan 10, 2019, at 8:44 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > On Thu, Jan 10, 2019 at 01:21:00AM +0000, Nadav Amit wrote:
> >>> On Jan 9, 2019, at 2:59 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >>> 
> >>> With this version, I stopped trying to use text_poke_bp(), and instead
> >>> went with a different approach: if the call site destination doesn't
> >>> cross a cacheline boundary, just do an atomic write.  Otherwise, keep
> >>> using the trampoline indefinitely.
> >>> 
> >>> NOTE: At least experimentally, the call destination writes seem to be
> >>> atomic with respect to instruction fetching.  On Nehalem I can easily
> >>> trigger crashes when writing a call destination across cachelines while
> >>> reading the instruction on other CPU; but I get no such crashes when
> >>> respecting cacheline boundaries.
> >>> 
> >>> BUT, the SDM doesn't document this approach, so it would be great if any
> >>> CPU people can confirm that it's safe!
> >> 
> >> I (still) think that having a compiler plugin can make things much cleaner
> >> (as done in [1]). The callers would not need to be changed, and the key can
> >> be provided through an attribute.
> >> 
> >> Using a plugin should also allow to use Steven’s proposal for doing
> >> text_poke() safely: by changing 'func()' into 'asm (“call func”)', as done
> >> by the plugin, you can be guaranteed that registers are clobbered. Then, you
> >> can store in the assembly block the return address in one of these
> >> registers.
> > 
> > I'm no GCC expert (why do I find myself saying this a lot lately?), but
> > this sounds to me like it could be tricky to get right.
> > 
> > I suppose you'd have to do it in an early pass, to allow GCC to clobber
> > the registers in a later pass.  So it would necessarily have side
> > effects, but I don't know what the risks are.
> 
> I’m not GCC expert either and writing this code was not making me full of
> joy, etc.. I’ll be happy that my code would be reviewed, but it does work. I
> don’t think an early pass is needed, as long as hardware registers were not
> allocated.
> 
> > Would it work with more than 5 arguments, where args get passed on the
> > stack?
> 
> It does.
> 
> > 
> > At the very least, it would (at least partially) defeat the point of the
> > callee-saved paravirt ops.
> 
> Actually, I think you can even deal with callee-saved functions and remove
> all the (terrible) macros. You would need to tell the extension not to
> clobber the registers through a new attribute.

Ok, it does sound interesting then.  I assume you'll be sharing the
code?

> > What if we just used a plugin in a simpler fashion -- to do call site
> > alignment, if necessary, to ensure the instruction doesn't cross
> > cacheline boundaries.  This could be done in a later pass, with no side
> > effects other than code layout.  And it would allow us to avoid
> > breakpoints altogether -- again, assuming somebody can verify that
> > intra-cacheline call destination writes are atomic with respect to
> > instruction decoder reads.
> 
> The plugin should not be able to do so. Layout of the bytecode is done by
> the assembler, so I don’t think a plugin would help you with this one.

Actually I think we could use .bundle_align_mode for this purpose:

  https://sourceware.org/binutils/docs-2.31/as/Bundle-directives.html

-- 
Josh
