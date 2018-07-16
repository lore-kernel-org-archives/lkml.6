Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AA7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7719A20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7719A20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeGPNTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:19:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728687AbeGPNTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:19:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F412240770CC;
        Mon, 16 Jul 2018 12:51:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 207E0111CD4C;
        Mon, 16 Jul 2018 12:51:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 16 Jul 2018 14:51:47 +0200 (CEST)
Date:   Mon, 16 Jul 2018 14:51:45 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
Subject: Re: [RFC][PATCH 07/11] signal: Deliver group signals via
 PIDTYPE_TGID not PIDTYPE_PID
Message-ID: <20180716125144.GA18262@redhat.com>
References: <877em2jxyr.fsf_-_@xmission.com>
 <20180711024459.10654-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711024459.10654-7-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 16 Jul 2018 12:51:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 16 Jul 2018 12:51:48 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Eric W. Biederman wrote:
>
> Now that we can make the distinction use PIDTYPE_TGID rather than
> PIDTYPE_PID.

Wai, wait, this doesn't look right...

> There is no immediate effect as they point point at the
> same task,

How so? pid_task(pid, PIDTYPE_TGID) will return NULL unless this pid is actually
a group leader's pid,

> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1315,7 +1315,7 @@ int kill_pid_info(int sig, struct siginfo *info, struct pid *pid)
>
>  	for (;;) {
>  		rcu_read_lock();
> -		p = pid_task(pid, PIDTYPE_PID);
> +		p = pid_task(pid, PIDTYPE_TGID);
>  		if (p)
>  			error = group_send_sig_info(sig, info, p);

So, currently kill(pid_nr) always works, even if pid_nr is a sub-thread's tid.

After this change kill(2) will always fail with -ESRCH in this case.

Or I am totally confused?

> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -347,12 +347,11 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
>  	 */
>  	timr->sigq->info.si_sys_private = si_private;
>  
> +	shared = !(timr->it_sigev_notify & SIGEV_THREAD_ID);
>  	rcu_read_lock();
> -	task = pid_task(timr->it_pid, PIDTYPE_PID);
> -	if (task) {
> -		shared = !(timr->it_sigev_notify & SIGEV_THREAD_ID);
> +	task = pid_task(timr->it_pid, shared ? PIDTYPE_TGID : PIDTYPE_PID);

This looks fine, afaics without SIGEV_THREAD_ID ->it_pid is alwats task_tgid().

Oleg.

