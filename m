Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B6FC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA9A2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA9A2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeJKWtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:49:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:64714 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbeJKWtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:49:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 08:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="77271624"
Received: from 2b52.sc.intel.com ([143.183.136.147])
  by fmsmga007.fm.intel.com with ESMTP; 11 Oct 2018 08:21:44 -0700
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
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v5 03/11] x86/cet/ibt: Add IBT legacy code bitmap allocation function
Date:   Thu, 11 Oct 2018 08:16:46 -0700
Message-Id: <20181011151654.27221-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011151654.27221-1-yu-cheng.yu@intel.com>
References: <20181011151654.27221-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indirect branch tracking provides an optional legacy code bitmap
that indicates locations of non-IBT compatible code.  When set,
each bit in the bitmap represents a page in the linear address is
legacy code.

We allocate the bitmap only when the application requests it.
Most applications do not need the bitmap.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/kernel/cet.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 40c4c08e5e31..77ae4eaa9dea 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -21,6 +21,7 @@
 #include <asm/compat.h>
 #include <asm/cet.h>
 #include <asm/special_insns.h>
+#include <asm/elf.h>
 
 static int set_shstk_ptr(unsigned long addr)
 {
@@ -327,3 +328,49 @@ void cet_disable_ibt(void)
 	wrmsrl(MSR_IA32_U_CET, r);
 	current->thread.cet.ibt_enabled = 0;
 }
+
+int cet_setup_ibt_bitmap(void)
+{
+	u64 r;
+	unsigned long bitmap;
+	unsigned long size;
+
+	if (!cpu_feature_enabled(X86_FEATURE_IBT))
+		return -EOPNOTSUPP;
+
+	if (!current->thread.cet.ibt_bitmap_addr) {
+		/*
+		 * Calculate size and put in thread header.
+		 * may_expand_vm() needs this information.
+		 */
+		size = in_compat_syscall() ? task_size_32bit() : task_size_64bit(1);
+		size = size / PAGE_SIZE / BITS_PER_BYTE;
+		current->thread.cet.ibt_bitmap_size = size;
+		bitmap = do_mmap_locked(0, size, PROT_READ | PROT_WRITE,
+					MAP_ANONYMOUS | MAP_PRIVATE,
+					VM_DONTDUMP);
+
+		if ((bitmap >= TASK_SIZE) || (bitmap < size)) {
+			current->thread.cet.ibt_bitmap_size = 0;
+			return -ENOMEM;
+		}
+
+		current->thread.cet.ibt_bitmap_addr = bitmap;
+
+		/*
+		 * Lower bits of MSR_IA32_CET_LEG_IW_EN are for IBT
+		 * settings.  Clear lower bits even bitmap is already
+		 * page-aligned.
+		 */
+		bitmap &= PAGE_MASK;
+
+		/*
+		 * Turn on IBT legacy bitmap.
+		 */
+		rdmsrl(MSR_IA32_U_CET, r);
+		r |= (MSR_IA32_CET_LEG_IW_EN | bitmap);
+		wrmsrl(MSR_IA32_U_CET, r);
+	}
+
+	return 0;
+}
-- 
2.17.1

