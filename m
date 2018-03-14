Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeCNWCN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:02:13 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:41470 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNWCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:02:12 -0400
X-Google-Smtp-Source: AG47ELtEVRlpV9QRQchFivWN0v8c1Pudc9GWIKhsNPyjF67HWn05GvBdx/0izAcWGruIatXFfYS5jRT8IpywPySlz8A=
MIME-Version: 1.0
In-Reply-To: <20180310081123.thin6wphgk7tongy@gmail.com>
References: <1520620971-9567-1-git-send-email-john.stultz@linaro.org>
 <1520620971-9567-4-git-send-email-john.stultz@linaro.org> <20180310081123.thin6wphgk7tongy@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 23:02:10 +0100
X-Google-Sender-Auth: 8aKrr8vGgoREbuNJYsfyL0NpBXE
Message-ID: <CAK8P3a1PGEk2WDQU8i7H64Cw4dmYaJ-6vPLzW_2o23PTgm74JA@mail.gmail.com>
Subject: Re: [PATCH 3/4] y2038: time: Introduce struct __kernel_old_timeval
To: Ingo Molnar <mingo@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <stephen.boyd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 9:11 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
>> +extern struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec);
>
> Generally there's no need to mark arguments with arithmethic types as const, as
> they are never modified in the calling scope.

Sure. Here I just copied from the neighboring line, but that's an obvious
change.

>> + * legacy timeval structure, only embedded in structures that
>> + * traditionally used 'timeval' to pass time intervals (not absolute
>> + * times). Do not add new users. If user space fails to compile
>> + * here, this is probably because it is not y2038 safe and needs to
>> + * be changed to use another interface.
>> + */
>> +struct __kernel_old_timeval {
>> +     __kernel_long_t tv_sec;                 /* seconds */
>> +     __kernel_long_t tv_usec;                /* seconds */
>
> s/seconds/microseconds

Right.

>> +struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
>> +{
>> +     struct timespec64 ts = ns_to_timespec64(nsec);
>> +     struct __kernel_old_timeval tv;
>> +
>> +     tv.tv_sec = ts.tv_sec;
>> +     tv.tv_usec = (suseconds_t) ts.tv_nsec / 1000;
>
> Is ts.tv_nsec guaranteed to never have bits set in the high 32 bits?

Yes, ns_to_timespec64() produces a valid timespec64 structure.

> In any case, the space before the type cast is a bit confusing to me, I think it
> should be written as:
>
>         tv.tv_usec = (suseconds_t)ts.tv_nsec / 1000;
>
> To better show was the higher precedence of the cast is going to result in.

Sure.

Thanks for taking a look, I'll send an updated version.

       Arnd
