Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ABDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4235720827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4235720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeKJD1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:27:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbeKJD1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:27:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F059307C940;
        Fri,  9 Nov 2018 17:46:12 +0000 (UTC)
Received: from treble (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A0975C229;
        Fri,  9 Nov 2018 17:46:10 +0000 (UTC)
Date:   Fri, 9 Nov 2018 11:46:08 -0600
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
Message-ID: <20181109174608.eahqh4fkyl3k2gvs@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <CAKv+Gu9bMkFEx_GxH3uLm0gveQurp7ELDi6C5NvpugufPFMbRA@mail.gmail.com>
 <20181109151028.faifw66enzye32gg@treble>
 <CAKv+Gu_J1b30+pMNRF0icEpyew4TM_VP3ShG=4HkLnk=fRL9zg@mail.gmail.com>
 <CAKv+Gu-DOW2WT=h8C0x5igbCDAc2bp3mTRM6U_wTJST+RnVicg@mail.gmail.com>
 <20181109173106.kbghzsdsu7oachl6@treble>
 <CAKv+Gu-9XYOwAPJ5m6F4Cn9Uo6dvbtEG9p0knX+_XcjHp2QKGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-9XYOwAPJ5m6F4Cn9Uo6dvbtEG9p0knX+_XcjHp2QKGA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 09 Nov 2018 17:46:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 06:33:03PM +0100, Ard Biesheuvel wrote:
> On 9 November 2018 at 18:31, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Fri, Nov 09, 2018 at 06:25:24PM +0100, Ard Biesheuvel wrote:
> >> On 9 November 2018 at 16:14, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> > On 9 November 2018 at 16:10, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >> >> On Fri, Nov 09, 2018 at 02:39:17PM +0100, Ard Biesheuvel wrote:
> >> >>> > +       for (site = start; site < stop; site++) {
> >> >>> > +               struct static_call_key *key = static_call_key(site);
> >> >>> > +               unsigned long addr = static_call_addr(site);
> >> >>> > +
> >> >>> > +               if (list_empty(&key->site_mods)) {
> >> >>> > +                       struct static_call_mod *mod;
> >> >>> > +
> >> >>> > +                       mod = kzalloc(sizeof(*mod), GFP_KERNEL);
> >> >>> > +                       if (!mod) {
> >> >>> > +                               WARN(1, "Failed to allocate memory for static calls");
> >> >>> > +                               return;
> >> >>> > +                       }
> >> >>> > +
> >> >>> > +                       mod->sites = site;
> >> >>> > +                       list_add_tail(&mod->list, &key->site_mods);
> >> >>> > +
> >> >>> > +                       /*
> >> >>> > +                        * The trampoline should no longer be used.  Poison it
> >> >>> > +                        * it with a BUG() to catch any stray callers.
> >> >>> > +                        */
> >> >>> > +                       arch_static_call_poison_tramp(addr);
> >> >>>
> >> >>> This patches the wrong thing: the trampoline is at key->func not addr.
> >> >>
> >> >> If you look at the x86 implementation, it actually does poison the
> >> >> trampoline.
> >> >>
> >> >> The address of the trampoline isn't actually known here.  key->func
> >> >> isn't the trampoline address; it's the destination func address.
> >> >>
> >> >> So instead I passed the address of the call instruction.  The arch code
> >> >> then reads the instruction to find the callee (the trampoline).
> >> >>
> >> >> The code is a bit confusing.  To make it more obvious, maybe we should
> >> >> add another arch function to read the call destination.  Then this code
> >> >> can pass that into arch_static_call_poison_tramp().
> >> >>
> >> >
> >> > Ah right, so I am basically missing a dereference in my
> >> > arch_static_call_poison_tramp() code if this breaks.
> >> >
> >>
> >> Could we call it 'defuse' rather than 'poision'? On arm64, we will
> >> need to keep it around to bounce function calls that are out of range,
> >> and replace it with a PLT sequence.
> >
> > Ok, but doesn't that defeat the purpose of the inline approach?
> >
> 
> It does. But this only occurs when a module is loaded far away, and
> this will only happen if you have 2 GB range KASLR enabled, or your
> 128 MB module region gets exhausted for some reason, so the majority
> of calls should use a single relative branch.

Makes sense.  Do you also account for the possibility that the original
call emitted by GCC was far away and thus used the PLT?

-- 
Josh
