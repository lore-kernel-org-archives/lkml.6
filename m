Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeD2Gfl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 02:35:41 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37697 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbeD2Gfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 02:35:40 -0400
X-Google-Smtp-Source: AB8JxZqHCDbT7CghWWUSGuAiaIWy9HOHMk8b4igKFFB1kquFxeWWQ18aIG9mrFGtMfKEggIxLqQtLIMS00GpknnSJHs=
MIME-Version: 1.0
In-Reply-To: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
From: Joel Fernandes <joel.opensrc@gmail.com>
Date: Sat, 28 Apr 2018 23:35:38 -0700
Message-ID: <CAEi0qNk7pVtfcrFU4gM35sajPb09xjR8d6cJkgoSr-H0Tgo+QA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] arm64: provide pseudo NMI with GICv3
To: Julien Thierry <julien.thierry@arm.com>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mark.rutland@arm.com, marc.zyngier@arm.com, james.morse@arm.com,
        daniel.thompson@linaro.org, Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

I am interested in evaluating if using this is feasible for our
Android devices. There is quite a usecase for lockup detection that it
seems worthwhile if it works well. Atleast I feel this can be used a
debug option considering the performance downgrade.

Do you have more details of if any GICv3 based system will work, or is
there a way an SoC can be misconfigured so that this series will not
work? I think Marc told me that's possible, but I wasn't sure. I will
be quite happy if it works on SoC as long as they have the requisite
GIC version.

Some more questions below:

On Wed, Jan 17, 2018 at 3:54 AM, Julien Thierry <julien.thierry@arm.com> wrote:
> Hi,
>
> This series is a continuation of the work started by Daniel [1]. The goal
> is to use GICv3 interrupt priorities to simulate an NMI.
>
> To achieve this, set two priorities, one for standard interrupts and
> another, higher priority, for NMIs. Whenever we want to disable interrupts,
> we mask the standard priority instead so NMIs can still be raised. Some
> corner cases though still require to actually mask all interrupts
> effectively disabling the NMI.
>
> Of course, using priority masking instead of PSR.I comes at some cost. On
> hackbench, the drop of performance seems to be >1% on average for this
> version. I can only attribute that to recent changes in the kernel as

Do you have more specific performance data on the performance overhead
with this series?

> hackbench seems slightly slower compared to my other benchmarks while the
> runs with the use of GICv3 priorities have stayed in the same time frames.
> KVM Guests do not seem to be affected preformance-wise by the host using
> PMR to mask interrupts or not.
>
> Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
> hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
> for now. I don't think there is any reason LPIs should be allowed to be set
> as NMI as they do not have an active state.
> When an NMI is active on a CPU, no other NMI can be triggered on the CPU.
>
>
> Requirements to use this:
> - Have GICv3
> - SCR_EL3.FIQ is set to 1 when linux runs

Ah I see it mentioned here. Again, can you clarify if this is
something that can be misconfigured? Is it something that the
bootloader sets?

Sorry if these questions sound premature, I haven't yet taken a closer
look at the series.

thanks,

- Joel
