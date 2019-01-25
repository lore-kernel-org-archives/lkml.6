Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D4AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B92C2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfAYM1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:27:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfAYM1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:27:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22B725F726;
        Fri, 25 Jan 2019 12:27:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id C27356EE22;
        Fri, 25 Jan 2019 12:27:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 25 Jan 2019 13:27:15 +0100 (CET)
Date:   Fri, 25 Jan 2019 13:27:13 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v6 4/7] cgroup: cgroup v2 freezer
Message-ID: <20190125122713.GA18218@redhat.com>
References: <20181222000307.28231-1-guro@fb.com>
 <20181222000307.28231-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222000307.28231-5-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 25 Jan 2019 12:27:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this version raced with my vacation, I missed it.

I'll try to read this code carefully but after a quick glance I have some
concerns,

On 12/21, Roman Gushchin wrote:
>
> +static void cgroup_update_frozen(struct cgroup *cgrp)
> +{
> +	bool frozen;
> +
> +	lockdep_assert_held(&css_set_lock);
> +
> +	/*
> +	 * If the cgroup has to be frozen (CGRP_FREEZE bit set),
> +	 * and all tasks are frozen or stopped, let's consider
> +	 * the cgroup frozen. Otherwise it's not frozen.
> +	 */
> +	frozen = test_bit(CGRP_FREEZE, &cgrp->flags) &&
> +		cgrp->freezer.nr_frozen_tasks +
> +		cgrp->freezer.nr_stopped_tasks ==
> +		cgrp->freezer.nr_tasks_to_freeze;

OK. Suppose that cgroup is frozen, CGRP_FROZEN is set, stopped == 0,
to_freeze = frozen.

One of the task is killed, it calls leave_frozen(). If I read this code path
correctly, only ->nr_frozen_tasks will be decremented, so "frozen" will be
"false" when cgroup_update_frozen() is called.

Doesn't this mean that this cgroup will no longer be CGRP_FROZEN even after
the killed task goes away completely?


Or. Suppose that another process picks a task from the CGRP_FROZEN cgroup and
does PTRACE_ATTACH + PTRACE_INTERRUPT. IIUC, the tracee will only increment
->nr_stopped_tasks, it won't touch other counters. Again, cgroup won't be FROZEN
until PTRACE_CONT'ed tracee does cgroup_leave_stopped() ? This looks strange at
least.



SIGSTOP. IIUC, a frozen task sleeping in do_freezer_trap() won't stop. However if
another thread has already called do_signal_stop(), the woken frozen task will
react to JOBCTL_STOP_PENDING and stop. And do_signal_stop()->cgroup_enter_stopped()
will "destroy" CGRP_FROZEN too, or I am totally confused.

OTOH, if you freeze a TASK_STOPPED task's cgroup, this task can react to SIGCONT,
notify its parent, then freeze again. This is fine, but iiuc this cgroup won't be
FROZEN in between, cgroup_file_notify() will be called twice...

Oleg.

