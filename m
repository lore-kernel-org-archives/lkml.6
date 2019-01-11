Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5A0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357A220836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390793AbfAKUbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:31:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389191AbfAKUbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:31:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8056FD3DF;
        Fri, 11 Jan 2019 20:31:41 +0000 (UTC)
Received: from treble (ovpn-122-231.rdu2.redhat.com [10.10.122.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 454AB1001F50;
        Fri, 11 Jan 2019 20:31:37 +0000 (UTC)
Date:   Fri, 11 Jan 2019 14:31:35 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Message-ID: <20190111203135.5clurevf34bkiy3o@treble>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble>
 <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble>
 <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 11 Jan 2019 20:31:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:12:30PM -0800, Linus Torvalds wrote:
> On Fri, Jan 11, 2019 at 12:04 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > But really, to me, having to create and manage all those custom
> > trampolines still feels a lot more complex than just making a gap on the
> > stack.
> 
> There are no "all those custom trampolines".
> 
> There is literally *one* custom trampoline that you generate as you do
> the rewriting.
> 
> Well, two, since you need the version with the "sti" before the jmp.
> 
> It would be possible to generate the custom trampoline on the fly in
> the BP handler itself, and just have a magic flag for that case. But
> it's probably simpler to do it in the caller, since you need to
> generate that special writable and executable code sequence. You
> probably don't want to do that at BP time.
> 
> You probably want to use a FIX_TEXT_POKE2 page for the generated
> sequence that just maps some generated code executably for a short
> while. Or something like that.

I was referring to the fact that a single static call key update will
usually result in patching multiple call sites.  But you're right, it's
only 1-2 trampolines per text_poke_bp() invocation.  Though eventually
we may want to batch all the writes like what Daniel has proposed for
jump labels, to reduce IPIs.

Regardless, the trampoline management seems more complex to me.  But
it's easier to argue about actual code, so maybe I'll code it up to make
it easier to compare solutions.

-- 
Josh
