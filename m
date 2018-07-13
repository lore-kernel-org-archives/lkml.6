Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B723ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FADD20854
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIFeDm43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FADD20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeGMRgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:36:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40472 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbeGMRgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:36:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so25824279wrn.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dn+Bph2u+s2kvXX976dZhlU7pRRj9I7o9bg1xcEI9V8=;
        b=UIFeDm43CxdURUVElIuOVNiaPXJvyKB9of4hq3E5vfOOpH0JDTfcISnZyR1iMfJbQ1
         dPk0z11mGXIRY4lQYjbcCVw1mbjKZrmQa5Q96ogRkjKlshOOA/qwdOOkT2kutf3d7eiZ
         Lmy0DVMWgCTYNY65MSS4Fyz0gy/UVv/gl+vUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dn+Bph2u+s2kvXX976dZhlU7pRRj9I7o9bg1xcEI9V8=;
        b=KMcGtVonw9P902+Zl9kmUy5MLrXX2/70LSa3JY84zCEvbwfncvVYRZ5ldwxLlp0Vnz
         3XO6uZXlDL43m4Cjg6bFiG+prJh/B9C3GLmzSEYKKeJRqA9v4LW0cIB7O9OUs0BkvCGr
         LIWNgSiT3dIjVo5As5RDjgcYASFj7+p1HztWkjNHV0BiTVx8O/wp52Qb7YiJVt2dqnpT
         ZG/3I1ohqkoq9zCC3j1ERZSxoLSg5s3fKw03qVKTyKLZ3RhAEcka+Z3lBXbmZLjlsJxt
         zapDSy9AKUn392s5U0Qe2ktzsDWQ4Xk86I4Gx2qO4oqSUsW9FJEhlDSk2Or0DS2VhIAC
         efnw==
X-Gm-Message-State: AOUpUlFG1XrcsPSZ9yWYTWOZNA6O0xEejBozHVSK/ftAFPuY6tmdyqPQ
        NaSCRGhN4j7eQbjiS0U5ob7OpSlfcBSDOd8b0ZabEw==
X-Google-Smtp-Source: AAOMgpcInROM+CwLksnExCol+3jCEVVr/vZP9sGGxPFYg10L3dPjg3wkNXVtnFiS2vl2FqkCg/HNE6lq4SYFm3pMCnA=
X-Received: by 2002:adf:8296:: with SMTP id 22-v6mr5407757wrc.252.1531502431540;
 Fri, 13 Jul 2018 10:20:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c202:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 10:20:30
 -0700 (PDT)
In-Reply-To: <7e25b63e-cc9b-1f6d-e3d2-087dd484f631@codeaurora.org>
References: <1530883047-17452-1-git-send-email-mojha@codeaurora.org>
 <CALAqxLVs=EbbJ83bw=YRb=1B7E2uLcnrUh+qWEjm9U3iYd7FAg@mail.gmail.com> <7e25b63e-cc9b-1f6d-e3d2-087dd484f631@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 13 Jul 2018 10:20:30 -0700
Message-ID: <CALAqxLX=-ZZV=O7AAZwMYaXZ1s5h91BfFng4qbtgvkvrKtxgaw@mail.gmail.com>
Subject: Re: [PATCH v3] time: Fix incorrect sleeptime injection when suspend fails
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, gkohli@codeaurora.org,
        cpandya@codeaurora.org, neeraju@codeaurora.org,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 12:13 AM, Mukesh Ojha <mojha@codeaurora.org> wrote:
> Hi John,
>
> Thanks for your response
> Please find my comments inline.
>
>
> On 7/11/2018 1:43 AM, John Stultz wrote:
>>
>> On Fri, Jul 6, 2018 at 6:17 AM, Mukesh Ojha <mojha@codeaurora.org> wrote:
>>>
>>> Currently, there exists a corner case assuming when there is
>>> only one clocksource e.g RTC, and system failed to go to
>>> suspend mode. While resume rtc_resume() injects the sleeptime
>>> as timekeeping_rtc_skipresume() returned 'false' (default value
>>> of sleeptime_injected) due to which we can see mismatch in
>>> timestamps.
>>>
>>> This issue can also come in a system where more than one
>>> clocksource are present and very first suspend fails.
>>>
>>> Fix this by handling `sleeptime_injected` flag properly.
>>>
>>> Success case:
>>> ------------
>>>                                          {sleeptime_injected=false}
>>> rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>
>>>
>>> (sleeptime injected)
>>>   rtc_resume()
>>>
>>> Failure case:
>>> ------------
>>>           {failure in sleep path} {sleeptime_injected=false}
>>> rtc_suspend()     =>          rtc_resume()
>>>
>>> sleeptime injected again which was not required as the suspend failed)
>>>
>>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>>> ---
>>> Changes in v3:
>>>   * Updated commit subject and description.
>>>   * Updated the patch as per the fix given by Thomas Gleixner.
>>>
>>> Changes in v2:
>>>   * Updated the commit text.
>>>   * Removed extra variable and used the earlier static
>>>     variable 'sleeptime_injected'.
>>>
>>>   kernel/time/timekeeping.c | 21 ++++++++++++++++++---
>>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>>> index 4786df9..32ae9ae 100644
>>> --- a/kernel/time/timekeeping.c
>>> +++ b/kernel/time/timekeeping.c
>>> @@ -1510,8 +1510,20 @@ void __weak read_boot_clock64(struct timespec64
>>> *ts)
>>>          ts->tv_nsec = 0;
>>>   }
>>>
>>> -/* Flag for if timekeeping_resume() has injected sleeptime */
>>> -static bool sleeptime_injected;
>>> +/*
>>> + * Flag reflecting whether timekeeping_resume() has injected sleeptime.
>>> + *
>>> + * The flag starts of true and is only cleared when a suspend reaches
>>> + * timekeeping_suspend(), timekeeping_resume() sets it when the
>>> timekeeper
>>> + * clocksource is not stopping across suspend and has been used to
>>> update
>>> + * sleep time. If the timekeeper clocksource has stopped then the flag
>>> + * stays false and is used by the RTC resume code to decide whether
>>> sleep
>>> + * time must be injected and if so the flag gets set then.
>>> + *
>>> + * If a suspend fails before reaching timekeeping_resume() then the flag
>>> + * stays true and prevents erroneous sleeptime injection.
>>> + */
>>> +static bool sleeptime_injected = true;
>>
>> I worry this upside-down logic is too subtle to be easily reasoned
>> about, and will just lead to future mistakes.
>>
>> Can we instead call this "suspend_timing_needed" and only set it to
>> true when we don't inject any sleep time on resume?
>
>
> I did not get your point "only set it to true when we don't inject any sleep
> time on resume? "
> How do we know  this ?
> This question itself depends on the "sleeptime_injected" if it is true means
> no need to inject else need to inject.
>
> Also, we need to make this variable back and forth true, false; suspends
> path ensures it to make it false.

So yea, I'm not saying logically the code is really any different,
this is more of a naming nit. So instead of having a variable that is
always on that we occasionally turn off, lets invert the naming and
have it be a flag that we occasionally turn on.

Just the name sleeptime_injected is read a statement, which if we say
is defaults to true, becomes confusing to think about when the
timekeeping_suspend/resume code hasn't yet run (which is the case
where your error cropped up) - and no sleeptime has actually been
injected.

So instead if we call it suspend_timing_needed and only set it on in
timekeeping_resume() after the timekeeping code has not injected any
sleep-time, then I think the code will make more sense to read. (And
yes, we still need to set suspend_timing_needed false on
timekeeping_suspend and in the inject_sleeptime call path - the logic
doesn't change, just the naming and boolean state).

thanks
-john
