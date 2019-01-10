Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FE5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674CC20675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfAJSVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:21:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731005AbfAJSVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:21:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 323957FD6F;
        Thu, 10 Jan 2019 18:21:31 +0000 (UTC)
Received: from treble (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C6A560923;
        Thu, 10 Jan 2019 18:21:26 +0000 (UTC)
Date:   Thu, 10 Jan 2019 12:21:19 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20190110182119.56uw7aghymh2txke@treble>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
 <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
 <20190110172004.wuh45xoafynfm2df@treble>
 <20190110123243.3b9e0856@gandalf.local.home>
 <20190110174257.GE16556@linux.intel.com>
 <20190110125757.1c8d2870@gandalf.local.home>
 <20190110180428.GG16556@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110180428.GG16556@linux.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 10 Jan 2019 18:21:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:04:28AM -0800, Sean Christopherson wrote:
> On Thu, Jan 10, 2019 at 12:57:57PM -0500, Steven Rostedt wrote:
> > On Thu, 10 Jan 2019 09:42:57 -0800
> > Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > 
> > > On Thu, Jan 10, 2019 at 12:32:43PM -0500, Steven Rostedt wrote:
> > > > On Thu, 10 Jan 2019 11:20:04 -0600
> > > > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > > 
> > > >   
> > > > > > While I can't find a reason for hypervisors to emulate this instruction,
> > > > > > smarter people might find ways to turn it into a security exploit.    
> > > > > 
> > > > > Interesting point... but I wonder if it's a realistic concern.  BTW,
> > > > > text_poke_bp() also relies on undocumented behavior.  
> > > > 
> > > > But we did get an official OK from Intel that it will work. Took a bit
> > > > of arm twisting to get them to do so, but they did. And it really is
> > > > pretty robust.  
> > > 
> > > Did we (they?) list any caveats for this behavior?  E.g. I'm fairly
> > > certain atomicity guarantees go out the window if WC memtype is used.
> > 
> > Note, the text_poke_bp() process was this: (nothing to do with atomic
> > guarantees)
> > 
> > add breakpoint (one byte) to instruction.
> > 
> > Sync all cores (send an IPI to each one).
> > 
> > change the back half of the instruction (the rest of the instruction
> > after the breakpoint).
> > 
> > Sync all cores
> > 
> > Remove the breakpoint with the new byte of the new instruction.
> > 
> > 
> > What atomicity guarantee does the above require?
> 
> I was asking in the context of static calls.  My understanding is that
> the write to change the imm32 of the CALL needs to be atomic from a
> code fetch perspective so that we don't jump to a junk address.
> 
> Or were you saying that Intel gave an official OK on text_poke_bp()?

Yeah, I'm pretty sure he was saying that.

Whose arms can we twist for finding out about static calls? :-)

-- 
Josh
