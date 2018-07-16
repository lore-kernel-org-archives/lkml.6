Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F20ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456AC20989
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456AC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeGPKEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:04:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46110 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbeGPKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:04:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id s11-v6so31142772wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vwxOm1s+BrsjF189Vp9AYKDSlRCTryl7efaOffN/fYo=;
        b=DSKmS2Grl77zT3aIkXkNbT1S1Z62PdZ7t4/XYomSq5h+Ren/GMgIQvxYE1ocTp4zVJ
         JPuwbTboQmLrkjfwlhv8r0B8nNZ8csrqOcoJIlsMpIzHsiDf0h6jnnw9qOE8dwWOS7Wm
         a353EM7YEsuSgxXAocSFgNBwxAGcFeKKWOlTGA6xRmety+S1KSu4YLDJIVB47mji6SqW
         RHw8b5WASmBqbWjG3uo76RMASrXuAyDoi29MeqDMOrgMRlQ74B2OnvryYxATHsUiz45U
         2ni8Top0uZVO4PBydLqjWFaDZsj4q7p5FfFXwoL7oxZPIkq0mgwRygzDnGw7rH0dT8sR
         Crxg==
X-Gm-Message-State: AOUpUlGlmd0uxsRbuS/syF1hRvPsnlYcJxgxF/tmIyKoGhaLJ/YKs0sZ
        B+lMcLFcetKoIehLebNOfHfRWA==
X-Google-Smtp-Source: AAOMgpdY8pSvcUsPHQiKKAvZsjTuN1U9a8jAALaOaAZwrgp8gOSSKHSf6m4URKuR5fbn9IM5t+dmhw==
X-Received: by 2002:a5d:40c4:: with SMTP id b4-v6mr10466947wrq.133.1531733859859;
        Mon, 16 Jul 2018 02:37:39 -0700 (PDT)
Received: from localhost.localdomain ([151.15.255.159])
        by smtp.gmail.com with ESMTPSA id j6-v6sm8489929wro.13.2018.07.16.02.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 02:37:39 -0700 (PDT)
Date:   Mon, 16 Jul 2018 11:37:37 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH V2] sched/deadline: Update rq_clock of later_rq when
 pushing a task
Message-ID: <20180716093737.GA30854@localhost.localdomain>
References: <52d533238eb69a09fbf40b34765be312e0fd0296.1531490101.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d533238eb69a09fbf40b34765be312e0fd0296.1531490101.git.bristot@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/07/18 15:37, Daniel Bristot de Oliveira wrote:
> Daniel Casini got this warn while running a DL task here at RetisLab:
> 
>   [  461.137582] ------------[ cut here ]------------
>   [  461.137583] rq->clock_update_flags < RQCF_ACT_SKIP
>   [  461.137599] WARNING: CPU: 4 PID: 2354 at kernel/sched/sched.h:967 assert_clock_updated.isra.32.part.33+0x17/0x20
>       [a ton of modules]
>   [  461.137646] CPU: 4 PID: 2354 Comm: label_image Not tainted 4.18.0-rc4+ #3
>   [  461.137647] Hardware name: ASUS All Series/Z87-K, BIOS 0801 09/02/2013
>   [  461.137649] RIP: 0010:assert_clock_updated.isra.32.part.33+0x17/0x20
>   [  461.137649] Code: ff 48 89 83 08 09 00 00 eb c6 66 0f 1f 84 00 00 00 00 00 55 48 c7 c7 98 7a 6c a5 c6 05 bc 0d 54 01 01 48 89 e5 e8 a9 84 fb ff <0f> 0b 5d c3 0f 1f 44 00 00 0f 1f 44 00 00 83 7e 60 01 74 0a 48 3b
>   [  461.137673] RSP: 0018:ffffa77e08cafc68 EFLAGS: 00010082
>   [  461.137674] RAX: 0000000000000000 RBX: ffff8b3fc1702d80 RCX: 0000000000000006
>   [  461.137674] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8b3fded164b0
>   [  461.137675] RBP: ffffa77e08cafc68 R08: 0000000000000026 R09: 0000000000000339
>   [  461.137676] R10: ffff8b3fd060d410 R11: 0000000000000026 R12: ffffffffa4e14e20
>   [  461.137677] R13: ffff8b3fdec22940 R14: ffff8b3fc1702da0 R15: ffff8b3fdec22940
>   [  461.137678] FS:  00007efe43ee5700(0000) GS:ffff8b3fded00000(0000) knlGS:0000000000000000
>   [  461.137679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [  461.137680] CR2: 00007efe30000010 CR3: 0000000301744003 CR4: 00000000001606e0
>   [  461.137680] Call Trace:
>   [  461.137684]  push_dl_task.part.46+0x3bc/0x460
>   [  461.137686]  task_woken_dl+0x60/0x80
>   [  461.137689]  ttwu_do_wakeup+0x4f/0x150
>   [  461.137690]  ttwu_do_activate+0x77/0x80
>   [  461.137692]  try_to_wake_up+0x1d6/0x4c0
>   [  461.137693]  wake_up_q+0x32/0x70
>   [  461.137696]  do_futex+0x7e7/0xb50
>   [  461.137698]  __x64_sys_futex+0x8b/0x180
>   [  461.137701]  do_syscall_64+0x5a/0x110
>   [  461.137703]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   [  461.137705] RIP: 0033:0x7efe4918ca26
>   [  461.137705] Code: 00 00 00 74 17 49 8b 48 20 44 8b 59 10 41 83 e3 30 41 83 fb 20 74 1e be 85 00 00 00 41 ba 01 00 00 00 41 b9 01 00 00 04 0f 05 <48> 3d 01 f0 ff ff 73 1f 31 c0 c3 be 8c 00 00 00 49 89 c8 4d 31 d2
>   [  461.137738] RSP: 002b:00007efe43ee4928 EFLAGS: 00000283 ORIG_RAX: 00000000000000ca
>   [  461.137739] RAX: ffffffffffffffda RBX: 0000000005094df0 RCX: 00007efe4918ca26
>   [  461.137740] RDX: 0000000000000001 RSI: 0000000000000085 RDI: 0000000005094e24
>   [  461.137741] RBP: 00007efe43ee49c0 R08: 0000000005094e20 R09: 0000000004000001
>   [  461.137741] R10: 0000000000000001 R11: 0000000000000283 R12: 0000000000000000
>   [  461.137742] R13: 0000000005094df8 R14: 0000000000000001 R15: 0000000000448a10
>   [  461.137743] ---[ end trace 187df4cad2bf7649 ]---
> 
> This warning happened in the push_dl_task(), because
> __add_running_bw()->cpufreq_update_util() is getting the rq_clock of
> the later_rq before its update, which takes place at activate_task().
> The fix then is to update the rq_clock before calling add_running_bw().

I believe Steve hit the same problem last week:

https://lore.kernel.org/lkml/20180703120301.3667f418@gandalf.local.home/

> To avoid double rq_clock_update() call, we set ENQUEUE_NOCLOCK flag to
> activate_task().

I suggested almost the same, but missed the ENQUEUE_NOCLOCK bit (which I
think it's required).

> Changes from v1:
>   Cosmetic changes in the log, and correct Juri's email (Daniel).
> 
> Reported-by: Daniel Casini <daniel.casini@santannapisa.it>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: <stable@vger.kernel.org> # 4.16+
> Fixes: e0367b12674b sched/deadline: Move CPU frequency selection triggering points
> ---
>  kernel/sched/deadline.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index fbfc3f1d368a..e733c15b7695 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2090,8 +2090,16 @@ static int push_dl_task(struct rq *rq)
>  	sub_rq_bw(&next_task->dl, &rq->dl);
>  	set_task_cpu(next_task, later_rq->cpu);
>  	add_rq_bw(&next_task->dl, &later_rq->dl);
> +
> +	/*
> +	 * Update the later_rq clock here, because the clock is used
> +	 * by the cpufreq_update_util() inside __add_running_bw().
> +	 * Then, set ENQUEUE_NOCLOCK flag to avoid updating the rq_clock
> +	 * again in the activate_task()->enqueue_task().
> +	 */
> +	update_rq_clock(later_rq);
>  	add_running_bw(&next_task->dl, &later_rq->dl);
> -	activate_task(later_rq, next_task, 0);
> +	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
>  	ret = 1;

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!

- Juri
