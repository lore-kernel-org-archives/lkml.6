Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964913AbeBPL0z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:26:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50336 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964886AbeBPL0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:26:53 -0500
From: Borislav Petkov <bp@alien8.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] x86/CPU: Add a microcode loader callback
Date: Fri, 16 Feb 2018 12:26:39 +0100
Message-Id: <20180216112640.11554-3-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180216112640.11554-1-bp@alien8.de>
References: <20180216112640.11554-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add a callback function which the microcode loader calls when microcode
has been updated to a newer revision. Do the callback only when no error
was encountered during loading.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/processor.h     |  1 +
 arch/x86/kernel/cpu/common.c         | 10 ++++++++++
 arch/x86/kernel/cpu/microcode/core.c |  8 ++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 23fdaf4ec925..856669b90a0c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -977,4 +977,5 @@ bool xen_set_default_idle(void);
 
 void stop_this_cpu(void *dummy);
 void df_debug(struct pt_regs *regs, long error_code);
+void microcode_check(void);
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d63f4b5706e4..82c142b33bf3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1749,3 +1749,13 @@ static int __init init_cpu_syscore(void)
 	return 0;
 }
 core_initcall(init_cpu_syscore);
+
+/*
+ * The microcode loader calls this upon late microcode load to recheck features,
+ * only when microcode has been updated. Caller holds microcode_mutex and CPU
+ * hotplug lock.
+ */
+void microcode_check(void)
+{
+	perf_check_microcode();
+}
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6fdaf7cf3182..aa1b9a422f2b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -509,6 +509,7 @@ static ssize_t reload_store(struct device *dev,
 			    const char *buf, size_t size)
 {
 	enum ucode_state tmp_ret = UCODE_OK;
+	bool do_callback = false;
 	unsigned long val;
 	ssize_t ret = 0;
 	int cpu;
@@ -531,10 +532,13 @@ static ssize_t reload_store(struct device *dev,
 			if (!ret)
 				ret = -EINVAL;
 		}
+
+		if (tmp_ret == UCODE_UPDATED)
+			do_callback = true;
 	}
 
-	if (!ret && tmp_ret == UCODE_UPDATED)
-		perf_check_microcode();
+	if (!ret && do_callback)
+		microcode_check();
 
 	mutex_unlock(&microcode_mutex);
 	put_online_cpus();
-- 
2.13.0
