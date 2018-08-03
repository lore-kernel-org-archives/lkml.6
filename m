Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8FBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6220621759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6220621759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeHCNhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:37:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39634 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeHCNhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:37:16 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flYSH-0007Gp-Ok; Fri, 03 Aug 2018 13:41:13 +0200
Date:   Fri, 3 Aug 2018 13:41:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Sodagudi Prasad <psodagud@codeaurora.org>, mingo@kernel.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        isaacm@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: cpu stopper threads and setaffinity leads to deadlock
In-Reply-To: <20180802094908.GK2494@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1808031340500.1745@nanos.tec.linutronix.de>
References: <24eebe1d874cb8e3b9a18087554544fa@codeaurora.org> <20180802094908.GK2494@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prasad.

On Thu, 2 Aug 2018, Peter Zijlstra wrote:
> 
> So why didn't you do the 'obvious' parallel to what you did for
> cpu_stop_queue_two_works(), namely:

Is that patch fixing the issue for you?

> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -81,6 +81,7 @@ static bool cpu_stop_queue_work(unsigned
>  	unsigned long flags;
>  	bool enabled;
>  
> +	preempt_disable();
>  	raw_spin_lock_irqsave(&stopper->lock, flags);
>  	enabled = stopper->enabled;
>  	if (enabled)
> @@ -90,6 +91,7 @@ static bool cpu_stop_queue_work(unsigned
>  	raw_spin_unlock_irqrestore(&stopper->lock, flags);
>  
>  	wake_up_q(&wakeq);
> +	preempt_enable();
>  
>  	return enabled;
>  }
> 
