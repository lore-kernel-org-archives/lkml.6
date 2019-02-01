Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92433C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE6E21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfBAIpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:45:39 -0500
Received: from foss.arm.com ([217.140.101.70]:56060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbfBAIpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:45:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50F9BA78;
        Fri,  1 Feb 2019 00:45:35 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3986E3F71E;
        Fri,  1 Feb 2019 00:45:33 -0800 (PST)
Subject: Re: [RFC PATCH 3/3] sched/Documentation: Point out use of
 preempt_schedule_irq()
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org
References: <20190131182339.9835-1-valentin.schneider@arm.com>
 <20190131182339.9835-4-valentin.schneider@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <cd1b1ea6-7b5f-0468-1512-eaabba77a98a@arm.com>
Date:   Fri, 1 Feb 2019 08:45:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190131182339.9835-4-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 31/01/2019 18:23, Valentin Schneider wrote:
> Since there are a few archs out there that call preempt_schedule_irq()
> within a need_resched() loop, point out that it's not needed.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/scheduler/sched-arch.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-arch.txt b/Documentation/scheduler/sched-arch.txt
> index a2f27bbf2cba..ae41a94da700 100644
> --- a/Documentation/scheduler/sched-arch.txt
> +++ b/Documentation/scheduler/sched-arch.txt
> @@ -59,6 +59,16 @@ Your cpu_idle routines need to obey the following rules:
>  arch/x86/kernel/process.c has examples of both polling and
>  sleeping idle functions.
>  
> +Kernel preemption
> +=================
> +When returning from interrupt context, you should call either of
> +preempt_schedule() or preempt_schedule_irq() if preemption is enabled
> +and need_resched() is true.
> +

I don't think preempt_schedule() is really an option for a return from
interrupt. First thing preempt_schedule() does is:

        if (likely(!preemptible()))
		return;

And preemptible() is:

preempt_count() == 0 && !irqs_disabled()

Generally on return from interrupt context interrupts are disabled, so
we would never be preemptible() and preempt_schedule() would just do
nothing.

Unless I'm missing something.

Cheers,

-- 
Julien Thierry
