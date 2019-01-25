Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4675C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895B32087E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfAYNnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:43:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAYNnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:43:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29A34C7A15;
        Fri, 25 Jan 2019 13:43:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id C699F61520;
        Fri, 25 Jan 2019 13:43:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 25 Jan 2019 14:43:38 +0100 (CET)
Date:   Fri, 25 Jan 2019 14:43:36 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v6 4/7] cgroup: cgroup v2 freezer
Message-ID: <20190125134336.GA18991@redhat.com>
References: <20181222000307.28231-1-guro@fb.com>
 <20181222000307.28231-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222000307.28231-5-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 25 Jan 2019 13:43:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21, Roman Gushchin wrote:
>
> +static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze)
> +{
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +
> +	lockdep_assert_held(&cgroup_mutex);
> +
> +	spin_lock_irq(&css_set_lock);
> +	if (freeze) {
> +		cgrp->freezer.nr_tasks_to_freeze = __cgroup_task_count(cgrp);
> +		set_bit(CGRP_FREEZE, &cgrp->flags);
> +	} else {
> +		clear_bit(CGRP_FREEZE, &cgrp->flags);
> +	}
> +	spin_unlock_irq(&css_set_lock);
> +
> +	css_task_iter_start(&cgrp->self, 0, &it);
> +	while ((task = css_task_iter_next(&it))) {
> +		/*
> +		 * Ignore kernel threads here. Freezing cgroups containing
> +		 * kthreads isn't supported.
> +		 */
> +		if (task->flags & PF_KTHREAD)
> +			continue;
> +		cgroup_freeze_task(task, freeze);
> +	}
> +	css_task_iter_end(&it);

I don't understand why this can race with exiting task. Or with SIGKILL which
kills a task before it sets current->frozen.

How can we trust nr_tasks_to_freeze at all?

Yes you added cgroup_dec_tasks_to_freeze() into cgroup_exit(). But it won't be
called if CGRP_FROZEN was not set yet, or because of "spurious" transitions
caused by cgroup_inc/dec_frozen_cnt() called by this or other tasks.

it seems that cgroup_exit() should check CGRP_FREEZE instead...

Oleg.

