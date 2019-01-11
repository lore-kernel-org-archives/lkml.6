Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69371C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432D620874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbfAKQ6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:58:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731195AbfAKQ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:58:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE9657AE8B;
        Fri, 11 Jan 2019 16:57:59 +0000 (UTC)
Received: from treble (ovpn-122-231.rdu2.redhat.com [10.10.122.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C068660851;
        Fri, 11 Jan 2019 16:57:54 +0000 (UTC)
Date:   Fri, 11 Jan 2019 10:57:52 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20190111165752.z6e2dfktj2caqi4n@treble>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad6fae93-4122-7854-aa4c-2facd67ca839@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 11 Jan 2019 16:58:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 05:46:36PM +0100, Alexandre Chartre wrote:
> 
> 
> On 01/11/2019 04:28 PM, Josh Poimboeuf wrote:
> > On Fri, Jan 11, 2019 at 01:10:52PM +0100, Alexandre Chartre wrote:
> > > To avoid any issue with live patching the call instruction, what about
> > > toggling between two call instructions: one would be the currently active
> > > call, while the other would currently be inactive but to be used after a
> > > change is made. You can safely patch the inactive call and then toggle
> > > the call flow (using a jump label) between the active and inactive calls.
> > > 
> > > So instead of having a single call instruction:
> > > 
> > > 	call function
> > > 
> > > You would have:
> > > 
> > > 	STATIC_JUMP_IF_TRUE label, key
> > > 	call function1
> > > 	jmp done
> > > label:
> > > 	call function2
> > > done:
> > > 
> > > If the key is set so that function1 is currently called then you can
> > > safely update the call instruction for function2. Once this is done,
> > > just flip the key to make the function2 call active. On a next update,
> > > you would, of course, have to switch and update the call for function1.
> > 
> > What about the following race?
> > 
> > CPU1						CPU2
> > static key is false, doesn't jump
> > task gets preempted before calling function1
> > 						change static key to true
> > 						start patching "call function1"
> > task resumes, sees inconsistent call instruction
> > 
> 
> If the function1 call is active then it won't be changed, you will change
> function2. However, I presume you can still have a race but if the function
> is changed twice before calling function1:
> 
> CPU1						CPU2
> static key is false, doesn't jump
> task gets preempted before calling function1
>                                                 -- first function change --
>                                                 patch "call function2"
>                                                 change static key to true
>                                                 -- second function change --
>                                                 start patching "call function1"
> task resumes, sees inconsistent call instruction
> 
> So right, that's a problem.

Right, that's what I meant to say :-)

-- 
Josh
