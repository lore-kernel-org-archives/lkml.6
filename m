Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE1BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B22B2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B22B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeKZHog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:44:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:50330 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbeKZHog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:44:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9670AC38;
        Sun, 25 Nov 2018 20:52:38 +0000 (UTC)
Date:   Sun, 25 Nov 2018 21:52:36 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user
 space protection mode
In-Reply-To: <CAHk-=whtiX45YPjFPMFuktZ3WB23zqBZR-rL6RewrTyvrFj2Fw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1811252147450.21108@cbobk.fhfr.pm>
References: <20181125183328.318175777@linutronix.de> <20181125185006.051663132@linutronix.de> <CAHk-=whtiX45YPjFPMFuktZ3WB23zqBZR-rL6RewrTyvrFj2Fw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2018, Linus Torvalds wrote:

> > The mitigation guide documents how STIPB works:
> >
> >    Setting bit 1 (STIBP) of the IA32_SPEC_CTRL MSR on a logical processor
> >    prevents the predicted targets of indirect branches on any logical
> >    processor of that core from being controlled by software that executes
> >    (or executed previously) on another logical processor of the same core.
> 
> Can we please just fix this stupid lie?
> 
> Yes, Intel calls it "STIBP" and tries to make it out to be about the
> indirect branch predictor being per-SMT thread.
> 
> But the reason it is unacceptable is apparently because in reality it just
> disables indirect branch prediction entirely. So yes, *technically* it's
> true that that limits indirect branch prediction to just a single SMT
> core, but in reality it is just a "go really slow" mode.
> 
> If STIBP had actually just keyed off the logical SMT thread, we wouldn't
> need to have worried about it in the first place.
> 
> So let's document reality rather than Intel's Pollyanna world-view.
> 
> Reality matters. It's why we had to go all this. Lying about things
> and making it appear like it's not a big deal was why the original
> patch made it through without people noticing.

Yeah, exactly; the documentation doesn't discourage STIBP use (well, the 
AMD one now actually does).

I am all in favor of documenting the truth rather than the documented 
behavior, but I guess without having a word from CPU folks, explaining how 
exactly this is implemented in reality, we can just guess based on 
observed symptoms (which is what we'll do anyway I guess if we don't get 
any better / more accurate wording).

Arjan, Tim, would you have a wording handy that would be guaranteed to 
describe the reality for the sake of changelog?

Thanks,

-- 
Jiri Kosina
SUSE Labs

