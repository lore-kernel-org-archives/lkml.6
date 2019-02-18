Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3261C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A8621908
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498000;
	bh=2WwFNnXJR80r3GMhM9pE/wlNSerjrShpLR7BNvhv5tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YdyPLSLPPshEYCeDhkzyDh2WG0wldOZHFxgcGo/u7V1w2oq/K4BZtMB6Sld3BwDMg
	 8nmlJ0U9OHVNhicCoUxStK4sw9Pe3kyHBa4M03ETYQQXQy4Uc4VyvgVgXCBf9SxZQc
	 v8P4iDoVw/iwfBOj/+AyOnzWlfwx+0uEKXTssVa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfBRNxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732923AbfBRNxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:53:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C2921908;
        Mon, 18 Feb 2019 13:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497994;
        bh=2WwFNnXJR80r3GMhM9pE/wlNSerjrShpLR7BNvhv5tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Necny8VdafyNF6dYnhU4j/XNS1P8nDTCPZEhywD5fx4dbD/Aita79qS10Cxvhmrr0
         V1eD4vnst/JUV6QZFU1OjtNL96KswJy1orMVJ4IiO1/D0ySqwdo2Z4OXoaytvF3OTt
         gdnZobDb7P7Qx35wKDBTfaT7XlRdzrEK3fXjz2wQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan ORear <sorear2@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: [PATCH 4.19 60/85] riscv: Add pte bit to distinguish swap from invalid
Date:   Mon, 18 Feb 2019 14:43:26 +0100
Message-Id: <20190218133505.846915178@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

From: Stefan O'Rear <sorear2@gmail.com>

commit e3613bb8afc2a9474c9214d65c8326c5ac02135e upstream.

Previously, invalid PTEs and swap PTEs had the same binary
representation, causing errors when attempting to unmap PROT_NONE
mappings, including implicit unmap on exit.

Typical error:

swap_info_get: Bad swap file entry 40000000007a9879
BUG: Bad page map in process a.out  pte:3d4c3cc0 pmd:3e521401

Cc: stable@vger.kernel.org
Signed-off-by: Stefan O'Rear <sorear2@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/riscv/include/asm/pgtable-bits.h |    6 ++++++
 arch/riscv/include/asm/pgtable.h      |    8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -35,6 +35,12 @@
 #define _PAGE_SPECIAL   _PAGE_SOFT
 #define _PAGE_TABLE     _PAGE_PRESENT
 
+/*
+ * _PAGE_PROT_NONE is set on not-present pages (and ignored by the hardware) to
+ * distinguish them from swapped out pages
+ */
+#define _PAGE_PROT_NONE _PAGE_READ
+
 #define _PAGE_PFN_SHIFT 10
 
 /* Set of bits to preserve across pte_modify() */
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -44,7 +44,7 @@
 /* Page protection bits */
 #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_USER)
 
-#define PAGE_NONE		__pgprot(0)
+#define PAGE_NONE		__pgprot(_PAGE_PROT_NONE)
 #define PAGE_READ		__pgprot(_PAGE_BASE | _PAGE_READ)
 #define PAGE_WRITE		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE)
 #define PAGE_EXEC		__pgprot(_PAGE_BASE | _PAGE_EXEC)
@@ -98,7 +98,7 @@ extern unsigned long empty_zero_page[PAG
 
 static inline int pmd_present(pmd_t pmd)
 {
-	return (pmd_val(pmd) & _PAGE_PRESENT);
+	return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
 }
 
 static inline int pmd_none(pmd_t pmd)
@@ -178,7 +178,7 @@ static inline pte_t *pte_offset_kernel(p
 
 static inline int pte_present(pte_t pte)
 {
-	return (pte_val(pte) & _PAGE_PRESENT);
+	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
 }
 
 static inline int pte_none(pte_t pte)
@@ -380,7 +380,7 @@ static inline int ptep_clear_flush_young
  *
  * Format of swap PTE:
  *	bit            0:	_PAGE_PRESENT (zero)
- *	bit            1:	reserved for future use (zero)
+ *	bit            1:	_PAGE_PROT_NONE (zero)
  *	bits      2 to 6:	swap type
  *	bits 7 to XLEN-1:	swap offset
  */


