Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E1CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B622083E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B622083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbeKOWvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:51:25 -0500
Received: from ozlabs.org ([203.11.71.1]:32791 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388138AbeKOWvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:51:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42wgyg73pyz9s3x;
        Thu, 15 Nov 2018 23:43:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     benh@kernel.crashing.org, paulus@samba.org, ebiederm@xmission.com,
        muriloo@linux.ibm.com, christophe.leroy@c-s.fr, npiggin@gmail.com,
        leitao@debian.org, aneesh.kumar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] Powerpc/perf: Wire up PMI throttling
In-Reply-To: <20181114141425.1892-1-ravi.bangoria@linux.ibm.com>
References: <20181114141425.1892-1-ravi.bangoria@linux.ibm.com>
Date:   Thu, 15 Nov 2018 23:43:39 +1100
Message-ID: <8736s2v7d0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:

> Commit 14c63f17b1fde ("perf: Drop sample rate when sampling is too
> slow") introduced a way to throttle PMU interrupts if we're spending
> too much time just processing those. Wire up powerpc PMI handler to
> use this infrastructure.

To be clear we have throttling of the *rate* of interrupts, but this
adds throttling based on the *time taken* to process the interrupts. Or
at least that's my understanding?

> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 9a86572db1ef..44f85fa22356 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -18,6 +18,7 @@
>  #include <linux/errno.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
> +#include <linux/sched/clock.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/pkeys.h>
> @@ -1803,9 +1804,12 @@ void vsx_unavailable_tm(struct pt_regs *regs)
>  
>  void performance_monitor_exception(struct pt_regs *regs)
>  {
> +	u64 start_clock;
>  	__this_cpu_inc(irq_stat.pmu_irqs);
>  
> +	start_clock = sched_clock();
>  	perf_irq(regs);
> +	perf_sample_event_took(sched_clock() - start_clock);
>  }

Despite the name, perf_irq() may not actually be the perf IRQ handler :)

It's a function pointer which might call perf or might call oprofile, or
a dummy handler.

I don't think we should be calling perf_sample_event_took() if we're not
actually using perf, that is wasteful at best.

So the timing logic should go in the perf specific handler I think.
ie. perf_event_interrupt().

cheers
