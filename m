Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1633EC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9FE208C1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9FE208C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeF1IEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:04:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54841 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbeF1IED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:04:03 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fYRuJ-00023d-35; Thu, 28 Jun 2018 10:03:59 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fYRuC-0003lh-EJ; Thu, 28 Jun 2018 10:03:52 +0200
Date:   Thu, 28 Jun 2018 10:03:52 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Gavin Schenk <g.schenk@eckelmann.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        kernel@pengutronix.de, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] RFC: siox: don't create a thread without starting it
Message-ID: <20180628080352.3l24sdhxz7633sfw@pengutronix.de>
References: <20180625102056.28468-1-u.kleine-koenig@pengutronix.de>
 <20180625125105.GZ2494@hirez.programming.kicks-ass.net>
 <20180625192121.k3hx32xbbhqkyfu4@pengutronix.de>
 <20180626073841.GY2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180626073841.GY2458@hirez.programming.kicks-ass.net>
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

On Tue, Jun 26, 2018 at 09:38:41AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 25, 2018 at 09:21:21PM +0200, Uwe Kleine-König wrote:
> > > I don't think so, that patch has an issue with INTERRUPTIBLE, but IDLE
> > > very much doesn't allow signals like INTERRUPTIBLE does.
> > 
> > I don't think I can provide a good commit log for
> > s/TASK_UNINTERRUPTIBLE/TASK_IDLE/ in kernel/kthread.c:kthread(). But I
> > can confirm that this patch makes the warning go away, so if you want to
> > address this, you can add my Tested-by:.
> 
> Yeah, it's also a little bit more involved, I'd also have to change all
> the kthread_bind() code and audit all kthread users to see if anybody
> else actually relies on TASK_UNINTERRUPTIBLE.
> 
> So I think I'll leave it as is for now, maybe another day ... :-)

Should we add a reminder to kthread() à la:

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -227,7 +227,14 @@ static int kthread(void *_create)
        init_completion(&self->parked);
        current->vfork_done = &self->exited;
 
-       /* OK, tell user we're spawned, wait for stop or wakeup */
+       /*
+        * OK, tell user we're spawned, wait for stop or wakeup.
+        * It might be possible to use TASK_IDLE here to not trigger the
+        * hung-task-check if the creator doesn't run the thread immediately.
+        * Changing this would however need some research first as this has an
+        * effect on e.g. kthread_bind() or the caller might rely on
+        * TASK_UNINTERRUPTIBLE.
+        */
        __set_current_state(TASK_UNINTERRUPTIBLE);
        create->result = current;
        complete(done);

?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
