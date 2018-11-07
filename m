Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ACBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FF12081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FF12081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeKHFzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:55:23 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42064 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeKHFzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:55:22 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKUMD-0007pL-Oh; Wed, 07 Nov 2018 21:23:22 +0100
Date:   Wed, 7 Nov 2018 21:23:14 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michael Kelley <mikelley@microsoft.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, Long Li <longli@microsoft.com>
Subject: RE: [tip:irq/core] genirq/matrix: Improve target CPU selection for
 managed interrupts.
In-Reply-To: <CY4PR21MB0773C3A2748B87E9125095F9D7C40@CY4PR21MB0773.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1811072049070.1666@nanos.tec.linutronix.de>
References: <20181106040000.27316-1-longli@linuxonhyperv.com> <tip-e8da8794a7fd9eef1ec9a07f0d4897c68581c72b@git.kernel.org> <CY4PR21MB0773C3A2748B87E9125095F9D7C40@CY4PR21MB0773.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

On Wed, 7 Nov 2018, Michael Kelley wrote:
> >  2) Managed interrupts:
> > 
> >     Managed interrupts guarantee vector reservation when the MSI/MSI-X
> >     functionality of a device is enabled, which is achieved by reserving
> >     vectors in the bitmaps of the possible target CPUs. This reservation
> >     decrements the available count on each possible target CPU.
> >
> 
> For the curious, could you elaborate on the reservation guarantee for
> managed interrupts?  What exactly is guaranteed?  I'm trying to
> understand the benefit of reserving a vector on all possible target CPUs.
> I can imagine this may be to related hot-remove of CPUs, but I'm not
> seeing the scenario where reserving on all possible target CPUs solves
> any fundamental problem.  irq_build_affinity_masks() assigns spreads
> target CPUs across each IRQ in the batch, so you might get a small handful
> of possible target CPUs for each IRQ.  But if those small handful of CPUs
> were to be hot-removed, then all the reserved vectors disappear anyway.
> So maybe there's another scenario I'm missing.

When managed interrupts are allocated (MSI[-X] enable) then each allocated
Linux interrupt (virtual irq number) is given an affinity mask in the
spreading algorithm. The mask contains 1 or more CPUs depending on the
ratio of queues and possible CPUs.

When the virtual irq and the corresponding data structures are allocated,
then a vector is reserved on each CPU in the affinity mask.

The device driver and other layers like block-mq rely on the associated
affinity mask of each interrupt, i.e. they associate a device queue to the
exact same affinity mask. All I/O on the CPUs in the mask goes through that
associated device queue.

So if the allocation would not be guaranteed and allowed to fail, then the
I/O association would not work as expected.

Sure, we could move the interrupt to a random CPU, but that would cause
performance problems especially when the interrupt affinity moves to a
different node.

Now you might argue that reserving one vector on one CPU in the mask would
be sufficient. That's true, if CPU hotplug is disabled and all CPUs are
online when the device driver is initialized.

But it would break assumptions in the CPU hotplug case. The guaranteed
reservation on all CPUs in the associated CPU mask guarantees that the
interrupt can be moved from the outgoing CPU to a still online CPU in the
mask without violating the affinity association.

There is another interesting property of managed interrupts vs. CPU
hotplug. When the last CPU in the affinity mask goes offline, then the core
code shuts down the interrupt and the device driver and related layers
exclude the associated device queue from I/O. The same applies for CPUs
which are not online when the device is initialized, i.e. if non of the
CPUs is online then the interrupt is not started and the I/O queue stays
disabled.

When the first CPU in the mask comes online (again), then the interrupt is
reenabled and the device driver and related layers reenable I/O on the
associated device queue.

If the reservation would not be guaranteed even accross offline/online
cycles, then again the assumptions of the drivers and the related layers
would not longer work.

Note, that the affinity of managed interrupts cannot be changed from
userspace via /proc/irq/$N/affinity for the same reasons.

That was a design decision to simplify the block multi-queue logic in the
device drivers and the related layers. It removed the whole track affinity
changes, reallocate data structures and reroute I/O requirements. Some of
the early multi-queue device drivers implemented horrible hacks to handle
all those horrors.

Hope that answers your question.

Thanks,

	tglx
