Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF72C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041DB21902
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBTOmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:42:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfBTOmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:42:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1C4912E399;
        Wed, 20 Feb 2019 14:42:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 84E6960851;
        Wed, 20 Feb 2019 14:42:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 20 Feb 2019 15:42:04 +0100 (CET)
Date:   Wed, 20 Feb 2019 15:42:02 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v8 4/7] cgroup: cgroup v2 freezer
Message-ID: <20190220144202.GB9477@redhat.com>
References: <20190219220252.4906-1-guro@fb.com>
 <20190219220252.4906-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219220252.4906-5-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 20 Feb 2019 14:42:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19, Roman Gushchin wrote:
>
> @@ -2065,6 +2066,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
>  		preempt_disable();
>  		read_unlock(&tasklist_lock);
>  		preempt_enable_no_resched();
> +		cgroup_enter_stopped();
>  		freezable_schedule();
>  	} else {
>  		/*
> @@ -2243,6 +2245,7 @@ static bool do_signal_stop(int signr)
>  		}
>  
>  		/* Now we don't run again until woken by SIGCONT or SIGKILL */
> +		cgroup_enter_stopped();
>  		freezable_schedule();
>  		return true;

Please see my reply to 0/7.

> @@ -2280,7 +2286,8 @@ static void do_jobctl_trap(void)
>  		    !(signal->flags & SIGNAL_STOP_STOPPED))
>  			signr = SIGTRAP;
>  		WARN_ON_ONCE(!signr);
> -		ptrace_do_notify(signr, signr | (PTRACE_EVENT_STOP << 8),
> +		ptrace_do_notify(signr,
> +				 signr | (PTRACE_EVENT_STOP << 8),
>  				 CLD_STOPPED);

white-space cleanup?

> @@ -2363,7 +2419,8 @@ bool get_signal(struct ksignal *ksig)
>  	 * we should notify the parent, prepare_signal(SIGCONT) encodes
>  	 * the CLD_ si_code into SIGNAL_CLD_MASK bits.
>  	 */
> -	if (unlikely(signal->flags & SIGNAL_CLD_MASK)) {
> +	if (unlikely(signal->flags & SIGNAL_CLD_MASK) &
> +	    !(current->jobctl & JOBCTL_TRAP_FREEZE)) {

Hmm, why?

Oleg.

