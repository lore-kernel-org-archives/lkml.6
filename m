Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688FDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387B92087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gx3mesPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfA1NoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:44:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1NoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t7sRyqFD8zaElsWAyTkdV/A/de2tWj31e5vDAsus3RY=; b=Gx3mesPgnK5Ve3gM75gM5zcxn
        3vpEoKJtIKjrFMtU13XkK3y5QTDnPAdoVpRBZGcNhwzJv4tZ61g9K1LkJkayc2n70E2C2GFYkLeSY
        b68vlLgcCbcZ1qkvdFJ5cEvE7PgmILWvXWC79izp+qn6BKvMm32a3/UXhIC8tyD4mBDVHOl6mPex9
        FJQ5eLCVVpk+QlirSBNJL5S7OmvKpznA70GGDASvLsOsvLYKPx0WVugUCvJiTYqmbtUYh2eH79hCS
        kv4XDS55uV+Rgl2OaHXhUGXw5Dvel5qtPnTgQKp9HI21aLKsDK9Vvu8PzygRclCYXaASDGeuWe/PS
        1sZeblWEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go7Cv-0004Lm-5e; Mon, 28 Jan 2019 13:44:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6530825E16E01; Mon, 28 Jan 2019 14:44:10 +0100 (CET)
Date:   Mon, 28 Jan 2019 14:44:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
Message-ID: <20190128134410.GA28485@hirez.programming.kicks-ass.net>
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129112321.GB3449@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:23:21PM +0100, Heiko Carstens wrote:

> And indeed, if I run only this test case in an endless loop and do
> some parallel work (like kernel compile) it currently seems to be
> possible to reproduce the warning:
> 
> while true; do time ./testrun.sh nptl/tst-robustpi8 --direct ; done
> 
> within the build directory of glibc (2.28).

Right; so that reproduces for me.

After staring at all that for a while; trying to remember how it all
worked (or supposed to work rather), I became suspiscous of commit:

  56222b212e8e ("futex: Drop hb->lock before enqueueing on the rtmutex")

And indeed, when I revert that; the above reproducer no longer works (as
in, it no longer triggers in minutes and has -- so far -- held up for an
hour+ or so).

That patch in particular allows futex_unlock_pi() to 'start' early:


futex_lock_pi()				futex_unlock_pi()
  lock hb
  queue
  lock wait_lock
  unlock hb
					lock hb
					futex_top_waiter
					get_pi_state
					lock wait_lock
  rt_mutex_proxy_start // fail
  unlock wait_lock
					// acquired wait_lock
					wake_futex_pi()
					rt_mutex_next_owner() // whoops, no waiter
					WARN

  lock hb
  unqueue_me_pi



So reverting that patch should cure things, because then there is no hb
lock break between queue/unqueue and futex_unlock_pi() cannot observe
this half-arsed state.

Now obviously reverting that makes RT unhappy; let me see what the
options are.

(concurrently tglx generated a trace that corroborates)
