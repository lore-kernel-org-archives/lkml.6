Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E97C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E998724CDD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CRibGxxU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HZxw8zMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E998724CDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeGCFxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:53:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753939AbeGCFxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:53:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D8E8860B68; Tue,  3 Jul 2018 05:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530597226;
        bh=yjZIToqqXYHzoEiYeEovqq3uW1LM/o6SvLbqL0d86V4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CRibGxxUuI3F8h+2HbSOkQWFp5ffop5I0dxVfdOyfl00Ur/8aosZys6TBOzYBfg2K
         KoC3m2dg9DxKZzfYQh3/VnLHdrPowZxiFBJXMz0sjlxrfrb1XOBL8P0lnqjyDEsQU+
         vPAL/pL/xVV0PY5Aj2XNColx5COkkQbxfyx24bsM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E1BB160B24;
        Tue,  3 Jul 2018 05:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530597225;
        bh=yjZIToqqXYHzoEiYeEovqq3uW1LM/o6SvLbqL0d86V4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HZxw8zMP6qqV3Mz5Ov3yR31lK6VGB8/cIkrJ545dO4/kCgWhlmqU8XS88lVufwn5B
         E97oMnpQ8IxRnfy5Psj5PqTR/CNxyCwn604qtsxzlXf9uQBkhfTd6tlyB55ju05eIz
         VX4UVAlU85TfRwavLJN8fQjYPSuNAPViTDoufigA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Jul 2018 22:53:45 -0700
From:   isaacm@codeaurora.org
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     matt@codeblueprint.co.uk, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, pkondeti@codeaurora.org
Subject: Re: [PATCH v2] stop_machine: Disable preemption when waking two
 stopper threads
In-Reply-To: <20180702121500.GK2494@hirez.programming.kicks-ass.net>
References: <1530305712-16416-1-git-send-email-isaacm@codeaurora.org>
 <20180702121500.GK2494@hirez.programming.kicks-ass.net>
Message-ID: <0a5741e3d244b9914667608df5b5db23@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for the feedback. I'll make sure to incorporate it into my next
patch, and send that soon.

Thanks,
Isaac Manjarres
On 2018-07-02 05:15, Peter Zijlstra wrote:
> On Fri, Jun 29, 2018 at 01:55:12PM -0700, Isaac J. Manjarres wrote:
>> When cpu_stop_queue_two_works() begins to wake the stopper
>> threads, it does so without preemption disabled, which leads
>> to the following race condition:
>> 
>> The source CPU calls cpu_stop_queue_two_works(), with cpu1
>> as the source CPU, and cpu2 as the destination CPU. When
>> adding the stopper threads to the wake queue used in this
>> function, the source CPU stopper thread is added first,
>> and the destination CPU stopper thread is added last.
>> 
>> When wake_up_q() is invoked to wake the stopper threads, the
>> threads are woken up in the order that they are queued in,
>> so the source CPU's stopper thread is woken up first, and
>> it preempts the thread running on the source CPU.
>> 
>> The stopper thread will then execute on the source CPU,
>> disable preemption, and begin executing multi_cpu_stop(),
>> and wait for an ack from the destination CPU's stopper thread,
>> with preemption still disabled. Since the worker thread that
>> woke up the stopper thread on the source CPU is affine to the
>> source CPU, and preemption is disabled on the source CPU, that
>> thread will never run to dequeue the destination CPU's stopper
>> thread from the wake queue, and thus, the destination CPU's
>> stopper thread will never run, causing the source CPU's stopper
>> thread to wait forever, and stall.
>> 
>> Disable preemption when waking the stopper threads in
>> cpu_stop_queue_two_works() to ensure that the worker thread
>> that is waking up the stopper threads isn't preempted
>> by the source CPU's stopper thread, and permanently
>> scheduled out, leaving the remaining stopper thread asleep
>> in the wake queue.
>> 
>> Co-developed-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
>> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
>> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
>> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> 
> That SoB chain is broken, if Prasad wrote the ptch then there needs to
> be a From: line somewhere.
> 
> But yes, that looks about right.
> 
>> ---
>>  kernel/stop_machine.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
>> index f89014a..1ff523d 100644
>> --- a/kernel/stop_machine.c
>> +++ b/kernel/stop_machine.c
>> @@ -270,7 +270,11 @@ static int cpu_stop_queue_two_works(int cpu1, 
>> struct cpu_stop_work *work1,
>>  		goto retry;
>>  	}
>> 
>> -	wake_up_q(&wakeq);
>> +	if (!err) {
>> +		preempt_disable();
>> +		wake_up_q(&wakeq);
>> +		preempt_enable();
>> +	}
>> 
>>  	return err;
>>  }
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
