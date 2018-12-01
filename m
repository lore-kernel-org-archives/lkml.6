Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE88C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7088920834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7088920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeLBBiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 20:38:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbeLBBiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 20:38:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2145537E60;
        Sat,  1 Dec 2018 14:25:42 +0000 (UTC)
Received: from treble (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE01F67662;
        Sat,  1 Dec 2018 14:25:40 +0000 (UTC)
Date:   Sat, 1 Dec 2018 08:25:38 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 0/5] x86: dynamic indirect call promotion
Message-ID: <20181201142538.tuxabm2sy2xtrfuq@treble>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181128160849.epmoto4o5jaxxxol@treble>
 <9EACED43-EC21-41FB-BFAC-4E98C3842FD9@vmware.com>
 <20181129003837.6lgxsnhoyipkebmz@treble>
 <CALCETrUfC37TxuYLgqbN3_pZ1RzfpV03byKMpSt87o+JHtk6FQ@mail.gmail.com>
 <0E75C656-18BF-4967-98A3-35E0BD83D603@vmware.com>
 <4CD1975E-3B15-4B9C-B2A9-2E5F72E1D95F@amacapital.net>
 <CALCETrWN5QenBqNpLZ3EWEF2XFje3HGubzck4AEFePCspM6mGQ@mail.gmail.com>
 <20181129151906.owxeef2e3cm4nn2y@treble>
 <EEB5784B-A85E-47E9-8CB5-1560E58E87C6@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EEB5784B-A85E-47E9-8CB5-1560E58E87C6@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 01 Dec 2018 14:25:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 06:52:45AM +0000, Nadav Amit wrote:
> > On Nov 29, 2018, at 7:19 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > On Wed, Nov 28, 2018 at 10:06:52PM -0800, Andy Lutomirski wrote:
> >> On Wed, Nov 28, 2018 at 7:24 PM Andy Lutomirski <luto@amacapital.net> wrote:
> >>> On Nov 28, 2018, at 6:06 PM, Nadav Amit <namit@vmware.com> wrote:
> >>> 
> >>>>> On Nov 28, 2018, at 5:40 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >>>>> 
> >>>>>> On Wed, Nov 28, 2018 at 4:38 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >>>>>> On Wed, Nov 28, 2018 at 07:34:52PM +0000, Nadav Amit wrote:
> >>>>>>>> On Nov 28, 2018, at 8:08 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >>>>>>>> 
> >>>>>>>>> On Wed, Oct 17, 2018 at 05:54:15PM -0700, Nadav Amit wrote:
> >>>>>>>>> This RFC introduces indirect call promotion in runtime, which for the
> >>>>>>>>> matter of simplification (and branding) will be called here "relpolines"
> >>>>>>>>> (relative call + trampoline). Relpolines are mainly intended as a way
> >>>>>>>>> of reducing retpoline overheads due to Spectre v2.
> >>>>>>>>> 
> >>>>>>>>> Unlike indirect call promotion through profile guided optimization, the
> >>>>>>>>> proposed approach does not require a profiling stage, works well with
> >>>>>>>>> modules whose address is unknown and can adapt to changing workloads.
> >>>>>>>>> 
> >>>>>>>>> The main idea is simple: for every indirect call, we inject a piece of
> >>>>>>>>> code with fast- and slow-path calls. The fast path is used if the target
> >>>>>>>>> matches the expected (hot) target. The slow-path uses a retpoline.
> >>>>>>>>> During training, the slow-path is set to call a function that saves the
> >>>>>>>>> call source and target in a hash-table and keep count for call
> >>>>>>>>> frequency. The most common target is then patched into the hot path.
> >>>>>>>>> 
> >>>>>>>>> The patching is done on-the-fly by patching the conditional branch
> >>>>>>>>> (opcode and offset) that is used to compare the target to the hot
> >>>>>>>>> target. This allows to direct all cores to the fast-path, while patching
> >>>>>>>>> the slow-path and vice-versa. Patching follows 2 more rules: (1) Only
> >>>>>>>>> patch a single byte when the code might be executed by any core. (2)
> >>>>>>>>> When patching more than one byte, ensure that all cores do not run the
> >>>>>>>>> to-be-patched-code by preventing this code from being preempted, and
> >>>>>>>>> using synchronize_sched() after patching the branch that jumps over this
> >>>>>>>>> code.
> >>>>>>>>> 
> >>>>>>>>> Changing all the indirect calls to use relpolines is done using assembly
> >>>>>>>>> macro magic. There are alternative solutions, but this one is
> >>>>>>>>> relatively simple and transparent. There is also logic to retrain the
> >>>>>>>>> software predictor, but the policy it uses may need to be refined.
> >>>>>>>>> 
> >>>>>>>>> Eventually the results are not bad (2 VCPU VM, throughput reported):
> >>>>>>>>> 
> >>>>>>>>>         base            relpoline
> >>>>>>>>>         ----            ---------
> >>>>>>>>> nginx      22898           25178 (+10%)
> >>>>>>>>> redis-ycsb 24523           25486 (+4%)
> >>>>>>>>> dbench     2144            2103 (+2%)
> >>>>>>>>> 
> >>>>>>>>> When retpolines are disabled, and if retraining is off, performance
> >>>>>>>>> benefits are up to 2% (nginx), but are much less impressive.
> >>>>>>>> 
> >>>>>>>> Hi Nadav,
> >>>>>>>> 
> >>>>>>>> Peter pointed me to these patches during a discussion about retpoline
> >>>>>>>> profiling.  Personally, I think this is brilliant.  This could help
> >>>>>>>> networking and filesystem intensive workloads a lot.
> >>>>>>> 
> >>>>>>> Thanks! I was a bit held-back by the relatively limited number of responses.
> >>>>>> 
> >>>>>> It is a rather, erm, ambitious idea, maybe they were speechless :-)
> >>>>>> 
> >>>>>>> I finished another version two weeks ago, and every day I think: "should it
> >>>>>>> be RFCv2 or v1”, ending up not sending it…
> >>>>>>> 
> >>>>>>> There is one issue that I realized while working on the new version: I’m not
> >>>>>>> sure it is well-defined what an outline retpoline is allowed to do. The
> >>>>>>> indirect branch promotion code can change rflags, which might cause
> >>>>>>> correction issues. In practice, using gcc, it is not a problem.
> >>>>>> 
> >>>>>> Callees can clobber flags, so it seems fine to me.
> >>>>> 
> >>>>> Just to check I understand your approach right: you made a macro
> >>>>> called "call", and you're therefore causing all instances of "call" to
> >>>>> become magic?  This is... terrifying.  It's even plausibly worse than
> >>>>> "#define if" :)  The scariest bit is that it will impact inline asm as
> >>>>> well.  Maybe a gcc plugin would be less alarming?
> >>>> 
> >>>> It is likely to look less alarming. When I looked at the inline retpoline
> >>>> implementation of gcc, it didn’t look much better than what I did - it
> >>>> basically just emits assembly instructions.
> >>> 
> >>> To be clear, that wasn’t a NAK.  It was merely a “this is alarming.”
> >> 
> >> Although... how do you avoid matching on things that really don't want
> >> this treatment?  paravirt ops come to mind.
> > 
> > Paravirt ops don't use retpolines because they're patched into direct
> > calls during boot.  So Nadav's patches won't touch them.
> 
> Actually, the way it’s handled is slightly more complicated - yes, the CALL
> macro should not be applied, as Josh said, but the question is how it is
> achieved.
> 
> The basic idea is that the CALL macro should only be applied to C
> source-files and not to assembly files and for macros.s, which holds the PV
> call macros. I will recheck it is done this way.

Even if the CALL macro were applied, it would get ignored by your code
because the PARAVIRT_CALL macro doesn't use retpolines.  So it would get
skipped by this check:

.ifc "\v", "__x86_indirect_thunk_\reg_it"
	relpoline_call reg=\reg_it
	retpoline = 1
.endif

-- 
Josh
