Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E6697C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADF5208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U6NqA+uw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FVfOmjXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADF5208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965111AbeFNOHq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:07:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965068AbeFNOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:07:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A50BD607BB; Thu, 14 Jun 2018 14:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528985258;
        bh=C5BlthjhyXFfxq62wvzajVzmg1OYwlwje68GEQzJYoc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U6NqA+uwR2rBzPdjezZDDH2G8gCO/YU8op1gfrtxyAG/zt+u1jMpr3ST0mpuOuDR8
         Ahyn/mgtRTZ2XRJs6nS1cDw0R/UOWWNLIHgvdkRBD2zwAIIN/vSz9MYQbt4MprgEhX
         hfpoIPs2J2EOsLTNP+xZ5hnQxD+nt6HtCKz/j9Mw=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B88860795;
        Thu, 14 Jun 2018 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528985257;
        bh=C5BlthjhyXFfxq62wvzajVzmg1OYwlwje68GEQzJYoc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FVfOmjXpdGN1iChBHXfUzCwCIRi9mdpdRCDSEMBqtkoAXBvgG4GlNt3Lljq43AcV5
         7ekywnJtB6H8UCce1BQpmuV/y3Dev07femkjjxHqrCQeYcvHOnOV2y6Hd7dzsdsnly
         s2yAfWzBcdFNuNUba9h3sUT7+HUkI1e4NYQYIfok=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B88860795
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] time: Fix sleeptime injection for non-stop clocksource
 & persistent clock
To:     john.stultz@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     neeraju@codeaurora.org, gkohli@codeaurora.org,
        cpandya@codeaurora.org
References: <1527680699-16068-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <19644aab-d5dc-aace-48da-5df1587da873@codeaurora.org>
Date:   Thu, 14 Jun 2018 19:37:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527680699-16068-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any input on this ?

Thanks,
Mukesh
On 5/30/2018 5:14 PM, Mukesh Ojha wrote:
> Currently, for both non-stop clocksource and persistent clock
> there is a corner case, when a driver failed to go suspend mode.
> rtc_resume() injects the sleeptime as timekeeping_rtc_skipresume()
> returned 'false'(sleeptime_injected=false) due to which we can
> see mismatch in timestamps between system clock and other timers.
>
> Fix this by updating sleeptime_injected=true for both non-stop
> clocksource and persistent clock.
>
> Success case:
> ------------
>                                           {sleeptime_injected=true}
> rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>
>    rtc_resume()
>
> Failure case:
> ------------
>               {failure in sleep path} {sleeptime_injected=false}
> rtc_suspend()          =>            rtc_resume()
>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
> Changes in v2:
>   * Updated the commit text.
>   * Removed extra variable and used the earlier static
>     variable 'sleeptime_injected'.
>
>   kernel/time/timekeeping.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 49cbcee..2754c1b 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1610,6 +1610,17 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
>    */
>   bool timekeeping_rtc_skipresume(void)
>   {
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	/*
> +	 * This is to ensure that we don't end up injecting
> +	 * the sleeptime via rtc_resume() for non-stop clocksource
> +	 * when we fail to sleep.
> +	 */
> +	if (!sleeptime_injected)
> +		sleeptime_injected = ((tk->tkr_mono.clock->flags &
> +			CLOCK_SOURCE_SUSPEND_NONSTOP) ||
> +			(persistent_clock_exists)) ? true : false;
> +
>   	return sleeptime_injected;
>   }
>   

