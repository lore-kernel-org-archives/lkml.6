Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BDCC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0781D2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0781D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeKJFRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:17:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbeKJFRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:17:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E05B308212C;
        Fri,  9 Nov 2018 19:35:09 +0000 (UTC)
Received: from treble (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11A4E600CD;
        Fri,  9 Nov 2018 19:35:06 +0000 (UTC)
Date:   Fri, 9 Nov 2018 13:35:05 -0600
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
Message-ID: <20181109193505.5p5iddrtgpk2cpb4@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <20181109133337.63487e3a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181109133337.63487e3a@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 09 Nov 2018 19:35:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 01:33:37PM -0500, Steven Rostedt wrote:
> > +config HAVE_STATIC_CALL_OPTIMIZED
> > +	bool
> > +
> > +config HAVE_STATIC_CALL_UNOPTIMIZED
> > +	bool
> > +
> 
> Let's also have
> 
> config HAVE_STATIC_CALL
> 	def_bool Y
> 	depends on HAVE_STATIC_CALL_OPTIMIZED || HAVE_STATIC_CALL_UNOPTIMIZED
>
> > +#if defined(CONFIG_HAVE_STATIC_CALL_OPTIMIZED) || \
> > +    defined(CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED)
> 
> Now we can have:
> 
> #ifdef CONFIG_HAVE_STATIC_CALL

Yeah, that's better.

> > +#define DECLARE_STATIC_CALL(key, func)					\
> > +	extern struct static_call_key key;				\
> > +	extern typeof(func) STATIC_CALL_TRAMP(key);			\
> > +	/* Preserve the ELF symbol so objtool can access it: */		\
> > +	__ADDRESSABLE(key)
> 
> Does the __ADDRESSABLE(key) need to be in the DECLARE part?
> If so, there needs to be more explanation than just the comment above
> it.

For each call site, objtool creates a struct in .static_call_sites:

	struct static_call_site {
		s32 addr;
		s32 key;
	};

In order to do that, it needs to create a relocation which references
the key symbol.  If the key is defined in another .o file, then the
current .o will not have an ELF symbol associated with the key.  The
__ADDRESSABLE(key) thing tells GCC to leave the key symbol in the .o
file, even though it's not referenced anywhere.  That makes objtool's
job easier, so it doesn't have to edit the symbol table.

I could add a comment saying as much, though it's hard to explain it in
fewer words than I just did :-)

> > +	/*
> > +	 * If called before init, leave the call sites unpatched for now.
> > +	 * In the meantime they'll continue to call the temporary trampoline.
> > +	 */
> > +	if (!static_call_initialized)
> > +		goto done;
> > +
> > +	list_for_each_entry(mod, &key->site_mods, list) {
> 
> Since I'm expecting a lot of sites, I'm wondering if we should just do
> this as an array, like I do with the ftrace call sites.
> 
> But this can be an enhancement for later. Let's focus on getting this
> working first.

But it's not a static list.  It can grow/shrink as modules are
loaded/unload.

> 
> > +		if (!mod->sites) {
> > +			/*
> > +			 * This can happen if the static call key is defined in
> > +			 * a module which doesn't use it.
> > +			 */
> > +			continue;
> > +		}
> > +
> > +		stop = __stop_static_call_sites;
> > +
> > +#ifdef CONFIG_MODULES
> > +		if (mod->mod) {
> 
> BTW, "mod" is an unfortunate name.

True.  I'll change it to 'site_mod'.

> 
> > +			stop = mod->mod->static_call_sites +
> > +			       mod->mod->num_static_call_sites;
> > +		}
> > +#endif
> > +
> > +		for (site = mod->sites;
> > +		     site < stop && static_call_key(site) == key; site++) {
> > +			unsigned long addr = static_call_addr(site);
> > +
> > +			if (!mod->mod && init_section_contains((void *)addr, 1))
> > +				continue;
> > +			if (mod->mod && within_module_init(addr, mod->mod))
> > +				continue;
> > +
> 
> 
> So what's the reason for skipping init calls?

This is the runtime changing code (static_call_update).  Presumably the
init sections no longer exist and we shouldn't write to any (former)
call sites there.

That's probably a dangerous assumption though...  If
static_call_update() were called early, some init code might not get
patched and then call into the wrong function.

I'm thinking we should just disallow static call sites in init sections.
I can't think of a good reason why they would be needed in init code.
We can WARN when detecting them during boot / module init.

-- 
Josh
