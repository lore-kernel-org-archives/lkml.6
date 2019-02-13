Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80360C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BEE20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083902;
	bh=feGGcNipgq/kodvDw3nUcE3YAsR0l2hxy+3oYpEeCHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SK5mtxBk34j75X5TFxw2y6SV9SW9BpIlBSQu9GjgRLMeXcW7JTJf04OhS9rsfqGJX
	 53KEHUtC11gWUBUqAjLBcP2xrWlapoleL4f9qrb+o8uMxLpotTUeyCBi1peq3Y/Vvu
	 n5Jl1uqOXZE0gDWGy0IaC3en2gQyBfmVUsbtNtyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394129AbfBMSvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:51:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405895AbfBMSnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59B1222D6;
        Wed, 13 Feb 2019 18:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083411;
        bh=feGGcNipgq/kodvDw3nUcE3YAsR0l2hxy+3oYpEeCHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2P4b5R7xro+i/Er7Mq66gCfLDqIPVi0Cg/muuNIhWa44GveMVNvI8MUT2mqpgxLpP
         QMjxXhobG8EgFKfhJUvvwbA2Zbck0v6gmjzCDULgOi4ye+O66qrgqIaXuDoROnMkyT
         4u0FJSthLkqBUNbHAudYCyvkTqtirIckc/x+2uRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 28/44] powerpc/radix: Fix kernel crash with mremap()
Date:   Wed, 13 Feb 2019 19:38:29 +0100
Message-Id: <20190213183654.146099977@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

commit 579b9239c1f38665b21e8d0e6ee83ecc96dbd6bb upstream.

With support for split pmd lock, we use pmd page pmd_huge_pte pointer
to store the deposited page table. In those config when we move page
tables we need to make sure we move the deposited page table to the
correct pmd page. Otherwise this can result in crash when we withdraw
of deposited page table because we can find the pmd_huge_pte NULL.

eg:

  __split_huge_pmd+0x1070/0x1940
  __split_huge_pmd+0xe34/0x1940 (unreliable)
  vma_adjust_trans_huge+0x110/0x1c0
  __vma_adjust+0x2b4/0x9b0
  __split_vma+0x1b8/0x280
  __do_munmap+0x13c/0x550
  sys_mremap+0x220/0x7e0
  system_call+0x5c/0x70

Fixes: 675d995297d4 ("powerpc/book3s64: Enable split pmd ptlock.")
Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/book3s/64/pgtable.h |   22 +++++++---------------
 arch/powerpc/mm/pgtable-book3s64.c           |   22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 15 deletions(-)

--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1234,21 +1234,13 @@ extern pmd_t pmdp_invalidate(struct vm_a
 
 #define pmd_move_must_withdraw pmd_move_must_withdraw
 struct spinlock;
-static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
-					 struct spinlock *old_pmd_ptl,
-					 struct vm_area_struct *vma)
-{
-	if (radix_enabled())
-		return false;
-	/*
-	 * Archs like ppc64 use pgtable to store per pmd
-	 * specific information. So when we switch the pmd,
-	 * we should also withdraw and deposit the pgtable
-	 */
-	return true;
-}
-
-
+extern int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
+				  struct spinlock *old_pmd_ptl,
+				  struct vm_area_struct *vma);
+/*
+ * Hash translation mode use the deposited table to store hash pte
+ * slot information.
+ */
 #define arch_needs_pgtable_deposit arch_needs_pgtable_deposit
 static inline bool arch_needs_pgtable_deposit(void)
 {
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -477,3 +477,25 @@ void arch_report_meminfo(struct seq_file
 		   atomic_long_read(&direct_pages_count[MMU_PAGE_1G]) << 20);
 }
 #endif /* CONFIG_PROC_FS */
+
+/*
+ * For hash translation mode, we use the deposited table to store hash slot
+ * information and they are stored at PTRS_PER_PMD offset from related pmd
+ * location. Hence a pmd move requires deposit and withdraw.
+ *
+ * For radix translation with split pmd ptl, we store the deposited table in the
+ * pmd page. Hence if we have different pmd page we need to withdraw during pmd
+ * move.
+ *
+ * With hash we use deposited table always irrespective of anon or not.
+ * With radix we use deposited table only for anonymous mapping.
+ */
+int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
+			   struct spinlock *old_pmd_ptl,
+			   struct vm_area_struct *vma)
+{
+	if (radix_enabled())
+		return (new_pmd_ptl != old_pmd_ptl) && vma_is_anonymous(vma);
+
+	return true;
+}


