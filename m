Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeEBQp7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:45:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52748 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbeEBQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:45:56 -0400
Subject: Re: [PATCH] [v3] x86: Convert x86_platform_ops to timespec64
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
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
References: <20180427201435.3194219-1-arnd@arndb.de>
 <b8d3167b-ee9f-f14d-e43e-73aa2719d6ae@oracle.com>
 <CAK8P3a0T8RkPgHm6F+Y+RHBdi7v5ho1hQ8w+MwWFcOk5TbMaCw@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <92ef9d3a-d2bc-59db-de43-4845a46fd2d8@oracle.com>
Date: Wed, 2 May 2018 17:44:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0T8RkPgHm6F+Y+RHBdi7v5ho1hQ8w+MwWFcOk5TbMaCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/2018 11:09 AM, Arnd Bergmann wrote:
> On Sat, Apr 28, 2018 at 12:21 AM, Joao Martins
> <joao.m.martins@oracle.com> wrote:
>> On 04/27/2018 09:13 PM, Arnd Bergmann wrote:
>>> diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
>>> index 761f6af6efa5..637982efecd8 100644
>>> --- a/arch/x86/kernel/pvclock.c
>>> +++ b/arch/x86/kernel/pvclock.c
>>> @@ -123,28 +123,35 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
>>>
>>>  void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
>>>                           struct pvclock_vcpu_time_info *vcpu_time,
>>> -                         struct timespec *ts)
>>> +                         struct timespec64 *ts)
>>>  {
>>>       u32 version;
>>>       u64 delta;
>>> -     struct timespec now;
>>> +     struct timespec64 now;
>>>
>>>       /* get wallclock at system boot */
>>>       do {
>>>               version = wall_clock->version;
>>>               rmb();          /* fetch version before time */
>>> +             /*
>>> +              * Note: wall_clock->sec is a u32 value, so it can
>>> +              * only store dates between 1970 and 2106. To allow
>>> +              * times beyond that, we need to create a new hypercall
>>> +              * interface with an extended pvclock_wall_clock structure
>>> +              * like ARM has.
>>> +              */
>>>               now.tv_sec  = wall_clock->sec;
>>
>> IIUC the interface you're probably speaking about is common to both ARM and x86
>> on Xen[*] (since Xen 4.6) i.e.
>>
>>         now.tv_sec  = ((uint64_t)s->wc_sec_hi << 32) | s->wc_sec;
>>
>> s representing struct shared_info like on ARM (there's a 32-bit hole where
>> wc_sec_hi is placed on x86_64/ARM). Except on x86 32-bit guests wc_sec_hi is
>> located elsewhere.
>>
>>         Joao
>>
>> [*]
>> https://xenbits.xen.org/docs/4.6-testing/hypercall/x86_64/include,public,xen.h.html#incontents_startofday_shared
> 
> Ah, good. How portable is that? Will it do the right thing (i.e.
> guarantee to have
> zeroes on the upper half, or the epoch if supported) on all versions of both KVM
> and Xen, or do we need an additional check in there?
>
The whole shared info page is zeroed out by Xen when allocated, so on
unsupported platforms that includes the upper half. But I don't know if this is
considered ABI or not. FWIW, the oldest release (2.0) has that behavior.

But this is Xen that I'm speaking about; KVM doesn't support this IIUC.

On KVM, there's HC_CLOCK_PAIRING hypercall or else *maybe* host could just write
wc_sec_hi at the end of the wall_clock struct (with the current MSR) and given
that it's (PAGE_SIZE aligned) guest memory, guest could always keep it zeroed
out for unsupported platforms (that won't write more than 12bytes).

> I'd suggest leaving the implementation of that to a follow-up patch that you
> can add once my patch is merged.

/nods

	Joao
