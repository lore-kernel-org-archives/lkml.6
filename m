Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D635DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CFC20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CFC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeKJGRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:17:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbeKJGRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:17:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 297CC3DE04;
        Fri,  9 Nov 2018 20:35:03 +0000 (UTC)
Received: from treble (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 723F75D9CA;
        Fri,  9 Nov 2018 20:35:01 +0000 (UTC)
Date:   Fri, 9 Nov 2018 14:34:59 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20181109203459.wbftlkxcvfnwo2bm@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <20181109133337.63487e3a@gandalf.local.home>
 <20181109193505.5p5iddrtgpk2cpb4@treble>
 <20181109145746.0037da3f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181109145746.0037da3f@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 09 Nov 2018 20:35:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:57:46PM -0500, Steven Rostedt wrote:
> On Fri, 9 Nov 2018 13:35:05 -0600
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> 
> > > > +#define DECLARE_STATIC_CALL(key, func)					\
> > > > +	extern struct static_call_key key;				\
> > > > +	extern typeof(func) STATIC_CALL_TRAMP(key);			\
> > > > +	/* Preserve the ELF symbol so objtool can access it: */		\
> > > > +	__ADDRESSABLE(key)  
> > > 
> > > Does the __ADDRESSABLE(key) need to be in the DECLARE part?
> > > If so, there needs to be more explanation than just the comment above
> > > it.  
> > 
> > For each call site, objtool creates a struct in .static_call_sites:
> > 
> > 	struct static_call_site {
> > 		s32 addr;
> > 		s32 key;
> > 	};
> > 
> > In order to do that, it needs to create a relocation which references
> > the key symbol.  If the key is defined in another .o file, then the
> > current .o will not have an ELF symbol associated with the key.  The
> > __ADDRESSABLE(key) thing tells GCC to leave the key symbol in the .o
> > file, even though it's not referenced anywhere.  That makes objtool's
> > job easier, so it doesn't have to edit the symbol table.
> > 
> > I could add a comment saying as much, though it's hard to explain it in
> > fewer words than I just did :-)
> 
> Does this have to do with adding the references by relative address?
> 
> In record_mcount, I just picked an existing symbol and referenced that..
> But perhaps this is a cleaner way.

I think recordmcount is different.  It creates references (in
__mcount_loc) to functions which are already in the object file, so they
already have symbols associated with them.

But in this case, when objtool is creating references, the symbol it
needs to reference is outside the .o file, so there's no symbol to
associate it with.

> Adding a more in depth comment wont hurt.
> 
> > 
> > > > +	/*
> > > > +	 * If called before init, leave the call sites unpatched for now.
> > > > +	 * In the meantime they'll continue to call the temporary trampoline.
> > > > +	 */
> > > > +	if (!static_call_initialized)
> > > > +		goto done;
> > > > +
> > > > +	list_for_each_entry(mod, &key->site_mods, list) {  
> > > 
> > > Since I'm expecting a lot of sites, I'm wondering if we should just do
> > > this as an array, like I do with the ftrace call sites.
> > > 
> > > But this can be an enhancement for later. Let's focus on getting this
> > > working first.  
> > 
> > But it's not a static list.  It can grow/shrink as modules are
> > loaded/unload.
> 
> Neither is ftrace :-) What I did was make one array for the core kernel
> code, and an array for each module, and link list those (single link,
> although double link may not be hard either). That will save a lot of
> memory than having each instance have a link pointer, as it only grows
> or shrinks in chunks.

That sounds exactly like what I did :-)

The site_mods list is a list of static_call_mods.  Each static_call_mod
has a pointer to an array (which is that module/vmlinux's
.static_call_site section).

> > > So what's the reason for skipping init calls?  
> > 
> > This is the runtime changing code (static_call_update).  Presumably the
> > init sections no longer exist and we shouldn't write to any (former)
> > call sites there.
> > 
> > That's probably a dangerous assumption though...  If
> > static_call_update() were called early, some init code might not get
> > patched and then call into the wrong function.
> > 
> > I'm thinking we should just disallow static call sites in init sections.
> > I can't think of a good reason why they would be needed in init code.
> > We can WARN when detecting them during boot / module init.
> > 
> 
> What I would do is to allow init (like ftrace now does). I have
> ftrace_free_init_mem() that removes all the mcount references for init
> calls from its list. You could add a static_call_free_init() to
> kernel_init() in init/main.c too.

That makes sense for ftrace, but I don't see much point in allowing it
for static calls.  Maybe we could just add support for it later if it
turns out to be useful.

-- 
Josh
