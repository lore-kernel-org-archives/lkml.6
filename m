Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759794AbeD1KJv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 06:09:51 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35589 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759622AbeD1KJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 06:09:49 -0400
X-Google-Smtp-Source: AB8JxZpPGXckT7FI7sbqtrTsyw5kxU3B2T+nZIOR85rV78qJNq5TpOw7Df5rQAs5p1/HLmlk0m6NoEXeSdDvJlUIY68=
MIME-Version: 1.0
In-Reply-To: <b8d3167b-ee9f-f14d-e43e-73aa2719d6ae@oracle.com>
References: <20180427201435.3194219-1-arnd@arndb.de> <b8d3167b-ee9f-f14d-e43e-73aa2719d6ae@oracle.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 28 Apr 2018 12:09:47 +0200
X-Google-Sender-Auth: oKrrtNboOhCE0RdeYHA0IhDB3dk
Message-ID: <CAK8P3a0T8RkPgHm6F+Y+RHBdi7v5ho1hQ8w+MwWFcOk5TbMaCw@mail.gmail.com>
Subject: Re: [PATCH] [v3] x86: Convert x86_platform_ops to timespec64
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, kvm@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 12:21 AM, Joao Martins
<joao.m.martins@oracle.com> wrote:
> On 04/27/2018 09:13 PM, Arnd Bergmann wrote:
>> diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
>> index 761f6af6efa5..637982efecd8 100644
>> --- a/arch/x86/kernel/pvclock.c
>> +++ b/arch/x86/kernel/pvclock.c
>> @@ -123,28 +123,35 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
>>
>>  void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
>>                           struct pvclock_vcpu_time_info *vcpu_time,
>> -                         struct timespec *ts)
>> +                         struct timespec64 *ts)
>>  {
>>       u32 version;
>>       u64 delta;
>> -     struct timespec now;
>> +     struct timespec64 now;
>>
>>       /* get wallclock at system boot */
>>       do {
>>               version = wall_clock->version;
>>               rmb();          /* fetch version before time */
>> +             /*
>> +              * Note: wall_clock->sec is a u32 value, so it can
>> +              * only store dates between 1970 and 2106. To allow
>> +              * times beyond that, we need to create a new hypercall
>> +              * interface with an extended pvclock_wall_clock structure
>> +              * like ARM has.
>> +              */
>>               now.tv_sec  = wall_clock->sec;
>
> IIUC the interface you're probably speaking about is common to both ARM and x86
> on Xen[*] (since Xen 4.6) i.e.
>
>         now.tv_sec  = ((uint64_t)s->wc_sec_hi << 32) | s->wc_sec;
>
> s representing struct shared_info like on ARM (there's a 32-bit hole where
> wc_sec_hi is placed on x86_64/ARM). Except on x86 32-bit guests wc_sec_hi is
> located elsewhere.
>
>         Joao
>
> [*]
> https://xenbits.xen.org/docs/4.6-testing/hypercall/x86_64/include,public,xen.h.html#incontents_startofday_shared

Ah, good. How portable is that? Will it do the right thing (i.e.
guarantee to have
zeroes on the upper half, or the epoch if supported) on all versions of both KVM
and Xen, or do we need an additional check in there?

I'd suggest leaving the implementation of that to a follow-up patch that you
can add once my patch is merged.

        Arnd
