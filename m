Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C101FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9554B20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9554B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeLFRp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:45:26 -0500
Received: from foss.arm.com ([217.140.101.70]:57244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbeLFRpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:45:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D71980D;
        Thu,  6 Dec 2018 09:45:25 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2633F3F5AF;
        Thu,  6 Dec 2018 09:45:24 -0800 (PST)
Date:   Thu, 6 Dec 2018 17:45:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv2] locking/atomics: build atomic headers as required
Message-ID: <20181206174516.2bbjxzhsnwckqf5n@lakrids.cambridge.arm.com>
References: <20181128085455.1164-1-mark.rutland@arm.com>
 <20181206161344.GA110430@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206161344.GA110430@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 05:13:44PM +0100, Ingo Molnar wrote:
> 
> * Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Andrew and Ingo report that the check-atomics.sh script is simply too
> > slow to run for every kernel build, and it's impractical to make it
> > faster without rewriting it in something other than shell.
> > 
> > Rather than committing the generated headers, let's regenerate these
> > as-required, if we change the data or scripts used to generate the
> > atomic headers, or when building from a pristine tree.
> > 
> > That ensures they're always up-to-date, allows them to be built in
> > parallel, and avoid redundant rebuilds, which is a 2-8s saving per
> > incremental build. Since the results are not committed, it's very
> > obvious that they should not be modified directly. If we need to
> > generate more headers in future, it's easy to extend Makefile.genheader
> > to permit this.
> > 
> > I've verified that this works in the cases we previously had issues with
> > (out-of-tree builds and where scripts have no execute permissions), and
> > have tested these cases for both x86_64 and arm64.
> > 
> > The diffstat looks nice, at least...
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  Kbuild                                    |   18 +-
> >  Makefile                                  |    8 +-
> >  arch/arm64/include/asm/atomic.h           |    2 +-
> >  arch/x86/include/asm/atomic.h             |    2 +-
> >  include/asm-generic/atomic-instrumented.h | 1787 ----------------------
> >  include/asm-generic/atomic-long.h         | 1012 -------------
> >  include/linux/atomic-fallback.h           | 2294 -----------------------------
> >  include/linux/atomic.h                    |    4 +-
> >  scripts/Makefile.genheader                |   26 +
> >  scripts/atomic/check-atomics.sh           |   19 -
> >  10 files changed, 38 insertions(+), 5134 deletions(-)
> >  delete mode 100644 include/asm-generic/atomic-instrumented.h
> >  delete mode 100644 include/asm-generic/atomic-long.h
> >  delete mode 100644 include/linux/atomic-fallback.h
> >  create mode 100644 scripts/Makefile.genheader
> >  delete mode 100755 scripts/atomic/check-atomics.sh
> 
> So these 'automatically generated' headers are actual and important code, 
> and I think it's bad practice to remove these from the git grep search 
> space and history as well.

Ok. Let's aim for that, then. :)

> Really, this whole notion of auto-generating the headers should be 
> implemented correctly, instead of working around deficiencies in a 
> short-term fashion that introduces other deficiencies.

I certainly agree.

> I never got any replies to my previous comments about this:
> 
>   <20181128083057.GA7879@gmail.com>
> 
> Did I miss some mails of yours perhaps?

It appears my mailserver dropped that on the floor, as I can't find it
in any of my mailboxes. :(

Sorry about that; I'll try to figure out what happened there.

This patch covers your suggestion of parallelizing things. On my box
with -j64, that saves ~1.5s for a pristine allnoconfig build which
otherwise takes ~15s.

Practically, optimizing the scripts requires moving away from shell.
The cost is all down to sub-shells resulting in fork+exec, but the
scripts would be illegible without this.

One option is to generate a checksum when the headers are generated and
checked in, and check that at build time. I'll look into this tomorrow.

Thanks,
Mark.
