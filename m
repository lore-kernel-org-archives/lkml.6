Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB3CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AE020C0B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YQwlmOr4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YQwlmOr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AE020C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbeHBIyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:54:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44832 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeHBIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:54:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C2AA607BD; Thu,  2 Aug 2018 07:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533193466;
        bh=i3NvDqWIhQuiarPOzkCuEbBeAah9zhpjUEhaiWpfqqM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YQwlmOr4FVGau+CNuQpXkE28NIucMwv98Jf6t5+1AjY6KvXNoYRRo3F7UlW2mfI3S
         lldmpUkA3JP9Z6XDYkQCMWDvpoFJjL7nficZ9SXyj7OSwoRI8fTpP0b7+04pKGcTqt
         hQQtlOAP1qTHAQO+MeeWRsL+aI2ZSaRhbqb/dm+M=
Received: from [10.204.78.76] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 592446044B;
        Thu,  2 Aug 2018 07:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533193466;
        bh=i3NvDqWIhQuiarPOzkCuEbBeAah9zhpjUEhaiWpfqqM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YQwlmOr4FVGau+CNuQpXkE28NIucMwv98Jf6t5+1AjY6KvXNoYRRo3F7UlW2mfI3S
         lldmpUkA3JP9Z6XDYkQCMWDvpoFJjL7nficZ9SXyj7OSwoRI8fTpP0b7+04pKGcTqt
         hQQtlOAP1qTHAQO+MeeWRsL+aI2ZSaRhbqb/dm+M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 592446044B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v2] timers: Clear must_forward_clk inside base lock
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1533186903-28419-1-git-send-email-gkohli@codeaurora.org>
 <alpine.DEB.2.21.1808020826580.1835@nanos.tec.linutronix.de>
From:   "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <fce3d68c-341d-e720-773f-0867e7770c27@codeaurora.org>
Date:   Thu, 2 Aug 2018 12:34:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808020826580.1835@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2018 12:04 PM, Thomas Gleixner wrote:
> On Thu, 2 Aug 2018, Gaurav Kohli wrote:
>> Timer wheel base->must_forward_clock is indicating that
>> the base clock might be stale due to a long idle sleep.
>> The forwarding of base clock takes place in softirq of timer
> 
> of the base clock takes place in the timer softirq ...
> 
>> or when a timer is enqueued to base which is idle. While migrate
> 
> to a base ..
> 
>> timer from remote CPU to the new base which is idle, then
> 
> See below.
> 
>> following race can happen:
>>
>>    CPU0                                  CPU1
>>    run_timer_softirq                     timers_dead_cpu
>>
>> 					base = lock_timer_base(timer);
>>    base->must_forward_clk = false
>> 					if (base->must_forward_clk)
>> 				         forward(base); >>skip
>>
>> 					migrate_timer_list
> 
> I don't know why you insist on migrate_timer_list() being part of the
> picture here.

Hi Thomas,

Thanks for comment.
I agree this can come with normal enqueue of timer as well, will make it 
more generic to avoid confuzion and upload new patch for same.

Regards
Gaurav


> 
> It's only _ONE_ particular way to observe that issue. But it's not the only
> way. ANY remote enqueue which hits the situation on the other CPU (CPU0 in
> the example) has this problem. Tying it to migrate_timer_list() just
> because you observed it that way is actively misleading. Surely you can add
> a sentence that you observed it in that case, but that's supplemental
> information.
> 
> Thanks,
> 
> 	tglx
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
