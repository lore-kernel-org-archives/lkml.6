Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69DAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FC32086B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FC32086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeIFSwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbeIFSwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:52:49 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5327920844;
        Thu,  6 Sep 2018 14:17:03 +0000 (UTC)
Date:   Thu, 6 Sep 2018 10:17:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] lockdep: Have assert functions test for actual
 interrupts disabled
Message-ID: <20180906101701.3ffcba07@gandalf.local.home>
In-Reply-To: <20180906135258.GE24106@hirez.programming.kicks-ass.net>
References: <20180806214107.110626d0@gandalf.local.home>
        <20180905112031.540aa81b@gandalf.local.home>
        <20180906135258.GE24106@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018 15:52:58 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 05, 2018 at 11:20:31AM -0400, Steven Rostedt wrote:
> > 
> > Peter, you OK with this patch? I'm currently triggering a bug (in rc2)
> > where this patch is telling me that lockdep is getting it wrong. It
> > would be good to have this upstream such that we know if it is really a
> > bug in the code itself, or if lockdep didn't keep up properly.  
> 
> I thought we had something for that under CONFIG_DEBUG_LOCKDEP.
> 
> /me checks and finds:
> 
>   kernel/locking/lockdep.c:check_flags()
> 
> Doesn't that work?

Perhaps it does, but DEBUG_LOCKDEP wasn't set. Thus, when a use case
like this happens it will confuse developers because all they see is:

------------[ cut here ]------------
IRQs not enabled as expected
[...]


And there's no reason to assume that lockdep is broken.

Commits like ebf3adbad012b ("timers/nohz: Use lockdep to assert IRQs
are disabled/enabled") which replace WARN_ON_ONCE(!irqs_disabled())
with lockdep_assert_irqs_disabled(), were done for performance reasons
(which I agree with). My patch doesn't affect performance as it only
does the "irqs_disabled()" check when the WARN_ONCE() actually
triggers. And gives useful information.

If I haven't worked on lockdep in the past, I would have been spending
a lot more time trying to figure out why interrupts were disabled here
and never looking into the fact that the report was wrong.

I still think checking if IRQS are really disabled or not when lockdep
thinks it is (or not) is valuable and doesn't cause any other problems.

-- Steve

