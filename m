Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A70C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B80208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="H71NWJ3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B80208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733292AbeGKLg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:36:26 -0400
Received: from 8bytes.org ([81.169.241.247]:37802 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732808AbeGKLeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:06 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D6042A21; Wed, 11 Jul 2018 13:30:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308603; bh=iEPn9yhr8K3WkTxVGik81NaWC4cuH7/tnosk3392xlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H71NWJ3RgeMUV6UFc1T3TwJPaj/ltMHQ87VHoBqOUY8y8R6uMG3ZsJCJsT0+4ihMW
         O0GBl0bwd9/qPL4tsl3hepz1/sTZ9spudVtM5YYhOwZldKLGz+rfaxG2d2S47lV11w
         6qU277FpZjdTd8rY+zxofhrJLoH6la5lZ0+4ReH0/OAl8GhUbI0a1NIdB5YoTK1zc+
         Ucek/sA3LaWftUz1UuAsIbpdGrZBJccJ0DbluJV/5TdPSceLdX/5SOpR25kMpakzUh
         VxigK92C7XEQoZP+kde7VmOW1zd15XssG8STqtCq3cEimxiA86pqUSyNduhbnLFZ+h
         RIMAksXwEsHHQ==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 18/39] x86/pgtable: Move pgdp kernel/user conversion functions to pgtable.h
Date:   Wed, 11 Jul 2018 13:29:25 +0200
Message-Id: <1531308586-29340-19-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Make them available on 32 bit and clone_pgd_range() happy.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable.h    | 49 +++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/pgtable_64.h | 49 ---------------------------------------
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5715647..eb47432 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1155,6 +1155,55 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+/*
+ * All top-level PAGE_TABLE_ISOLATION page tables are order-1 pages
+ * (8k-aligned and 8k in size).  The kernel one is at the beginning 4k and
+ * the user one is in the last 4k.  To switch between them, you
+ * just need to flip the 12th bit in their addresses.
+ */
+#define PTI_PGTABLE_SWITCH_BIT	PAGE_SHIFT
+
+/*
+ * This generates better code than the inline assembly in
+ * __set_bit().
+ */
+static inline void *ptr_set_bit(void *ptr, int bit)
+{
+	unsigned long __ptr = (unsigned long)ptr;
+
+	__ptr |= BIT(bit);
+	return (void *)__ptr;
+}
+static inline void *ptr_clear_bit(void *ptr, int bit)
+{
+	unsigned long __ptr = (unsigned long)ptr;
+
+	__ptr &= ~BIT(bit);
+	return (void *)__ptr;
+}
+
+static inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
+{
+	return ptr_set_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
+}
+
+static inline pgd_t *user_to_kernel_pgdp(pgd_t *pgdp)
+{
+	return ptr_clear_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
+}
+
+static inline p4d_t *kernel_to_user_p4dp(p4d_t *p4dp)
+{
+	return ptr_set_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
+}
+
+static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
+{
+	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
+}
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+
 /*
  * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
  *
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 9406c4f..4adba19 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -132,55 +132,6 @@ static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 #endif
 }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-/*
- * All top-level PAGE_TABLE_ISOLATION page tables are order-1 pages
- * (8k-aligned and 8k in size).  The kernel one is at the beginning 4k and
- * the user one is in the last 4k.  To switch between them, you
- * just need to flip the 12th bit in their addresses.
- */
-#define PTI_PGTABLE_SWITCH_BIT	PAGE_SHIFT
-
-/*
- * This generates better code than the inline assembly in
- * __set_bit().
- */
-static inline void *ptr_set_bit(void *ptr, int bit)
-{
-	unsigned long __ptr = (unsigned long)ptr;
-
-	__ptr |= BIT(bit);
-	return (void *)__ptr;
-}
-static inline void *ptr_clear_bit(void *ptr, int bit)
-{
-	unsigned long __ptr = (unsigned long)ptr;
-
-	__ptr &= ~BIT(bit);
-	return (void *)__ptr;
-}
-
-static inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
-{
-	return ptr_set_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline pgd_t *user_to_kernel_pgdp(pgd_t *pgdp)
-{
-	return ptr_clear_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline p4d_t *kernel_to_user_p4dp(p4d_t *p4dp)
-{
-	return ptr_set_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
-{
-	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
-}
-#endif /* CONFIG_PAGE_TABLE_ISOLATION */
-
 /*
  * Page table pages are page-aligned.  The lower half of the top
  * level is used for userspace and the top half for the kernel.
-- 
2.7.4

