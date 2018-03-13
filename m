Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeCMRZM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:25:12 -0400
Received: from foss.arm.com ([217.140.101.70]:42130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932312AbeCMRZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:25:11 -0400
Subject: Re: [PATCH] arm64: kdump: fix interrupt handling done during
 machine_crash_shutdown
To: Grzegorz Jaszczyk <jaz@semihalf.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Hoeun Ryu <hoeun.ryu@gmail.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Nadav Haklai <nadavh@marvell.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, james.morse@arm.com,
        Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
 <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
 <20180302120556.xujh3hoy44y7ouz7@lakrids.cambridge.arm.com>
 <CAH76GKNw=irEY8BjhkaMnKm5m6AeCz8ZN67vrWSC6ByBmMMh8g@mail.gmail.com>
 <20180302131545.q2vf6uc3yofofqdb@lakrids.cambridge.arm.com>
 <CAH76GKOe=+WTrw8QEJ43+fyEfRPuo7+ds8VNoMCUqSNBMtxkyg@mail.gmail.com>
 <20180302164411.fxdx72ttz7livz2e@lakrids.cambridge.arm.com>
 <20180302165739.dc726v3yf2mxli3u@lakrids.cambridge.arm.com>
 <CAH76GKP5Abx3ty1jVfesd_BjOKaQLaNs0e_W06LBanWDAPS0gQ@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <f6b26139-8eed-ecd4-eeaa-05d8fe323180@arm.com>
Date: Tue, 13 Mar 2018 17:25:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAH76GKP5Abx3ty1jVfesd_BjOKaQLaNs0e_W06LBanWDAPS0gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/18 22:06, Grzegorz Jaszczyk wrote:
> 2018-03-02 17:57 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
>>>>> Do you see this for a panic() in *any* interrupt handler?
>>>>
>>>> I only test with this two interrupt handlers: watchdog and i2c but I
>>>> think it will behave the same with others - I can try with other if
>>>> you want, any suggestion which? Maybe with some PPI interrupt instead?
> 
> I was able to reproduce it from other interrupts handler (UART, I2C,
> timer and watchdog) no difference if it is PPI or SPI interrupt. I
> also reproduce this issue with GICv3. But again it only happens when
> eoimode = 0.
>>>>>
>>>>> Can you trigger the issue with magic-sysrq c, for example?
>>>>
>>>> There is no problem when I trigger it via 'echo c >
>>>> /proc/sysrq-trigger' - it works well all the time. The problem appears
>>>> only, when the kexec/kdump procedure is triggered from interrupt
>>>> context
>>>
>>> I'd meant that you'd send sysrq + c over serial, rather than writing to
>>> /proc/sysrq-trigger. That way, the panic will be in the context of the
>>> UART IRQ handler.
>>>
>>> If that shows the issue, that's ilikely to be the easiest way for
>>> someone else to reproduce and investigate this.
> 
> Yes it can be triggered by sending sysrq + c and indeed it is the
> easiest way to reproduce it.
>>
>> FWIW, having just given this a go on my Juno R1 with v4.16-rc3
>> defconfig, the UART IRQs work fine in the crash kernel. That crash
>> happened in IRQ context:
> 
> I think that by default Juno uses eoimode = 1, did you try it when
> eoimode was forced to be 0? Only eoimode = 0 triggers the issue.

FWIW, I've now posted fixes to LKML[1]. Feel free to test them and
report whether they fix the issue for you.

Thanks,

	M.

[1] https://lkml.org/lkml/2018/3/13/1088
-- 
Jazz is not dead. It just smells funny...
