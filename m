Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424258AbeCBNPw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:15:52 -0500
Received: from foss.arm.com ([217.140.101.70]:55100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423742AbeCBNPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:15:51 -0500
Date: Fri, 2 Mar 2018 13:15:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Grzegorz Jaszczyk <jaz@semihalf.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Hoeun Ryu <hoeun.ryu@gmail.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH] arm64: kdump: fix interrupt handling done during
 machine_crash_shutdown
Message-ID: <20180302131545.q2vf6uc3yofofqdb@lakrids.cambridge.arm.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
 <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
 <20180302120556.xujh3hoy44y7ouz7@lakrids.cambridge.arm.com>
 <CAH76GKNw=irEY8BjhkaMnKm5m6AeCz8ZN67vrWSC6ByBmMMh8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH76GKNw=irEY8BjhkaMnKm5m6AeCz8ZN67vrWSC6ByBmMMh8g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 01:59:27PM +0100, Grzegorz Jaszczyk wrote:
> 2018-03-02 13:05 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> > Do you have a way to reproduce the problem?
> >
> > Is there an easy way to cause the watchdog to trigger a kdump as above,
> > e.g. via LKDTM?
> 
> You can reproduce this problem by:
> - enabling CONFIG_ARM_SBSA_WATCHDOG in your kernel
> - passing via command-line: sbsa_gwdt.action=1 sbsa_gwdt.timeout=170
> - then load/prepare crasdump kernel (I am doing it via kexec tool)
> - echo 1 > /dev/watchdog
> 
> and after 170s the watchdog interrupt will hit triggering panic and
> the whole kexec machinery will run. The sbsa_gwdt.timeout can't be too
> small since it is also used for reset:
> |----timeout-----(panic)----timeout-----reset.
> If it is too small the crasdump kernel will not have enough time to start.
> 
> It is also reproducible with different interrupts, e.g. for test I put
> the panic to i2c interrupt handler and it was behaving the same.

Do you see this for a panic() in *any* interrupt handler?

Can you trigger the issue with magic-sysrq c, for example?

> > I think you just mean GICv2 here. GICv2m is an MSI controller, and
> > shouldn't interact with the SBSA watchdog's SPI.
> 
> Yes of course, I just wanted to mention that it has MSI controller.

Can you please tell us which platform you're seeing this on?

Thanks,
Mark.
