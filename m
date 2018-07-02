Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B85C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AE62550D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iZSQkKbK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XRjRS9M7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AE62550D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeGBEfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 00:35:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57688 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeGBEfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 00:35:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 38C9F601CF; Mon,  2 Jul 2018 04:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530506122;
        bh=Ezbyat8gPD6MPFZZhoNzZYdeMwnYW77nEBk22fHtDp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZSQkKbKc3Lpmxj/IgQKj04q4UWCyNYkJivX5Bmp7fOHSukjWQnDqiEBNwTqbHHQ6
         BzKBVs3MoFTyJYtVN1oP3YUEldv8U6yOizWTqS5JBmXL54X6CRldWAU/Lok/VbJD+O
         JTqK0NaXHhRZbnjgAXC5ogvN41qe0/jHqdRYn4XU=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E86B0601CF;
        Mon,  2 Jul 2018 04:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530506121;
        bh=Ezbyat8gPD6MPFZZhoNzZYdeMwnYW77nEBk22fHtDp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRjRS9M77k8Tme9XgngCvcp4HpEAdnRRAfFyrX70cVTw/0p23/0YW5cJ6w3P9iVGG
         H/zNdwI439Mbfmx4835GrMr6yRYpact8cwo27vI/ONh9uYFGJGhbMsywMWxuBP4OKn
         kxjJNhcfQ/kZNStgJcejZbfjlrDQ1Yf99SniUHpo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E86B0601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 2 Jul 2018 10:05:15 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     peterz@infradead.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        tglx@linutronix.de, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org
Subject: Re: [PATCH v2] stop_machine: Disable preemption when waking two
 stopper threads
Message-ID: <20180702043515.GH9208@codeaurora.org>
References: <1530305712-16416-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530305712-16416-1-git-send-email-isaacm@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Issac,

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
> ---

You might want to add the below Fixes tag and CC stable.

Fixes: 0b26351b910f ("stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock")

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

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

