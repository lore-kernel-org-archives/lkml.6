Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541A4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F1F2151B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F1F2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbeLDIjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:39:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:50620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbeLDIjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:39:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C49DCAFDB;
        Tue,  4 Dec 2018 08:39:28 +0000 (UTC)
Date:   Tue, 4 Dec 2018 09:39:27 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>,
        Jason Brandt <jason.w.brandt@intel.com>
Subject: Re: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user
 space protection mode
In-Reply-To: <f4b903ef-828c-0b05-29c6-6f71677d120d@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1812040937440.17216@cbobk.fhfr.pm>
References: <20181125183328.318175777@linutronix.de> <20181125185006.051663132@linutronix.de> <CAHk-=whtiX45YPjFPMFuktZ3WB23zqBZR-rL6RewrTyvrFj2Fw@mail.gmail.com> <f4b903ef-828c-0b05-29c6-6f71677d120d@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018, Tim Chen wrote:

> > Can we please just fix this stupid lie?
> > 
> > Yes, Intel calls it "STIBP" and tries to make it out to be about the
> > indirect branch predictor being per-SMT thread.
> > 
> > But the reason it is unacceptable is apparently because in reality it just
> > disables indirect branch prediction entirely. So yes, *technically* it's
> > true that that limits indirect branch prediction to just a single SMT
> > core, but in reality it is just a "go really slow" mode.
> > 
> > If STIBP had actually just keyed off the logical SMT thread, we wouldn't
> > need to have worried about it in the first place.
> > 
> > So let's document reality rather than Intel's Pollyanna world-view.
> > 
> > Reality matters. It's why we had to go all this. Lying about things
> > and making it appear like it's not a big deal was why the original
> > patch made it through without people noticing.
> > 
> 
> 
> To make the usage of STIBP and its working principles clear,
> here are some additional explanations of STIBP from our Intel
> HW architects.  This should also help answer some of the questions
> from Thomas and others on STIBP's usages with IBPB and IBRS.

Thanks a lot, this indeed does shed some light.

I have one question though:

[ ... snip ... ]
> On processors with enhanced IBRS support, we recommend setting IBRS to 1
> and left set. 

Then why doesn't CPU with EIBRS support acutally *default* to '1', with 
opt-out possibility for OS?

Thanks,

-- 
Jiri Kosina
SUSE Labs

