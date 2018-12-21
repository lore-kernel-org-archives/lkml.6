Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91833C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5760E21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M26lwCpS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RypjB3fQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbeLUGgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:36:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbeLUGgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 01:36:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 92E6060208; Fri, 21 Dec 2018 06:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545374163;
        bh=af8no7Z/E/LiL7O+JRO0jFB/5+xcxXn21WWrNWTjYHs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M26lwCpS61fLaYUW1xnyu1RXJup4KcZYpTO618hRvOGSInv8fEMwsFz7vj6cZftfP
         +P+ajBn1gkbZuijo52W6zBGUZ9A+2vkcjJimSGiG6nPeVuVmYiVyYAqE6dlPmh1es4
         w1HHmueaFbTO1QLpgQSD0+A12tE5MEslIuAi9PpQ=
Received: from [10.204.79.19] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B2A260208;
        Fri, 21 Dec 2018 06:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545374162;
        bh=af8no7Z/E/LiL7O+JRO0jFB/5+xcxXn21WWrNWTjYHs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RypjB3fQpNDb/LzieMF3Q53rl3GTO7meCBuLEaWP9qruS38OSJfDCfBG3+fP/xE16
         3Rt+9QHFa+mAPA2frq1bAIM8/kM+ho9HrKw7QyGJLz44mBoXgqZIjBqeBqcq7CCx1n
         6rbbimKCyEgrh+SZYt9j1k48d8KJQp7pQtPxN8Sk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B2A260208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: Re: [PATCH] percpu_rwsem: fix missed wakeup due to reordering of load
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     peterz@infradead.org, mingo@redhat.com, dbueso@suse.de,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org
References: <1543590656-7157-1-git-send-email-prsood@codeaurora.org>
 <20181212152852.GA11111@andrea>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <fa769c59-df1f-fab1-a574-594a0b1922d8@codeaurora.org>
Date:   Fri, 21 Dec 2018 12:05:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181212152852.GA11111@andrea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2018 08:58 PM, Andrea Parri wrote:
> On Fri, Nov 30, 2018 at 08:40:56PM +0530, Prateek Sood wrote:
>> In a scenario where cpu_hotplug_lock percpu_rw_semaphore is already
>> acquired for read operation by P1 using percpu_down_read().
>>
>> Now we have P1 in the path of releaseing the cpu_hotplug_lock and P2
>> is in the process of acquiring cpu_hotplug_lock.
>>
>> P1                                               P2
>> percpu_up_read() path                      percpu_down_write() path
>>
>>                                           rcu_sync_enter() //gp_state=GP_PASSED
>>
>> rcu_sync_is_idle() //returns false        down_write(rw_sem)
>>
>> __percpu_up_read()
>>
>> [L] task = rcu_dereference(w->task) //NULL
>>
>> smp_rmb()                                  [S] w->task = current
>>
>>                                             smp_mb()
>>
>>                                            [L] readers_active_check() //fails
>> 					     schedule()
>>
>> [S] __this_cpu_dec(read_count)
>>
>> Since load of task can result in NULL. This can lead to missed wakeup
>> in rcuwait_wake_up(). Above sequence violated the following constraint
>> in rcuwait_wake_up():
>>
>> 	 WAIT                WAKE
>> [S] tsk = current	  [S] cond = true
>> MB (A)	                    MB (B)
>> [L] cond		  [L] tsk
>>
>> This can happen as smp_rmb() in rcuwait_wake_up() will provide ordering
>> of load before barrier with load and store after barrier for arm64
>> architecture. Here the requirement is to order store before smp_rmb()
>> with load after the smp_rmb().
>>
>> For the usage of rcuwait_wake_up() in __percpu_up_read() full barrier
>> (smp_mb) is required to complete the constraint of rcuwait_wake_up().
>>
>> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> 
> I know this is going to sound ridiculous (coming from me or from
> the Italian that I am), but it looks like we could both work on
> our English. ;-)
> 
> But the fix seems correct to me:
> 
> Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> 
> It might be a good idea to integrate this fix with fixes to the
> inline comments/annotations: for example, I see that the comment
> in rcuwait_wake_up() mentions a non-existing rcuwait_trywake();
Ok, I will update the comment in next version of the patch.

> moreover, the memory-barrier annotation "B" is used also for the
> smp_mb() preceding the __this_cpu_dec() in __percpu_up_read().
In this annotation "B" is corresponding to annotation "A" in
rcuwait_wait_event(). So this seems to be correct.

> 
>   Andrea
> 
> 
>> ---
>>  kernel/exit.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index f1d74f0..a10820d 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -306,7 +306,7 @@ void rcuwait_wake_up(struct rcuwait *w)
>>  	 *        MB (A)	      MB (B)
>>  	 *    [L] cond		  [L] tsk
>>  	 */
>> -	smp_rmb(); /* (B) */
>> +	smp_mb(); /* (B) */
>>  
>>  	/*
>>  	 * Avoid using task_rcu_dereference() magic as long as we are careful,
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
>> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>


-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
