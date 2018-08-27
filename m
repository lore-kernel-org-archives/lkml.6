Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA11C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A616208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A616208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeH0Wpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:45:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:23091 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbeH0Wpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:45:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 11:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,296,1531810800"; 
   d="scan'208";a="69524693"
Received: from nitikasi-mobl.ger.corp.intel.com (HELO localhost) ([10.249.36.186])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2018 11:57:26 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Serge Ayoun <serge.ayoun@intel.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing enclaves
Date:   Mon, 27 Aug 2018 21:53:31 +0300
Message-Id: <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add a function to perform ENCLS(EINIT), which initializes an enclave,
which can be used by a driver for running enclaves and VMMs.

Writing the LE hash MSRs is extraordinarily expensive, e.g. 3-4x slower
than normal MSRs, so we use a per-cpu cache to track the last known value
of the MSRs to avoid unnecessarily writing the MSRs with the current value.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/asm/sgx.h      |  2 +
 arch/x86/kernel/cpu/intel_sgx.c | 86 +++++++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index baf30d49b71f..c15c156436be 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -108,6 +108,8 @@ void sgx_free_page(struct sgx_epc_page *page);
 void sgx_page_reclaimable(struct sgx_epc_page *page);
 struct page *sgx_get_backing(struct file *file, pgoff_t index);
 void sgx_put_backing(struct page *backing_page, bool write);
+int sgx_einit(struct sgx_sigstruct *sigstruct, struct sgx_einittoken *token,
+	      struct sgx_epc_page *secs_page, u64 lepubkeyhash[4]);
 
 #define ENCLS_FAULT_FLAG 0x40000000UL
 #define ENCLS_FAULT_FLAG_ASM "$0x40000000"
diff --git a/arch/x86/kernel/cpu/intel_sgx.c b/arch/x86/kernel/cpu/intel_sgx.c
index 1046478a3ab9..fe25e6805680 100644
--- a/arch/x86/kernel/cpu/intel_sgx.c
+++ b/arch/x86/kernel/cpu/intel_sgx.c
@@ -9,6 +9,7 @@
 #include <linux/sched/signal.h>
 #include <linux/shmem_fs.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <asm/sgx.h>
 #include <asm/sgx_pr.h>
 
@@ -38,6 +39,18 @@ static LIST_HEAD(sgx_active_page_list);
 static DEFINE_SPINLOCK(sgx_active_page_list_lock);
 static struct task_struct *ksgxswapd_tsk;
 static DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
+static struct notifier_block sgx_pm_notifier;
+static u64 sgx_pm_cnt;
+
+/* The cache for the last known values of IA32_SGXLEPUBKEYHASHx MSRs for each
+ * CPU. The entries are initialized when they are first used by sgx_einit().
+ */
+struct sgx_lepubkeyhash {
+	u64 msrs[4];
+	u64 pm_cnt;
+};
+
+static DEFINE_PER_CPU(struct sgx_lepubkeyhash *, sgx_lepubkeyhash_cache);
 
 /**
  * sgx_reclaim_pages - reclaim EPC pages from the consumers
@@ -328,6 +341,54 @@ void sgx_put_backing(struct page *backing_page, bool write)
 }
 EXPORT_SYMBOL_GPL(sgx_put_backing);
 
+/**
+ * sgx_einit - initialize an enclave
+ * @sigstruct:		a pointer to the SIGSTRUCT
+ * @token:		a pointer to the EINITTOKEN
+ * @secs_page:		a pointer to the SECS EPC page
+ * @lepubkeyhash:	the desired value for IA32_SGXLEPUBKEYHASHx MSRs
+ *
+ * Try to perform EINIT operation. If the MSRs are writable, they are updated
+ * according to @lepubkeyhash.
+ *
+ * Return:
+ *   0 on success,
+ *   -errno on failure
+ *   SGX error code if EINIT fails
+ */
+int sgx_einit(struct sgx_sigstruct *sigstruct, struct sgx_einittoken *token,
+	      struct sgx_epc_page *secs_page, u64 lepubkeyhash[4])
+{
+	struct sgx_lepubkeyhash __percpu *cache;
+	bool cache_valid;
+	int i, ret;
+
+	if (!sgx_lc_enabled)
+		return __einit(sigstruct, token, sgx_epc_addr(secs_page));
+
+	cache = per_cpu(sgx_lepubkeyhash_cache, smp_processor_id());
+	if (!cache) {
+		cache = kzalloc(sizeof(struct sgx_lepubkeyhash), GFP_KERNEL);
+		if (!cache)
+			return -ENOMEM;
+	}
+
+	cache_valid = cache->pm_cnt == sgx_pm_cnt;
+	cache->pm_cnt = sgx_pm_cnt;
+	preempt_disable();
+	for (i = 0; i < 4; i++) {
+		if (cache_valid && lepubkeyhash[i] == cache->msrs[i])
+			continue;
+
+		wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + i, lepubkeyhash[i]);
+		cache->msrs[i] = lepubkeyhash[i];
+	}
+	ret = __einit(sigstruct, token, sgx_epc_addr(secs_page));
+	preempt_enable();
+	return ret;
+}
+EXPORT_SYMBOL(sgx_einit);
+
 static __init int sgx_init_epc_bank(u64 addr, u64 size, unsigned long index,
 				    struct sgx_epc_bank *bank)
 {
@@ -426,6 +487,15 @@ static __init int sgx_page_cache_init(void)
 	return 0;
 }
 
+static int sgx_pm_notifier_cb(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	if (action == PM_SUSPEND_PREPARE || action == PM_HIBERNATION_PREPARE)
+		sgx_pm_cnt++;
+
+	return NOTIFY_DONE;
+}
+
 static __init int sgx_init(void)
 {
 	struct task_struct *tsk;
@@ -452,20 +522,30 @@ static __init int sgx_init(void)
 	if (!(fc & FEATURE_CONTROL_SGX_LE_WR))
 		pr_info("IA32_SGXLEPUBKEYHASHn MSRs are not writable\n");
 
-	ret = sgx_page_cache_init();
+	sgx_pm_notifier.notifier_call = sgx_pm_notifier_cb;
+	ret = register_pm_notifier(&sgx_pm_notifier);
 	if (ret)
 		return ret;
 
+	ret = sgx_page_cache_init();
+	if (ret)
+		goto out_pm;
+
 	tsk = kthread_run(ksgxswapd, NULL, "ksgxswapd");
 	if (IS_ERR(tsk)) {
-		sgx_page_cache_teardown();
-		return PTR_ERR(tsk);
+		ret = PTR_ERR(tsk);
+		goto out_pcache;
 	}
 	ksgxswapd_tsk = tsk;
 
 	sgx_enabled = true;
 	sgx_lc_enabled = !!(fc & FEATURE_CONTROL_SGX_LE_WR);
 	return 0;
+out_pcache:
+	sgx_page_cache_teardown();
+out_pm:
+	unregister_pm_notifier(&sgx_pm_notifier);
+	return ret;
 }
 
 arch_initcall(sgx_init);
-- 
2.17.1

