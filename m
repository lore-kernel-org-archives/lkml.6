Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A271AECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC2C20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LAxcCg54";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XqWECxvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC2C20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeGPQqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:46:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53704 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeGPQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:46:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 200AA6074D; Mon, 16 Jul 2018 16:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531757880;
        bh=Tu/qOBBRIdehrViG7WJFmtOdAXKyal51igVPRgPblrY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LAxcCg54CKps0EFi0xcq7s9zwMeCcfJHP6Unmll/kqCjhLLkLD+2tSeW5X4tWvvcK
         R4PNv//0KhBxuwgOQ5hRGXmYafYPaUxlYsv18SXV0o+ObndQTIJv8qshL+7ecUeBZ1
         6AIf+jYdfJftWy8f81xStZNwKuYW0ijLuIiS6i6c=
Received: from [10.79.175.48] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 892AA60541;
        Mon, 16 Jul 2018 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531757879;
        bh=Tu/qOBBRIdehrViG7WJFmtOdAXKyal51igVPRgPblrY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XqWECxvBvuBGMXeJ1rZVfTFvW35L4bVuKSHCyjQ3tY0pZ04G/kGe1C2/TNjkZGgoW
         z1V9w/DcOyF0uQ4565cBAkMby1jl/LWTqtQW8oVpEZp1EBjdMCIEnVFUKu3YG7Hrd9
         Ey/ZgMHPq7cClmLynWHzLUoB8eSYao+VpT4cim04=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 892AA60541
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
 <7e25b63e-cc9b-1f6d-e3d2-087dd484f631@codeaurora.org>
 <CALAqxLX=-ZZV=O7AAZwMYaXZ1s5h91BfFng4qbtgvkvrKtxgaw@mail.gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <45be9c4f-34fd-200a-df95-9c30b332a96b@codeaurora.org>
Date:   Mon, 16 Jul 2018 21:47:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLX=-ZZV=O7AAZwMYaXZ1s5h91BfFng4qbtgvkvrKtxgaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/13/2018 10:50 PM, John Stultz wrote:
> On Fri, Jul 13, 2018 at 12:13 AM, Mukesh Ojha <mojha@codeaurora.org> wrote:
>> Hi John,
>>
>> Thanks for your response
>> Please find my comments inline.
>>
>>
>> On 7/11/2018 1:43 AM, John Stultz wrote:
>>> On Fri, Jul 6, 2018 at 6:17 AM, Mukesh Ojha <mojha@codeaurora.org> wrote:
>>>> Currently, there exists a corner case assuming when there is
>>>> only one clocksource e.g RTC, and system failed to go to
>>>> suspend mode. While resume rtc_resume() injects the sleeptime
>>>> as timekeeping_rtc_skipresume() returned 'false' (default value
>>>> of sleeptime_injected) due to which we can see mismatch in
>>>> timestamps.
>>>>
>>>> This issue can also come in a system where more than one
>>>> clocksource are present and very first suspend fails.
>>>>
>>>> Fix this by handling `sleeptime_injected` flag properly.
>>>>
>>>> Success case:
>>>> ------------
>>>>                                           {sleeptime_injected=false}
>>>> rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>
>>>>
>>>> (sleeptime injected)
>>>>    rtc_resume()
>>>>
>>>> Failure case:
>>>> ------------
>>>>            {failure in sleep path} {sleeptime_injected=false}
>>>> rtc_suspend()     =>          rtc_resume()
>>>>
>>>> sleeptime injected again which was not required as the suspend failed)
>>>>
>>>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>>>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>>>> ---
>>>> Changes in v3:
>>>>    * Updated commit subject and description.
>>>>    * Updated the patch as per the fix given by Thomas Gleixner.
>>>>
>>>> Changes in v2:
>>>>    * Updated the commit text.
>>>>    * Removed extra variable and used the earlier static
>>>>      variable 'sleeptime_injected'.
>>>>
>>>>    kernel/time/timekeeping.c | 21 ++++++++++++++++++---
>>>>    1 file changed, 18 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>>>> index 4786df9..32ae9ae 100644
>>>> --- a/kernel/time/timekeeping.c
>>>> +++ b/kernel/time/timekeeping.c
>>>> @@ -1510,8 +1510,20 @@ void __weak read_boot_clock64(struct timespec64
>>>> *ts)
>>>>           ts->tv_nsec = 0;
>>>>    }
>>>>
>>>> -/* Flag for if timekeeping_resume() has injected sleeptime */
>>>> -static bool sleeptime_injected;
>>>> +/*
>>>> + * Flag reflecting whether timekeeping_resume() has injected sleeptime.
>>>> + *
>>>> + * The flag starts of true and is only cleared when a suspend reaches
>>>> + * timekeeping_suspend(), timekeeping_resume() sets it when the
>>>> timekeeper
>>>> + * clocksource is not stopping across suspend and has been used to
>>>> update
>>>> + * sleep time. If the timekeeper clocksource has stopped then the flag
>>>> + * stays false and is used by the RTC resume code to decide whether
>>>> sleep
>>>> + * time must be injected and if so the flag gets set then.
>>>> + *
>>>> + * If a suspend fails before reaching timekeeping_resume() then the flag
>>>> + * stays true and prevents erroneous sleeptime injection.
>>>> + */
>>>> +static bool sleeptime_injected = true;
>>> I worry this upside-down logic is too subtle to be easily reasoned
>>> about, and will just lead to future mistakes.
>>>
>>> Can we instead call this "suspend_timing_needed" and only set it to
>>> true when we don't inject any sleep time on resume?
>>
>> I did not get your point "only set it to true when we don't inject any sleep
>> time on resume? "
>> How do we know  this ?
>> This question itself depends on the "sleeptime_injected" if it is true means
>> no need to inject else need to inject.
>>
>> Also, we need to make this variable back and forth true, false; suspends
>> path ensures it to make it false.
> So yea, I'm not saying logically the code is really any different,
> this is more of a naming nit. So instead of having a variable that is
> always on that we occasionally turn off, lets invert the naming and
> have it be a flag that we occasionally turn on.

I understand your concern about the name of the variable will be misleading.
But the changing Boolean state would not solve the actual issue.

If i understand you correctly you meant below code

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 32ae9ae..becc5bd 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1523,7 +1523,7 @@ void __weak read_boot_clock64(struct timespec64 *ts)
   * If a suspend fails before reaching timekeeping_resume() then the flag
   * stays true and prevents erroneous sleeptime injection.
   */
-static bool sleeptime_injected = true;
+static bool suspend_timing_needed;

  /* Flag for if there is a persistent clock on this platform */
  static bool persistent_clock_exists;
@@ -1658,7 +1658,7 @@ void timekeeping_inject_sleeptime64(struct 
timespec64 *delta)
         raw_spin_lock_irqsave(&timekeeper_lock, flags);
         write_seqcount_begin(&tk_core.seq);

-       sleeptime_injected = true;
+       suspend_timing_needed = false;

         timekeeping_forward_now(tk);

@@ -1714,10 +1714,10 @@ void timekeeping_resume(void)
                                               tk->tkr_mono.mask);
                 nsec = mul_u64_u32_shr(cyc_delta, clock->mult, 
clock->shift);
                 ts_delta = ns_to_timespec64(nsec);
-               sleeptime_injected = true;
+               suspend_timing_needed = true;
         } else if (timespec64_compare(&ts_new, 
&timekeeping_suspend_time) > 0) {
                 ts_delta = timespec64_sub(ts_new, 
timekeeping_suspend_time);
-               sleeptime_injected = true;
+               suspend_timing_needed = true;
         }

         if (sleeptime_injected)
@@ -1756,7 +1756,7 @@ int timekeeping_suspend(void)
         if (timekeeping_suspend_time.tv_sec || 
timekeeping_suspend_time.tv_nsec)
                 persistent_clock_exists = true;

-       sleeptime_injected = false;
+       suspend_timing_needed = false;

         raw_spin_lock_irqsave(&timekeeper_lock, flags);


This has a problem..


>
> Just the name sleeptime_injected is read a statement, which if we say
> is defaults to true, becomes confusing to think about when the
> timekeeping_suspend/resume code hasn't yet run (which is the case
> where your error cropped up) - and no sleeptime has actually been
> injected.

Yes, when very first suspend fails and timekeeping_suspend/resume did 
not run ; That is the exact issue.
So, exact solution is no need to inject any sleeptime here.

  If we set the default value to false then we will see 
timekeeping_resume will inject sleeptime by below code which was not 
intended.

static int rtc_resume(struct device *dev)
{
         struct rtc_device       *rtc = to_rtc_device(dev);
         struct rtc_time         tm;
         struct timespec64       new_system, new_rtc;
         struct timespec64       sleep_time;
         int err;

         if (timekeeping_rtc_skipresume())  // it will return the value 
false as sleep failed and timekeeping_resume() did not get called.
                 return 0;

   <sleeptime injection happens here>
....
..


>
> So instead if we call it suspend_timing_needed and only set it on in
> timekeeping_resume() after the timekeeping code has not injected any
> sleep-time, then I think the code will make more sense to read. (And
> yes, we still need to set suspend_timing_needed false on
> timekeeping_suspend and in the inject_sleeptime call path - the logic
> doesn't change, just the naming and boolean state).

Thanks for your time and patience.

-Mukesh

> thanks
> -john

