Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C525FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944372086B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944372086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbeKNBrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:47:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbeKNBrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:47:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D41C87623A;
        Tue, 13 Nov 2018 15:48:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 75ACB1019635;
        Tue, 13 Nov 2018 15:48:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 13 Nov 2018 16:48:27 +0100 (CET)
Date:   Tue, 13 Nov 2018 16:48:25 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Message-ID: <20181113154825.GC30990@redhat.com>
References: <20181112230422.5911-1-guro@fb.com>
 <20181112230422.5911-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112230422.5911-5-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 13 Nov 2018 15:48:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12, Roman Gushchin wrote:
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -83,7 +83,8 @@ struct task_group;
>  #define TASK_WAKING			0x0200
>  #define TASK_NOLOAD			0x0400
>  #define TASK_NEW			0x0800
> -#define TASK_STATE_MAX			0x1000
> +#define TASK_FROZEN			0x1000
> +#define TASK_STATE_MAX			0x2000

Just noticed the new task state... Why? Can't we avoid it?

...

> +void cgroup_freezer_enter(void)
> +{
> +	long state = current->state;

Why? it must be TASK_RUNNING?

If not set_current_state() at the end is simply wrong... Yes, __refrigerator()
does this, but at least it has a reason although it is wrong too.

> +	struct cgroup *cgrp;
> +
> +	if (!current->frozen) {
> +		spin_lock_irq(&css_set_lock);
> +		current->frozen = true;
> +		cgrp = task_dfl_cgroup(current);
> +		cgrp->freezer.nr_frozen_tasks++;
> +
> +		WARN_ON_ONCE(cgrp->freezer.nr_tasks_to_freeze <
> +			     cgrp->freezer.nr_frozen_tasks);
> +
> +		if (cgrp->freezer.nr_tasks_to_freeze ==
> +		    cgrp->freezer.nr_frozen_tasks)
> +			cgroup_queue_notify_frozen(cgrp);
> +		spin_unlock_irq(&css_set_lock);
> +	}
> +
> +	/* refrigerator */
> +	set_current_state(TASK_WAKEKILL | TASK_INTERRUPTIBLE | TASK_FROZEN);

Why not __set_current_state() ?

If ->state include TASK_INTERRUPTIBLE, why do we need TASK_WAKEKILL?

And again, why TASK_FROZEN?

> +	clear_thread_flag(TIF_SIGPENDING);
> +	schedule();
> +	recalc_sigpending();

I simply can't understand these 3 lines above but I bet this is not correct ;)

if nothing else recalc_sigpending() without ->siglock is wrong, it can race
with signal_wakeup/etc.

> +	set_current_state(state);

see above...

Oleg.

