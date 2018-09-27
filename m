Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176D0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C7B21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C7B21710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeI1BLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:11:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbeI1BLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:11:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIol2g129841
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:50:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIokuG129838;
        Thu, 27 Sep 2018 11:50:46 -0700
Date:   Thu, 27 Sep 2018 11:50:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-9cc9f17a5a0a8564b41b7c5c460e7f078c42d712@git.kernel.org>
Cc:     bin.yang@intel.com, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, mark.gross@intel.com, tglx@linutronix.de,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org
Reply-To: dave.hansen@intel.com, linux-kernel@vger.kernel.org,
          mark.gross@intel.com, tglx@linutronix.de, hpa@zytor.com,
          peterz@infradead.org, mingo@kernel.org, bin.yang@intel.com
In-Reply-To: <20180917143546.507259989@linutronix.de>
References: <20180917143546.507259989@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Do the range check early
Git-Commit-ID: 9cc9f17a5a0a8564b41b7c5c460e7f078c42d712
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

Commit-ID:  9cc9f17a5a0a8564b41b7c5c460e7f078c42d712
Gitweb:     https://git.kernel.org/tip/9cc9f17a5a0a8564b41b7c5c460e7f078c42d712
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 16:29:16 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:39 +0200

x86/mm/cpa: Do the range check early

To avoid excessive 4k wise checks in the common case do a quick check first
whether the requested new page protections conflict with a static
protection area in the large page. If there is no conflict then the
decision whether to preserve or to split the page can be made immediately.

If the requested range covers the full large page, preserve it. Otherwise
split it up. No point in doing a slow crawl in 4k steps.

Before:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  538
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               560642
 4K pages set-checked:             7668

After:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  541
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:                  514
 4K pages set-checked:             7668

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180917143546.507259989@linutronix.de

---
 arch/x86/mm/pageattr.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 5160334f9095..bbc5eb5cbc9d 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -854,10 +854,28 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	}
 
 	/*
-	 * Make sure that the requested pgprot does not violate the static
-	 * protections. Check the full large page whether one of the pages
-	 * in it results in a different pgprot than the first one of the
-	 * requested range. If yes, then the page needs to be split.
+	 * Optimization: Check whether the requested pgprot is conflicting
+	 * with a static protection requirement in the large page. If not,
+	 * then checking whether the requested range is fully covering the
+	 * large page can be done right here.
+	 */
+	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
+				      CPA_DETECT);
+
+	if (pgprot_val(req_prot) == pgprot_val(new_prot)) {
+		if (address != lpaddr || cpa->numpages != numpages)
+			return 1;
+		goto setlp;
+	}
+
+	/*
+	 * Slow path. The full large page check above established that the
+	 * requested pgprot cannot be applied to the full large page due to
+	 * conflicting requirements of static protection regions. It might
+	 * turn out that the whole requested range is covered by the
+	 * modified protection of the first 4k segment at @address. This
+	 * might result in the ability to preserve the large page
+	 * nevertheless.
 	 */
 	new_prot = static_protections(req_prot, address, pfn, 1, CPA_DETECT);
 	pfn = old_pfn;
@@ -882,6 +900,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	if (address != lpaddr || cpa->numpages != numpages)
 		return 1;
 
+setlp:
 	/* All checks passed. Update the large page mapping. */
 	new_pte = pfn_pte(old_pfn, new_prot);
 	__set_pmd_pte(kpte, address, new_pte);
