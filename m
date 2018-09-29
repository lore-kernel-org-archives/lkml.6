Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0721C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEED92087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEED92087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeI3ES2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51621 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727989AbeI3ESX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:23 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000H6-Cy; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006yM-Fi; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mel Gorman" <mgorman@suse.de>,
        x86@kernel.org
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.968714306@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 118/131] x86/speculation/l1tf: Protect NUMA-balance
 entries against L1TF
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

NUMA balancing has its own functions that manipulated the PRESENT flag
in PTEs and PMDs.  These were not affected by the changes in commit
6b28baca9b1f "x86/speculation/l1tf: Protect PROT_NONE PTEs against
speculation".

This is not a problem upstream because NUMA balancing was changed to
use {pte,pmd}_modify() in Linux 4.0.

Override the generic implementations for x86 with implementations
that do the same inversion as {pte,pmd}_modify().

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: x86@kernel.org
Cc: Mel Gorman <mgorman@suse.de>
---
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -419,6 +419,54 @@ static inline pmd_t pmd_modify(pmd_t pmd
 	return __pmd(val);
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+
+static inline pte_t pte_mknonnuma(pte_t pte)
+{
+	pteval_t val = pte_val(pte), oldval = val;
+
+	val &= ~_PAGE_NUMA;
+	val |= (_PAGE_PRESENT|_PAGE_ACCESSED);
+	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
+	return __pte(val);
+}
+#define pte_mknonnuma pte_mknonnuma
+
+static inline pte_t pte_mknuma(pte_t pte)
+{
+	pteval_t val = pte_val(pte), oldval = val;
+
+	val &= ~_PAGE_PRESENT;
+	val |= _PAGE_NUMA;
+	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
+	return __pte(val);
+}
+#define pte_mknuma pte_mknuma
+
+static inline pmd_t pmd_mknonnuma(pmd_t pmd)
+{
+	pmdval_t val = pmd_val(pmd), oldval = val;
+
+	val &= ~_PAGE_NUMA;
+	val |= (_PAGE_PRESENT|_PAGE_ACCESSED);
+	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
+	return __pmd(val);
+}
+#define pmd_mknonnuma pmd_mknonnuma
+
+static inline pmd_t pmd_mknuma(pmd_t pmd)
+{
+	pmdval_t val = pmd_val(pmd), oldval = val;
+
+	val &= ~_PAGE_PRESENT;
+	val |= _PAGE_NUMA;
+	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
+	return __pmd(val);
+}
+#define pmd_mknuma pmd_mknuma
+
+#endif /* CONFIG_NUMA_BALANCING */
+
 /* mprotect needs to preserve PAT bits when updating vm_page_prot */
 #define pgprot_modify pgprot_modify
 static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)

