Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD75C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA7C208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aKa8B5v0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D/yU/rtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA7C208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeGaGHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:07:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42326 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeGaGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:07:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 35B3C60264; Tue, 31 Jul 2018 04:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533011373;
        bh=FBgx2iAY0kMwvdQrDxppPavTJQGfpZuyrykm3divWPo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aKa8B5v0tOUxk6jqOfq6lPTXJnI3uwcSkq+Byze8k6WGWfTrptz+08J8dp3it0WQc
         V8p/RKwuPsyB/TMK9pyyiRlPiO3C96d0tmf9RuVJKIPoHfiGpHEZVDTuR9DQfe9Q5Z
         Uxb5MZaR5jKQp+eQUJXqdWbCrt3BRH0KKK9rwScI=
Received: from [10.204.78.76] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BCD5C6071C;
        Tue, 31 Jul 2018 04:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533011372;
        bh=FBgx2iAY0kMwvdQrDxppPavTJQGfpZuyrykm3divWPo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D/yU/rtddOvrSzcKhAb0DStHGgAFTgrKd6Wx532VfvSYdlx/qMtW67DV+0yuwf57z
         oxxcTDcwKJgYlHJeBAMeieTWG+4yN8V4SpWa4ZbnVz10PoIgayUK5nDRYNjAvzNfUZ
         eKyUfMWoaW37qS2ZEmNrguHkGukX89fgO3KvSRqU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCD5C6071C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH] timers: Clear must_forward_clk inside base lock
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1532594522-28045-1-git-send-email-gkohli@codeaurora.org>
From:   "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <063840fb-3360-4208-2950-908ef76791c2@codeaurora.org>
Date:   Tue, 31 Jul 2018 09:59:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532594522-28045-1-git-send-email-gkohli@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John, Thomas,

Can you please review below patch and update your comments:

Regards
Gaurav

On 7/26/2018 2:12 PM, Gaurav Kohli wrote:
> While migrating timer to new base, there is a need
> to update base clk by calling forward_timer_base to
> avoid stale clock , but at the same time if run_timer
> is exectuing in new core it may set must_forward_clk
> to false and due to this forward base logic may fail as
> per below check:
> 
> if (likely(!base->must_forward_clk))
>                  return;
> 
> So preventing the same by putting must_forward_clk inside
> base lock.
> 
> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index cc2d23e..675241d 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1657,6 +1657,19 @@ static inline void __run_timers(struct timer_base *base)
>   
>   	raw_spin_lock_irq(&base->lock);
>   
> +	/*
> +	 * must_forward_clk must be cleared before running timers so that any
> +	 * timer functions that call mod_timer will not try to forward the
> +	 * base. idle trcking / clock forwarding logic is only used with
> +	 * BASE_STD timers.
> +	 *
> +	 * The deferrable base does not do idle tracking at all, so we do
> +	 * not forward it. This can result in very large variations in
> +	 * granularity for deferrable timers, but they can be deferred for
> +	 * long periods due to idle.
> +	 */
> +	base->must_forward_clk = false;
> +
>   	while (time_after_eq(jiffies, base->clk)) {
>   
>   		levels = collect_expired_timers(base, heads);
> @@ -1676,19 +1689,6 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
>   {
>   	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
>   
> -	/*
> -	 * must_forward_clk must be cleared before running timers so that any
> -	 * timer functions that call mod_timer will not try to forward the
> -	 * base. idle trcking / clock forwarding logic is only used with
> -	 * BASE_STD timers.
> -	 *
> -	 * The deferrable base does not do idle tracking at all, so we do
> -	 * not forward it. This can result in very large variations in
> -	 * granularity for deferrable timers, but they can be deferred for
> -	 * long periods due to idle.
> -	 */
> -	base->must_forward_clk = false;
> -
>   	__run_timers(base);
>   	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
>   		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
