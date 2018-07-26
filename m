Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D2FC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF65920685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF65920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeGZO6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:58:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730881AbeGZO6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80644402332F;
        Thu, 26 Jul 2018 13:41:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 279FA10FFE54;
        Thu, 26 Jul 2018 13:41:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 26 Jul 2018 15:41:45 +0200 (CEST)
Date:   Thu, 26 Jul 2018 15:41:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Subject: Re: [PATCH v3 20/20] signal: Don't restart fork when signals come in.
Message-ID: <20180726134143.GB32718@redhat.com>
References: <20180724032419.20231-20-ebiederm@xmission.com>
 <CA+55aFxNijeenFd6o7fg3iJFqAjdTZLaFV2=Eaqbg1fDOzx26A@mail.gmail.com>
 <874lgo5xdg.fsf@xmission.com>
 <CA+55aFw_CTTRTZfUf1e9yg04X_djG3q7HrCG-XqnyQorpKjaTQ@mail.gmail.com>
 <87fu084cxj.fsf@xmission.com>
 <CA+55aFxUc3ttEAuRS7GKs9aTjTFw1poE80DASFSXudVQCuWpHg@mail.gmail.com>
 <87a7qg4bb3.fsf_-_@xmission.com>
 <CA+55aFxe+Ku78ZEvd_F2TD_3gTmLXw0kzo4HDE-ngkYfSHQfPw@mail.gmail.com>
 <87pnzc2upf.fsf@xmission.com>
 <87k1pk2cj9.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1pk2cj9.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 26 Jul 2018 13:41:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 26 Jul 2018 13:41:45 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24, Eric W. Biederman wrote:
>
> @@ -1979,6 +1983,8 @@ static __latent_entropy struct task_struct *copy_process(
>  			attach_pid(p, PIDTYPE_TGID);
>  			attach_pid(p, PIDTYPE_PGID);
>  			attach_pid(p, PIDTYPE_SID);
> +			p->signal->shared_pending.signal = delayed.signal;

Again, in this case we do not hold p->sighand->siglock (unless CLONE_SIGHAND),
so this should be done before list_add_tail/attach_pid above. Plus we need some
sort of barrier.

Or we can do

	if (!CLONE_SIGHAND)
		spin_lock_nested(child->siglock);

at the start of "if (likely(p->pid))" block.

> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1123,6 +1123,15 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
>  out_set:
>  	signalfd_notify(t, sig);
>  	sigaddset(&pending->signal, sig);
> +
> +	/* Let multiprocess signals appear after on-going forks */
> +	if (type > PIDTYPE_TGID) {
> +		struct multiprocess_signals *delayed;
> +		hlist_for_each_entry(delayed, &t->signal->multiprocess, node) {
> +			sigaddset(&delayed->signal, sig);

This is not enough, I think...

Suppose you send SIGSTOP and then SIGCONT to some process group. The 1st SIGSTOP
will be queued correctly, but the 2nd SIGCONT won't flush the pending SIGSTOP, you
need to modify prepare_signal() too.

Oleg.

