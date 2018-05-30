Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeE3K1J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:27:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60092 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeE3K1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:27:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 141C860261
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH RESEND] time: Fix sleeptime injection for non-stop
 clocksource & persistent clock
To: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, neeraju@codeaurora.org,
        gkohli@codeaurora.org, cpandya@codeaurora.org
References: <1527587351-26634-1-git-send-email-mojha@codeaurora.org>
 <CALAqxLWsD7rpgGYhdpDCVuH3Sss+RkqmFgunDejFYpKZ7=JTng@mail.gmail.com>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <76bd29b8-c8af-b5ac-3538-b6a97afb6ab1@codeaurora.org>
Date: Wed, 30 May 2018 15:57:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLWsD7rpgGYhdpDCVuH3Sss+RkqmFgunDejFYpKZ7=JTng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,


On 5/30/2018 7:50 AM, John Stultz wrote:
> On Tue, May 29, 2018 at 2:49 AM, Mukesh Ojha <mojha@codeaurora.org> wrote:
>> Currently, for both non-stop clocksource and persistent clock
>> there is a corner case, when a driver failed to go suspend mode
>> rtc_resume() injects the sleeptime as timekeeping_rtc_skipresume()
>> returned 'false' due to which we can see mismatch in time between
>> system clock and other timers.
>>
>> Success case:
>>                                           {sleeptime_injected=true}
>> rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>
>>    rtc_resume()
>>
>> Failure case:
>>               {failure in sleep path} {sleeptime_injected=false}
>> rtc_suspend()          =>            rtc_resume()
>>
>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> I'm not sure this patch makes sense yet (since I don't really see how
> its used

In a system where both non-stop clocksource and rtc exist

Timestamp mismatch seen between a (Gyro)timer based on non-stop clocksource
and system clock after attempting a sleep.
Here, System clock timestamps increase by some millisecond as compare to
other timer.

And we see this is possible only when timekeeping_resume() has not been 
called
which is keeping sleeptime_injected to its default value(false). So, the 
call to
timekeeping_rtc_skipresume() in rtc_resume() is false and thats ends up in
sleeptime injection via rtc_resume().


When timekeeping_resume() has not been called means one of the driver failed
during suspend in syscore_suspend() in kernel/power/suspend.c .

So if we let rtc inject the sleeptime here, we would see the timestamp 
increase in case of
system clock.

>   - mind cc'ing me on the patch that makes use of this?)
>
> And more problematic, the patch doesn't seem to apply to mainline.
> Could you respin and resend?

Will spin the patch again with some minor code change.

Thanks,
Mukesh

>
> thanks
> -john
