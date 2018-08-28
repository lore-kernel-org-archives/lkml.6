Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA70C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E3C2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E3C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=softrans.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeH1T2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:28:35 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:60563 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726961AbeH1T2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:28:35 -0400
Received: from smtp.starsoftware.com.au (n175-33-133-183.meb2.vic.optusnet.com.au [175.33.133.183])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTP id 82797D69AAC;
        Wed, 29 Aug 2018 01:36:20 +1000 (AEST)
Received: from [192.168.0.7] (unknown [192.168.0.1])
        by smtp.starsoftware.com.au (Postfix) with ESMTP id 76EBD677E6BF;
        Wed, 29 Aug 2018 01:36:19 +1000 (AEST)
Subject: Re: [RESEND PATCH] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180817121251.4EB5318E01A1@virtux64.softrans.com.au>
 <CALCETrXY=PSdp6mpQ89yBQPsMrDj7j2p8AyLR1o4_+heiMzRbQ@mail.gmail.com>
From:   Matthew Rickard <matt@softrans.com.au>
Message-ID: <bcbd99e0-2e83-e220-18d1-4ec0cd474475@softrans.com.au>
Date:   Wed, 29 Aug 2018 01:36:19 +1000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALCETrXY=PSdp6mpQ89yBQPsMrDj7j2p8AyLR1o4_+heiMzRbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=DZtnkrlW c=1 sm=1 tr=0
        a=0SUgGFgJIhXJJGNlngNSLg==:117 a=0SUgGFgJIhXJJGNlngNSLg==:17
        a=IkcTkHD0fZMA:10 a=dapMudl6Dx4A:10 a=PIVNZ80yAAAA:8
        a=wwZdJBu_NBOgZ5g5YMoA:9 a=QEXdDO2ut3YA:10 a=3YJQTRF3V1zcZZCg0gjL:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the before and after times with CONFIG_RETPOLINE=y always on.
I don't see any regression, just the hoped-for improvement on glibc and
vDSO calls of CLOCK_TAI.

Before:
        sec Timestamp                   nanos clockname    tzname type
---------- --------------------------- ----- --------- --------- -------
1535445844 2018/08/28 08:44:04.338599419  96 CLOCK_REALTIME  UTC 0 glibc
1535445844 2018/08/28 08:44:04.348494684  87 CLOCK_REALTIME  UTC 1 vdso
1535445844 2018/08/28 08:44:04.357328913 321 CLOCK_REALTIME  UTC 2 sys
1535445834 2018/08/28 08:43:27.507099055 233 CLOCK_TAI right/UTC 0 glibc
1535445834 2018/08/28 08:43:27.530666383 239 CLOCK_TAI right/UTC 1 vdso
1535445834 2018/08/28 08:43:27.554827262 389 CLOCK_TAI right/UTC 2 sys
         80 1970/01/01 00:01:20.593942210  88 CLOCK_MONOTONIC UTC 0 glibc
         80 1970/01/01 00:01:20.602866312  84 CLOCK_MONOTONIC UTC 1 vdso
         80 1970/01/01 00:01:20.611322392 272 CLOCK_MONOTONIC UTC 2 sys
         80 1970/01/01 00:01:20.638630685 298 CLOCK_BOOTTIME  UTC 0 glibc
         80 1970/01/01 00:01:20.668487920 293 CLOCK_BOOTTIME  UTC 1 vdso
         80 1970/01/01 00:01:20.697818847 279 CLOCK_BOOTTIME  UTC 2 sys

After yours and my patches:
        sec Timestamp                   nanos clockname    tzname type
---------- --------------------------- ----- --------- --------- -------
1535466985 2018/08/28 14:36:25.483377529  93 CLOCK_REALTIME  UTC 0 glibc
1535466985 2018/08/28 14:36:25.493020681  89 CLOCK_REALTIME  UTC 1 vdso
1535466985 2018/08/28 14:36:25.502139080 282 CLOCK_REALTIME  UTC 2 sys
1535466975 2018/08/28 14:35:48.530621935  87 CLOCK_TAI right/UTC 0 glibc
1535466975 2018/08/28 14:35:48.539393751  81 CLOCK_TAI right/UTC 1 vdso
1535466975 2018/08/28 14:35:48.547693183 276 CLOCK_TAI right/UTC 2 sys
        224 1970/01/01 00:03:44.575542852  87 CLOCK_MONOTONIC UTC 0 glibc
        224 1970/01/01 00:03:44.584329822  81 CLOCK_MONOTONIC UTC 1 vdso
        224 1970/01/01 00:03:44.592473982 269 CLOCK_MONOTONIC UTC 2 sys
        224 1970/01/01 00:03:44.619450784 296 CLOCK_BOOTTIME  UTC 0 glibc
        224 1970/01/01 00:03:44.649224430 312 CLOCK_BOOTTIME  UTC 1 vdso
        224 1970/01/01 00:03:44.680600544 297 CLOCK_BOOTTIME  UTC 2 sys

-Matt-

On 25/08/2018 3:47 AM, Andy Lutomirski wrote:
> Minor nit: if it's not literally a resend, don't call it "RESEND" in
> $SUBJECT.  Call it v2, please.
> 
> Also, I added LKML and relevant maintainers to cc.  John and Stephen:
> this is a purely x86 patch, but it digs into the core timekeeping
> structures a bit.
> 
> On Fri, Aug 17, 2018 at 5:12 AM, Matt Rickard <matt@softrans.com.au> wrote:
>> Process clock_gettime(CLOCK_TAI) in vDSO. This makes the call about as fast as
>> CLOCK_REALTIME instead of taking about four times as long.
> 
> I'm conceptually okay with this, but the bug encountered last time
> around makes me suspect that GCC is generating genuinely horrible
> code.  Can you benchmark CLOCK_MONOTONIC before and after to make sure
> there isn't a big regression?  Please do this benchmark with
> CONFIG_RETPOLINE=y.
> 
> If there is a regression, then the code will need some reasonable
> restructuring to fix it.  Or perhaps -fno-jump-tables.
> 
> --Andy
> 
>> Signed-off-by: Matt Rickard <matt@softrans.com.au>
>> ---
>>   arch/x86/entry/vdso/vclock_gettime.c    | 25 +++++++++++++++++++++++++
>>   arch/x86/entry/vsyscall/vsyscall_gtod.c |  2 ++
>>   arch/x86/include/asm/vgtod.h            |  1 +
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
>> index f19856d95c60..91ed1bb2a3bb 100644
>> --- a/arch/x86/entry/vdso/vclock_gettime.c
>> +++ b/arch/x86/entry/vdso/vclock_gettime.c
>> @@ -246,6 +246,27 @@ notrace static int __always_inline do_monotonic(struct timespec *ts)
>>          return mode;
>>   }
>>
>> +notrace static int __always_inline do_tai(struct timespec *ts)
>> +{
>> +       unsigned long seq;
>> +       u64 ns;
>> +       int mode;
>> +
>> +       do {
>> +               seq = gtod_read_begin(gtod);
>> +               mode = gtod->vclock_mode;
>> +               ts->tv_sec = gtod->tai_time_sec;
>> +               ns = gtod->wall_time_snsec;
>> +               ns += vgetsns(&mode);
>> +               ns >>= gtod->shift;
>> +       } while (unlikely(gtod_read_retry(gtod, seq)));
>> +
>> +       ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
>> +       ts->tv_nsec = ns;
>> +
>> +       return mode;
>> +}
>> +
>>   notrace static void do_realtime_coarse(struct timespec *ts)
>>   {
>>          unsigned long seq;
>> @@ -277,6 +298,10 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
>>                  if (do_monotonic(ts) == VCLOCK_NONE)
>>                          goto fallback;
>>                  break;
>> +       case CLOCK_TAI:
>> +               if (do_tai(ts) == VCLOCK_NONE)
>> +                       goto fallback;
>> +               break;
>>          case CLOCK_REALTIME_COARSE:
>>                  do_realtime_coarse(ts);
>>                  break;
>> diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
>> index e1216dd95c04..d61392fe17f6 100644
>> --- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
>> +++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
>> @@ -53,6 +53,8 @@ void update_vsyscall(struct timekeeper *tk)
>>          vdata->monotonic_time_snsec     = tk->tkr_mono.xtime_nsec
>>                                          + ((u64)tk->wall_to_monotonic.tv_nsec
>>                                                  << tk->tkr_mono.shift);
>> +       vdata->tai_time_sec             = tk->xtime_sec
>> +                                       + tk->tai_offset;
>>          while (vdata->monotonic_time_snsec >=
>>                                          (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
>>                  vdata->monotonic_time_snsec -=
>> diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
>> index fb856c9f0449..adc9f7b20b9c 100644
>> --- a/arch/x86/include/asm/vgtod.h
>> +++ b/arch/x86/include/asm/vgtod.h
>> @@ -32,6 +32,7 @@ struct vsyscall_gtod_data {
>>          gtod_long_t     wall_time_coarse_nsec;
>>          gtod_long_t     monotonic_time_coarse_sec;
>>          gtod_long_t     monotonic_time_coarse_nsec;
>> +       gtod_long_t     tai_time_sec;
>>
>>          int             tz_minuteswest;
>>          int             tz_dsttime;
