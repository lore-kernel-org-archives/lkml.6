Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816F1ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E45120857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E45120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeKICvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:51:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44825 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeKICvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:51:45 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKntk-0005EV-LG; Thu, 08 Nov 2018 18:15:16 +0100
Date:   Thu, 8 Nov 2018 18:15:16 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: rcu: Merge RCU-bh into RCU-preempt
Message-ID: <20181108171516.axwvjtgay4zolc56@linutronix.de>
References: <20181101231804.GA11280@linux.ibm.com>
 <20181108160256.xpawe65h5lm65soi@linutronix.de>
 <20181108164247.GL4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181108164247.GL4170@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-08 08:42:47 [-0800], Paul E. McKenney wrote:
> On Thu, Nov 08, 2018 at 05:02:57PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2018-11-01 16:18:04 [-0700], Paul E. McKenney wrote:
> > > The need for this goes away as of the current merge window because
> > > RCU-bh has gone away.  (Aside from still being able to do things
> > > like rcu_read_lock_bh() as a documentation device.)
> > 
> > So in -RT rcu_read_lock_bh() does
> >  { local_bh_disable() ;  rcu_read_lock() }
> > 
> > So you are saying that this is also the case in v4.20?
> 
> No, rcu_read_lock_bh() and rcu_read_unlock_bh() are unchanged in v4.20.
> With the new RCU grace-period mechanism, local_bh_disable() blocks future
> grace periods on its own.
> 
> Unless I am missing something (quite probable, actually), the v4.20
> definitions of rcu_read_lock_bh() and rcu_read_unlock_bh() should work
> as-is for -rt.

I *think* tglx made this patch, then you somehow reverted it partly [0]
and the final piece we need for RT is this gem:

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/rcu-Eliminate-softirq-processing-from-rcutree.patch?h=linux-4.19.y-rt-patches

[0] rcu: Make ksoftirqd do RCU quiescent states
    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/patch-to-introduce-rcu-bh-qs-where-safe-from-softirq.patch?h=linux-4.19.y-rt-patches

> 							Thanx, Paul

Sebastian
