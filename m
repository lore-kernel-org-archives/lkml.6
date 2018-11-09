Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26E6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B6320825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B6320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeKJAvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:51:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbeKJAvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:51:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF6663082DDB;
        Fri,  9 Nov 2018 15:10:31 +0000 (UTC)
Received: from treble (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F4265C219;
        Fri,  9 Nov 2018 15:10:29 +0000 (UTC)
Date:   Fri, 9 Nov 2018 09:10:28 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
Message-ID: <20181109151028.faifw66enzye32gg@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <CAKv+Gu9bMkFEx_GxH3uLm0gveQurp7ELDi6C5NvpugufPFMbRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9bMkFEx_GxH3uLm0gveQurp7ELDi6C5NvpugufPFMbRA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 09 Nov 2018 15:10:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:39:17PM +0100, Ard Biesheuvel wrote:
> > +       for (site = start; site < stop; site++) {
> > +               struct static_call_key *key = static_call_key(site);
> > +               unsigned long addr = static_call_addr(site);
> > +
> > +               if (list_empty(&key->site_mods)) {
> > +                       struct static_call_mod *mod;
> > +
> > +                       mod = kzalloc(sizeof(*mod), GFP_KERNEL);
> > +                       if (!mod) {
> > +                               WARN(1, "Failed to allocate memory for static calls");
> > +                               return;
> > +                       }
> > +
> > +                       mod->sites = site;
> > +                       list_add_tail(&mod->list, &key->site_mods);
> > +
> > +                       /*
> > +                        * The trampoline should no longer be used.  Poison it
> > +                        * it with a BUG() to catch any stray callers.
> > +                        */
> > +                       arch_static_call_poison_tramp(addr);
> 
> This patches the wrong thing: the trampoline is at key->func not addr.

If you look at the x86 implementation, it actually does poison the
trampoline.

The address of the trampoline isn't actually known here.  key->func
isn't the trampoline address; it's the destination func address.

So instead I passed the address of the call instruction.  The arch code
then reads the instruction to find the callee (the trampoline).

The code is a bit confusing.  To make it more obvious, maybe we should
add another arch function to read the call destination.  Then this code
can pass that into arch_static_call_poison_tramp().

> However, patching it here means we poison it before all users are
> patched. I added this on top
> 
> diff --git a/kernel/static_call.c b/kernel/static_call.c
> index 599ebc6fc4f1..d9562329bec6 100644
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -248,6 +248,7 @@ static void __init static_call_init(void)
>         struct static_call_site *start = __start_static_call_sites;
>         struct static_call_site *stop  = __stop_static_call_sites;
>         struct static_call_site *site;
> +       struct static_call_key *prev_key = NULL;
> 
>         if (start == stop) {
>                 pr_warn("WARNING: empty static call table\n");
> @@ -279,7 +280,9 @@ static void __init static_call_init(void)
>                          * The trampoline should no longer be used.  Poison it
>                          * it with a BUG() to catch any stray callers.
>                          */
> -                       arch_static_call_poison_tramp(addr);
> +                       if (prev_key)
> +
> arch_static_call_poison_tramp((unsigned long)prev_key->func);
> +                       prev_key = key;
>                 }
> 
>                 arch_static_call_transform(addr, key->func);

While it does indeed poison the trampoline before all users are patched,
I had been thinking that it didn't really matter because this is before
the other CPUs have been booted.

But I believe interrupts are enabled at this point during the boot, so
it would indeed be wise to poison it afterwards, in case an irq handler
makes a static call.

-- 
Josh
