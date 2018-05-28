Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424862AbeE1Lqf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423635AbeE1LKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:10:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 115/272] powerpc/perf: Fix kernel address leak via sampling registers
Date: Mon, 28 May 2018 12:02:28 +0200
Message-Id: <20180528100250.838571729@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit e1ebd0e5b9d0a10ba65e63a3514b6da8c6a5a819 ]

Current code in power_pmu_disable() does not clear the sampling
registers like Sampling Instruction Address Register (SIAR) and
Sampling Data Address Register (SDAR) after disabling the PMU. Since
these are userspace readable and could contain kernel addresses, add
code to explicitly clear the content of these registers.

Also add a "context synchronizing instruction" to enforce no further
updates to these registers as suggested by Power ISA v3.0B. From
section 9.4, on page 1108:

  "If an mtspr instruction is executed that changes the value of a
  Performance Monitor register other than SIAR, SDAR, and SIER, the
  change is not guaranteed to have taken effect until after a
  subsequent context synchronizing instruction has been executed (see
  Chapter 11. "Synchronization Requirements for Context Alterations"
  on page 1133)."

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
[mpe: Massage change log and add ISA reference]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/perf/core-book3s.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1236,6 +1236,7 @@ static void power_pmu_disable(struct pmu
 		 */
 		write_mmcr0(cpuhw, val);
 		mb();
+		isync();
 
 		/*
 		 * Disable instruction sampling if it was enabled
@@ -1244,12 +1245,26 @@ static void power_pmu_disable(struct pmu
 			mtspr(SPRN_MMCRA,
 			      cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
 			mb();
+			isync();
 		}
 
 		cpuhw->disabled = 1;
 		cpuhw->n_added = 0;
 
 		ebb_switch_out(mmcr0);
+
+#ifdef CONFIG_PPC64
+		/*
+		 * These are readable by userspace, may contain kernel
+		 * addresses and are not switched by context switch, so clear
+		 * them now to avoid leaking anything to userspace in general
+		 * including to another process.
+		 */
+		if (ppmu->flags & PPMU_ARCH_207S) {
+			mtspr(SPRN_SDAR, 0);
+			mtspr(SPRN_SIAR, 0);
+		}
+#endif
 	}
 
 	local_irq_restore(flags);
