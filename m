Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA04C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78B42083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78B42083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbeGZOho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:37:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729410AbeGZOho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:37:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1043879C4;
        Thu, 26 Jul 2018 13:20:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6F6FD1C5B0;
        Thu, 26 Jul 2018 13:20:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 26 Jul 2018 15:20:52 +0200 (CEST)
Date:   Thu, 26 Jul 2018 15:20:50 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
Subject: Re: [PATCH 18/20] signal: Add calculate_sigpending()
Message-ID: <20180726132050.GA32718@redhat.com>
References: <87efft5ncd.fsf_-_@xmission.com>
 <20180724032419.20231-18-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724032419.20231-18-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 26 Jul 2018 13:20:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 26 Jul 2018 13:20:53 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23, Eric W. Biederman wrote:
>
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1988,6 +1988,7 @@ static __latent_entropy struct task_struct *copy_process(
>  					  &p->signal->thread_head);
>  		}
>  		attach_pid(p, PIDTYPE_PID);
> +		calculate_sigpending(p);

In theory this looks racy if !CLONE_SIGHAND, please see below

> +void calculate_sigpending(struct task_struct *new)
> +{
> +	/* Have any signals or users of TIF_SIGPENDING been delayed
> +	 * until after fork?
> +	 */
> +	bool pending = (new->jobctl & JOBCTL_PENDING_MASK) ||
> +		PENDING(&new->pending, &new->blocked) ||
> +		PENDING(&new->signal->shared_pending, &new->blocked) ||
> +		freezing(new) || klp_patch_pending(new);

note that we do not hold new->sighand->siglock, but this "new" task is already
visible to find_task_by_vpid/etc; so a new signal can come right after this check,

> +	update_tsk_thread_flag(new, TIF_SIGPENDING, pending);

and then update_tsk_thread_flag() can wrongly clear TIF_SIGPENDING.

Easy to fix, but perhaps we can simply add recalc_sigpending() into
schedule_tail() ? It already does more than just finish_task_switch/etc.

This way we do not need the new helper (which btw can only be used by
copy_process).


Note also that either way you can remove set_tsk_thread_flag(TIF_SIGPENDING)
from ptrace_init_task().

Oleg.

