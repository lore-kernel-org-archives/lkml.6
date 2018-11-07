Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C34C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E532085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E532085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbeKHA1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeKHA1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:27:11 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F000C2086C;
        Wed,  7 Nov 2018 14:56:28 +0000 (UTC)
Date:   Wed, 7 Nov 2018 09:56:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, bristot@redhat.com,
        linux-rt-users@vger.kernel.org, mtk.manpages@gmail.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] kernel/time/posix-cpu-timers: Remove useless call to
 check_dl_overrun
Message-ID: <20181107095627.13e9c187@gandalf.local.home>
In-Reply-To: <20181107111032.32291-1-juri.lelli@redhat.com>
References: <20181107111032.32291-1-juri.lelli@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 12:10:32 +0100
Juri Lelli <juri.lelli@redhat.com> wrote:

> check_dl_overrun is used to send a SIGXCPU to users that asked to be
> informed when SCHED_DEADLINE runtime overruns occur.
> 
> The function is called by check_thread_timers already, so the call in
> check_process_timers is redundant/wrong (even though harmless).
> 
> Remove it.
> 
> Fixes: 34be39305a77 ("sched/deadline: Implement "runtime overrun signal" support")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Claudio Scordino <claudio@evidence.eu.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  kernel/time/posix-cpu-timers.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index ce32cf741b25..8f0644af40be 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -917,9 +917,6 @@ static void check_process_timers(struct task_struct *tsk,
>  	struct task_cputime cputime;
>  	unsigned long soft;
>  
> -	if (dl_task(tsk))
> -		check_dl_overrun(tsk);
> -

Hmm, I wonder if we should just move this check directly into
run_posix_cpu_timers() directly. Why is it hidden in this call?

-- Steve


>  	/*
>  	 * If cputimer is not running, then there are no active
>  	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).

