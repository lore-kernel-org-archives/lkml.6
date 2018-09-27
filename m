Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB60C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD39F216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD39F216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeI1BPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:15:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56169 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbeI1BPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:15:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIsmNN130445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:54:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIsmRk130442;
        Thu, 27 Sep 2018 11:54:48 -0700
Date:   Thu, 27 Sep 2018 11:54:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-fce2ce9544e9f098ba828442221ce99c2a5ecb0f@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        bin.yang@intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mark.gross@intel.com, dave.hansen@intel.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
          bin.yang@intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mark.gross@intel.com, dave.hansen@intel.com
In-Reply-To: <20180919085948.087848187@infradead.org>
References: <20180919085948.087848187@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Move CLFLUSH test into cpa_flush_array()
Git-Commit-ID: fce2ce9544e9f098ba828442221ce99c2a5ecb0f
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

Commit-ID:  fce2ce9544e9f098ba828442221ce99c2a5ecb0f
Gitweb:     https://git.kernel.org/tip/fce2ce9544e9f098ba828442221ce99c2a5ecb0f
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 19 Sep 2018 10:50:22 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:42 +0200

x86/mm/cpa: Move CLFLUSH test into cpa_flush_array()

Rather than guarding cpa_flush_array() users with a CLFLUSH test, put
it inside.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180919085948.087848187@infradead.org

---
 arch/x86/mm/pageattr.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 3cc4a2ae4dbb..33d89d505f93 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -328,6 +328,11 @@ static void cpa_flush_array(unsigned long baddr, unsigned long *start,
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
+	if (!static_cpu_has(X86_FEATURE_CLFLUSH)) {
+		cpa_flush_all(cache);
+		return;
+	}
+
 	flush_tlb_kernel_range(baddr, baddr + PAGE_SIZE * numpages);
 
 	if (!cache)
@@ -1756,19 +1761,19 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 	cache = !!pgprot2cachemode(mask_set);
 
 	/*
-	 * On success we use CLFLUSH, when the CPU supports it to
-	 * avoid the WBINVD. If the CPU does not support it and in the
-	 * error case we fall back to cpa_flush_all (which uses
-	 * WBINVD):
+	 * On error; flush everything to be sure.
 	 */
-	if (!ret && boot_cpu_has(X86_FEATURE_CLFLUSH)) {
-		if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
-			cpa_flush_array(baddr, addr, numpages, cache,
-					cpa.flags, pages);
-		} else
-			cpa_flush_range(baddr, numpages, cache);
-	} else
+	if (ret) {
 		cpa_flush_all(cache);
+		goto out;
+	}
+
+	if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
+		cpa_flush_array(baddr, addr, numpages, cache,
+				cpa.flags, pages);
+	} else {
+		cpa_flush_range(baddr, numpages, cache);
+	}
 
 out:
 	return ret;
