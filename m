Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA8C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4376420811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083569;
	bh=qc7ouLlNtnf5CZ1yYOIQJgirFEbecDq3TScXxQTpQzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pe4jT0IPPwKvf1RgJTMXT8CG2u6jutJ056/gwxKImLXXNtJRPx5JvJw7+jHqwvfNH
	 7oQaCL5KwB/hu/tuBRqbYFOQcFjPfjD2dJ/qwu+gsnXKFvTHQeRiTMyPOWmJ6j5riG
	 MFkQNzQfY94A74GtIOroUnJGsy623mDOkaRqAtng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406382AbfBMSqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:46:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730855AbfBMSqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D4720811;
        Wed, 13 Feb 2019 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083564;
        bh=qc7ouLlNtnf5CZ1yYOIQJgirFEbecDq3TScXxQTpQzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALG8jfpPpnVxNeTTDlGHMeYnoISlTs/hF8PLXa1GItysyugPZ+/ifmDy3DcP4V+4N
         9ZbbfyrTsN+zwz+lfohV3WvYWz6WzMRxZMv7v/+TWIZm8ozqHcb3yYX4LlOKMBw0FF
         TzQ3dyhb3UT3iJIMinO+7QVHv1YZnqc7TYxLUz0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.20 34/50] powerpc/radix: Fix kernel crash with mremap()
Date:   Wed, 13 Feb 2019 19:38:39 +0100
Message-Id: <20190213183658.439425120@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1258,21 +1258,13 @@ extern pmd_t pmdp_invalidate(struct vm_a
 
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
@@ -482,3 +482,25 @@ void arch_report_meminfo(struct seq_file
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


