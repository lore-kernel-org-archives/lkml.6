Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6853C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17E52156E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17E52156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390553AbeIUU7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:59:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:13768 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390861AbeIUU7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:59:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 08:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="88187971"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2018 08:10:28 -0700
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v4 4/9] mm/mmap: Add IBT bitmap size to address space limit check
Date:   Fri, 21 Sep 2018 08:05:48 -0700
Message-Id: <20180921150553.21016-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921150553.21016-1-yu-cheng.yu@intel.com>
References: <20180921150553.21016-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The indirect branch tracking legacy bitmap takes a large address
space.  This causes may_expand_vm() failure on the address limit
check.  For a IBT-enabled task, add the bitmap size to the
address limit.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/uapi/asm/resource.h |  5 +++++
 include/uapi/asm-generic/resource.h  |  3 +++
 mm/mmap.c                            | 12 +++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/resource.h b/arch/x86/include/uapi/asm/resource.h
index 04bc4db8921b..0741b2a6101a 100644
--- a/arch/x86/include/uapi/asm/resource.h
+++ b/arch/x86/include/uapi/asm/resource.h
@@ -1 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifdef CONFIG_X86_INTEL_CET
+#define rlimit_as_extra() current->thread.cet.ibt_bitmap_size
+#endif
+
 #include <asm-generic/resource.h>
diff --git a/include/uapi/asm-generic/resource.h b/include/uapi/asm-generic/resource.h
index f12db7a0da64..8a7608a09700 100644
--- a/include/uapi/asm-generic/resource.h
+++ b/include/uapi/asm-generic/resource.h
@@ -58,5 +58,8 @@
 # define RLIM_INFINITY		(~0UL)
 #endif
 
+#ifndef rlimit_as_extra
+#define rlimit_as_extra() 0
+#endif
 
 #endif /* _UAPI_ASM_GENERIC_RESOURCE_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index fa581ced3f56..397b8cb0b0af 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3237,7 +3237,17 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
  */
 bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags, unsigned long npages)
 {
-	if (mm->total_vm + npages > rlimit(RLIMIT_AS) >> PAGE_SHIFT)
+	unsigned long as_limit = rlimit(RLIMIT_AS);
+	unsigned long as_limit_plus = as_limit + rlimit_as_extra();
+
+	/* as_limit_plus overflowed */
+	if (as_limit_plus < as_limit)
+		as_limit_plus = RLIM_INFINITY;
+
+	if (as_limit_plus > as_limit)
+		as_limit = as_limit_plus;
+
+	if (mm->total_vm + npages > as_limit >> PAGE_SHIFT)
 		return false;
 
 	if (is_data_mapping(flags) &&
-- 
2.17.1

