Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C47C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74039218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551217710;
	bh=teDK3tEvoTh9HeZppUpPFYOSwBG9kyz3MGwJkFRWzok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tUHlAxJIB+VRE1VfeI4XjzHIhaTkKwETJv7s9l5D5LCPNuCTiwBStV2Y3NOOqt9AB
	 qHQRFIyFkZ+zDfOMtN0zYCxMwWJlFpBHWE88Ix7mrYz6h07Gib47iprzLR+aqLqEGy
	 UHp6Qfm1RHseKtqE7xJNLXGgK3oL9ed/wOyb6lKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfBZVs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:48:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZVs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:48:28 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A428B7921;
        Tue, 26 Feb 2019 21:48:26 +0000 (UTC)
Date:   Tue, 26 Feb 2019 13:48:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/hung_task.c: Use continuously blocked time when
 reporting.
Message-Id: <20190226134825.a8be172f694eafb7b7f94695@linux-foundation.org>
In-Reply-To: <1551175083-10669-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1551175083-10669-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 18:58:03 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Since commit a2e514453861dd39 ("kernel/hung_task.c: allow to set checking
> interval separately from timeout") added hung_task_check_interval_secs,
> setting a value different from hung_task_timeout_secs
> 
>   echo 0 > /proc/sys/kernel/hung_task_panic
>   echo 120 > /proc/sys/kernel/hung_task_timeout_secs
>   echo 5 > /proc/sys/kernel/hung_task_check_interval_secs
> 
> causes confusing output as if the task was blocked for
> hung_task_timeout_secs seconds from the previous report.
> 
>   [  399.395930] INFO: task kswapd0:75 blocked for more than 120 seconds.
>   [  405.027637] INFO: task kswapd0:75 blocked for more than 120 seconds.
>   [  410.659725] INFO: task kswapd0:75 blocked for more than 120 seconds.
>   [  416.292860] INFO: task kswapd0:75 blocked for more than 120 seconds.
>   [  421.932305] INFO: task kswapd0:75 blocked for more than 120 seconds.
> 
> Although we could update t->last_switch_time after sched_show_task(t) if
> we want to report only every 120 seconds, reporting every 5 seconds might
> not be very bad for monitoring after a problematic situation has started.
> Thus, let's use continuously blocked time instead of updating previously
> reported time.
> 
>   [  677.985011] INFO: task kswapd0:80 blocked for more than 122 seconds.
>   [  693.856126] INFO: task kswapd0:80 blocked for more than 138 seconds.
>   [  709.728075] INFO: task kswapd0:80 blocked for more than 154 seconds.
>   [  725.600018] INFO: task kswapd0:80 blocked for more than 170 seconds.
>   [  741.473133] INFO: task kswapd0:80 blocked for more than 186 seconds.

hm, maybe.

The user asked for a report if a task was blocked for more than 120
seconds, so the kernel is accurately reporting that this happened.  The
actual blockage time is presumably useful information, but that's a
different thing.

We could report both:

"blocked for 122 seconds which is more than 120 seconds"

But on the other hand, what is the point in telling the user how they
configured their own kernel?

I think I'll stop arguing with myself and apply the patch ;)
