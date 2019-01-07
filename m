Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C69C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1182070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfAGR4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:56:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55181 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfAGR4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:56:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E29CA909;
        Mon,  7 Jan 2019 17:56:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.103])
        by smtp.corp.redhat.com (Postfix) with SMTP id 194CE5DE69;
        Mon,  7 Jan 2019 17:56:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  7 Jan 2019 18:56:47 +0100 (CET)
Date:   Mon, 7 Jan 2019 18:56:45 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux kernel <linux-kernel@vger.kernel.org>,
        gkohli@codeaurora.org
Subject: Re: kernel BUG at kernel/sched/core.c:3490!
Message-ID: <20190107175644.GB7636@redhat.com>
References: <ba9c5ad8-d78c-904d-0430-a67d8e3ea729@lca.pw>
 <20190107135215.GG14122@hirez.programming.kicks-ass.net>
 <46089f1c-ad72-c96c-2f35-c2f60e726462@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46089f1c-ad72-c96c-2f35-c2f60e726462@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 07 Jan 2019 17:56:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07, Qian Cai wrote:
>
>
> On 1/7/19 8:52 AM, Peter Zijlstra wrote:
> > On Tue, Jan 01, 2019 at 12:44:35AM -0500, Qian Cai wrote:
> >> Running some mmap() workloads to put the system on low memory situation with
> >> swapping and OOM, and then it trigger this BUG(),
> >>
> >> void __noreturn do_task_dead(void)
> >> {
> >>         /* Causes final put_task_struct in finish_task_switch(): */
> >>         set_special_state(TASK_DEAD);
> >>
> >>         /* Tell freezer to ignore us: */
> >>         current->flags |= PF_NOFREEZE;
> >>
> >>         __schedule(false);
> >>         BUG();
> >>
> >>         /* Avoid "noreturn function does return" - but don't continue if BUG()
> >> is a NOP: */
> >>         for (;;)
> >>                 cpu_relax();
> >> }
> >
> > This would mean that we somehow loose the TASK_DEAD state before hitting
> > schedule(), but that is something that should be avoided by
> > set_special_state(), which is supposed to serialize against concurrent
> > wake-ups.

or may be pick_next_task() somehow returns the deactivated TASK_DEAD task?

> > How readily does this reproduce?
>
> Running LTP oom01 [1] triggered it at least once in five attempts every time so
> far on v4.20+. Have not tried much on v5.0-rc1 yet.

Can you add

	pr_crit("XXX: %ld %d\n", current->state, current->on_rq);

before that BUG() and reproduce?

Oleg.

