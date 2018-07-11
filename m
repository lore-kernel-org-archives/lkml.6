Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3411C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC4A208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC4A208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbeGKOTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:19:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726639AbeGKOTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:19:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D55E980D2F6B;
        Wed, 11 Jul 2018 14:14:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 482792026D6B;
        Wed, 11 Jul 2018 14:14:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 11 Jul 2018 16:14:58 +0200 (CEST)
Date:   Wed, 11 Jul 2018 16:14:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
Subject: Re: [RFC][PATCH 11/11] signal: Ignore all but multi-process signals
 that come in during fork.
Message-ID: <20180711141456.GA6636@redhat.com>
References: <877em2jxyr.fsf_-_@xmission.com>
 <20180711024459.10654-11-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711024459.10654-11-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 11 Jul 2018 14:14:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 11 Jul 2018 14:14:58 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Eric W. Biederman wrote:
>
> @@ -1602,6 +1603,20 @@ static __latent_entropy struct task_struct *copy_process(
>  {
>  	int retval;
>  	struct task_struct *p;
> +	unsigned seq;
> +
> +	/*
> +	 * Signals that are delivered to multiple processes need to be
> +	 * delivered to just the parent before the fork or both the
> +	 * parent and the child after the fork.  Cache the multiple
> +	 * process signal sequence number so we can detect any of
> +	 * these signals that happen during the fork.  In the unlikely
> +	 * event a signal comes in while fork is starting and restart
> +	 * fork to handle the signal.
> +	 */
> +	seq = read_seqcount_begin(&current->signal->multi_process_seq);
> +	if (signal_pending(current))
> +		return ERR_PTR(-ERESTARTNOINTR);
>
>  	/*
>  	 * Don't allow sharing the root directory with processes in a different
> @@ -1930,8 +1945,8 @@ static __latent_entropy struct task_struct *copy_process(
>  	 * A fatal signal pending means that current will exit, so the new
>  	 * thread can't slip out of an OOM kill (or normal SIGKILL).
>  	*/
> -	recalc_sigpending();
> -	if (signal_pending(current)) {
> +	if (read_seqcount_retry(&current->signal->multi_process_seq, seq) ||
> +	    fatal_signal_pending(current)) {
>  		retval = -ERESTARTNOINTR;
>  		goto bad_fork_cancel_cgroup;

So once again, I think this is not right, see the discussion on bugzilla.

If signal_pending() == T we simply can't know if copy_process() can succeed or not.
I have already mentioned the races with stop/freeze, but I think there are more.

And in fact I think that the fact that signal_wake_up() helps to avoid the races
with fork() is useful. Say, we could add signal_wake_up() into syscall_regfunc()
and kill syscall_tracepoint_update(). Not that I think this particular change makes
any sense, but it can work.



That is why I tried to sugest another approach. copy_process() should always fail
if signal_pending() == T, just the "real" signal should not disturb the forking
thread unless the signal is fatal or multi-process.

This also makes another difference in multi-threaded case, a signal with a handler
sent to a forking process will be re-targeted to another thread which can handle it;
with your patch this signal will be "blocked" until fork() finishes or until another
thread gets TIF_SIGPENDING. Not that I think this is that important, but still.

Oleg.

