Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CEFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1235520870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfBAK16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:27:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57582 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfBAK16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:27:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60DB415BE;
        Fri,  1 Feb 2019 02:27:57 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C15D3F71E;
        Fri,  1 Feb 2019 02:27:56 -0800 (PST)
Subject: Re: [RFC PATCH 3/3] sched/Documentation: Point out use of
 preempt_schedule_irq()
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org
References: <20190131182339.9835-1-valentin.schneider@arm.com>
 <20190131182339.9835-4-valentin.schneider@arm.com>
 <cd1b1ea6-7b5f-0468-1512-eaabba77a98a@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <53775bec-67cf-3b5e-796f-0a09993d1628@arm.com>
Date:   Fri, 1 Feb 2019 10:27:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cd1b1ea6-7b5f-0468-1512-eaabba77a98a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2019 08:45, Julien Thierry wrote:
[...]
>> +Kernel preemption
>> +=================
>> +When returning from interrupt context, you should call either of
>> +preempt_schedule() or preempt_schedule_irq() if preemption is enabled
>> +and need_resched() is true.
>> +
> 
> I don't think preempt_schedule() is really an option for a return from
> interrupt. First thing preempt_schedule() does is:
> 
>         if (likely(!preemptible()))
> 		return;
> 
> And preemptible() is:
> 
> preempt_count() == 0 && !irqs_disabled()
> 
> Generally on return from interrupt context interrupts are disabled, so
> we would never be preemptible() and preempt_schedule() would just do
> nothing.
> 
> Unless I'm missing something.
> 

No, I think you're right. The main reason I still mentioned it here is to
be conservative, although I must admit I've started confusing what we
have vs what we used to have since my dive into the history.

If I look at some archs that don't use preempt_schedule_irq() (e.g. alpha,
unicore32), they seem to be calling schedule() directly - but I don't see
any (*current*) user of preempt_schedule() on interrupt return.

preempt_schedule() still has this comment attached to it:

 * this is the entry point to schedule() from in-kernel preemption
 * off of preempt_enable. Kernel preemptions off return from interrupt
 * occur there and call schedule directly.

So I might just remove the mention to preempt_schedule() in the doc and
also change the comment.

Thanks,
Valentin
