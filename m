Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB7C04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2CE2177A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2CE2177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHUEek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 00:34:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:17761 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeHUEej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 00:34:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 18:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,267,1531810800"; 
   d="scan'208";a="74359166"
Received: from shbuild000.sh.intel.com (HELO byang_ol.sh.intel.com) ([10.239.144.215])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2018 18:16:42 -0700
From:   Bin Yang <bin.yang@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, mark.gross@intel.com, bin.yang@intel.com
Subject: [PATCH v3 5/5] x86/mm: add WARN_ON_ONCE() for wrong large page mapping
Date:   Tue, 21 Aug 2018 01:16:26 +0000
Message-Id: <1534814186-37067-6-git-send-email-bin.yang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a large page which contains an area which requires a
different mapping that the one which the large page provides,
then something went wrong _before_ this code is called.

Here we can catch a case where the existing mapping is wrong
already.

Inspired-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bin Yang <bin.yang@intel.com>
---
 arch/x86/mm/pageattr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index fd90c5b..91a250c 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -625,6 +625,7 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 
 	psize = page_level_size(level);
 	pmask = page_level_mask(level);
+	addr = address & pmask;
 
 	/*
 	 * Calculate the number of pages, which fit into this large
@@ -636,6 +637,12 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 		cpa->numpages = numpages;
 
 	/*
+	 * The old pgprot should not have any protection bit. Otherwise,
+	 * the existing mapping is wrong already.
+	 */
+	WARN_ON_ONCE(needs_static_protections(old_prot, addr, psize, old_pfn));
+
+	/*
 	 * We are safe now. Check whether the new pgprot is the same:
 	 * Convert protection attributes to 4k-format, as cpa->mask* are set
 	 * up accordingly.
@@ -690,7 +697,6 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	 * would anyway result in a split after doing all the check work
 	 * for nothing.
 	 */
-	addr = address & pmask;
 	if (address != addr || cpa->numpages != numpages)
 		goto out_unlock;
 
-- 
2.7.4

