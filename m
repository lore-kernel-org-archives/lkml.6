Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Gi9jCVlEGVvBEwAAmS7hNA
	; Thu, 07 Jun 2018 14:42:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9E742608BA; Thu,  7 Jun 2018 14:42:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 81B9C607DC;
	Thu,  7 Jun 2018 14:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81B9C607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934297AbeFGOmk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:42:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:61237 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933716AbeFGOmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:42:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:42:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="235505947"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2018 07:42:30 -0700
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 4/7] x86/cet: add arcp_prctl functions for indirect branch tracking
Date: Thu,  7 Jun 2018 07:38:52 -0700
Message-Id: <20180607143855.3681-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180607143855.3681-1-yu-cheng.yu@intel.com>
References: <20180607143855.3681-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h        |  1 +
 arch/x86/include/uapi/asm/prctl.h |  1 +
 arch/x86/kernel/cet_prctl.c       | 54 ++++++++++++++++++++++++++++++++++++---
 arch/x86/kernel/elf.c             | 12 ++++++---
 arch/x86/kernel/process.c         |  1 +
 5 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index d07bdeb27db4..5b71a2b44eb1 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -19,6 +19,7 @@ struct cet_stat {
 	unsigned int	ibt_enabled:1;
 	unsigned int	locked:1;
 	unsigned int	exec_shstk:2;
+	unsigned int	exec_ibt:2;
 };
 
 #ifdef CONFIG_X86_INTEL_CET
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index f9965403b655..fef476d2d2f6 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -20,6 +20,7 @@
 #define ARCH_CET_EXEC		0x3004
 #define ARCH_CET_ALLOC_SHSTK	0x3005
 #define ARCH_CET_PUSH_SHSTK	0x3006
+#define ARCH_CET_LEGACY_BITMAP	0x3007
 
 /*
  * Settings for ARCH_CET_EXEC
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index 326996e2ea80..948f7ba98dc2 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -19,6 +19,7 @@
  * ARCH_CET_EXEC: set default features for exec()
  * ARCH_CET_ALLOC_SHSTK: allocate shadow stack
  * ARCH_CET_PUSH_SHSTK: put a return address on shadow stack
+ * ARCH_CET_LEGACY_BITMAP: allocate legacy bitmap
  */
 
 static int handle_get_status(unsigned long arg2)
@@ -28,8 +29,12 @@ static int handle_get_status(unsigned long arg2)
 
 	if (current->thread.cet.shstk_enabled)
 		features |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
+	if (current->thread.cet.ibt_enabled)
+		features |= GNU_PROPERTY_X86_FEATURE_1_IBT;
 	if (current->thread.cet.exec_shstk == CET_EXEC_ALWAYS_ON)
 		cet_exec |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
+	if (current->thread.cet.exec_ibt == CET_EXEC_ALWAYS_ON)
+		cet_exec |= GNU_PROPERTY_X86_FEATURE_1_IBT;
 	shstk_size = current->thread.cet.exec_shstk_size;
 
 	if (in_compat_syscall()) {
@@ -94,9 +99,18 @@ static int handle_set_exec(unsigned long arg2)
 			return -EPERM;
 	}
 
+	if (features & GNU_PROPERTY_X86_FEATURE_1_IBT) {
+		if (!cpu_feature_enabled(X86_FEATURE_IBT))
+			return -EINVAL;
+		if ((current->thread.cet.exec_ibt == CET_EXEC_ALWAYS_ON) &&
+		    (cet_exec != CET_EXEC_ALWAYS_ON))
+			return -EPERM;
+	}
+
 	if (features & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
 		current->thread.cet.exec_shstk = cet_exec;
-
+	if (features & GNU_PROPERTY_X86_FEATURE_1_IBT)
+		current->thread.cet.exec_ibt = cet_exec;
 	current->thread.cet.exec_shstk_size = shstk_size;
 	return 0;
 }
@@ -167,9 +181,36 @@ static int handle_alloc_shstk(unsigned long arg2)
 	return 0;
 }
 
+static int handle_bitmap(unsigned long arg2)
+{
+	unsigned long addr, size;
+
+	if (current->thread.cet.ibt_enabled) {
+		if (!current->thread.cet.ibt_bitmap_addr)
+			cet_setup_ibt_bitmap();
+		addr = current->thread.cet.ibt_bitmap_addr;
+		size = current->thread.cet.ibt_bitmap_size;
+	} else {
+		addr = 0;
+		size = 0;
+	}
+
+	if (in_compat_syscall()) {
+		if (put_user(addr, (unsigned int __user *)arg2) ||
+		    put_user(size, (unsigned int __user *)arg2 + 1))
+			return -EFAULT;
+	} else {
+		if (put_user(addr, (unsigned long __user *)arg2) ||
+		    put_user(size, (unsigned long __user *)arg2 + 1))
+		return -EFAULT;
+	}
+	return 0;
+}
+
 int prctl_cet(int option, unsigned long arg2)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) &&
+	    !cpu_feature_enabled(X86_FEATURE_IBT))
 		return -EINVAL;
 
 	switch (option) {
@@ -181,7 +222,8 @@ int prctl_cet(int option, unsigned long arg2)
 			return -EPERM;
 		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
 			cet_disable_free_shstk(current);
-
+		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			cet_disable_ibt();
 		return 0;
 
 	case ARCH_CET_LOCK:
@@ -197,6 +239,12 @@ int prctl_cet(int option, unsigned long arg2)
 	case ARCH_CET_PUSH_SHSTK:
 		return handle_push_shstk(arg2);
 
+	/*
+	 * Allocate legacy bitmap and return address & size to user.
+	 */
+	case ARCH_CET_LEGACY_BITMAP:
+		return handle_bitmap(arg2);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/elf.c b/arch/x86/kernel/elf.c
index a3995c8c2fc2..c2a89f3c7186 100644
--- a/arch/x86/kernel/elf.c
+++ b/arch/x86/kernel/elf.c
@@ -230,10 +230,14 @@ int arch_setup_features(void *ehdr_p, void *phdr_p,
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
-		if (ibt) {
-			err = cet_setup_ibt();
-			if (err < 0)
-				goto out;
+		int exec = current->thread.cet.exec_ibt;
+
+		if (exec != CET_EXEC_ALWAYS_OFF) {
+			if (ibt || (exec == CET_EXEC_ALWAYS_ON)) {
+				err = cet_setup_ibt();
+				if (err < 0)
+					goto out;
+			}
 		}
 	}
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9bec164e7958..c69576b4abd1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -801,6 +801,7 @@ long do_arch_prctl_common(struct task_struct *task, int option,
 	case ARCH_CET_EXEC:
 	case ARCH_CET_ALLOC_SHSTK:
 	case ARCH_CET_PUSH_SHSTK:
+	case ARCH_CET_LEGACY_BITMAP:
 		return prctl_cet(option, cpuid_enabled);
 	}
 
-- 
2.15.1
