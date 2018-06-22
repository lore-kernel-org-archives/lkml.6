Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF35C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E833024624
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E833024624
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933647AbeFVQ4K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:56:10 -0400
Received: from foss.arm.com ([217.140.101.70]:38368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754279AbeFVQ4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:56:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13C0E14;
        Fri, 22 Jun 2018 09:56:08 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1E5F3F557;
        Fri, 22 Jun 2018 09:56:06 -0700 (PDT)
Date:   Fri, 22 Jun 2018 17:55:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/7] atomics/tty: add missing atomic_long_t * cast
Message-ID: <20180622165535.w3jvdzc6aykkiq5m@lakrids.cambridge.arm.com>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-2-mark.rutland@arm.com>
 <20180605120021.GH12258@hirez.programming.kicks-ass.net>
 <20180605142051.GB12925@kroah.com>
 <20180605144304.GW12180@hirez.programming.kicks-ass.net>
 <20180605145334.GA12235@hirez.programming.kicks-ass.net>
 <20180606140042.GA8865@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606140042.GA8865@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 06, 2018 at 04:00:42PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 05, 2018 at 04:53:34PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 05, 2018 at 04:43:04PM +0200, Peter Zijlstra wrote:
> > 
> > > I can make a proper patch, hold on.
> > 
> > ---
> > Subject: atomic/tty: Fix up atomic abuse in ldsem
> > 
> > Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
> > working after making the atomic_long interface type safe.
> > 
> > Needing casts is bad form, which made me look at the code. There are no
> > ld_semaphore::count users outside of these functions so there is no
> > reason why it can not be an atomic_long_t in the first place, obviating
> > the need for this cast.
> > 
> > That also ensures the loads use atomic_long_read(), which implies (at
> > least) READ_ONCE() in order to guarantee single-copy-atomic loads.
> > 
> > When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
> > very thin (the only difference is not changing *old on success, which
> > most callers don't seem to care about).
> > 
> > So rework the whole thing to use atomic_long_t and its accessors
> > directly.
> > 
> > While there, fixup all the horrible comment styles.
> > 
> > Cc: Peter Hurley <peter@hurleysoftware.com>
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Looks good, I'll queue this up after 4.18-rc1 is out, thanks.

Now that v4.18-rc1 is out, I thought I'd ping so that this doesn't get
forgotten.

Have a good weekend!

Mark.
