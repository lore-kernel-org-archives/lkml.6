Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E11ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A009D20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A009D20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeGPMhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:37:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40867 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeGPMhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:37:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so31638071wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 05:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bfkQ8R72vGPT396bEDcym3En2hzr5JR/C+Zvo/gqHwI=;
        b=GoT/K0Q2/zPco0L0dQqgeQj1V1j+abj1PmWsyGaHClyKE+/RVI3EtFzptYjzCNwTpl
         N4dcuXATzsSmBvb1rLxNiNl7P509zUQiWoufVdT+bMsFM6klpfe7mABBc25mR2VLqLsj
         8fVHNuJ7MhePry/1TiZdeMrqnyP6ZcNolWMDN/XIo93NGjGdtblMTekQjB+iyN8UqFxG
         n4hTO1vfSgXb1tdJaDjt2N/iefwAkwgTIaXRW36NT8AZ0aAnmQXUZzLyGndIYTM2Zo/Z
         3fxxJoGBPsJBLFlIatFyZTugkhibjwsrLD+BuDwQla8bdQ7T++K06Mrbl5WkAyKVCO5o
         R9Ng==
X-Gm-Message-State: AOUpUlHeKdlr13eDmOffqLmdKUvAyGBKTY5rof9KWGxxFdqiWhFVqcr4
        7X3uIFmXbG4ALUg60vFte/Icxg==
X-Google-Smtp-Source: AAOMgpeZVyHspxpszk9FYVL1Vm3XF4KYxDoQePa0zEAIISJvqusaoznuvwhANnZrDov/zbTBuCFolA==
X-Received: by 2002:adf:a963:: with SMTP id u90-v6mr13028323wrc.248.1531743044128;
        Mon, 16 Jul 2018 05:10:44 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id d7-v6sm25762946wro.92.2018.07.16.05.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:10:43 -0700 (PDT)
Subject: Re: [PATCH V2] sched/deadline: Update rq_clock of later_rq when
 pushing a task
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
        Clark Williams <williams@redhat.com>
References: <52d533238eb69a09fbf40b34765be312e0fd0296.1531490101.git.bristot@redhat.com>
 <20180716093737.GA30854@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <048dc824-87b5-ce3a-d2d9-dc3ebe78fcb6@redhat.com>
Date:   Mon, 16 Jul 2018 14:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716093737.GA30854@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 11:37 AM, Juri Lelli wrote:
> Hi,
> 
> On 14/07/18 15:37, Daniel Bristot de Oliveira wrote:
>> Daniel Casini got this warn while running a DL task here at RetisLab:
>>
>>   [  461.137582] ------------[ cut here ]------------
>>   [  461.137583] rq->clock_update_flags < RQCF_ACT_SKIP
>>   [  461.137599] WARNING: CPU: 4 PID: 2354 at kernel/sched/sched.h:967 assert_clock_updated.isra.32.part.33+0x17/0x20
>>       [a ton of modules]
>>   [  461.137646] CPU: 4 PID: 2354 Comm: label_image Not tainted 4.18.0-rc4+ #3
>>   [  461.137647] Hardware name: ASUS All Series/Z87-K, BIOS 0801 09/02/2013
>>   [  461.137649] RIP: 0010:assert_clock_updated.isra.32.part.33+0x17/0x20
>>   [  461.137649] Code: ff 48 89 83 08 09 00 00 eb c6 66 0f 1f 84 00 00 00 00 00 55 48 c7 c7 98 7a 6c a5 c6 05 bc 0d 54 01 01 48 89 e5 e8 a9 84 fb ff <0f> 0b 5d c3 0f 1f 44 00 00 0f 1f 44 00 00 83 7e 60 01 74 0a 48 3b
>>   [  461.137673] RSP: 0018:ffffa77e08cafc68 EFLAGS: 00010082
>>   [  461.137674] RAX: 0000000000000000 RBX: ffff8b3fc1702d80 RCX: 0000000000000006
>>   [  461.137674] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8b3fded164b0
>>   [  461.137675] RBP: ffffa77e08cafc68 R08: 0000000000000026 R09: 0000000000000339
>>   [  461.137676] R10: ffff8b3fd060d410 R11: 0000000000000026 R12: ffffffffa4e14e20
>>   [  461.137677] R13: ffff8b3fdec22940 R14: ffff8b3fc1702da0 R15: ffff8b3fdec22940
>>   [  461.137678] FS:  00007efe43ee5700(0000) GS:ffff8b3fded00000(0000) knlGS:0000000000000000
>>   [  461.137679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   [  461.137680] CR2: 00007efe30000010 CR3: 0000000301744003 CR4: 00000000001606e0
>>   [  461.137680] Call Trace:
>>   [  461.137684]  push_dl_task.part.46+0x3bc/0x460
>>   [  461.137686]  task_woken_dl+0x60/0x80
>>   [  461.137689]  ttwu_do_wakeup+0x4f/0x150
>>   [  461.137690]  ttwu_do_activate+0x77/0x80
>>   [  461.137692]  try_to_wake_up+0x1d6/0x4c0
>>   [  461.137693]  wake_up_q+0x32/0x70
>>   [  461.137696]  do_futex+0x7e7/0xb50
>>   [  461.137698]  __x64_sys_futex+0x8b/0x180
>>   [  461.137701]  do_syscall_64+0x5a/0x110
>>   [  461.137703]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>   [  461.137705] RIP: 0033:0x7efe4918ca26
>>   [  461.137705] Code: 00 00 00 74 17 49 8b 48 20 44 8b 59 10 41 83 e3 30 41 83 fb 20 74 1e be 85 00 00 00 41 ba 01 00 00 00 41 b9 01 00 00 04 0f 05 <48> 3d 01 f0 ff ff 73 1f 31 c0 c3 be 8c 00 00 00 49 89 c8 4d 31 d2
>>   [  461.137738] RSP: 002b:00007efe43ee4928 EFLAGS: 00000283 ORIG_RAX: 00000000000000ca
>>   [  461.137739] RAX: ffffffffffffffda RBX: 0000000005094df0 RCX: 00007efe4918ca26
>>   [  461.137740] RDX: 0000000000000001 RSI: 0000000000000085 RDI: 0000000005094e24
>>   [  461.137741] RBP: 00007efe43ee49c0 R08: 0000000005094e20 R09: 0000000004000001
>>   [  461.137741] R10: 0000000000000001 R11: 0000000000000283 R12: 0000000000000000
>>   [  461.137742] R13: 0000000005094df8 R14: 0000000000000001 R15: 0000000000448a10
>>   [  461.137743] ---[ end trace 187df4cad2bf7649 ]---
>>
>> This warning happened in the push_dl_task(), because
>> __add_running_bw()->cpufreq_update_util() is getting the rq_clock of
>> the later_rq before its update, which takes place at activate_task().
>> The fix then is to update the rq_clock before calling add_running_bw().
> 
> I believe Steve hit the same problem last week:
> 
> https://lore.kernel.org/lkml/20180703120301.3667f418@gandalf.local.home/

Yeap, this is the same problem!

>> To avoid double rq_clock_update() call, we set ENQUEUE_NOCLOCK flag to
>> activate_task().
> 
> I suggested almost the same, but missed the ENQUEUE_NOCLOCK bit (which I
> think it's required).
> 
>> Changes from v1:
>>   Cosmetic changes in the log, and correct Juri's email (Daniel).
>>
>> Reported-by: Daniel Casini <daniel.casini@santannapisa.it>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Luca Abeni <luca.abeni@santannapisa.it>
>> Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: <stable@vger.kernel.org> # 4.16+
>> Fixes: e0367b12674b sched/deadline: Move CPU frequency selection triggering points
>> ---
>>  kernel/sched/deadline.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index fbfc3f1d368a..e733c15b7695 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2090,8 +2090,16 @@ static int push_dl_task(struct rq *rq)
>>  	sub_rq_bw(&next_task->dl, &rq->dl);
>>  	set_task_cpu(next_task, later_rq->cpu);
>>  	add_rq_bw(&next_task->dl, &later_rq->dl);
>> +
>> +	/*
>> +	 * Update the later_rq clock here, because the clock is used
>> +	 * by the cpufreq_update_util() inside __add_running_bw().
>> +	 * Then, set ENQUEUE_NOCLOCK flag to avoid updating the rq_clock
>> +	 * again in the activate_task()->enqueue_task().
>> +	 */
>> +	update_rq_clock(later_rq);
>>  	add_running_bw(&next_task->dl, &later_rq->dl);
>> -	activate_task(later_rq, next_task, 0);
>> +	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
>>  	ret = 1;
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!

-- Daniel

> Thanks!
> 
> - Juri
> 

