Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbeDXOnE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:43:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbeDXOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:42:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1015607E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH] kthread/smpboot: Serialize kthread parking against wakeup
To: tglx@linutronix.de, mpe@ellerman.id.au, dzickus@redhat.com,
        peterz@infradead.org, mingo@kernel.org, bigeasy@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
References: <1524562105-31026-1-git-send-email-gkohli@codeaurora.org>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <3e823654-9701-9b01-43fc-1a29feb7a298@codeaurora.org>
Date: Tue, 24 Apr 2018 20:12:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524562105-31026-1-git-send-email-gkohli@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

We can also fix below race by smpboot code as well:

@@ -109,7 +109,6 @@ static int smpboot_thread_fn(void *data)

         struct smp_hotplug_thread *ht = td->ht;

         while (1) {

-               set_current_state(TASK_INTERRUPTIBLE);

                 preempt_disable();

                 if (kthread_should_stop()) {

                         __set_current_state(TASK_RUNNING);

@@ -157,6 +156,7 @@ static int smpboot_thread_fn(void *data)

                 if (!ht->thread_should_run(td->cpu)) {

                         preempt_enable_no_resched();

+                       set_current_state(TASK_INTERRUPTIBLE);

                         schedule();

                 } else {

                         __set_current_state(TASK_RUNNING);

Please suggest if this approach is better.

Regards

Gaurav

On 4/24/2018 2:58 PM, Gaurav Kohli wrote:

> The control cpu thread which initiates hotplug calls kthread_park()
> for hotplug thread and sets KTHREAD_SHOULD_PARK. After this control
> thread wakes up the hotplug thread. There is a chance that wakeup
> code sees the hotplug thread (running on AP core) in INTERRUPTIBLE
> state, but sets its state to RUNNING after hotplug thread has entered
> kthread_parkme() and changed its state to TASK_PARKED. This can result
> in panic later on in kthread_unpark(), as it sees KTHREAD_IS_PARKED
> flag set but fails to rebind the kthread, due to it being not in
> TASK_PARKED state. Fix this, by serializing wakeup state change,
> against state change before parking the kthread.
>
> Below is the possible race:
>
> Control thread				      Hotplug Thread
>
> kthread_park()
> set KTHREAD_SHOULD_PARK
> 					      smpboot_thread_fn
> 					      set_current_state(TASK_INTERRUPTIBLE);
> 					      kthread_parkme
>
> wake_up_process()
>
> raw_spin_lock_irqsave(&p->pi_lock, flags);
> if (!(p->state & state)) -> this will fail
>              goto out;
>
> 					      __kthread_parkme
> 					       __set_current_state(TASK_PARKED);
>
> if (p->on_rq && ttwu_remote(p, wake_flags))
>      ttwu_remote()
>          p->state = TASK_RUNNING;
> 						schedule();
>
> So to avoid this race, take pi_lock to serial state changes.
>
> Suggested-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> Co-developed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
>
> diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> index 1650578..514b232 100644
> --- a/kernel/smpboot.c
> +++ b/kernel/smpboot.c
> @@ -121,7 +121,9 @@ static int smpboot_thread_fn(void *data)
>   		}
>   
>   		if (kthread_should_park()) {
> +			raw_spin_lock(&current->pi_lock);
>   			__set_current_state(TASK_RUNNING);
> +			raw_spin_unlock(&current->pi_lock);
>   			preempt_enable();
>   			if (ht->park && td->status == HP_THREAD_ACTIVE) {
>   				BUG_ON(td->cpu != smp_processor_id());
>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
