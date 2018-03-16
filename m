Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeCPIYS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:24:18 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42646 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753034AbeCPIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:24:15 -0400
X-Google-Smtp-Source: AG47ELsCx/lPF7k2lz83qtJ/h/ofGC39OCAuesqKwCeOFFdCczzlk8BwDaUJ4lMhqMumdv2CCQoEOKeWcrEHJ9yRsnc=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803160059380.1520@nanos.tec.linutronix.de>
References: <20180315161739.576085-1-arnd@arndb.de> <alpine.DEB.2.21.1803160059380.1520@nanos.tec.linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 16 Mar 2018 09:24:13 +0100
X-Google-Sender-Auth: AuXlne-7qD7YH-TtgkV6HfIr-FA
Message-ID: <CAK8P3a2PApN7arpHa9LUT8sbt-=4AgCOK9X+VSxChBg-=Qrxdg@mail.gmail.com>
Subject: Re: [PATCH] [v3] y2038: introduce struct __kernel_old_timeval
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 1:02 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 15 Mar 2018, Arnd Bergmann wrote:
>> + * legacy timeval structure, only embedded in structures that
>> + * traditionally used 'timeval' to pass time intervals (not absolute
>> + * times). Do not add new users. If user space fails to compile
>> + * here, this is probably because it is not y2038 safe and needs to
>> + * be changed to use another interface.
>> + */
>> +struct __kernel_old_timeval {
>> +     __kernel_long_t tv_sec;
>> +     __kernel_long_t tv_usec;
>> +};
>> +
>> +/*
>>   * The IDs of the various system clocks (for POSIX.1b interval timers):
>>   */
>>  #define CLOCK_REALTIME                       0
>> diff --git a/kernel/time/time.c b/kernel/time/time.c
>> index 5db8f15ec056..6fa99213fc72 100644
>> --- a/kernel/time/time.c
>> +++ b/kernel/time/time.c
>> @@ -486,6 +486,18 @@ struct timeval ns_to_timeval(const s64 nsec)
>>  }
>>  EXPORT_SYMBOL(ns_to_timeval);
>>
>> +struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
>> +{
>> +     struct timespec64 ts = ns_to_timespec64(nsec);
>> +     struct __kernel_old_timeval tv;
>> +
>> +     tv.tv_sec = ts.tv_sec;
>
> We might think about adding some debug aid here which yells when ts.tv_sec
> is > than the cutoff.
>
> Hmm?

We discussed those before (a long time ago) and couldn't really
reach consensus. If we do that, I'd like to have it done consistently
across the kernel, and in a separate patch series.

In particular, we need to decide on a policy for how to handle
it depending on the caller, e.g. do we want to have a way to
WARN_ONCE() for any process calling an unsafe function even
if it doesn't overflow, should we try to return an error to a syscall
when it does overflow, should the behavior be configurable etc.

        Arnd
