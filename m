Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06B6C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F76420658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dlL3LLAE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TyvHUKTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F76420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeIEQkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:40:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeIEQkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:40:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DCF5D6083E; Wed,  5 Sep 2018 12:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536149413;
        bh=Sw6sljOrp9NvbBi5V1a6iAdqeRwN1PLLE2t0xmFMt+Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dlL3LLAElT+R71BvLi1Tg4X349h7lyy15rYN85h4t7nD8kxuWlNffQzToteeVNp4C
         NpUmRMoONIr/8HBpOl+mz2RJ46LwquGng8OKAAMdxqXxKa8p1DrP8E7jK8r45KVt0x
         zH5iIHS/CZJAkSOEgASTbbxPiynRal4UwqSDWrZ8=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 74A2A60242;
        Wed,  5 Sep 2018 12:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536149412;
        bh=Sw6sljOrp9NvbBi5V1a6iAdqeRwN1PLLE2t0xmFMt+Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TyvHUKTc5Ee3ZpRvsivWZYjmsSfGVLI9hDzm7YUHY4yjR0qn29hfNJ7kKhK8G0HCe
         V+21+gdxvN3UNwTB6IhMB3I0LqAqxCkde2vtJvwEiLr33+i/MBtAxUM/7CHAsfPpLl
         cLMhFPbUq4B1zxFVneEF2yAijF2Slt5VbHSuZYBk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74A2A60242
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] cpu/hotplug: Fix rollback during error-out in
 takedown_cpu()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, peterz@infradead.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dzickus@redhat.com,
        brendan.jackman@arm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org
References: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org>
 <alpine.DEB.2.21.1809051244500.1416@nanos.tec.linutronix.de>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <cf91ee04-a4b6-6f2c-d194-71b7e92fbf45@codeaurora.org>
Date:   Wed, 5 Sep 2018 17:39:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809051244500.1416@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/2018 5:03 PM, Thomas Gleixner wrote:
> On Tue, 4 Sep 2018, Neeraj Upadhyay wrote:
>> If takedown_cpu() fails during _cpu_down(), st->state is reset,
>> by calling cpuhp_reset_state(). This results in an additional
>> increment of st->state, which results in CPUHP_AP_SMPBOOT_THREADS
>> state being skipped during rollback. Fix this by not calling
>> cpuhp_reset_state() and doing the state reset directly in
>> _cpu_down().
>>
>> Fixes: 4dddfb5faa61 ("smp/hotplug: Rewrite AP state machine core")
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>> ---
>>   kernel/cpu.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index aa7fe85..9f49edb 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -970,7 +970,14 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>>   	 */
>>   	ret = cpuhp_down_callbacks(cpu, st, target);
>>   	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
>> -		cpuhp_reset_state(st, prev_state);
>> +		/*
>> +		 * As st->last is not set, cpuhp_reset_state() increments
>> +		 * st->state, which results in CPUHP_AP_SMPBOOT_THREADS being
>> +		 * skipped during rollback. So, don't use it here.
>> +		 */
>> +		st->rollback = true;
>> +		st->target = prev_state;
>> +		st->bringup = !st->bringup;
> No, this is just papering over the actual problem.
>
> The state inconsistency happens in take_cpu_down() when it returns with a
> failure from __cpu_disable() because that returns with state = TEARDOWN_CPU
> and st->state is then incremented in undo_cpu_down().
>
> That's the real issue and we need to analyze the whole cpu_down rollback
> logic first.

Could this be done like below ?

diff --git a/kernel/cpu.c b/kernel/cpu.c
index aa7fe85..47bce90 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -802,17 +802,18 @@ static int take_cpu_down(void *_param)
         int err, cpu = smp_processor_id();
         int ret;

-       /* Ensure this CPU doesn't handle any more interrupts. */
-       err = __cpu_disable();
-       if (err < 0)
-               return err;
-
         /*
          * We get here while we are in CPUHP_TEARDOWN_CPU state and we 
must not
          * do this step again.
          */
         WARN_ON(st->state != CPUHP_TEARDOWN_CPU);
         st->state--;
+
+       /* Ensure this CPU doesn't handle any more interrupts. */
+       err = __cpu_disable();
+       if (err < 0)
+               return err;
+
         /* Invoke the former CPU_DYING callbacks */

Thanks,
Mukesh
>
>
>
>
>
>

