Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeFDQ1n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:27:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeFDQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:27:41 -0400
Message-Id: <20180604153352.480513443@linutronix.de>
User-Agent: quilt/0.65
Date: Mon, 04 Jun 2018 17:33:52 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Song Liu <liu.song.a23@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Mike Travis <mike.travis@hpe.com>
Subject: [patch 0/8] x86/apic: Prevent data corruption and make affinity
 setting more robust
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several people observed the WARN_ON() in irq_matrix_free() which triggers
when the caller tries to free an vector which is not in the allocation
range. Song provided the trace information which allowed to decode the root
cause.

The rework of the vector allocation mechanism failed to preserve a sanity
check, which prevents setting a new target vector/CPU when the previous
affinity change has not fully completed.

As a result a half finished affinity change can be overwritten, which can
cause the leak of a irq descriptor pointer on the previous target CPU and
double enqueue of the hlist head into the cleanup lists of two or more
CPUs. After one CPU cleaned up its vector the next CPU will invoke the
cleanup handler with vector 0, which triggers the out of range warning in
the matrix allocator.

The fix for that issue is simple, but it exposes a different long standing
problem, which was harder to trigger before the vector management code got
reworked:

  The fact that affinity settings can return -EBUSY is not handled well by
  tools despite the fact that this possibility existed for a long time.

So just applying the fix will cause some tools just to malfunction and
while we might get away with pointing fingers and telling them that they
should have handled this years ago, this will not solve anything.

After thinking about it for quite a while, it turned out that the existing
generic pending infrastructure, which defers affinity updates to the next
raised interrupt context (to handle non irq remapped oddities), can be
utilized to avoid the EBUSY return to user space completely.

In course of that it turned out that the pending mechanics did not handle
-EBUSY properly either. In case of moving the interrupt and getting the
-EBUSY return value (unlikely but possible), the pending affinity change was
silently dropped.

In hindsight, we should have never tried to return -EBUSY back to user
space as it's completely undefined what user space is supposed to do about
it due to the dependency on the next interrupt to arrive before retrying
which can take forever.

The following patch set addresses these issues and handles the busy case
completely in the kernel. The interrupts might not move immediately, but
that's the case for the non interrupt remapped ones by default, so this
should not come as a surprise.

Thanks,

	tglx

8<-------------
 arch/x86/include/asm/apic.h         |    2 +
 arch/x86/kernel/apic/io_apic.c      |    2 -
 arch/x86/kernel/apic/vector.c       |   48 ++++++++++++++++++++++++------------
 arch/x86/platform/uv/uv_irq.c       |    7 -----
 drivers/iommu/amd_iommu.c           |    2 -
 drivers/iommu/intel_irq_remapping.c |    2 -
 drivers/iommu/irq_remapping.c       |    5 ---
 drivers/iommu/irq_remapping.h       |    2 -
 kernel/irq/manage.c                 |   37 ++++++++++++++++++++++++++-
 kernel/irq/migration.c              |   24 +++++++++++++-----
 10 files changed, 91 insertions(+), 40 deletions(-)
