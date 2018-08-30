Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95872C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A88F20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A88F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeH3Srj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:47:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:18694 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729764AbeH3SrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:47:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 07:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="228910411"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga004.jf.intel.com with ESMTP; 30 Aug 2018 07:44:31 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v3 4/8] x86/cet/ibt: Add arch_prctl functions for IBT
Date:   Thu, 30 Aug 2018 07:40:05 -0700
Message-Id: <20180830144009.3314-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830144009.3314-1-yu-cheng.yu@intel.com>
References: <20180830144009.3314-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ARCH_CET_STATUS and ARCH_CET_DISABLE to include Indirect
Branch Tracking features.

Introduce:

arch_prctl(ARCH_CET_LEGACY_BITMAP, unsigned long *addr)
    Enable the Indirect Branch Tracking legacy code bitmap.

    The parameter 'addr' is a pointer to a user buffer.
    On returning to the caller, the kernel fills the following:

    *addr = IBT bitmap base address
    *(addr + 1) = IBT bitmap size

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/uapi/asm/prctl.h |  1 +
 arch/x86/kernel/cet_prctl.c       | 38 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/process.c         |  1 +
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 3aec1088e01d..31d2465f9caf 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -18,5 +18,6 @@
 #define ARCH_CET_DISABLE	0x3002
 #define ARCH_CET_LOCK		0x3003
 #define ARCH_CET_ALLOC_SHSTK	0x3004
+#define ARCH_CET_LEGACY_BITMAP	0x3005
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index c4b7c19f5040..df47b5ebc3f4 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -20,6 +20,8 @@ static int handle_get_status(unsigned long arg2)
 
 	if (current->thread.cet.shstk_enabled)
 		features |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
+	if (current->thread.cet.ibt_enabled)
+		features |= GNU_PROPERTY_X86_FEATURE_1_IBT;
 
 	shstk_base = current->thread.cet.shstk_base;
 	shstk_size = current->thread.cet.shstk_size;
@@ -49,9 +51,35 @@ static int handle_alloc_shstk(unsigned long arg2)
 	return 0;
 }
 
+static int handle_bitmap(unsigned long arg2)
+{
+	unsigned long addr, size;
+
+	if (current->thread.cet.ibt_enabled) {
+		int err;
+
+		err  = cet_setup_ibt_bitmap();
+		if (err)
+			return err;
+
+		addr = current->thread.cet.ibt_bitmap_addr;
+		size = current->thread.cet.ibt_bitmap_size;
+	} else {
+		addr = 0;
+		size = 0;
+	}
+
+	if (put_user(addr, (unsigned long __user *)arg2) ||
+	    put_user(size, (unsigned long __user *)arg2 + 1))
+		return -EFAULT;
+
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
@@ -63,6 +91,8 @@ int prctl_cet(int option, unsigned long arg2)
 			return -EPERM;
 		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
 			cet_disable_free_shstk(current);
+		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			cet_disable_ibt();
 
 		return 0;
 
@@ -73,6 +103,12 @@ int prctl_cet(int option, unsigned long arg2)
 	case ARCH_CET_ALLOC_SHSTK:
 		return handle_alloc_shstk(arg2);
 
+	/*
+	 * Allocate legacy bitmap and return address & size to user.
+	 */
+	case ARCH_CET_LEGACY_BITMAP:
+		return handle_bitmap(arg2);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ac0ea9c7e89f..aea15a9b6a3e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -797,6 +797,7 @@ long do_arch_prctl_common(struct task_struct *task, int option,
 	case ARCH_CET_DISABLE:
 	case ARCH_CET_LOCK:
 	case ARCH_CET_ALLOC_SHSTK:
+	case ARCH_CET_LEGACY_BITMAP:
 		return prctl_cet(option, cpuid_enabled);
 	}
 
-- 
2.17.1

