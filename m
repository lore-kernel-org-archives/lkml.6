Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3837216256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981E720857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RJHQIlP4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LhBgGSdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981E720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbeG3Ssm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:48:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3Ssm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:48:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C26B062012; Mon, 30 Jul 2018 17:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532970764;
        bh=3i4OwjlLmnJLm1CQSwJm4J08j4tb5Qrf0Dn3mEoaC2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RJHQIlP434Hkl9octwfS31tjFM+JADm60bnLig4rtPioYwiIBmOIMkHDSGXWYeS3h
         fJy727HgfQuUVHeChhDwboMWgPma3yOtyyTJcDdXidhJDmBcT/88VoMIxq4265r9Lw
         F7vXGGUb1SuLzFGimTepnFbvFrw5/JsNqAQ/vXd4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DEC8262012;
        Mon, 30 Jul 2018 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532970763;
        bh=3i4OwjlLmnJLm1CQSwJm4J08j4tb5Qrf0Dn3mEoaC2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LhBgGSdOQ/7iq14XZ9EdjvdmYFHlhfV0uSyJ6OLtt/R6RirIuvP+F9vr2gACxY41N
         OxbC+mfpLDIq5x1IFb+hMs/kGbnWr5cytL17R3YaOGDFodmwkzCApxj0aDJXhe6NON
         CAh6nZ8/DrxZ1QKgLVFIE+Docf8xDFpeleP2b3pk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Jul 2018 10:12:43 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        isaacm@codeaurora.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        pkondeti@codeaurora.org, stable@vger.kernel.org
Subject: Re: [PATCH] stop_machine: Disable preemption after queueing stopper
 threads
In-Reply-To: <alpine.DEB.2.21.1807301440340.2518@nanos.tec.linutronix.de>
References: <1531856129-9871-1-git-send-email-isaacm@codeaurora.org>
 <a30d1e147d3181fc7b294262e380a10c@codeaurora.org>
 <20180724062350.nlem2suuy5wlxpts@linutronix.de>
 <alpine.DEB.2.21.1807301220280.2518@nanos.tec.linutronix.de>
 <20180730112140.GH2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1807301440340.2518@nanos.tec.linutronix.de>
Message-ID: <109d0e70606ccd34861a80525d6d11aa@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-30 05:41, Thomas Gleixner wrote:
> On Mon, 30 Jul 2018, Peter Zijlstra wrote:
> 
>> On Mon, Jul 30, 2018 at 12:20:57PM +0200, Thomas Gleixner wrote:
>> > On Tue, 24 Jul 2018, Sebastian Andrzej Siewior wrote:
>> > > On 2018-07-23 18:13:48 [-0700], isaacm@codeaurora.org wrote:
>> > > > Hi all,
>> > > Hi,
>> > >
>> > > > Are there any comments about this patch?
>> > >
>> > > I haven't look in detail at this but your new preempt_disable() makes
>> > > things unbalanced for the err != 0 case.
>> >
>> > It doesn't but that code is really an unreadable pile of ...
>> 
>> ---
>> Subject: stop_machine: Reflow cpu_stop_queue_two_works()
>> 
>> The code flow in cpu_stop_queue_two_works() is a little arcane; fix
>> this by lifting the preempt_disable() to the top to create more 
>> natural
>> nesting wrt the spinlocks and make the wake_up_q() and 
>> preempt_enable()
>> unconditional at the end.
>> 
>> Furthermore, enable preemption in the -EDEADLK case, such that we
>> spin-wait with preemption enabled.
>> 
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
Hi Peter/Thomas,

How about including below change as well?  Currently, there is no way to 
identify thread migrations completed or not.  When we observe this 
issue, the symptom was work queue lock up. It is better to have some 
timeout here and induce the bug_on.

There is no way to identify the migration threads stuck or not.

--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -290,6 +290,7 @@ int stop_two_cpus(unsigned int cpu1, unsigned int 
cpu2, cpu_stop_fn_t fn, void *
         struct cpu_stop_done done;
         struct cpu_stop_work work1, work2;
         struct multi_stop_data msdata;
+       int ret;

         msdata = (struct multi_stop_data){
                 .fn = fn,
@@ -312,7 +313,10 @@ int stop_two_cpus(unsigned int cpu1, unsigned int 
cpu2, cpu_stop_fn_t fn, void *
         if (cpu_stop_queue_two_works(cpu1, &work1, cpu2, &work2))
                 return -ENOENT;

-       wait_for_completion(&done.completion);
+       ret = wait_for_completion_timeout(&done.completion,  
msecs_to_jiffies(1000));
+       if (!ret)
+               BUG_ON(1);
+


> Thanks for cleaning that up!
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
