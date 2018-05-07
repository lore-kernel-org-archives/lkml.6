Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeEGLYD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:24:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51278 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbeEGLYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:24:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FC5260271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
References: <20180426085719.GW4129@hirez.programming.kicks-ass.net>
 <4d3f68f8-e599-6b27-a2e8-9e96b401d57a@codeaurora.org>
 <20180430111744.GE4082@hirez.programming.kicks-ass.net>
 <3af3365b-4e3f-e388-8e90-45a3bd4120fd@codeaurora.org>
 <20180501101845.GE12217@hirez.programming.kicks-ass.net>
 <f134c8d8-e56f-bf29-0177-e6702ae79f2b@codeaurora.org>
 <20180501113132.GF12217@hirez.programming.kicks-ass.net>
 <745d762d-9ab3-0749-9b87-9bb03d913071@codeaurora.org>
 <20180501131904.GG12217@hirez.programming.kicks-ass.net>
 <9b289790-9b3a-73bd-7166-bf39f32cefd8@codeaurora.org>
 <20180502082011.GB12180@hirez.programming.kicks-ass.net>
 <830d7225-af90-a55a-991a-bb2023d538f1@codeaurora.org>
 <cdd5d434-9c11-7c19-2895-0f7f3811eb11@codeaurora.org>
Message-ID: <55221a5b-dd52-3359-f582-86830dd9f205@codeaurora.org>
Date: Mon, 7 May 2018 16:53:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cdd5d434-9c11-7c19-2895-0f7f3811eb11@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected the formatting, Sorry for spam.


> 
> HI Peter,
> 
> We have tested with new patch and still seeing same issue, in this dumps 
> we don't have debug traces, but seems there still exist race from code 
> review , Can you please check it once:
> 
> Controller Thread                               CPUHP Thread
> takedown_cpu
> kthread_park
> kthread_parkme
> Set KTHREAD_SHOULD_PARK
>                                                 smpboot_thread_fn
>                                                 set Task interruptible
> 
> 
> wake_up_process
> 
>                                                 Kthread_parkme
>                                                 SET TASK_PARKED
>                                                 schedule
>                                                 raw_spin_lock(&rq->lock)
> 
>                                                 context_switch
> 
>                                                 finish_lock_switch
> 
> 
> 
>                                                 Case TASK_PARKED
>                                                 kthread_park_complete
> 
> 
> SET TASK_INTERRUPTIBLE
> 
> 
> And also seeing the same warning during unpark of cpuhp from controller:
>   if (!wait_task_inactive(p, state)) {
>                  WARN_ON(1);
>                  return;
>          }
> 325.065893] [<ffffff8920ed0200>] kthread_unpark+0x80/0xd8
> [  325.065902] [<ffffff8920eab754>] bringup_cpu+0xa0/0x12c
> [  325.065910] [<ffffff8920eaae90>] cpuhp_invoke_callback+0xb4/0x5c8
> [  325.065917] [<ffffff8920eabd98>] cpuhp_up_callbacks+0x3c/0x154
> [  325.065924] [<ffffff8920ead220>] _cpu_up+0x134/0x208
> [  325.065931] [<ffffff8920ead45c>] do_cpu_up+0x168/0x1a0
> [  325.065938] [<ffffff8920ead4b8>] cpu_up+0x24/0x30
> [  325.065948] [<ffffff89215b1408>] cpu_subsys_online+0x20/0x2c
> [  325.065956] [<ffffff89215aac64>] device_online+0x70/0xb4
> [  325.065962] [<ffffff89215aad78>] online_store+0xd0/0xdc
> [  325.065971] [<ffffff89215a7424>] dev_attr_store+0x40/0x54
> [  325.065982] [<ffffff89210d8a98>] sysfs_kf_write+0x5c/0x74
> [  325.065988] [<ffffff89210d7b9c>] kernfs_fop_write+0xcc/0x1ec
> [  325.065999] [<ffffff8921049288>] vfs_write+0xb4/0x1d0
> [  325.066006] [<ffffff892104a858>] SyS_write+0x60/0xc0
> [  325.066014] [<ffffff8920e83770>] el0_svc_naked+0x24/0x28
> 
> 
> And after this same crash occured:
> [  325.521307] [<ffffff8920ed4aac>] smpboot_thread_fn+0x26c/0x2c8
> [  325.527295] [<ffffff8920ecfb24>] kthread+0xf4/0x108
> 
> I will put more debug ftraces to check what is going on exactly.
> 
> Regards
> Gaurav
> 
> 
> 
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
