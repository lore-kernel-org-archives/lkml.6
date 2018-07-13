Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1E62124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hMBofH3o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IQIDxTKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1E62124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbeGMH0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:26:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34328 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbeGMH0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:26:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6EEA760B72; Fri, 13 Jul 2018 07:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531466008;
        bh=4EOupMgPZK67tDxQvww4+iZ9OmN9lwH8iZT+EV39QbE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hMBofH3oV0uqVS5VwFfd350nFWkNChncxNL7wULW9e/RaDn8vYwMcSNNmuJaSPEZe
         Joh3Xm0Lvay7y1+32j7uAzBReYkZAltCLkopgwHNFVPOtYQJQSnwnUrfQC47ruXIFl
         YnveNfsMkU5p2b45kgg17gNFtXcODUOSp29jqTVg=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA85B6078C;
        Fri, 13 Jul 2018 07:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531466007;
        bh=4EOupMgPZK67tDxQvww4+iZ9OmN9lwH8iZT+EV39QbE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IQIDxTKSSPRirfMs3P11+o5dfWp/UU8J9PCFZQN2Mq7FEnl9cFbEOu3lsmE4CCXdf
         1ieHMZfB94Gzz2cxSe1CTd1fN5jqwIkGO64N2zUdp3R8oBY6dnzjGWaJSdGufwNxp6
         p2cUbgrdA+ru1hvNxZ2bNYNEHFJI0mZYhKjahI+c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA85B6078C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3] time: Fix incorrect sleeptime injection when suspend
 fails
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, gkohli@codeaurora.org,
        cpandya@codeaurora.org, neeraju@codeaurora.org,
        Baolin Wang <baolin.wang@linaro.org>
References: <1530883047-17452-1-git-send-email-mojha@codeaurora.org>
 <CALAqxLVs=EbbJ83bw=YRb=1B7E2uLcnrUh+qWEjm9U3iYd7FAg@mail.gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <7e25b63e-cc9b-1f6d-e3d2-087dd484f631@codeaurora.org>
Date:   Fri, 13 Jul 2018 12:43:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLVs=EbbJ83bw=YRb=1B7E2uLcnrUh+qWEjm9U3iYd7FAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks for your response
Please find my comments inline.

On 7/11/2018 1:43 AM, John Stultz wrote:
> On Fri, Jul 6, 2018 at 6:17 AM, Mukesh Ojha <mojha@codeaurora.org> wrote:
>> Currently, there exists a corner case assuming when there is
>> only one clocksource e.g RTC, and system failed to go to
>> suspend mode. While resume rtc_resume() injects the sleeptime
>> as timekeeping_rtc_skipresume() returned 'false' (default value
>> of sleeptime_injected) due to which we can see mismatch in
>> timestamps.
>>
>> This issue can also come in a system where more than one
>> clocksource are present and very first suspend fails.
>>
>> Fix this by handling `sleeptime_injected` flag properly.
>>
>> Success case:
>> ------------
>>                                          {sleeptime_injected=false}
>> rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>
>>
>> (sleeptime injected)
>>   rtc_resume()
>>
>> Failure case:
>> ------------
>>           {failure in sleep path} {sleeptime_injected=false}
>> rtc_suspend()     =>          rtc_resume()
>>
>> sleeptime injected again which was not required as the suspend failed)
>>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>> ---
>> Changes in v3:
>>   * Updated commit subject and description.
>>   * Updated the patch as per the fix given by Thomas Gleixner.
>>
>> Changes in v2:
>>   * Updated the commit text.
>>   * Removed extra variable and used the earlier static
>>     variable 'sleeptime_injected'.
>>
>>   kernel/time/timekeeping.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> index 4786df9..32ae9ae 100644
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -1510,8 +1510,20 @@ void __weak read_boot_clock64(struct timespec64 *ts)
>>          ts->tv_nsec = 0;
>>   }
>>
>> -/* Flag for if timekeeping_resume() has injected sleeptime */
>> -static bool sleeptime_injected;
>> +/*
>> + * Flag reflecting whether timekeeping_resume() has injected sleeptime.
>> + *
>> + * The flag starts of true and is only cleared when a suspend reaches
>> + * timekeeping_suspend(), timekeeping_resume() sets it when the timekeeper
>> + * clocksource is not stopping across suspend and has been used to update
>> + * sleep time. If the timekeeper clocksource has stopped then the flag
>> + * stays false and is used by the RTC resume code to decide whether sleep
>> + * time must be injected and if so the flag gets set then.
>> + *
>> + * If a suspend fails before reaching timekeeping_resume() then the flag
>> + * stays true and prevents erroneous sleeptime injection.
>> + */
>> +static bool sleeptime_injected = true;
> I worry this upside-down logic is too subtle to be easily reasoned
> about, and will just lead to future mistakes.
>
> Can we instead call this "suspend_timing_needed" and only set it to
> true when we don't inject any sleep time on resume?

I did not get your point "only set it to true when we don't inject any 
sleep time on resume? "
How do we know  this ?
This question itself depends on the "sleeptime_injected" if it is true 
means no need to inject else need to inject.

Also, we need to make this variable back and forth true, false; suspends 
path ensures it to make it false.

Just to add here there are already two path where `sleeptime_injected` 
set to true one from
NON-stop clocksource and other from persistant clock and the RTC one was 
missing, so we are adding
with this patch.

Cheers,
-Mukesh


