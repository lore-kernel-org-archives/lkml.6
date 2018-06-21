Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6295EC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFA521524
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFA521524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbeFUVSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:18:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:27244 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754240AbeFUVSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:18:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 14:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="48912119"
Received: from hanvin-mobl2.amr.corp.intel.com ([10.254.42.214])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2018 14:18:02 -0700
From:   "H. Peter Anvin, Intel" <h.peter.anvin@intel.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "H. Peter Anvin" <hpa@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        "Markus T . Metzger" <markus.t.metzger@intel.com>
Subject: [PATCH v3 3/7] x86: move fill_user_desc() from tls.c to desc.h and add validity check
Date:   Thu, 21 Jun 2018 14:17:50 -0700
Message-Id: <20180621211754.12757-4-h.peter.anvin@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180621211754.12757-1-h.peter.anvin@intel.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@linux.intel.com>

This is generic code which is potentially useful in other contexts.
Unfortunately modify_ldt() is kind of stupid in that it returns a
descriptor in CPU format but takes a different format, but regsets
*have* to operate differently.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Markus T. Metzger <markus.t.metzger@intel.com>
---
 arch/x86/include/asm/desc.h | 22 ++++++++++++++++++++++
 arch/x86/kernel/tls.c       | 19 -------------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 13c5ee878a47..5e69f993c9ff 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -386,6 +386,28 @@ static inline void set_desc_limit(struct desc_struct *desc, unsigned long limit)
 	desc->limit1 = (limit >> 16) & 0xf;
 }
 
+
+static inline void fill_user_desc(struct user_desc *info, int idx,
+			   const struct desc_struct *desc)
+
+{
+	memset(info, 0, sizeof(*info));
+	info->entry_number = idx;
+	if (desc->s && desc->dpl == 3) {
+		info->base_addr = get_desc_base(desc);
+		info->limit = get_desc_limit(desc);
+		info->seg_32bit = desc->d;
+		info->contents = desc->type >> 2;
+		info->read_exec_only = !(desc->type & 2);
+		info->limit_in_pages = desc->g;
+		info->seg_not_present = !desc->p;
+		info->useable = desc->avl;
+#ifdef CONFIG_X86_64
+		info->lm = desc->l;
+#endif
+	}
+}
+
 void update_intr_gate(unsigned int n, const void *addr);
 void alloc_intr_gate(unsigned int n, const void *addr);
 
diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index a5b802a12212..7b8ecb760707 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -197,25 +197,6 @@ SYSCALL_DEFINE1(set_thread_area, struct user_desc __user *, u_info)
  * Get the current Thread-Local Storage area:
  */
 
-static void fill_user_desc(struct user_desc *info, int idx,
-			   const struct desc_struct *desc)
-
-{
-	memset(info, 0, sizeof(*info));
-	info->entry_number = idx;
-	info->base_addr = get_desc_base(desc);
-	info->limit = get_desc_limit(desc);
-	info->seg_32bit = desc->d;
-	info->contents = desc->type >> 2;
-	info->read_exec_only = !(desc->type & 2);
-	info->limit_in_pages = desc->g;
-	info->seg_not_present = !desc->p;
-	info->useable = desc->avl;
-#ifdef CONFIG_X86_64
-	info->lm = desc->l;
-#endif
-}
-
 int do_get_thread_area(struct task_struct *p, int idx,
 		       struct user_desc __user *u_info)
 {
-- 
2.14.4

