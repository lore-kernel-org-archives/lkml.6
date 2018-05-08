Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755097AbeEHNif (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932132AbeEHNid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:38:33 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Rich Felker <dalias@libc.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>
Subject: [GIT PULL] 
Date: Tue,  8 May 2018 15:38:15 +0200
Message-Id: <1525786706-22846-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Please pull the softirq/mask-v4 branch that can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	softirq/mask-v4

HEAD: dc06cbb5e1296938211040bccdacd7a361469116

Changes since v3:

* Rebase against v4.17-rc4
* Fix build error on SH. (new patch "sh: Use nmi_count() on /proc/interrupts print out")

--
The softirq mask and its accessors/mutators have many implementations
scattered around many architectures. Most do the same things consisting
in a field in a per-cpu struct (often irq_cpustat_t) accessed through
per-cpu ops. We can provide instead a generic efficient version that
most of them can use. In fact s390 is the only exception because the
field is stored in lowcore.

Thanks,
	Frederic
---

Frederic Weisbecker (11):
      ia64: Convert local_softirq_pending() to per-cpu ops
      sparc: Convert local_softirq_pending() to use per-cpu op
      sh: Use nmi_count() on /proc/interrupts print out
      softirq: Turn default irq_cpustat_t to standard per-cpu
      softirq: Consolidate default local_softirq_pending() implementations
      ia64: Switch to generic local_softirq_pending() implementation
      parisc: Switch to generic local_softirq_pending() implementation
      powerpc: Switch to generic local_softirq_pending() implementation
      sparc: Switch to generic local_softirq_pending() implementation
      x86: Switch to generic local_softirq_pending() implementation
      softirq/s390: Move default mutators of overwritten softirq mask to s390


 arch/ia64/include/asm/hardirq.h     |  2 +-
 arch/parisc/include/asm/hardirq.h   |  8 --------
 arch/powerpc/include/asm/hardirq.h  |  7 -------
 arch/s390/include/asm/hardirq.h     |  2 ++
 arch/sh/kernel/irq.c                |  2 +-
 arch/sparc/include/asm/hardirq_64.h |  5 +++--
 arch/x86/include/asm/hardirq.h      |  8 --------
 include/linux/interrupt.h           | 13 ++++++++++---
 include/linux/irq_cpustat.h         | 10 +++-------
 kernel/softirq.c                    |  4 ++--
 10 files changed, 22 insertions(+), 39 deletions(-)
