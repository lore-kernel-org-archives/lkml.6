Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E267EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A3021530
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A3021530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeHPAxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:53:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:4458 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbeHPAxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:53:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 14:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,244,1531810800"; 
   d="scan'208";a="77124498"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2018 14:57:02 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 065EB301B7C; Wed, 15 Aug 2018 14:57:02 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] x86/speculation/l1tf: Add assembly guard for xtensa/ia64
Date:   Wed, 15 Aug 2018 14:56:46 -0700
Message-Id: <20180815215646.12653-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The stable backport of the

x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE mappings

patch for 4.4 and 4.9 put new C code for !__HAVE_ARCH_PFN_MODIFY_ALLOWED
code outside the assembler ifdef. This breaks the xtensa and ia64
build as reported by 0day which somehow include this file
into assembler.

Just add an #ifdef __ASSEMBLY__ around the new code to fix this.

This patch is only needed for 4.9 and 4.4 stable, the newer stables
don't have this problem.

Fixes: 7c5b42f82c13 ("x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE mappings")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 include/asm-generic/pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index a88ea9e37a25..abc2a1b15dd8 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -825,6 +825,7 @@ static inline int pmd_free_pte_page(pmd_t *pmd)
 #endif
 #endif
 
+#ifndef __ASSEMBLY__
 struct file;
 int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
 			unsigned long size, pgprot_t *vma_prot);
@@ -839,6 +840,9 @@ static inline bool arch_has_pfn_modify_check(void)
 {
 	return false;
 }
+
+#endif
+
 #endif /* !_HAVE_ARCH_PFN_MODIFY_ALLOWED */
 
 #endif /* !__ASSEMBLY__ */
-- 
2.17.1

