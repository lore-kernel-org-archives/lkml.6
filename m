Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED00C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4502148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999282;
	bh=3cwsIjh3ApljIwoxs1Z8F/paLZJXh2OhOoTcBzp7XiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MIFvh6cNGLBnN71+QS5VMkwk4eCCA6zHIuMpOWwpT6AtJJei7Nj0CL9CQLdGbQPfT
	 dFdhNlMAmt8Zo2RZSSLlMuSmNAEYIwGsxFwj6qGL/0u3PYHwQsDWXbGd7lTqGOee/I
	 lMEuztU6+sZ9SppS+2bbDEAD9xrsNUzpp0GPiAYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbeL1MOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731098AbeL1MOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83E1C20866;
        Fri, 28 Dec 2018 12:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999274;
        bh=3cwsIjh3ApljIwoxs1Z8F/paLZJXh2OhOoTcBzp7XiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnOyPwb4Cj5m/0OZtaDhuGi5H5RU5Zg8yMhDgGC9Si2I8g8aRfAX4t9hBD6PuK35Q
         E1fLDv8G6uSlPMZ/jymYUI9v6t9QQJtcokXphxffnsebWAqTbhsPJIGw5y2Q+saq2X
         NvwQJRsJdQx193M+9XCcvCOhVak8ui2QrIoFZmpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 31/46] mm: add mm_pxd_folded checks to pgtable_bytes accounting functions
Date:   Fri, 28 Dec 2018 12:52:25 +0100
Message-Id: <20181228113126.637583556@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

[ Upstream commit 6d212db11947ae5464e4717536ed9faf61c01e86 ]

The common mm code calls mm_dec_nr_pmds() and mm_dec_nr_puds()
in free_pgtables() if the address range spans a full pud or pmd.
If mm_dec_nr_puds/mm_dec_nr_pmds are non-empty due to configuration
settings they blindly subtract the size of the pmd or pud table from
pgtable_bytes even if the pud or pmd page table layer is folded.

Add explicit mm_[pmd|pud]_folded checks to the four pgtable_bytes
accounting functions mm_inc_nr_puds, mm_inc_nr_pmds, mm_dec_nr_puds
and mm_dec_nr_pmds. As the check for folded page tables can be
overwritten by the architecture, this allows to keep a correct
pgtable_bytes value for platforms that use a dynamic number of
page table levels.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0416a7204be3..e899460f1bc5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1724,11 +1724,15 @@ int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address);
 
 static inline void mm_inc_nr_puds(struct mm_struct *mm)
 {
+	if (mm_pud_folded(mm))
+		return;
 	atomic_long_add(PTRS_PER_PUD * sizeof(pud_t), &mm->pgtables_bytes);
 }
 
 static inline void mm_dec_nr_puds(struct mm_struct *mm)
 {
+	if (mm_pud_folded(mm))
+		return;
 	atomic_long_sub(PTRS_PER_PUD * sizeof(pud_t), &mm->pgtables_bytes);
 }
 #endif
@@ -1748,11 +1752,15 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address);
 
 static inline void mm_inc_nr_pmds(struct mm_struct *mm)
 {
+	if (mm_pmd_folded(mm))
+		return;
 	atomic_long_add(PTRS_PER_PMD * sizeof(pmd_t), &mm->pgtables_bytes);
 }
 
 static inline void mm_dec_nr_pmds(struct mm_struct *mm)
 {
+	if (mm_pmd_folded(mm))
+		return;
 	atomic_long_sub(PTRS_PER_PMD * sizeof(pmd_t), &mm->pgtables_bytes);
 }
 #endif
-- 
2.19.1



