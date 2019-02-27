Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A32C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2FA218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfB0DVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 22:21:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729128AbfB0DVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 22:21:01 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C60F499E8551345B2B1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:20:59 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:20:54 +0800
Subject: Re: [RFC PATCH] posix-cpu-timers: Avoid undefined behaviour in
 timespec64_to_ns()
To:     Deepa Dinamani <deepa.kernel@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <1551233212-42022-1-git-send-email-wangxiongfeng2@huawei.com>
 <CABeXuvoKTeC2e150keLo+z_+3_dykbSiNwVZuHemJSgDovW7Cw@mail.gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <c752f845-cf4c-ec39-cc83-b1a641b54a2a@huawei.com>
Date:   Wed, 27 Feb 2019 11:20:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CABeXuvoKTeC2e150keLo+z_+3_dykbSiNwVZuHemJSgDovW7Cw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/2/27 10:38, Deepa Dinamani wrote:
> On Tue, Feb 26, 2019 at 6:07 PM Xiongfeng Wang
> <wangxiongfeng2@huawei.com> wrote:
>>
>> When I ran Syzkaller testsuite, I got the following call trace.
>> ================================================================================
>> UBSAN: Undefined behaviour in ./include/linux/time64.h:120:27
>> signed integer overflow:
>> 8243129037239968815 * 1000000000 cannot be represented in type 'long long int'
>> CPU: 5 PID: 28854 Comm: syz-executor.1 Not tainted 4.19.24 #4
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0xca/0x13e lib/dump_stack.c:113
>>  ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
>>  handle_overflow+0x193/0x1e2 lib/ubsan.c:190
>>  timespec64_to_ns include/linux/time64.h:120 [inline]
>>  posix_cpu_timer_set+0x95a/0xb70 kernel/time/posix-cpu-timers.c:687
>>  do_timer_settime+0x198/0x2a0 kernel/time/posix-timers.c:892
>>  __do_sys_timer_settime kernel/time/posix-timers.c:918 [inline]
>>  __se_sys_timer_settime kernel/time/posix-timers.c:904 [inline]
>>  __x64_sys_timer_settime+0x18d/0x260 kernel/time/posix-timers.c:904
>>  do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x462eb9
>> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f14e4127c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
>> RAX: ffffffffffffffda RBX: 000000000073bfa0 RCX: 0000000000462eb9
>> RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f14e41286bc
>> R13: 00000000004c54cc R14: 0000000000704278 R15: 00000000ffffffff
>> ================================================================================
>>
>> This patch use 'timespec64_to_ktime()' to limit 'tv_sec' to avoid
>> overflow.
>>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  kernel/time/posix-cpu-timers.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
>> index 80f9552..f7e3929 100644
>> --- a/kernel/time/posix-cpu-timers.c
>> +++ b/kernel/time/posix-cpu-timers.c
>> @@ -684,7 +684,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
>>          * Install the new reload setting, and
>>          * set up the signal and overrun bookkeeping.
>>          */
>> -       timer->it.cpu.incr = timespec64_to_ns(&new->it_interval);
>> +       timer->it.cpu.incr = ktime_to_ns(timespec64_to_ktime(new->it_interval));
>>         timer->it_interval = ns_to_ktime(timer->it.cpu.incr);
>>
>>         /*
> 
> This seems like a similar bug as the other one
> https://lkml.org/lkml/2019/2/24/214. Maybe it makes sense here also to
> do some bounds checking when we get the userspace parameter.
> This patch just saturates the value.

Thanks for your advice. I will send another version.

Thanks,
Xiongfeng

> 
> -Deepa
> 
> .
> 

