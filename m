Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F07C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8BA2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHPF/4x/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8BA2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJQJNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbeJQJNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:13:30 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1562147E;
        Wed, 17 Oct 2018 01:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539739220;
        bh=37kahjbbH123nMVYg2Ft3HdOKY2TLWNlk9BlugIx4pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHPF/4x/roC7vp6gNn/yctp+tYwVlwvAnipIDV4tBXDOnadUbIE9UmJUpaBEE/anF
         dBlQJxUNUNSE8q25rx25pO8qVcx4B25BQNv/7ZJVle8TwwposK3oeI5pCl6p7Dn+BR
         HrmMIbwoGuksAQgmZAjt5DzUetj3lF3Xapc3V+/Y=
Date:   Wed, 17 Oct 2018 03:20:05 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [RFC PATCH 00/30] softirq: Make softirqs soft-interruptible (+
 per vector disablement)
Message-ID: <20181017012004.GB24723@lerouge>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
 <20181016160359.5523ae90@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016160359.5523ae90@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 04:03:59PM -0600, Jonathan Corbet wrote:
> On Thu, 11 Oct 2018 01:11:47 +0200
> Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > 945 files changed, 13857 insertions(+), 9767 deletions(-)
> 
> Impressive :)

In the wrong way :)

> 
> I have to ask a dumb question, though.  Might it not be better to add a
> new set of functions like:
> 
> 	local_softirq_disable(mask);
> 	spin_lock_softirq(lock, mask);
> 
> Then just define the existing functions to call the new ones with
> SOFTIRQ_ALL_MASK?  It would achieve something like the same result with
> far less churn and conflict potential; then individual call sites could be
> changed at leisure?  For extra credit, somebody could do a checkpatch rule
> to keep new calls to the _bh functions from being added.

So it's not a dumb question at all. That's in fact the core of the suggestions
I got while discussing that lately on IRC with the initial Cc list.

That's definetly the direction I'll take on v2: keeping the current API,
introduce new ones with per vector granularity and convert iteratively.
The diffstat will shrink tremendously and it can make the change
eventually maintainable.

The reason why I didn't take that approach first in this version is because
of a little technical detail:

    _ Serving softirqs is done under SOFTIRQ_OFFSET: (1 << SOFTIRQ_SHIFT)

    _ Disabling softirqs is done under SOFTIRQ_OFFSET * 2

We do that to differentiate both state. Serving softirqs can't nest whereas disabling
softirqs can nest. So we just need to check the value is odd to identify a serving
softirq state.

Now things are going to change as serving softirqs will be able to nest too.
And having that bh saved state allowed me to make softirqs disablement not
nesting. So I just needed to invert both ways to account. I wanted to do that
because otherwise we need to share SOFTIRQ_MASK for two counters, which makes
a maximum of 16 for both. That's enough for serving softirqs as it's couldn't
nest further than NR_SOFTIRQS, but disabling softirqs depth was unpredictable,
even though 16 levels is already insane, anyway...

There is an easy alternative though:

    local_bh_enter()
    {
        bool nesting = false;

        if (preempt_count() & SOFTIRQ_OFFSET)
            nesting = true;
        else
            preempt_count() |= SOFTIRQ_OFFSET;

        return nesting;
    }

    local_bh_exit(bool nesting)
    {
        if (nesting)
            preempt_count() &= ~SOFTIRQ_OFFSET;
    }

    do_softirq()
    {
        bool nesting = local_bh_enter();

        // process softirqs ....

        local_bh_exit(nesting);
    }

But I guess it was just too obvious for me to be considered :-S
