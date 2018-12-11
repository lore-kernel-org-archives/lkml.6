Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1231C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A72C2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A72C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeLKQ0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:26:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbeLKQ0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:26:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D91B7308FB8B;
        Tue, 11 Dec 2018 16:26:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.131])
        by smtp.corp.redhat.com (Postfix) with SMTP id F2B3D600D6;
        Tue, 11 Dec 2018 16:26:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 11 Dec 2018 17:26:35 +0100 (CET)
Date:   Tue, 11 Dec 2018 17:26:32 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v5 4/7] cgroup: cgroup v2 freezer
Message-ID: <20181211162632.GB8504@redhat.com>
References: <20181207201531.1665-1-guro@fb.com>
 <20181207201531.1665-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207201531.1665-5-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 11 Dec 2018 16:26:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07, Roman Gushchin wrote:
>
> Cgroup v2 freezer tries to put tasks into a state similar to jobctl
> stop. This means that tasks can be killed, ptraced (using
> PTRACE_SEIZE*), and interrupted. It is possible to attach to
> a frozen task, get some information (e.g. read registers) and detach.

I fail to understand how this all supposed to work.

> @@ -368,6 +369,8 @@ static inline int signal_pending_state(long state, struct task_struct *p)
>  		return 0;
>  	if (!signal_pending(p))
>  		return 0;
> +	if (unlikely(cgroup_task_frozen(p) && p->jobctl == JOBCTL_TRAP_FREEZE))
> +		return __fatal_signal_pending(p);

I think I will never agree with this change ;) and I don't think it actually helps.

> +void cgroup_enter_frozen(void)
> +{
> +	if (!current->frozen) {
> +		spin_lock_irq(&css_set_lock);
> +		current->frozen = true;
> +		cgroup_inc_frozen_cnt(task_dfl_cgroup(current), false, true);
> +		spin_unlock_irq(&css_set_lock);
> +	}
> +
> +	__set_current_state(TASK_INTERRUPTIBLE);
> +	schedule();

So once again, suppose it races with PTRACE_INTERRUPT, or SIGSTOP, or something
else which should be handled by get_signal() before do_freezer_trap().

If (say) PTRACE_INTERRUPT comes before schedule it will be lost. Otherwise
the frozen task will react. This can't be right. Or I am totally confused.

Perhaps you can split this patch? start with cgroup_enter_frozen() using
TASK_KILLABLE, then teach it to handle ptrace/stop/etc? I think this way it
would be simpler to discuss the necessary changes and document what exactly
are you trying to do.

and btw.... what about suspend? try_to_freeze_tasks() will obviously fail
if there is a ->frozen thread?

Oleg.

