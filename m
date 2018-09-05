Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125CDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D44F20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CKVAu6JR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cCrUmpVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D44F20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeIERVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:21:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37088 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeIERVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:21:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 05E61607DC; Wed,  5 Sep 2018 12:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536151881;
        bh=Osy4Z+zNR5oPKgMubZYUo+PCgiLFm4Yzh7FsrxpmFlY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CKVAu6JRUpDXgeC51L23iyRmSHNK82dB5obW2hvEGbCthmSuIOPt8db7q3ffUab6b
         70L6opdsWtIYZvtpOAdguYWxRa67oPp2UttcktcalK8XhyZ1SfmPVAvdB+2KP4xz+n
         S7P/mX+HuuPgVe3T6O/z0IQNPgsEXNJGEImwi5m8=
Received: from [10.204.78.89] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CF1E60388;
        Wed,  5 Sep 2018 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536151880;
        bh=Osy4Z+zNR5oPKgMubZYUo+PCgiLFm4Yzh7FsrxpmFlY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cCrUmpVunoFRiQjhDKVC2UQN1Qv/kCWvJ6AeBOpFcrfaSbuyMwt6DUmnqr7ipz8np
         f6G0r2EBIUpZtO+bxfwzt2DLg/sJjY5tAV81g8YbH8qqPuWtTuiZ0ULEBW4GEpHP+i
         5iUlUAClKjupyn2v0816jbfsXEjpa6TtxmdLgdKI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CF1E60388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] cpu/hotplug: Fix rollback during error-out in
 takedown_cpu()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     josh@joshtriplett.org, peterz@infradead.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dzickus@redhat.com,
        brendan.jackman@arm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org
References: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org>
 <alpine.DEB.2.21.1809051244500.1416@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809051419580.1416@nanos.tec.linutronix.de>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <5b0e528f-e597-9598-3ff6-b9e08ddb8165@codeaurora.org>
Date:   Wed, 5 Sep 2018 18:21:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809051419580.1416@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2018 05:53 PM, Thomas Gleixner wrote:
> On Wed, 5 Sep 2018, Thomas Gleixner wrote:
>> On Tue, 4 Sep 2018, Neeraj Upadhyay wrote:
>>>   	ret = cpuhp_down_callbacks(cpu, st, target);
>>>   	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
>>> -		cpuhp_reset_state(st, prev_state);
>>> +		/*
>>> +		 * As st->last is not set, cpuhp_reset_state() increments
>>> +		 * st->state, which results in CPUHP_AP_SMPBOOT_THREADS being
>>> +		 * skipped during rollback. So, don't use it here.
>>> +		 */
>>> +		st->rollback = true;
>>> +		st->target = prev_state;
>>> +		st->bringup = !st->bringup;
>> No, this is just papering over the actual problem.
>>
>> The state inconsistency happens in take_cpu_down() when it returns with a
>> failure from __cpu_disable() because that returns with state = TEARDOWN_CPU
>> and st->state is then incremented in undo_cpu_down().
>>
>> That's the real issue and we need to analyze the whole cpu_down rollback
>> logic first.
> And looking closer this is a general issue. Just that the TEARDOWN state
> makes it simple to observe. It's universaly broken, when the first teardown
> callback fails because, st->state is only decremented _AFTER_ the callback
> returns success, but undo_cpu_down() increments unconditionally.
>
> Patch below.
>
> Thanks,
>
> 	tglx
As per my understanding, there are 2 problems here; one is fixed with 
your patch, and other is cpuhp_reset_state() is used during rollback 
from non-AP to AP state, which seem to result in 2 increments of 
st->state (one increment done by cpuhp_reset_state() and another by 
cpu_thread_fun()) .
> ----
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -916,7 +916,8 @@ static int cpuhp_down_callbacks(unsigned
>   		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
>   		if (ret) {
>   			st->target = prev_state;
> -			undo_cpu_down(cpu, st);
> +			if (st->state < prev_state)
> +				undo_cpu_down(cpu, st);
>   			break;
>   		}
>   	}
> @@ -969,7 +970,7 @@ static int __ref _cpu_down(unsigned int
>   	 * to do the further cleanups.
>   	 */
>   	ret = cpuhp_down_callbacks(cpu, st, target);
> -	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
> +	if (ret && st->state == CPUHP_TEARDOWN_CPU && st->state < prev_state) {
>   		cpuhp_reset_state(st, prev_state);
>   		__cpuhp_kick_ap(st);
>   	}

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

