Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5683EC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E762735F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E762735F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935372AbeF1M1j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:27:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932640AbeF1M1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:27:37 -0400
Received: from localhost (unknown [104.153.224.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4D9886A;
        Thu, 28 Jun 2018 12:27:19 +0000 (UTC)
Date:   Thu, 28 Jun 2018 21:07:42 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/7] atomics/tty: add missing atomic_long_t * cast
Message-ID: <20180628120742.GB4065@kroah.com>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-2-mark.rutland@arm.com>
 <20180605120021.GH12258@hirez.programming.kicks-ass.net>
 <20180605142051.GB12925@kroah.com>
 <20180605144304.GW12180@hirez.programming.kicks-ass.net>
 <20180605145334.GA12235@hirez.programming.kicks-ass.net>
 <20180606140042.GA8865@kroah.com>
 <20180622165535.w3jvdzc6aykkiq5m@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622165535.w3jvdzc6aykkiq5m@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 05:55:59PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Wed, Jun 06, 2018 at 04:00:42PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 05, 2018 at 04:53:34PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 05, 2018 at 04:43:04PM +0200, Peter Zijlstra wrote:
> > > 
> > > > I can make a proper patch, hold on.
> > > 
> > > ---
> > > Subject: atomic/tty: Fix up atomic abuse in ldsem
> > > 
> > > Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
> > > working after making the atomic_long interface type safe.
> > > 
> > > Needing casts is bad form, which made me look at the code. There are no
> > > ld_semaphore::count users outside of these functions so there is no
> > > reason why it can not be an atomic_long_t in the first place, obviating
> > > the need for this cast.
> > > 
> > > That also ensures the loads use atomic_long_read(), which implies (at
> > > least) READ_ONCE() in order to guarantee single-copy-atomic loads.
> > > 
> > > When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
> > > very thin (the only difference is not changing *old on success, which
> > > most callers don't seem to care about).
> > > 
> > > So rework the whole thing to use atomic_long_t and its accessors
> > > directly.
> > > 
> > > While there, fixup all the horrible comment styles.
> > > 
> > > Cc: Peter Hurley <peter@hurleysoftware.com>
> > > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Looks good, I'll queue this up after 4.18-rc1 is out, thanks.
> 
> Now that v4.18-rc1 is out, I thought I'd ping so that this doesn't get
> forgotten.

Not forgotten, sorry, now queued up.

greg k-h
