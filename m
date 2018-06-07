Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gGC9Bx9TGVt9HAAAmS7hNA
	; Thu, 07 Jun 2018 15:46:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0C624607E7; Thu,  7 Jun 2018 15:46:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8E8EE601B4;
	Thu,  7 Jun 2018 15:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E8EE601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935040AbeFGPqP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:46:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:36283 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934492AbeFGOke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:40:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:40:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="47542292"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2018 07:40:32 -0700
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
Subject: [PATCH 3/9] mm: Introduce VM_SHSTK for shadow stack memory
Date: Thu,  7 Jun 2018 07:36:59 -0700
Message-Id: <20180607143705.3531-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180607143705.3531-1-yu-cheng.yu@intel.com>
References: <20180607143705.3531-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM_SHSTK indicates a shadow stack memory area.

A shadow stack PTE must be read-only and dirty.  For non shadow
stack, we use a spare bit of the 64-bit PTE for dirty.  The PTE
changes are in the next patch.

There is no more spare bit in the 32-bit PTE (except for PAE) and
the shadow stack is not implemented for the 32-bit kernel.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 include/linux/mm.h | 8 ++++++++
 mm/internal.h      | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 02a616e2f17d..bf4388a8cc41 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -221,11 +221,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #if defined(CONFIG_X86)
@@ -257,6 +259,12 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MPX		VM_NONE
 #endif
 
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+# define VM_SHSTK	VM_HIGH_ARCH_5
+#else
+# define VM_SHSTK	VM_NONE
+#endif
+
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
diff --git a/mm/internal.h b/mm/internal.h
index 502d14189794..44c64711a309 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -280,6 +280,14 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
 }
 
+/*
+ * Shadow stack area
+ */
+static inline bool is_shstk_mapping(vm_flags_t flags)
+{
+	return (flags & VM_SHSTK);
+}
+
 /* mm/util.c */
 void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct rb_node *rb_parent);
-- 
2.15.1
