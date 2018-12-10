Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6A8C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A247820855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A247820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeLJOT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:19:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54924 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727396AbeLJOT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:19:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB69C1596;
        Mon, 10 Dec 2018 06:19:56 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18FB33F575;
        Mon, 10 Dec 2018 06:19:54 -0800 (PST)
Subject: Re: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep
 warning
To:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mark.rutland@arm.com,
        marc.zyngier@arm.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, mingo@kernel.org, longman@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
 <20181210135228.49751-1-cai@lca.pw>
 <20181210140703.GM5289@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9303a6cf-24af-2f31-9fbd-8c1ecdd5e4f4@arm.com>
Date:   Mon, 10 Dec 2018 14:19:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210140703.GM5289@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/2018 14:07, Peter Zijlstra wrote:
[...]
> ---
>  kernel/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 91d5c38eb7e5..e1ee8caf28b5 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -313,6 +313,8 @@ void cpus_write_unlock(void)
>  
>  void lockdep_assert_cpus_held(void)
>  {
> +	if (system_state < SYSTEM_RUNNING)
> +		return;
>  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
>  }
>  

Kinda hijacking the thread here - is that something we'd want to replace 

    40fa3780bac2 ("sched/core: Take the hotplug lock in sched_init_smp()")

with?
 
