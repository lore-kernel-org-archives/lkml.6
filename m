Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C07DECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E30C2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E30C2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeJSVqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:46:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:23847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbeJSVqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:46:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 06:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,400,1534834800"; 
   d="scan'208";a="89603836"
Received: from svm-s2600wft.bj.intel.com ([10.240.193.45])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Oct 2018 06:39:51 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, jgross@suse.com,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, Yi Sun <yi.y.sun@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Date:   Fri, 19 Oct 2018 21:13:55 +0800
Message-Id: <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HvNotifyLongSpinWait hypercall (HVCALL_NOTIFY_LONG_SPIN_WAIT)
is used by a guest OS to notify the hypervisor that the calling
virtual processor is attempting to acquire a resource that is
potentially held by another virtual processor within the same
Virtual Machine. This scheduling hint improves the scalability of
VMs with more than one virtual processor on Hyper-V.

Per MSFT TLFS, the retry number (SpinWaitInfo) is sent to hypervisor
only when the retry number exceeds the recommended number. If
recommended number is 0xFFFFFFFF, never retry.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/hyperv/hv_spinlock.c       | 18 ++++++++++++++++++
 arch/x86/include/asm/mshyperv.h     |  1 +
 kernel/locking/qspinlock_paravirt.h | 10 ++++++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index a861b04..723dccb 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -18,6 +18,24 @@
 
 static bool __initdata hv_pvspin = true;
 
+bool hv_notify_long_spin_wait(int retry_num)
+{
+	/*
+	 * Per MSFT TLFS, the SpinWaitInfo is sent to hypervisor only when
+	 * the retry number exceeds the recommended number.
+	 *
+	 * If recommended number is 0xFFFFFFFF, never retry.
+	 */
+	if (ms_hyperv.num_spin_retry == HYPERV_SPINLOCK_RETRY_NEVER)
+		return false;
+
+	if ((0 == retry_num % ms_hyperv.num_spin_retry) && retry_num)
+		hv_do_fast_hypercall8(HVCALL_NOTIFY_LONG_SPIN_WAIT,
+				      retry_num);
+
+	return true;
+}
+
 static void hv_qlock_kick(int cpu)
 {
 	apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f909365..bd87868 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -356,6 +356,7 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 void hv_apic_init(void);
 void __init hv_init_spinlocks(void);
 bool hv_vcpu_is_preempted(int vcpu);
+bool hv_notify_long_spin_wait(int retry_num);
 #else
 static inline void hv_apic_init(void) {}
 #endif
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 0130e48..9e88c7e 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -7,6 +7,8 @@
 #include <linux/bootmem.h>
 #include <linux/debug_locks.h>
 
+#include <asm/mshyperv.h>
+
 /*
  * Implement paravirt qspinlocks; the general idea is to halt the vcpus instead
  * of spinning them.
@@ -305,6 +307,10 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 				wait_early = true;
 				break;
 			}
+#if defined(CONFIG_X86_64) && defined(CONFIG_PARAVIRT_SPINLOCKS) && IS_ENABLED(CONFIG_HYPERV)
+			if (!hv_notify_long_spin_wait(SPIN_THRESHOLD - loop))
+				break;
+#endif
 			cpu_relax();
 		}
 
@@ -433,6 +439,10 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
 			if (trylock_clear_pending(lock))
 				goto gotlock;
+#if defined(CONFIG_X86_64) && defined(CONFIG_PARAVIRT_SPINLOCKS) && IS_ENABLED(CONFIG_HYPERV)
+			if (!hv_notify_long_spin_wait(SPIN_THRESHOLD - loop))
+				break;
+#endif
 			cpu_relax();
 		}
 		clear_pending(lock);
-- 
1.9.1

