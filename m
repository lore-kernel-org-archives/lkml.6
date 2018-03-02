Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034546AbeCBQ5u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:57:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58558 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034460AbeCBQ5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:57:44 -0500
Date: Fri, 2 Mar 2018 16:57:39 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Grzegorz Jaszczyk <jaz@semihalf.com>
Cc: Hoeun Ryu <hoeun.ryu@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, james.morse@arm.com,
        Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: kdump: fix interrupt handling done during
 machine_crash_shutdown
Message-ID: <20180302165739.dc726v3yf2mxli3u@lakrids.cambridge.arm.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
 <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
 <20180302120556.xujh3hoy44y7ouz7@lakrids.cambridge.arm.com>
 <CAH76GKNw=irEY8BjhkaMnKm5m6AeCz8ZN67vrWSC6ByBmMMh8g@mail.gmail.com>
 <20180302131545.q2vf6uc3yofofqdb@lakrids.cambridge.arm.com>
 <CAH76GKOe=+WTrw8QEJ43+fyEfRPuo7+ds8VNoMCUqSNBMtxkyg@mail.gmail.com>
 <20180302164411.fxdx72ttz7livz2e@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302164411.fxdx72ttz7livz2e@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 04:44:13PM +0000, Mark Rutland wrote:
> On Fri, Mar 02, 2018 at 02:52:07PM +0100, Grzegorz Jaszczyk wrote:
> > 2018-03-02 14:15 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> > > Do you see this for a panic() in *any* interrupt handler?
> > 
> > I only test with this two interrupt handlers: watchdog and i2c but I
> > think it will behave the same with others - I can try with other if
> > you want, any suggestion which? Maybe with some PPI interrupt instead?
> > >
> > > Can you trigger the issue with magic-sysrq c, for example?
> > 
> > There is no problem when I trigger it via 'echo c >
> > /proc/sysrq-trigger' - it works well all the time. The problem appears
> > only, when the kexec/kdump procedure is triggered from interrupt
> > context
> 
> I'd meant that you'd send sysrq + c over serial, rather than writing to
> /proc/sysrq-trigger. That way, the panic will be in the context of the
> UART IRQ handler.
> 
> If that shows the issue, that's ilikely to be the easiest way for
> someone else to reproduce and investigate this.

FWIW, having just given this a go on my Juno R1 with v4.16-rc3
defconfig, the UART IRQs work fine in the crash kernel. That crash
happened in IRQ context:

[  384.653153] Call trace:
[  384.655581]  sysrq_handle_crash+0x20/0x30
[  384.659559]  __handle_sysrq+0xa8/0x1a0
[  384.663278]  handle_sysrq+0x28/0x38
[  384.666738]  pl011_fifo_to_tty+0x150/0x1a8
[  384.670801]  pl011_int+0x30c/0x430
[  384.674177]  __handle_irq_event_percpu+0x5c/0x148
[  384.678843]  handle_irq_event_percpu+0x34/0x88
[  384.683250]  handle_irq_event+0x48/0x78
[  384.687056]  handle_fasteoi_irq+0xa8/0x180
[  384.691119]  generic_handle_irq+0x24/0x38
[  384.695095]  __handle_domain_irq+0x5c/0xb0
[  384.699158]  gic_handle_irq+0x58/0xa8
[  384.702790]  el1_irq+0xb0/0x128
[  384.705907]  cpuidle_enter_state+0x138/0x220
[  384.710142]  cpuidle_enter+0x18/0x20
[  384.713690]  call_cpuidle+0x1c/0x38
[  384.717151]  do_idle+0x1b0/0x1e8
[  384.720354]  cpu_startup_entry+0x20/0x28
[  384.724246]  rest_init+0xd0/0xe0
[  384.727450]  start_kernel+0x3e4/0x410

On a separate note, the crashkernel complained:

[    0.224730] CPU: CPUs started in inconsistent modes

... which is a separate disaster. I suspect the kexec code failed to punt the
crash CPU back to EL2 as it should have.

Thanks,
Mark.
