Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19446C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6B020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6B020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbeGXOLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:11:46 -0400
Received: from foss.arm.com ([217.140.101.70]:51020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388279AbeGXOLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:11:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 550007A9;
        Tue, 24 Jul 2018 06:05:21 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AA713F6A8;
        Tue, 24 Jul 2018 06:05:18 -0700 (PDT)
Date:   Tue, 24 Jul 2018 14:05:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv4 01/12] atomic/tty: Fix up atomic abuse in ldsem
Message-ID: <20180724130515.ung6ox2p4rgzn746@lakrids.cambridge.arm.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
 <20180716113017.3909-2-mark.rutland@arm.com>
 <20180724071518.GA7300@gmail.com>
 <20180724092036.GN2494@hirez.programming.kicks-ass.net>
 <20180724092324.vnfowffsla4kja5c@lakrids.cambridge.arm.com>
 <20180724111313.GA14212@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724111313.GA14212@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 01:13:13PM +0200, Ingo Molnar wrote:
> 
> * Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Tue, Jul 24, 2018 at 11:20:36AM +0200, Peter Zijlstra wrote:
> > > On Tue, Jul 24, 2018 at 09:15:18AM +0200, Ingo Molnar wrote:
> > > > 
> > > > * Mark Rutland <mark.rutland@arm.com> wrote:
> > > > 
> > > > > From: Peter Zijlstra <peterz@infradead.org>
> > > > > 
> > > > > Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
> > > > > working after making the atomic_long interface type safe.
> > > > > 
> > > > > Needing casts is bad form, which made me look at the code. There are no
> > > > > ld_semaphore::count users outside of these functions so there is no
> > > > > reason why it can not be an atomic_long_t in the first place, obviating
> > > > > the need for this cast.
> > > > > 
> > > > > That also ensures the loads use atomic_long_read(), which implies (at
> > > > > least) READ_ONCE() in order to guarantee single-copy-atomic loads.
> > > > > 
> > > > > When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
> > > > > very thin (the only difference is not changing *old on success, which
> > > > > most callers don't seem to care about).
> > > > > 
> > > > > So rework the whole thing to use atomic_long_t and its accessors
> > > > > directly.
> > > > > 
> > > > > While there, fixup all the horrible comment styles.
> > > > > 
> > > > > Cc: Peter Hurley <peter@hurleysoftware.com>
> > > > > Acked-by: Will Deacon <will.deacon@arm.com>
> > > > > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > > ---
> > > > >  drivers/tty/tty_ldsem.c   | 82 ++++++++++++++++++++---------------------------
> > > > >  include/linux/tty_ldisc.h |  4 +--
> > > > >  2 files changed, 37 insertions(+), 49 deletions(-)
> > > > > 
> > > > > Note: Greg has queued this via the in the tty tree for v4.19, which can be seen at: 
> > > > > 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=5fd691afdf929061c391d897fa627822c3b2fd5a
> > > > 
> > > > Can this patch be skipped, or do the others depend on it?
> > > 
> > > IIRC it depends on it, without this patch you get build issues due to
> > > atomic_long_cmpxchg() getting picky about it's arguments (type safety
> > > improved).
> > 
> > Yup. Without this patch, there will be a build regression at patch 9,
> > when we move to generated atomic_long_*() wrappers.
> 
> Ok, then these bits will have to wait until Greg's tree goes upstream
> in about two weeks.

Ok.

> Which patches can I apply as a preparatory step?

Patches 2-6 can be applied now.

I guess I should rebase and resend the remaining bits once Greg's tree
goes upstream?

Thanks,
Mark.
