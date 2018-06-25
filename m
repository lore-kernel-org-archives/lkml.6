Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E898C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100892606D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100892606D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935032AbeFYTV1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:21:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39301 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934943AbeFYTV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:21:26 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fXX3E-0005Eh-ND; Mon, 25 Jun 2018 21:21:24 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fXX3B-0003ou-Lk; Mon, 25 Jun 2018 21:21:21 +0200
Date:   Mon, 25 Jun 2018 21:21:21 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
Subject: Re: [PATCH] RFC: siox: don't create a thread without starting it
Message-ID: <20180625192121.k3hx32xbbhqkyfu4@pengutronix.de>
References: <20180625102056.28468-1-u.kleine-koenig@pengutronix.de>
 <20180625125105.GZ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625125105.GZ2494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On Mon, Jun 25, 2018 at 02:51:05PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 25, 2018 at 12:20:56PM +0200, Uwe Kleine-König wrote:
> > when I just boot without any other siox-related action. So the kthread (created
> > in drivers/siox/siox-core.c:siox_master_register()) is never started.
> > 
> > While you could argue that there is little reason to not start the
> > thread there also is little reason to actually do it.
> 
> Well, you really _should_ wake up the thread. That first wakeup really
> is part of the whole 'create/setup' kthread pattern.

ok

> > peterz in #kernelnewbies said "[...] kernel/kthread.c:kthread() should
> > really be using __set_current_state(TASK_IDLE), I suppose". This however
> > seems to interfere with problems fixed in a076e4bca2fd ("freezer: fix
> > kthread_create vs freezer theoretical race").
> 
> I don't think so, that patch has an issue with INTERRUPTIBLE, but IDLE
> very much doesn't allow signals like INTERRUPTIBLE does.

I don't think I can provide a good commit log for
s/TASK_UNINTERRUPTIBLE/TASK_IDLE/ in kernel/kthread.c:kthread(). But I
can confirm that this patch makes the warning go away, so if you want to
address this, you can add my Tested-by:.
 
> > So I wonder where the real problem is and how it can be fixed.
> 
> Without the first wakeup, the kthread will not run the provided function
> and we can therefore argue the creation is incomplete. I really feel you
> should just wake the thing up to land in your own wait-condition-loop.
> 
> That said, irrespective of the whole UNINTERRUPTIBLE/IDLE thing, I find
> this construct fairly fragile. We rely on not getting any spurious
> wakeups without a 'special' state.

Well, if the thread is woken up unintentionally nothing happens (apart
from the lock and the list that I moved in my patch that might not be
initialized yet; this should be fixed for sure). It just enters the
thread's own wait-condition-loop. So you could argue that the wakeup
call is just overhead that isn't necessary until the thread is really
needed. (I won't argue, I can accept your opinion and do the wakeup.)

> The only reason this doesn't normally happen is because it's a new
> task, but since it is already hashed, it might well be possible to
> trick someone into sending a wakeup.

Is this an ack for the RFC patch you replied to?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
