Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A3BC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02F726115
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I38ErCxc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I38ErCxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02F726115
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934654AbeF0OHz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:07:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932166AbeF0OHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:07:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D63E560B1A; Wed, 27 Jun 2018 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530108471;
        bh=Rf/F49z1Ad72rwzNS3wuVEc+hj0ojuRmX5uqUPc6334=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I38ErCxcA+cVdGXxYSfGlZM8YJ7zHwB3cy0qjDPOh2g3WjVqC684F2LQ+7SLo4PlH
         U2QHY0dbNt9AKwvAbQP/Zg8p4V+aWze1qyjJxIRDuE6cSwqBnn8Nc7dzipld7qhV3P
         8vHKPZbAWQrkcwjbXf/UeEla/OK8ztD53Jrm2irI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id ED159601EA;
        Wed, 27 Jun 2018 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530108471;
        bh=Rf/F49z1Ad72rwzNS3wuVEc+hj0ojuRmX5uqUPc6334=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I38ErCxcA+cVdGXxYSfGlZM8YJ7zHwB3cy0qjDPOh2g3WjVqC684F2LQ+7SLo4PlH
         U2QHY0dbNt9AKwvAbQP/Zg8p4V+aWze1qyjJxIRDuE6cSwqBnn8Nc7dzipld7qhV3P
         8vHKPZbAWQrkcwjbXf/UeEla/OK8ztD53Jrm2irI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 Jun 2018 07:07:50 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, peterz@infradead.org,
        matt@codeblueprint.co.uk, mingo@kernel.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop_machine: Remove cpu swap from stop_two_cpus
In-Reply-To: <20180627071527.hvrndkz436yeqwpq@linutronix.de>
References: <1530048506-21393-1-git-send-email-isaacm@codeaurora.org>
 <20180627071527.hvrndkz436yeqwpq@linutronix.de>
Message-ID: <d3184f0b64e877cb37968c4499aadb94@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-27 00:15, Sebastian Andrzej Siewior wrote:
> On 2018-06-26 14:28:26 [-0700], Isaac J. Manjarres wrote:
>> Remove CPU ID swapping in stop_two_cpus() so that the
>> source CPU's stopper thread is added to the wake queue last,
>> so that the source CPU's stopper thread is woken up last,
>> ensuring that all other threads that it depends on are woken
>> up before it runs.
> 
> You can't do that because you could deadlock while locking the stoper
> lock.
<Prasad> Without this change boot up issues are observed with Linux 
4.14.52.
One of the core is executing the stopper thread after wake_up_q() in
cpu_stop_queue_two_works() function, without waking up other cores 
stopper thread.
We see this issue 100% on device boot up with Linux 4.14.52.

Could you please explain bit more how the deadlock occurs?
static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work 
*work1,
                                     int cpu2, struct cpu_stop_work 
*work2)
{
         struct cpu_stopper *stopper1 = per_cpu_ptr(&cpu_stopper, cpu1);
         struct cpu_stopper *stopper2 = per_cpu_ptr(&cpu_stopper, cpu2);
         DEFINE_WAKE_Q(wakeq);
         int err;
retry:
         raw_spin_lock_irq(&stopper1->lock);
         raw_spin_lock_nested(&stopper2->lock, SINGLE_DEPTH_NESTING);

<SNIP>

I think, you are suggesting to switch the locking sequence too.
stopper2->lock and stopper1->lock.

could you please share the test case to stress this code flow?

> Couldn't you swap cpu1+cpu2 and work1+work2?
<Prasad> Work1 and work2 are having same data contents.


> 
>> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
>> index f89014a..d10d633 100644
>> --- a/kernel/stop_machine.c
>> +++ b/kernel/stop_machine.c
>> @@ -307,8 +307,6 @@ int stop_two_cpus(unsigned int cpu1, unsigned int 
>> cpu2, cpu_stop_fn_t fn, void *
>>  	cpu_stop_init_done(&done, 2);
>>  	set_state(&msdata, MULTI_STOP_PREPARE);
>> 
>> -	if (cpu1 > cpu2)
>> -		swap(cpu1, cpu2);
>>  	if (cpu_stop_queue_two_works(cpu1, &work1, cpu2, &work2))
>>  		return -ENOENT;
>> 
> 
> Sebastian

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
