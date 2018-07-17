Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970A4208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zn2Zrkb0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NJaOpSwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970A4208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeGQHAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:00:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeGQHAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:00:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50C426063A; Tue, 17 Jul 2018 06:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531808955;
        bh=AZ3kL6Y+z0xeG7jB2/34I/IukEXLJE52goODusuc8C4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Zn2Zrkb0LiE5t5Q1KHVderF5Civun/j9nSLFEIuFCPxFc8xrYGTXlcDUeRqIwINLB
         mpkgd7pKdMZedWImn4CBnqZFyilWptN9zf+TD1Hmg/xp+/NJdAMpI/5m/gH3WUPMpA
         ZBElOofJrTcZPHJ5REQNZ5q44wF8V/RN3snLROiE=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 252EC6063A;
        Tue, 17 Jul 2018 06:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531808954;
        bh=AZ3kL6Y+z0xeG7jB2/34I/IukEXLJE52goODusuc8C4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NJaOpSwqXu6fSyxiWgsntPy5tnC4tjcVc+DnbDb4+ODOTbpzbfjSNqfXvd/AqoqyN
         MwubTnXtA6lzkaLpl1vgBxIwj63VXyGxrDWgCyxGMKQhyOtpA6WCYPgK+Q4UAgMr0I
         sLInJ//cWkDHY0wddK42AwXNfJeYVWDpMjn0g8FE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 252EC6063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v4] time: Fix extra sleeptime injection when suspend fails
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, gkohli@codeaurora.org,
        cpandya@codeaurora.org, neeraju@codeaurora.org
References: <1531773650-30424-1-git-send-email-mojha@codeaurora.org>
 <CALAqxLVMaU4FJ1xu78ow=FwSbmQObw0-HGBUTpgr27vjKTOqrw@mail.gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <793798fc-4c5a-da9a-2ca4-35fc1c39eb00@codeaurora.org>
Date:   Tue, 17 Jul 2018 11:59:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLVMaU4FJ1xu78ow=FwSbmQObw0-HGBUTpgr27vjKTOqrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2018 2:31 AM, John Stultz wrote:
> On Mon, Jul 16, 2018 at 1:40 PM, Mukesh Ojha <mojha@codeaurora.org> wrote:
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
>> Fix this by handling the sleeptime_injected flag properly.
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
>> Changes in V4:
>>   * Changes as suggested by John
>>      - Changed the variable name from sleeptime_injected to suspend_timing_needed
>>      - Changed the boolean logic.
> Thanks so much for reworking and resending this again!
>
>
>> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
>> index d37588f..ee455cc 100644
>> --- a/drivers/rtc/class.c
>> +++ b/drivers/rtc/class.c
>> @@ -102,7 +102,7 @@ static int rtc_resume(struct device *dev)
>>          struct timespec64       sleep_time;
>>          int err;
>>
>> -       if (timekeeping_rtc_skipresume())
>> +       if (!timekeeping_rtc_skipresume())
>
> Hrm... So I'd have instead inverted the logic *in*
> timekeeping_rtc_skipresume(), rather then here,  but this looks to be
> close enough and I can fix that bit up.

Will take care of yours and Thomas comment in v5.

>
> Can you confirm you've validated this version of the patch resolves
> the issue you reported?
Yeah, I validated.

Thanks
Mukesh


>
> thanks
> -john

