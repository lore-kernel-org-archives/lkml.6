Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A65C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A012084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lHHgoU4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A012084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbeKLKo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:44:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbeKLKo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LY+A/LXYXTbuY2MwEavME25By2/pinQHuA207V/eWcU=; b=lHHgoU4RKGcsD3NSW8hktD7pK
        f0C768++KOn+P4pnbblYhkxeDKtBg78yd032uICoy5/RIfmyA2qMQYUMBt2B9trGXo4a8WC7/1HXq
        cO+vlIM2jd5SYawDey79CxZWdaLq3xCwGAdwt1ei7/twLQdCYiPjAv33oqU3FpuT4nQRApJxlACex
        hITK1Dgqe10h9xBXWFu+Ww4bUc9cEi3IplwaoeovvGWCVHtNaNE/SG9KMHczOKatKjpelzWJ6yzvU
        Ub73Y0I1Br0+eCMwZJK4Mo0XQXLNZeiEPNqpno0yK15PzgYEpsSL8ohszumU7Xd5wzbSavay4ZBQQ
        I8b6+OI1g==;
Received: from [64.114.255.97] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM0Tq-00027z-7y; Mon, 12 Nov 2018 00:53:32 +0000
Received: by worktop (Postfix, from userid 1000)
        id 1A4D26E061A; Mon, 12 Nov 2018 01:53:29 +0100 (CET)
Date:   Mon, 12 Nov 2018 01:53:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 23/41] sched: Replace synchronize_sched()
 with synchronize_rcu()
Message-ID: <20181112005329.GG3056@worktop>
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-23-paulmck@linux.ibm.com>
 <20181112001233.GC3056@worktop>
 <20181112004528.GA4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112004528.GA4170@linux.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 04:45:28PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 12, 2018 at 01:12:33AM +0100, Peter Zijlstra wrote:
> > On Sun, Nov 11, 2018 at 11:43:52AM -0800, Paul E. McKenney wrote:
> > > Now that synchronize_rcu() waits for preempt-disable regions of code
> > > as well as RCU read-side critical sections, synchronize_sched() can be
> > > replaced by synchronize_rcu().  This commit therefore makes this change.
> > 
> > Yes, but it also waits for an actual RCU quiestent state, which makes
> > synchoinize_rcu() potentially much more expensive than an actual
> > synchronize_sched().
> 
> None of the readers have changed.
> 
> For the updaters, if CONFIG_PREEMPT=n, synchronize_rcu() and
> synchronize_sched() always were one and the same.  When CONFIG_PREEMPT=y,
> synchronize_rcu() and synchronize_sched() are now one and the same.

The Changelog does not state this; and does the commit that makes that
happen state the regression potential?

> > So why are we doing this?
> 
> Given that synchronize_rcu() and synchronize_sched() are now always one
> and the same, this is a distinction without a difference.

The Changelog did not state a reason for the patch. Therefore it is a
bad patch.
