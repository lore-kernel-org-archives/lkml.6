Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E9AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64062526C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bjc7ZAqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64062526C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeGBMPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:15:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbeGBMPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jTzLrRXUUpW5WwBJpgHaPgLzEHZBYgG9Nuosma0Z02w=; b=Bjc7ZAqmro6J6X9gkEAQztMu0
        ppnzBBdKYyhE2kc/WRfnhyBAI3+JJLIC9L/p6rTDObk/Gorf3uhJ3ivPQbTMLOXekDpWdnCmx5Rt5
        kLl54MDHnD9nseobU9iTGu0A1ykA/2y2fCEjdy3iLOrdgleaoWIsaPwTRIugtD+oCI7btWrow0jar
        y8vnoDVchkuPLQDKd8lP6eHxxb3zkJ1Yvx2Xl/PZ7uLsmck3f2bLqvdQTYoIXnbTgtKXDiID66PHy
        uvKgfu7WwOexZJB/RIm3AdiNwNbeRZoY+wxo3kOfe/d+/qQk1sCM24PR7pCGOreuh7bwBP1sybJPX
        YjyfhAprA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZxjT-000622-B8; Mon, 02 Jul 2018 12:15:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E1E32029F1D9; Mon,  2 Jul 2018 14:15:00 +0200 (CEST)
Date:   Mon, 2 Jul 2018 14:15:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     matt@codeblueprint.co.uk, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, pkondeti@codeaurora.org
Subject: Re: [PATCH v2] stop_machine: Disable preemption when waking two
 stopper threads
Message-ID: <20180702121500.GK2494@hirez.programming.kicks-ass.net>
References: <1530305712-16416-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530305712-16416-1-git-send-email-isaacm@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:55:12PM -0700, Isaac J. Manjarres wrote:
> When cpu_stop_queue_two_works() begins to wake the stopper
> threads, it does so without preemption disabled, which leads
> to the following race condition:
> 
> The source CPU calls cpu_stop_queue_two_works(), with cpu1
> as the source CPU, and cpu2 as the destination CPU. When
> adding the stopper threads to the wake queue used in this
> function, the source CPU stopper thread is added first,
> and the destination CPU stopper thread is added last.
> 
> When wake_up_q() is invoked to wake the stopper threads, the
> threads are woken up in the order that they are queued in,
> so the source CPU's stopper thread is woken up first, and
> it preempts the thread running on the source CPU.
> 
> The stopper thread will then execute on the source CPU,
> disable preemption, and begin executing multi_cpu_stop(),
> and wait for an ack from the destination CPU's stopper thread,
> with preemption still disabled. Since the worker thread that
> woke up the stopper thread on the source CPU is affine to the
> source CPU, and preemption is disabled on the source CPU, that
> thread will never run to dequeue the destination CPU's stopper
> thread from the wake queue, and thus, the destination CPU's
> stopper thread will never run, causing the source CPU's stopper
> thread to wait forever, and stall.
> 
> Disable preemption when waking the stopper threads in
> cpu_stop_queue_two_works() to ensure that the worker thread
> that is waking up the stopper threads isn't preempted
> by the source CPU's stopper thread, and permanently
> scheduled out, leaving the remaining stopper thread asleep
> in the wake queue.
> 
> Co-developed-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>

That SoB chain is broken, if Prasad wrote the ptch then there needs to
be a From: line somewhere.

But yes, that looks about right.

> ---
>  kernel/stop_machine.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index f89014a..1ff523d 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -270,7 +270,11 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
>  		goto retry;
>  	}
>  
> -	wake_up_q(&wakeq);
> +	if (!err) {
> +		preempt_disable();
> +		wake_up_q(&wakeq);
> +		preempt_enable();
> +	}
>  
>  	return err;
>  }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
