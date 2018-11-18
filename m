Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473EEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA702075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA702075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeKSIjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:39:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:47026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbeKSIjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:39:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67FF7AF99;
        Sun, 18 Nov 2018 22:17:31 +0000 (UTC)
Date:   Sun, 18 Nov 2018 23:17:30 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        stable@vger.kernel.org
Subject: Re: STIBP by default.. Revert?
In-Reply-To: <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com> <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm> <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018, Linus Torvalds wrote:

> > So, I think it's as theoretical as any other spectrev2 (only with the
> > extra "HT" condition added on top).
> 
> What? No.
> 
> It's *way* more theoretical than something like meltdown, which could
> be trivially used to get data from another protection domain.

Oh yeah, I absolutely agree that spectrev2 and Meltdown and completely 
different beasts.

> Have you seen any actual realistic attacks for normal human users?
> Things where the *kernel* should actually care?
> 
> The javascript thing is for the browser to fix up, 

It's probably not just browsers, but anything running JITed sandboxed 
code. So the most straightforward way might be the prctl() aproach, where 
userspace would claim "I do care about this, please fix it up for me". So 
prctl() + perhaps SECCOMP.

Which gets us back to Tim's fixup patch. Do you still prefer the revert, 
given the existence of that? I think that if Tim's fixup makes it through 
(it's currently missing SECCOMP handling, but that is trivial to add on 
top), it might be the best compromise. We'd also have have to make IBPB 
obey it to be consistent (and get even a few more % of performance back), 
but that's easy as well.

Thanks,

-- 
Jiri Kosina
SUSE Labs

