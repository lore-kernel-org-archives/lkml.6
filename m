Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34EAECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCE720673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCE720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbeGTAQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:16:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33767 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeGTAQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:16:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNTRjY2453564
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:29:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNTQNk2453561;
        Thu, 19 Jul 2018 16:29:26 -0700
Date:   Thu, 19 Jul 2018 16:29:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-6c0df8689494e1fefa685377676fa8192291a0eb@git.kernel.org>
Cc:     will.deacon@arm.com, jroedel@suse.de, tglx@linutronix.de,
        dave.hansen@intel.com, pavel@ucw.cz, hpa@zytor.com,
        luto@kernel.org, gregkh@linuxfoundation.org,
        David.Laight@aculab.com, dhgutteridge@sympatico.ca,
        peterz@infradead.org, jkosina@suse.cz, bp@alien8.de,
        llong@redhat.com, dvlasenk@redhat.com, boris.ostrovsky@oracle.com,
        eduval@amazon.com, torvalds@linux-foundation.org,
        brgerst@gmail.com, aarcange@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com, jgross@suse.com
Reply-To: gregkh@linuxfoundation.org, luto@kernel.org,
          dhgutteridge@sympatico.ca, David.Laight@aculab.com,
          jroedel@suse.de, will.deacon@arm.com, tglx@linutronix.de,
          dave.hansen@intel.com, pavel@ucw.cz, hpa@zytor.com, bp@alien8.de,
          llong@redhat.com, peterz@infradead.org, jkosina@suse.cz,
          eduval@amazon.com, brgerst@gmail.com,
          torvalds@linux-foundation.org, aarcange@redhat.com,
          mingo@kernel.org, dvlasenk@redhat.com,
          boris.ostrovsky@oracle.com, jgross@suse.com,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com
In-Reply-To: <1531906876-13451-22-git-send-email-joro@8bytes.org>
References: <1531906876-13451-22-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pae: Populate valid user PGD entries
Git-Commit-ID: 6c0df8689494e1fefa685377676fa8192291a0eb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6c0df8689494e1fefa685377676fa8192291a0eb
Gitweb:     https://git.kernel.org/tip/6c0df8689494e1fefa685377676fa8192291a0eb
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:42 +0200

x86/mm/pae: Populate valid user PGD entries

Generic page-table code populates all non-leaf entries with _KERNPG_TABLE
bits set. This is fine for all paging modes except PAE.

In PAE mode only a subset of the bits is allowed to be set.  Make sure to
only set allowed bits by masking out the reserved bits.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-22-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/pgtable_types.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 99fff853c944..b64acb08a62b 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -50,6 +50,7 @@
 #define _PAGE_GLOBAL	(_AT(pteval_t, 1) << _PAGE_BIT_GLOBAL)
 #define _PAGE_SOFTW1	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW1)
 #define _PAGE_SOFTW2	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW2)
+#define _PAGE_SOFTW3	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW3)
 #define _PAGE_PAT	(_AT(pteval_t, 1) << _PAGE_BIT_PAT)
 #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
 #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
@@ -266,14 +267,37 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
 
 typedef struct { pgdval_t pgd; } pgd_t;
 
+#ifdef CONFIG_X86_PAE
+
+/*
+ * PHYSICAL_PAGE_MASK might be non-constant when SME is compiled in, so we can't
+ * use it here.
+ */
+
+#define PGD_PAE_PAGE_MASK	((signed long)PAGE_MASK)
+#define PGD_PAE_PHYS_MASK	(((1ULL << __PHYSICAL_MASK_SHIFT)-1) & PGD_PAE_PAGE_MASK)
+
+/*
+ * PAE allows Base Address, P, PWT, PCD and AVL bits to be set in PGD entries.
+ * All other bits are Reserved MBZ
+ */
+#define PGD_ALLOWED_BITS	(PGD_PAE_PHYS_MASK | _PAGE_PRESENT | \
+				 _PAGE_PWT | _PAGE_PCD | \
+				 _PAGE_SOFTW1 | _PAGE_SOFTW2 | _PAGE_SOFTW3)
+
+#else
+/* No need to mask any bits for !PAE */
+#define PGD_ALLOWED_BITS	(~0ULL)
+#endif
+
 static inline pgd_t native_make_pgd(pgdval_t val)
 {
-	return (pgd_t) { val };
+	return (pgd_t) { val & PGD_ALLOWED_BITS };
 }
 
 static inline pgdval_t native_pgd_val(pgd_t pgd)
 {
-	return pgd.pgd;
+	return pgd.pgd & PGD_ALLOWED_BITS;
 }
 
 static inline pgdval_t pgd_flags(pgd_t pgd)
