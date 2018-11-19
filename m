Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934EAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636712089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636712089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbeKTFxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:53:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbeKTFxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:53:01 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A3882075B;
        Mon, 19 Nov 2018 19:27:58 +0000 (UTC)
Date:   Mon, 19 Nov 2018 14:27:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Andrew Morton <akpm@osdl.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Do not bug in __sched_setscheduler() when pi is
 not used
Message-ID: <20181119142756.057ad784@gandalf.local.home>
In-Reply-To: <06f2927d-5d5d-aca5-6a2e-e48836e4782c@gmail.com>
References: <20170309101842.1449d49a@gandalf.local.home>
        <46a07263-3327-94b6-f6b8-a0a17ae7bfee@broadcom.com>
        <20181119151311.GA5340@kroah.com>
        <20181119104654.47623a42@gandalf.local.home>
        <20181119162432.GB13065@kroah.com>
        <20181119113537.3aa4f05e@gandalf.local.home>
        <06f2927d-5d5d-aca5-6a2e-e48836e4782c@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 11:09:50 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:


> > I did the change against v4.2.8 below.  
> 
> Thanks Steven! Here is the local 4.9 backport:

Yours even updates the comment.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 917be221438b..6b3fff6a6437 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4087,8 +4087,8 @@ static int __sched_setscheduler(struct task_struct *p,
>         int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
>         struct rq *rq;
> 
> -       /* may grab non-irq protected spin_locks */
> -       BUG_ON(in_interrupt());
> +       /* The pi code expects interrupts enabled */
> +       BUG_ON(pi && in_interrupt());
>  recheck:
>         /* double check policy once rq lock held */
