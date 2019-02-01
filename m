Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BC5C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8188520855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfBAPH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:07:59 -0500
Received: from foss.arm.com ([217.140.101.70]:33084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbfBAPH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:07:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF41080D;
        Fri,  1 Feb 2019 07:07:57 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90E1C3F589;
        Fri,  1 Feb 2019 07:07:55 -0800 (PST)
Subject: Re: [PATCH v4 00/10] steal tasks to improve CPU utilization
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Steve Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <e9ba0a93-4799-c230-8dcb-6580f6c00635@arm.com>
Message-ID: <a005fd39-a8f5-439a-0e16-3227000b8a02@arm.com>
Date:   Fri, 1 Feb 2019 15:07:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e9ba0a93-4799-c230-8dcb-6580f6c00635@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 20:30, Valentin Schneider wrote:
[...]
> ----->8-----
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 17ab4db..8b5172f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7152,7 +7152,8 @@ done: __maybe_unused;
>         rq_idle_stamp_update(rq);
>  
>         new_tasks = idle_balance(rq, rf);
> -       if (new_tasks == 0)
> +       if (new_tasks == 0 &&
> +           (!static_key_unlikely(&sched_energy_present) || READ_ONCE(rq->rd->overutilized))
>                 new_tasks = try_steal(rq, rf);
>  
>         if (new_tasks)
> -----8<-----
> 

As a heads-up, that should now use sched_energy_enabled() [1], so that'd be:

-----8<-----
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f28df187db24..2eddb40fd368 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7134,7 +7134,8 @@ done: __maybe_unused;
        rq_idle_stamp_update(rq);
 
        new_tasks = idle_balance(rq, rf);
-       if (new_tasks == 0)
+       if (new_tasks == 0 &&
+           (!sched_energy_enabled() || READ_ONCE(rq->rd->overutilized)))
                new_tasks = try_steal(rq, rf);
 
        if (new_tasks)
----->8-----

[1]: f8a696f25ba0 ("sched/core: Give DCE a fighting chance")

[...]
