Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946566AbeCBM7e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:59:34 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38035 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946553AbeCBM72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:59:28 -0500
X-Google-Smtp-Source: AG47ELuR9KmdYvbdIUSnQT4RtNxqt9ANSoaiHvkvx21DARoG6l3XbOlHYQSpkcYqMVqFE2sr0Bs8196ZAQ9tr/96NDo=
MIME-Version: 1.0
In-Reply-To: <20180302120556.xujh3hoy44y7ouz7@lakrids.cambridge.arm.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com> <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
 <20180302120556.xujh3hoy44y7ouz7@lakrids.cambridge.arm.com>
From: Grzegorz Jaszczyk <jaz@semihalf.com>
Date: Fri, 2 Mar 2018 13:59:27 +0100
Message-ID: <CAH76GKNw=irEY8BjhkaMnKm5m6AeCz8ZN67vrWSC6ByBmMMh8g@mail.gmail.com>
Subject: Re: [PATCH] arm64: kdump: fix interrupt handling done during machine_crash_shutdown
To: Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Hoeun Ryu <hoeun.ryu@gmail.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-02 13:05 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> On Fri, Mar 02, 2018 at 12:56:24PM +0100, Grzegorz Jaszczyk wrote:
>> Thank you for your feedback. I probably over-interpreted some of the
>> documentation paragraph to justify (probably) buggy behavior that I am
>> seeing. Regardless of correctness of this patch I will appreciate if
>> you could help understanding this issue.
>>
>> First the whole story: I was debugging why the crashdump kernel hangs
>> in v. early stage, when the kdump was triggered from the
>> ARM_SBSA_WATCHDOG interrupt handler, while everything worked fine when
>> it was triggered from the process context. Finally It occurred that it
>> is because the crashdump kernel doesn't get any timer interrupt. I
>> also notice that this problem doesn't occur when the gic is configured
>> to work in EOImode == 1. In such circumstances, the write to
>> GIC_CPU_EOI in gic_handle_irq is causing priority drop to idle, and
>> therefore when the crashdump kernel starts, the timer interrupt is
>> able to preempt still active watchdog interrupt (I know that this
>> interrupt shouldn't be active after irq_set_irqchip_state but for some
>> reason it seems to not do the job correctly).
>
> Do you have a way to reproduce the problem?
>
> Is there an easy way to cause the watchdog to trigger a kdump as above,
> e.g. via LKDTM?

You can reproduce this problem by:
- enabling CONFIG_ARM_SBSA_WATCHDOG in your kernel
- passing via command-line: sbsa_gwdt.action=1 sbsa_gwdt.timeout=170
- then load/prepare crasdump kernel (I am doing it via kexec tool)
- echo 1 > /dev/watchdog

and after 170s the watchdog interrupt will hit triggering panic and
the whole kexec machinery will run. The sbsa_gwdt.timeout can't be too
small since it is also used for reset:
|----timeout-----(panic)----timeout-----reset.
If it is too small the crasdump kernel will not have enough time to start.

It is also reproducible with different interrupts, e.g. for test I put
the panic to i2c interrupt handler and it was behaving the same.

To use gic with EOImode == 0 mode, you can fulfill some of
gic_check_eoimode ( irqchip/irq-gic.c) conditions or just for test
"return false;" in this function.


> I think you just mean GICv2 here. GICv2m is an MSI controller, and
> shouldn't interact with the SBSA watchdog's SPI.

Yes of course, I just wanted to mention that it has MSI controller.

Thank you,
Grzegorz
