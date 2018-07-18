Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4609F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="l0VXA5zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4609F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeGRKUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:20:43 -0400
Received: from 8bytes.org ([81.169.241.247]:53890 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731583AbeGRKSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:35 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BF03B32E; Wed, 18 Jul 2018 11:41:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906881; bh=iEPn9yhr8K3WkTxVGik81NaWC4cuH7/tnosk3392xlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0VXA5zczlqz0kuUJ2v+cNLP4RGH65IzpXn0rDLEwwJv549Z9TSKbfEP3dN1qINbR
         8xZ/uoGUG6pvi5aDwyqe3gmxzvrYrhOXTYXxMx0QXXLLfb+0jkeAr4jEvXa6Ag9V37
         frLIm9mEKa0vI47YXQGz/IhpZgMCSLyQOIR8Uts8D80YLZAyRaozzjqPPoYAg+TXNy
         sIpVQkB7dYByLs3hu072jgAW/cdx+dFBLHG+gwv05l329M7kzoNNyymZykY/7HGNGW
         3FMWeSAGu7IKy79CCH93KrL+VsYGNOZC51jlP4Prm7csZQM6o/yokh5XTVznn4WbKt
         7T9J1hR1qV1MA==
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
Date:   Wed, 18 Jul 2018 11:40:55 +0200
Message-Id: <1531906876-13451-19-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
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

