Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ED3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FB920675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfAPRce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:32:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfAPRcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:32:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90DE7285BB;
        Wed, 16 Jan 2019 17:32:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3505D5D967;
        Wed, 16 Jan 2019 17:32:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 16 Jan 2019 18:32:33 +0100 (CET)
Date:   Wed, 16 Jan 2019 18:32:30 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Kohli, Gaurav" <gkohli@codeaurora.org>
Cc:     Qian Cai <cai@lca.pw>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at kernel/sched/core.c:3490!
Message-ID: <20190116173229.GA20060@redhat.com>
References: <ba9c5ad8-d78c-904d-0430-a67d8e3ea729@lca.pw>
 <20190107135215.GG14122@hirez.programming.kicks-ass.net>
 <46089f1c-ad72-c96c-2f35-c2f60e726462@lca.pw>
 <20190107175644.GB7636@redhat.com>
 <3a6d8f4c-d7ed-e888-601b-a379efec306a@codeaurora.org>
 <1547223444.6911.19.camel@lca.pw>
 <5a65a014-9013-cfbd-48a9-67199d33e719@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a65a014-9013-cfbd-48a9-67199d33e719@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 16 Jan 2019 17:32:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12, Kohli, Gaurav wrote:
>
> HI Peter, Oleg,
>
> as per flag and state this seems to be possible only from below code:

Not sure I understand you,

> XXX: 0 1 0x40844c
> PF_NOFREEZE
> PF_RANDOMIZE
> PF_SIGNALED
> PF_FORKNOEXEC
> PF_EXITING
> PF_EXITPIDONE
>
> above state shows do_exit runs properely and  if somehow after parked stated
> , TASK_WAKEKILL got set and signal_pending_state returns 1 in below case:
>
>  switch_count = &prev->nivcsw;
>         if (!preempt && prev->state) {
>                 if (unlikely(signal_pending_state(prev->state, prev))) {
>                         prev->state = TASK_RUNNING;
>                 } else {
>                         deactivate_task(rq, prev, DEQUEUE_SLEEP |
> DEQUEUE_NOCLOCK);

or task->state was TASK_RUNNING when __schedule() was called, or the deactivated
dead task was woken up later...

The only problem is that every case looks "obviously impossible" ;) I have no
idea whats going on, I can only suggest more stupid debugging patches which might
narrow the problem.

Oleg.

