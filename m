Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81724C0044B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5195921707
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5195921707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbeKLOsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:48:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730779AbeKLOsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:48:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0DE7308FBAA;
        Mon, 12 Nov 2018 04:56:34 +0000 (UTC)
Received: from treble (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F44D19940;
        Mon, 12 Nov 2018 04:56:31 +0000 (UTC)
Date:   Sun, 11 Nov 2018 22:56:29 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
Message-ID: <20181112045629.3gwex4ekeglfas64@treble>
References: <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <20181109133337.63487e3a@gandalf.local.home>
 <20181109193505.5p5iddrtgpk2cpb4@treble>
 <20181109145746.0037da3f@gandalf.local.home>
 <20181109203459.wbftlkxcvfnwo2bm@treble>
 <20181110001023.57f27312@vmware.local.home>
 <CAKv+Gu-y=O6=dSbCXSaMxkj7LxfL9txzJ4r8Bcf1U0G6JQNUng@mail.gmail.com>
 <20181110080917.29af5d66@vmware.local.home>
 <20181112030722.da5cxslvlmdgttsw@treble>
 <CAKv+Gu-hs7cRjkAAzk7hUqoXWw1vQDvUGQaKnyALrPvW-TTLzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-hs7cRjkAAzk7hUqoXWw1vQDvUGQaKnyALrPvW-TTLzA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 12 Nov 2018 04:56:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:39:38AM +0100, Ard Biesheuvel wrote:
> On 12 November 2018 at 04:07, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Sat, Nov 10, 2018 at 08:09:17AM -0500, Steven Rostedt wrote:
> >> On Sat, 10 Nov 2018 12:58:08 +0100
> >> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >>
> >>
> >> > > The complaint is on:
> >> > >
> >> > >         DEFINE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name);
> >> > >
> >> > > And the previous definition is on:
> >> > >
> >> > >         DECLARE_STATIC_CALL(__tp_func_##name, __tracepoint_iter_##name); \
> >> > >
> >> >
> >> > Does the DECLARE really need the __ADDRESSABLE? Its purpose is to
> >> > ensure that symbols with static linkage are not optimized away, but
> >> > since the reference is from a header file, the symbol should have
> >> > external linkage anyway.
> >
> > Yes, DECLARE needs the __ADDRESSABLE.  In the case where DECLARE
> > is used, but DEFINE is not, GCC strips the symbol.
> >
> 
> I assume DECLARE() is intended for use in header files, and DEFINE()
> for source files, no?

Right.

> Doesn't that mean that whatever symbol __ADDRESSABLE() refers to
> should have external linkage, in which case it it addressable anyway?
> Or are we talking about some LTO / --gc-sections use case here?

If the key is declared, but not used, GCC doesn't put the key's ELF
symbol in the binary's symbol table.  That makes objtool's life harder,
because if the file has a call site, then objtool has to add the key
symbol to the symbol table, so that it can create a relocation (in the
call site table) which references the symbol.

-- 
Josh
