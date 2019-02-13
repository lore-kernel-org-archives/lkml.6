Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5FFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42E5222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390456AbfBMNTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:19:22 -0500
Received: from foss.arm.com ([217.140.101.70]:53452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbfBMNTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:19:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 787A980D;
        Wed, 13 Feb 2019 05:19:21 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 931EC3F557;
        Wed, 13 Feb 2019 05:19:19 -0800 (PST)
Date:   Wed, 13 Feb 2019 13:19:16 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/4] Allow tasks to have their user stack pointer
 sanity checked
Message-ID: <20190213131915.GC5875@brain-police>
References: <20190211175935.4602-1-will.deacon@arm.com>
 <CAGXu5jJk7zpKzx0DrBRmJvAoPDEMUni5bgE-O1xR8_1-p6HAxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJk7zpKzx0DrBRmJvAoPDEMUni5bgE-O1xR8_1-p6HAxQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Mon, Feb 11, 2019 at 11:12:19AM -0800, Kees Cook wrote:
> On Mon, Feb 11, 2019 at 9:59 AM Will Deacon <will.deacon@arm.com> wrote:
> > I attended an interesting talk at LCA last month that described some of the
> > security features deployed in OpenBSD [1]. One hardening feature that piqued
> > my interest was, on syscall entry and page faults from userspace, checking
> > that the user stack pointer for a task points at pages that were either
> > allocated by the kernel for the initial process stack of mapped with mmap()
> > using the MAP_STACK flag. This acts as a basic defense against stack
> > pivoting attacks.
> 
> I think this is nice to have, yes! Thanks for working on it. It seems
> like this blocks pivots to heap -- relocating to a groomed stack area
> would still be allowed. Regardless, this does narrow the scope of such
> attacks quite nicely.
> 
> > The problem with this checking is that it is a retrospective tightening
> > of the ABI, but that hasn't stopped me hacking it together behind a couple
> > of prctl() options.
> 
> MAP_STACK has been around for a long time, so I think anything using
> threads via glibc should be "covered". I would assume this would mean
> that glibc could set the prctl() for such users. I suspect there are a
> lot of open-coded threading implementations, though. It'd be
> interesting to see how many need modification.
> 
> Given that this is behind a prctl(), it seems the CONFIG isn't needed?

I wanted to keep the CONFIG because we grow task_struct and maybe somebody
cares about that (many of the other fields in there are guarded).

> > Anyway, it was fun to implement so I figured I'd post it as an RFC.
> 
> Thanks! I'd love to see an x86 counterpart to the sycall check too.

I'll take a quick look. I think that, like arm64, x86 moved much of their
entry code into C so it might be really straightforward.

> Did you trying bringing up a full userspace and windowing environment
> with this enabled by default (i.e. forcing init to set the prctls)?
> I'd be curious to see how much (if anything) goes boom. :)

So far I haven't found anything other than my targetted testcase which
explodes. However, I would fully expect some JITs to go wrong and probably
also some uses of sigaltstack().

> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

Will
