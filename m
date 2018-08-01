Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDFAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680B1208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680B1208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389377AbeHAPFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389216AbeHAPFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:05:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8516720844;
        Wed,  1 Aug 2018 13:19:45 +0000 (UTC)
Date:   Wed, 1 Aug 2018 09:19:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT] sched: drop is_special_task_state() check from
 __set_current_state_no_track()
Message-ID: <20180801091942.46292953@gandalf.local.home>
In-Reply-To: <20180801090524.7hmzfdx7r4bivekq@linutronix.de>
References: <20180801090524.7hmzfdx7r4bivekq@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018 11:05:25 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The is_special_task_state() check in __set_current_state_no_track()
> has been wrongly placed. __set_current_state_no_track() is used in RT
> while a sleeping lock is acquired. It is used at the begin of the wait
> loop with TASK_UNINTERRUPTIBLE and while leaving it and restoring the
> original state. The latter part triggers the warning.
> 
> Drop the special state check. This is only used within the sleeping lock
> implementation and the assignment happens while the PI lock is held.
> While at it, drop set_current_state_no_track() because it has no users.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/sched.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a0c1c0cae992..b20264e17b02 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -132,16 +132,9 @@ struct task_group;
>  
>  #define __set_current_state_no_track(state_value)		\
>  	do {							\
> -		WARN_ON_ONCE(is_special_task_state(state_value));\
>  		current->state = (state_value);			\
>  	} while (0)

I don't think we need to keep the do { } while with a single line. It
is now equivalent to the non-debug version of __set_current_state()
which is defined as:

#define __set_current_state(state_value)				\
	current->state = (state_value)

-- Steve

>  
> -#define set_current_state_no_track(state_value)			\
> -	do {							\
> -		WARN_ON_ONCE(is_special_task_state(state_value));\
> -		smp_store_mb(current->state, (state_value));	\
> -	} while (0)
> -
>  #define set_special_state(state_value)					\
>  	do {								\
>  		unsigned long flags; /* may shadow */			\
> @@ -196,7 +189,6 @@ struct task_group;
>  	smp_store_mb(current->state, (state_value))
>  
>  #define __set_current_state_no_track(state_value)	__set_current_state(state_value)
> -#define set_current_state_no_track(state_value)		set_current_state(state_value)
>  
>  /*
>   * set_special_state() should be used for those states when the blocking task

