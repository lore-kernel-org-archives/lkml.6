Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428333AbeCBNwK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:52:10 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:40565 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424338AbeCBNwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:52:08 -0500
X-Google-Smtp-Source: AG47ELsPfOHVfVW+IC3ZJOVNK8xyyo0Orq6AE3cqymqCgUcJR4bXnRDraduxwSfuX+XWbH4XmiRS7hsDXnZRBOtPNIA=
MIME-Version: 1.0
In-Reply-To: <20180302131545.q2vf6uc3yofofqdb@lakrids.cambridge.arm.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com> <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
 <20180302120556.xujh3hoy44y7ouz7@lakrids.cambridge.arm.com>
 <CAH76GKNw=irEY8BjhkaMnKm5m6AeCz8ZN67vrWSC6ByBmMMh8g@mail.gmail.com> <20180302131545.q2vf6uc3yofofqdb@lakrids.cambridge.arm.com>
From: Grzegorz Jaszczyk <jaz@semihalf.com>
Date: Fri, 2 Mar 2018 14:52:07 +0100
Message-ID: <CAH76GKOe=+WTrw8QEJ43+fyEfRPuo7+ds8VNoMCUqSNBMtxkyg@mail.gmail.com>
Subject: Re: [PATCH] arm64: kdump: fix interrupt handling done during machine_crash_shutdown
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Hoeun Ryu <hoeun.ryu@gmail.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-02 14:15 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> On Fri, Mar 02, 2018 at 01:59:27PM +0100, Grzegorz Jaszczyk wrote:
>> 2018-03-02 13:05 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
>> > Do you have a way to reproduce the problem?
>> >
>> > Is there an easy way to cause the watchdog to trigger a kdump as above,
>> > e.g. via LKDTM?
>>
>> You can reproduce this problem by:
>> - enabling CONFIG_ARM_SBSA_WATCHDOG in your kernel
>> - passing via command-line: sbsa_gwdt.action=1 sbsa_gwdt.timeout=170
>> - then load/prepare crasdump kernel (I am doing it via kexec tool)
>> - echo 1 > /dev/watchdog
>>
>> and after 170s the watchdog interrupt will hit triggering panic and
>> the whole kexec machinery will run. The sbsa_gwdt.timeout can't be too
>> small since it is also used for reset:
>> |----timeout-----(panic)----timeout-----reset.
>> If it is too small the crasdump kernel will not have enough time to start.
>>
>> It is also reproducible with different interrupts, e.g. for test I put
>> the panic to i2c interrupt handler and it was behaving the same.
>
> Do you see this for a panic() in *any* interrupt handler?

I only test with this two interrupt handlers: watchdog and i2c but I
think it will behave the same with others - I can try with other if
you want, any suggestion which? Maybe with some PPI interrupt instead?
>
> Can you trigger the issue with magic-sysrq c, for example?

There is no problem when I trigger it via 'echo c >
/proc/sysrq-trigger' - it works well all the time. The problem appears
only, when the kexec/kdump procedure is triggered from interrupt
context - as I said it seems that deactivating the interrupt via
irq_set_irqchip_state doesn't do the job and because of that any new
interrupt (e.g. timer interrupt) can't interrupt the CPU (the previous
irq watchdog/i2c irq seems to be still active preventing other irq to
interrupt the CPU). This result with crashdump kernel hang (it waits
for the timer interrupt, which never interrupts the CPU).

Reworking the machine_kexec_mask_interrupts routine so it will call
'chip->irq_eoi(&desc->irq_data);' independently of
irq_set_irqchip_state return value, solves the problem.

Thank you,
Grzegorz
