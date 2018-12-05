Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53329C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A6E20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A6E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeLESHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:07:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLESHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:07:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB5I6B6q1375656
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Dec 2018 10:06:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB5I6BOl1375653;
        Wed, 5 Dec 2018 10:06:11 -0800
Date:   Wed, 5 Dec 2018 10:06:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-4369deaa2f022ef92da45a0e7eec8a4a52e8e8a4@git.kernel.org>
Cc:     riel@surriel.com, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        dave.hansen@intel.com, bigeasy@linutronix.de,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        dan.j.williams@intel.com, bp@alien8.de, mingo@kernel.org,
        peterz@infradead.org
Reply-To: mingo@kernel.org, peterz@infradead.org, bp@alien8.de,
          dan.j.williams@intel.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, dave.hansen@intel.com,
          bigeasy@linutronix.de, luto@kernel.org,
          kirill.shutemov@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
          riel@surriel.com
In-Reply-To: <279dadae-9148-465c-7ec6-3f37e026c6c9@intel.com>
References: <279dadae-9148-465c-7ec6-3f37e026c6c9@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] generic/pgtable: Introduce set_pte_safe()
Git-Commit-ID: 4369deaa2f022ef92da45a0e7eec8a4a52e8e8a4
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

Commit-ID:  4369deaa2f022ef92da45a0e7eec8a4a52e8e8a4
Gitweb:     https://git.kernel.org/tip/4369deaa2f022ef92da45a0e7eec8a4a52e8e8a4
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Tue, 4 Dec 2018 13:37:16 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 5 Dec 2018 09:03:06 +0100

generic/pgtable: Introduce set_pte_safe()

Commit:

  f77084d96355 "x86/mm/pat: Disable preemption around __flush_tlb_all()"

introduced a warning to capture cases __flush_tlb_all() is called without
pre-emption disabled. It triggers a false positive warning in the memory
hotplug path.

On investigation it was found that the __flush_tlb_all() calls are not
necessary. However, they are only "not necessary" in practice provided
the ptes are being initially populated from the !present state.

Introduce set_pte_safe() as a sanity check that the pte is being updated
in a way that does not require a TLB flush.

Forgive the macro, the availability of the various of set_pte() levels
is hit and miss across architectures.

[ mingo: Minor readability edits. ]

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/279dadae-9148-465c-7ec6-3f37e026c6c9@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/pgtable.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index dae7f98babed..a9cac82e9a7a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -400,6 +400,44 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
 }
 #endif
 
+/*
+ * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
+ * TLB flush will be required as a result of the "set". For example, use
+ * in scenarios where it is known ahead of time that the routine is
+ * setting non-present entries, or re-setting an existing entry to the
+ * same value. Otherwise, use the typical "set" helpers and flush the
+ * TLB.
+ */
+#define set_pte_safe(ptep, pte) \
+({ \
+	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
+	set_pte(ptep, pte); \
+})
+
+#define set_pmd_safe(pmdp, pmd) \
+({ \
+	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
+	set_pmd(pmdp, pmd); \
+})
+
+#define set_pud_safe(pudp, pud) \
+({ \
+	WARN_ON_ONCE(pud_present(*pudp) && !pud_same(*pudp, pud)); \
+	set_pud(pudp, pud); \
+})
+
+#define set_p4d_safe(p4dp, p4d) \
+({ \
+	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
+	set_p4d(p4dp, p4d); \
+})
+
+#define set_pgd_safe(pgdp, pgd) \
+({ \
+	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
+	set_pgd(pgdp, pgd); \
+})
+
 #ifndef __HAVE_ARCH_DO_SWAP_PAGE
 /*
  * Some architectures support metadata associated with a page. When a
