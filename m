Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3ECC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCE120825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCE120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeKJDOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:14:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeKJDOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:14:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 286147F3E7;
        Fri,  9 Nov 2018 17:33:09 +0000 (UTC)
Received: from treble (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FB1E600CD;
        Fri,  9 Nov 2018 17:33:07 +0000 (UTC)
Date:   Fri, 9 Nov 2018 11:33:05 -0600
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
Message-ID: <20181109173305.2trzwl7ugczxf6rg@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <CAKv+Gu9bMkFEx_GxH3uLm0gveQurp7ELDi6C5NvpugufPFMbRA@mail.gmail.com>
 <20181109151028.faifw66enzye32gg@treble>
 <CAKv+Gu_J1b30+pMNRF0icEpyew4TM_VP3ShG=4HkLnk=fRL9zg@mail.gmail.com>
 <CAKv+Gu-DOW2WT=h8C0x5igbCDAc2bp3mTRM6U_wTJST+RnVicg@mail.gmail.com>
 <20181109173106.kbghzsdsu7oachl6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181109173106.kbghzsdsu7oachl6@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 09 Nov 2018 17:33:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 11:31:06AM -0600, Josh Poimboeuf wrote:
> On Fri, Nov 09, 2018 at 06:25:24PM +0100, Ard Biesheuvel wrote:
> > On 9 November 2018 at 16:14, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > On 9 November 2018 at 16:10, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >> On Fri, Nov 09, 2018 at 02:39:17PM +0100, Ard Biesheuvel wrote:
> > >>> > +       for (site = start; site < stop; site++) {
> > >>> > +               struct static_call_key *key = static_call_key(site);
> > >>> > +               unsigned long addr = static_call_addr(site);
> > >>> > +
> > >>> > +               if (list_empty(&key->site_mods)) {
> > >>> > +                       struct static_call_mod *mod;
> > >>> > +
> > >>> > +                       mod = kzalloc(sizeof(*mod), GFP_KERNEL);
> > >>> > +                       if (!mod) {
> > >>> > +                               WARN(1, "Failed to allocate memory for static calls");
> > >>> > +                               return;
> > >>> > +                       }
> > >>> > +
> > >>> > +                       mod->sites = site;
> > >>> > +                       list_add_tail(&mod->list, &key->site_mods);
> > >>> > +
> > >>> > +                       /*
> > >>> > +                        * The trampoline should no longer be used.  Poison it
> > >>> > +                        * it with a BUG() to catch any stray callers.
> > >>> > +                        */
> > >>> > +                       arch_static_call_poison_tramp(addr);
> > >>>
> > >>> This patches the wrong thing: the trampoline is at key->func not addr.
> > >>
> > >> If you look at the x86 implementation, it actually does poison the
> > >> trampoline.
> > >>
> > >> The address of the trampoline isn't actually known here.  key->func
> > >> isn't the trampoline address; it's the destination func address.
> > >>
> > >> So instead I passed the address of the call instruction.  The arch code
> > >> then reads the instruction to find the callee (the trampoline).
> > >>
> > >> The code is a bit confusing.  To make it more obvious, maybe we should
> > >> add another arch function to read the call destination.  Then this code
> > >> can pass that into arch_static_call_poison_tramp().
> > >>
> > >
> > > Ah right, so I am basically missing a dereference in my
> > > arch_static_call_poison_tramp() code if this breaks.
> > >
> > 
> > Could we call it 'defuse' rather than 'poision'? On arm64, we will
> > need to keep it around to bounce function calls that are out of range,
> > and replace it with a PLT sequence.
> 
> Ok, but doesn't that defeat the purpose of the inline approach?

Or are you only going to use the trampoline for out-of-range calls,
otherwise just do direct calls?

-- 
Josh
