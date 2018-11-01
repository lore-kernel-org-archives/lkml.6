Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191A0C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BB420657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BB420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeKARvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:51:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57052 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeKARvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:51:06 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gI8ez-0000oa-6F; Thu, 01 Nov 2018 09:49:01 +0100
Date:   Thu, 1 Nov 2018 09:49:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Long Li <longli@microsoft.com>
cc:     Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] genirq/matrix: Choose CPU for assigning interrupts
 based on allocated IRQs
In-Reply-To: <20181101031332.7404-1-longli@linuxonhyperv.com>
Message-ID: <alpine.DEB.2.21.1811010931400.1642@nanos.tec.linutronix.de>
References: <20181101031332.7404-1-longli@linuxonhyperv.com>
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

Long,

On Thu, 1 Nov 2018, Long Li wrote:
> On a large system with multiple devices of the same class (e.g. NVMe disks,
> using managed IRQs), the kernel tends to concentrate their IRQs on several
> CPUs.
> 
> The issue is that when NVMe calls irq_matrix_alloc_managed(), the assigned
> CPU tends to be the first several CPUs in the cpumask, because they check for
> cpumap->available that will not change after managed IRQs are reserved.
> 
> In irq_matrix->cpumap, "available" is set when IRQs are allocated earlier
> in the IRQ allocation process. This value is caculated based on

calculated

> 1. how many unmanaged IRQs are allocated on this CPU
> 2. how many managed IRQs are reserved on this CPU
> 
> But "available" is not accurate in accouting the real IRQs load on a given CPU.
> 
> For a managed IRQ, it tends to reserve more than one CPU, based on cpumask in
> irq_matrix_reserve_managed. But later when actually allocating CPU for this
> IRQ, only one CPU is allocated. Because "available" is calculated at the time
> managed IRQ is reserved, it tends to indicate a CPU has more IRQs than it's
> actually assigned.
> 
> When a managed IRQ is assigned to a CPU in irq_matrix_alloc_managed(), it
> decreases "allocated" based on the actually assignment of this IRQ to this CPU.

decreases?

> Unmanaged IRQ also decreases "allocated" after allocating an IRQ on this CPU.

ditto

> For this reason, checking "allocated" is more accurate than checking
> "available" for a given CPU, and result in a more evenly distributed IRQ
> across all CPUs.

Again, this approach is only correct for managed interrupts. Why?

Assume that total vector space size  = 10

CPU 0:
       allocated	=  8
       available	=  1

       i.e. there are 2 managed reserved, but not assigned interrupts

CPU 1:
       allocated	=  7
       available	=  0

       i.e. there are 3 managed reserved, but not assigned interrupts

Now allocate a non managed interrupt:

irq_matrix_alloc()

	cpu = find_best_cpu() <-- returns CPU1

	---> FAIL

The allocation fails because it cannot allocate from the managed reserved
space. The managed reserved space is guaranteed even if the vectors are not
assigned. This is required to make hotplug work and to allow late
activation without breaking the guarantees.

Non managed has no guarantees, it's a best effort approach, so it can fail.
But the fail above is just wrong.

You really need to treat managed and unmanaged CPU selection differently.

Thanks,

	tglx
