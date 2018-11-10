Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA340C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889682081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889682081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeKJPbS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:31:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbeKJPbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:31:18 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF732081C;
        Sat, 10 Nov 2018 05:10:25 +0000 (UTC)
Date:   Sat, 10 Nov 2018 00:10:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
Message-ID: <20181110001023.57f27312@vmware.local.home>
In-Reply-To: <20181109203459.wbftlkxcvfnwo2bm@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
        <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
        <20181109133337.63487e3a@gandalf.local.home>
        <20181109193505.5p5iddrtgpk2cpb4@treble>
        <20181109145746.0037da3f@gandalf.local.home>
        <20181109203459.wbftlkxcvfnwo2bm@treble>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 14:34:59 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

I'm slowly massaging this to work with tracepoints.

But I hit a snag on this patch.

> On Fri, Nov 09, 2018 at 02:57:46PM -0500, Steven Rostedt wrote:
> > On Fri, 9 Nov 2018 13:35:05 -0600
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> >   
> > > > > +#define DECLARE_STATIC_CALL(key, func)					\
> > > > > +	extern struct static_call_key key;				\
> > > > > +	extern typeof(func) STATIC_CALL_TRAMP(key);			\
> > > > > +	/* Preserve the ELF symbol so objtool can access it: */		\
> > > > > +	__ADDRESSABLE(key)    
> > > > 
> > > > Does the __ADDRESSABLE(key) need to be in the DECLARE part?
> > > > If so, there needs to be more explanation than just the comment above
> > > > it.    
> > > 
> > > For each call site, objtool creates a struct in .static_call_sites:
> > > 
> > > 	struct static_call_site {
> > > 		s32 addr;
> > > 		s32 key;
> > > 	};
> > > 
> > > In order to do that, it needs to create a relocation which references
> > > the key symbol.  If the key is defined in another .o file, then the
> > > current .o will not have an ELF symbol associated with the key.  The
> > > __ADDRESSABLE(key) thing tells GCC to leave the key symbol in the .o
> > > file, even though it's not referenced anywhere.  That makes objtool's
> > > job easier, so it doesn't have to edit the symbol table.
> > > 
> > > I could add a comment saying as much, though it's hard to explain it in
> > > fewer words than I just did :-)  
> > 
> > Does this have to do with adding the references by relative address?
> > 
> > In record_mcount, I just picked an existing symbol and referenced that..
> > But perhaps this is a cleaner way.  
> 
> I think recordmcount is different.  It creates references (in
> __mcount_loc) to functions which are already in the object file, so they
> already have symbols associated with them.
> 
> But in this case, when objtool is creating references, the symbol it
> needs to reference is outside the .o file, so there's no symbol to
> associate it with.
> 

The __ADDRESSABLE() appears to fail if you have a header with a
DECLARE_STATIC_CALL() that is included where the DEFINE_STATIC_CALL()
is, because I'm getting this:

In file included from <command-line>:
/work/git/linux-trace.git/include/linux/compiler.h:285:11: error: redefinition of ‘__addressable___tp_func_sys_enter40’
   __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
           ^~~~~~~~~~~~~~
/work/git/linux-trace.git/include/linux/compiler_types.h:53:23: note: in definition of macro ‘___PASTE’
 #define ___PASTE(a,b) a##b
                       ^
/work/git/linux-trace.git/include/linux/compiler.h:285:3: note: in expansion of macro ‘__PASTE’
   __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
   ^~~~~~~
/work/git/linux-trace.git/include/linux/static_call.h:112:2: note: in expansion of macro ‘__ADDRESSABLE’
  __ADDRESSABLE(key)
  ^~~~~~~~~~~~~
/work/git/linux-trace.git/include/linux/static_call.h:115:2: note: in expansion of macro ‘DECLARE_STATIC_CALL’
  DECLARE_STATIC_CALL(key, _func);    \
  ^~~~~~~~~~~~~~~~~~~
/work/git/linux-trace.git/include/linux/tracepoint.h:310:2: note: in expansion of macro ‘DEFINE_STATIC_CALL’
  DEFINE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name);
  ^~~~~~~~~~~~~~~~~~
/work/git/linux-trace.git/include/trace/define_trace.h:42:2: note: in expansion of macro ‘DEFINE_TRACE_FN’
  DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
  ^~~~~~~~~~~~~~~
/work/git/linux-trace.git/include/trace/events/syscalls.h:18:1: note: in expansion of macro ‘TRACE_EVENT_FN’
 TRACE_EVENT_FN(sys_enter,
 ^~~~~~~~~~~~~~
/work/git/linux-trace.git/include/linux/compiler.h:285:11: note: previous definition of ‘__addressable___tp_func_sys_enter40’ was here
   __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
           ^~~~~~~~~~~~~~
/work/git/linux-trace.git/include/linux/compiler_types.h:53:23: note: in definition of macro ‘___PASTE’
 #define ___PASTE(a,b) a##b
                       ^
/work/git/linux-trace.git/include/linux/compiler.h:285:3: note: in expansion of macro ‘__PASTE’
   __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
   ^~~~~~~
/work/git/linux-trace.git/include/linux/static_call.h:112:2: note: in expansion of macro ‘__ADDRESSABLE’
  __ADDRESSABLE(key)
  ^~~~~~~~~~~~~
/work/git/linux-trace.git/include/linux/tracepoint.h:234:2: note: in expansion of macro ‘DECLARE_STATIC_CALL’
  DECLARE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name); \
  ^~~~~~~~~~~~~~~~~~~
/work/git/linux-trace.git/include/linux/tracepoint.h:421:2: note: in expansion of macro ‘__DECLARE_TRACE’
  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
  ^~~~~~~~~~~~~~~
/work/git/linux-trace.git/include/linux/tracepoint.h:560:2: note: in expansion of macro ‘DECLARE_TRACE’
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
  ^~~~~~~~~~~~~
/work/git/linux-trace.git/include/trace/events/syscalls.h:18:1: note: in expansion of macro ‘TRACE_EVENT_FN’
 TRACE_EVENT_FN(sys_enter,

The complaint is on:

	DEFINE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name);

And the previous definition is on:

	DECLARE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name); \

-- Steve
