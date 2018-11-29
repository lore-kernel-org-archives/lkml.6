Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0823C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB52F2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB52F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeK2LmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:42:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbeK2LmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:42:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5972E1556B;
        Thu, 29 Nov 2018 00:38:42 +0000 (UTC)
Received: from treble (ovpn-123-4.rdu2.redhat.com [10.10.123.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBA25604D0;
        Thu, 29 Nov 2018 00:38:39 +0000 (UTC)
Date:   Wed, 28 Nov 2018 18:38:37 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 0/5] x86: dynamic indirect call promotion
Message-ID: <20181129003837.6lgxsnhoyipkebmz@treble>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181128160849.epmoto4o5jaxxxol@treble>
 <9EACED43-EC21-41FB-BFAC-4E98C3842FD9@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9EACED43-EC21-41FB-BFAC-4E98C3842FD9@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 29 Nov 2018 00:38:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 07:34:52PM +0000, Nadav Amit wrote:
> > On Nov 28, 2018, at 8:08 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > On Wed, Oct 17, 2018 at 05:54:15PM -0700, Nadav Amit wrote:
> >> This RFC introduces indirect call promotion in runtime, which for the
> >> matter of simplification (and branding) will be called here "relpolines"
> >> (relative call + trampoline). Relpolines are mainly intended as a way
> >> of reducing retpoline overheads due to Spectre v2.
> >> 
> >> Unlike indirect call promotion through profile guided optimization, the
> >> proposed approach does not require a profiling stage, works well with
> >> modules whose address is unknown and can adapt to changing workloads.
> >> 
> >> The main idea is simple: for every indirect call, we inject a piece of
> >> code with fast- and slow-path calls. The fast path is used if the target
> >> matches the expected (hot) target. The slow-path uses a retpoline.
> >> During training, the slow-path is set to call a function that saves the
> >> call source and target in a hash-table and keep count for call
> >> frequency. The most common target is then patched into the hot path.
> >> 
> >> The patching is done on-the-fly by patching the conditional branch
> >> (opcode and offset) that is used to compare the target to the hot
> >> target. This allows to direct all cores to the fast-path, while patching
> >> the slow-path and vice-versa. Patching follows 2 more rules: (1) Only
> >> patch a single byte when the code might be executed by any core. (2)
> >> When patching more than one byte, ensure that all cores do not run the
> >> to-be-patched-code by preventing this code from being preempted, and
> >> using synchronize_sched() after patching the branch that jumps over this
> >> code.
> >> 
> >> Changing all the indirect calls to use relpolines is done using assembly
> >> macro magic. There are alternative solutions, but this one is
> >> relatively simple and transparent. There is also logic to retrain the
> >> software predictor, but the policy it uses may need to be refined.
> >> 
> >> Eventually the results are not bad (2 VCPU VM, throughput reported):
> >> 
> >> 		base		relpoline
> >> 		----		---------
> >> nginx 	22898 		25178 (+10%)
> >> redis-ycsb	24523		25486 (+4%)
> >> dbench	2144		2103 (+2%)
> >> 
> >> When retpolines are disabled, and if retraining is off, performance
> >> benefits are up to 2% (nginx), but are much less impressive.
> > 
> > Hi Nadav,
> > 
> > Peter pointed me to these patches during a discussion about retpoline
> > profiling.  Personally, I think this is brilliant.  This could help
> > networking and filesystem intensive workloads a lot.
> 
> Thanks! I was a bit held-back by the relatively limited number of responses.

It is a rather, erm, ambitious idea, maybe they were speechless :-)

> I finished another version two weeks ago, and every day I think: "should it
> be RFCv2 or v1”, ending up not sending it…
> 
> There is one issue that I realized while working on the new version: I’m not
> sure it is well-defined what an outline retpoline is allowed to do. The
> indirect branch promotion code can change rflags, which might cause
> correction issues. In practice, using gcc, it is not a problem.

Callees can clobber flags, so it seems fine to me.

> > Some high-level comments:
> > 
> > - "Relpoline" looks confusingly a lot like "retpoline".  How about
> >  "optpoline"?  To avoid confusing myself I will hereafter refer to it
> >  as such :-)
> 
> Sure. For the academic paper we submitted, we used a much worse name that my
> colleague came up with. I’m ok with anything other than that name (not
> mentioned to prevent double-blinding violations). I’ll go with your name.
> 
> > - Instead of patching one byte at a time, is there a reason why
> >  text_poke_bp() can't be used?  That would greatly simplify the
> >  patching process, as everything could be patched in a single step.
> 
> I thought of it and maybe it is somehow possible, but there are several
> problems, for which I didn’t find a simple solution:
> 
> 1. An indirect branch inside the BP handler might be the one we patch

I _think_ nested INT3s should be doable, because they don't use IST.
Maybe Andy can clarify.

To avoid recursion we'd have to make sure not to use any function
pointers in do_int3() before or during the call to poke_int3_handler().

Incidentally I'm working on a patch which adds an indirect call to
poke_int3_handler().  We'd have to disable optolines for that code.

> 2. An indirect branch inside an interrupt or NMI handler might be the
>    one we patch

But INT3s just use the existing stack, and NMIs support nesting, so I'm
thinking that should also be doable.  Andy?

> 3. Overall, we need to patch more than a single instruction, and
>    text_poke_bp() is not suitable

Hm, I suppose that's true.

> > - In many cases, a single direct call may not be sufficient, as there
> >  could be for example multiple tasks using different network protocols
> >  which need different callbacks for the same call site.
> 
> We want to know during compilation how many targets to use. It is not
> super-simple to support multiple inlined targets, but it is feasible if you
> are willing to annotate when multiple targets are needed.

Why would an annotation be needed?  Is there a reason why the 'call'
macro wouldn't work?

I hate to say it, but another option would be a compiler plugin.

> We have a version which uses outlined indirect branch promotion when
> there are multiple targets, but it’s not ready for prime time, and the
> code-cache misses can induce some overheads.

It would be interesting to see some measurements comparing inline and
out-of-line.  If there were multiple direct call slots then out-of-line
could have advantages in some cases since it reduces the original
function's i-cache footprint.  But maybe it wouldn't be worth it.

> > - I'm not sure about the periodic retraining logic, it seems a bit
> >  nondeterministic and bursty.
> 
> I agree. It can be limited to cases in which modules are loaded/removed,
> or when the user explicitly asks for it to take place.
> 
> > 
> > So I'd propose the following changes:
> > 
> > - In the optpoline, reserve space for multiple (5 or so) comparisons and
> >  direct calls.  Maybe the number of reserved cmp/jne/call slots can be
> >  tweaked by the caller somehow.  Or maybe it could grow as needed.
> >  Starting out, they would just be NOPs.
> > 
> > - Instead of the temporary learning mode, add permanent tracking to
> >  detect a direct call "miss" -- i.e., when none of the existing direct
> >  calls are applicable and the retpoline will be used.
> > 
> > - In the case of a miss (or N misses), it could trigger a direct call
> >  patching operation to be run later (workqueue or syscall exit).  If
> >  all the direct call slots are full, it could patch the least recently
> >  modified one.  If this causes thrashing (>x changes over y time), it
> >  could increase the number of direct call slots using a trampoline.
> >  Even if there were several slots, CPU branch prediction would
> >  presumably help make it much faster than a basic retpoline.
> > 
> > Thoughts?
> 
> I’m ok with these changes in general, although having multiple inline
> targets is not super-simple. However, there are a few issues:
> 
> - There is potentially a negative impact due to code-size increase which
>   I was worried about.

True.  Though out-of-line could help with that (but it would also have
downsides of course).

> - I see no reason not to use all the available slots immediately when
>   we encounter a miss.

Agreed.

> - The order of the branches might be “wrong” (unoptimized) if we do not
>   do any relearning.

True, though branch prediction would mitigate that to a certain degree.
Also if the number of slots is reasonably small (which it will probably
need to be anyway) then it might be good enough.

> - The main question is what to do if we run out of slots and still get
>   (many?) misses. I presume the right thing is to disable the optpoline
>   and jump over it to the retpoline.

It may need some experimentation.  You could just try a simple
round-robin patching scheme.  Possibly only writing after X number of
misses.  And if that doesn't help, just disable it.  Such a simple
approach might work well enough in practice.

-- 
Josh
