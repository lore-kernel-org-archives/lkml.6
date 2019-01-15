Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D58C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C45620859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfAOQT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:19:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfAOQT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:19:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B936620657;
        Tue, 15 Jan 2019 16:19:23 +0000 (UTC)
Date:   Tue, 15 Jan 2019 11:19:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Nadav Amit <namit@vmware.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
Message-ID: <20190115111922.153240f0@gandalf.local.home>
In-Reply-To: <49f9bb3d-7b65-06e8-b0b3-42cf7f0a82b5@oracle.com>
References: <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
        <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
        <20190110172004.wuh45xoafynfm2df@treble>
        <20190110123243.3b9e0856@gandalf.local.home>
        <20190110174257.GE16556@linux.intel.com>
        <20190110125757.1c8d2870@gandalf.local.home>
        <20190110180428.GG16556@linux.intel.com>
        <e5ea3781-336d-7b03-a22e-5012e915affd@oracle.com>
        <20190111152809.ejutcmqrx4ud3fli@treble>
        <ad6fae93-4122-7854-aa4c-2facd67ca839@oracle.com>
        <20190111165752.z6e2dfktj2caqi4n@treble>
        <49f9bb3d-7b65-06e8-b0b3-42cf7f0a82b5@oracle.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 12:10:19 +0100
Alexandre Chartre <alexandre.chartre@oracle.com> wrote:

> Thinking more about it (and I've probably missed something or I am just being
> totally stupid because this seems way too simple), can't we just replace the
> "call" with "push+jmp" and patch the jmp instruction?
> 
> Instead of having:
> 
>      call target
> 
> Have:
> 
>      push $done
> static_call:
>      jmp target
> done:

But how do you implement it? Inline assembly()? Then you need to be
able to do that for any type of function parameters (there will be
users that have 13 parameters!)

I believe people have mentioned having a gcc plugin that would do it
for us, which was one of the suggested solutions.

-- Steve

> 
> Then we can safely patch the "jmp" instruction to jump to a new target
> with text_poke_bp(), using the new target as the text_poke_bp() handler:
> 
>    new_jmp_code = opcode of "jmp new_target"
> 
>    text_poke_bp(static_call, new_jmp_code, new_jmp_code_size, new_target);
> 
> Problems come with patching a call instruction, but there's no issue with patching
> a jmp, no? (that's what jump labels do).
> 
> No change to the int3 handler, no thunk, this seems really too simple... :-)

