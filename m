Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeC2C1S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 22:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeC2C1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 22:27:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A6A2177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>
Subject: [PATCH 00/10] softirq: Consolidate and optimize softirq mask
Date: Thu, 29 Mar 2018 04:26:55 +0200
Message-Id: <1522290425-22844-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The softirq mask and its accessors/mutators have many implementations
scattered around many architectures. Most do the same things consisting
in a field in a per-cpu struct (often irq_cpustat_t) accessed through
per-cpu ops. We can provide instead a generic efficient version that
most of them can use. In fact s390 is the only exception because the
field is stored in lowcore.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	softirq/mask

HEAD: fb3db1bfa6033202c4b8191e570f39d3777d6a9d

Thanks,
	Frederic
---

Frederic Weisbecker (10):
      ia64: Convert local_softirq_pending() to per-cpu ops
      sparc: Convert local_softirq_pending() to use per-cpu op
      softirq: Turn default irq_cpustat_t to standard per-cpu
      softirq: Consolidate default local_softirq_pending() implementations
      ia64: Switch to generic local_softirq_pending() implementation
      parisc: Switch to generic local_softirq_pending() implementation
      powerpc: Switch to generic local_softirq_pending() implementation
      sparc: Switch to generic local_softirq_pending() implementation
      x86: Switch to generic local_softirq_pending() implementation
      softirq: Remove __ARCH_SET_SOFTIRQ_PENDING


 arch/ia64/include/asm/hardirq.h     |  2 +-
 arch/parisc/include/asm/hardirq.h   |  8 --------
 arch/powerpc/include/asm/hardirq.h  |  7 -------
 arch/sparc/include/asm/hardirq_64.h |  5 +++--
 arch/x86/include/asm/hardirq.h      |  8 --------
 include/linux/interrupt.h           | 16 ++++++++++++++--
 include/linux/irq_cpustat.h         | 10 +++-------
 kernel/softirq.c                    |  4 ++--
 8 files changed, 23 insertions(+), 37 deletions(-)
