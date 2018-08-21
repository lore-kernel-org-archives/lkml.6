Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B130DC04AB9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAD221770
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAD221770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeHUEee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 00:34:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:17761 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeHUEed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 00:34:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 18:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,267,1531810800"; 
   d="scan'208";a="74359135"
Received: from shbuild000.sh.intel.com (HELO byang_ol.sh.intel.com) ([10.239.144.215])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2018 18:16:36 -0700
From:   Bin Yang <bin.yang@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, mark.gross@intel.com, bin.yang@intel.com
Subject: [PATCH v3 1/5] x86/mm: avoid redundant checking if pgprot has no change
Date:   Tue, 21 Aug 2018 01:16:22 +0000
Message-Id: <1534814186-37067-2-git-send-email-bin.yang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In try_preserve_large_page(), the check for
pgprot_val(new_prot) == pgprot_val(old_port) can definitely
be done at first to avoid redundant checking.

The approach and some of the comments came from Thomas Gleixner's
email example for how to do this

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bin Yang <bin.yang@intel.com>
---
 arch/x86/mm/pageattr.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 8d6c34f..68613fd 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -629,6 +629,22 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	new_prot = static_protections(req_prot, address, pfn);
 
 	/*
+	 * The static_protections() is used to check specific protection flags
+	 * for certain areas of memory. The old pgprot should be checked already
+	 * when it was applied before. If it's not, then this is a bug in some
+	 * other code and needs to be fixed there.
+	 *
+	 * If new pgprot is same as old pgprot, return directly without any
+	 * additional checking. The following static_protections() checking is
+	 * pointless if pgprot has no change. It can avoid the redundant
+	 * checking and optimize the performance of large page split checking.
+	 */
+	if (pgprot_val(new_prot) == pgprot_val(old_prot)) {
+		do_split = 0;
+		goto out_unlock;
+	}
+
+	/*
 	 * We need to check the full range, whether
 	 * static_protection() requires a different pgprot for one of
 	 * the pages in the range we try to preserve:
@@ -642,14 +658,6 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 			goto out_unlock;
 	}
 
-	/*
-	 * If there are no changes, return. maxpages has been updated
-	 * above:
-	 */
-	if (pgprot_val(new_prot) == pgprot_val(old_prot)) {
-		do_split = 0;
-		goto out_unlock;
-	}
 
 	/*
 	 * We need to change the attributes. Check, whether we can
-- 
2.7.4

