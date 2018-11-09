Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593E7C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2808B20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2808B20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeKJBBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:01:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbeKJBBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:01:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8EC930841DE;
        Fri,  9 Nov 2018 15:20:17 +0000 (UTC)
Received: from treble (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B97225D9CA;
        Fri,  9 Nov 2018 15:20:15 +0000 (UTC)
Date:   Fri, 9 Nov 2018 09:20:08 -0600
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
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 0/3] Static calls
Message-ID: <20181109152008.3z63vouyddtbeocu@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <20181109072811.GB86700@gmail.com>
 <CAKv+Gu-3OfrgGafO3OY3hAir723tD6shEaWTLJ5Ec4YcW4yZyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-3OfrgGafO3OY3hAir723tD6shEaWTLJ5Ec4YcW4yZyQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 09 Nov 2018 15:20:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:50:27PM +0100, Ard Biesheuvel wrote:
> On 9 November 2018 at 08:28, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> >> These patches are related to two similar patch sets from Ard and Steve:
> >>
> >> - https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
> >> - https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org
> >>
> >> The code is also heavily inspired by the jump label code, as some of the
> >> concepts are very similar.
> >>
> >> There are three separate implementations, depending on what the arch
> >> supports:
> >>
> >>   1) CONFIG_HAVE_STATIC_CALL_OPTIMIZED: patched call sites - requires
> >>      objtool and a small amount of arch code
> >>
> >>   2) CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED: patched trampolines - requires
> >>      a small amount of arch code
> >>
> >>   3) If no arch support, fall back to regular function pointers
> >>
> >>
> >> TODO:
> >>
> >> - I'm not sure about the objtool approach.  Objtool is (currently)
> >>   x86-64 only, which means we have to use the "unoptimized" version
> >>   everywhere else.  I may experiment with a GCC plugin instead.
> >
> > I'd prefer the objtool approach. It's a pretty reliable first-principles
> > approach while GCC plugin would have to be replicated for Clang and any
> > other compilers, etc.
> >
> 
> I implemented the GCC plugin approach here for arm64
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=static-calls
>
> That implements both the unoptimized and the optimized versions.

Nice!  That was fast :-)

> I do take your point about GCC and other compilers, but on arm64 we
> don't have a lot of choice.
> 
> As far as I can tell, the GCC plugin is generic (i.e., it does not
> rely on any ARM specific passes, but obviously, this requires a *lot*
> of testing and validation to be taken seriously.

Yeah.  I haven't had a chance to try your plugin on x86 yet, but in
theory it should be arch-independent.

-- 
Josh
