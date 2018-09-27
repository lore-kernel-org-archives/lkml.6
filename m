Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE97C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E64A21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E64A21710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeI1BMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:12:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44193 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1BMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:12:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIqTMk130122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:52:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIqTPx130119;
        Thu, 27 Sep 2018 11:52:29 -0700
Date:   Thu, 27 Sep 2018 11:52:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-c0a759abf5a686a37b9204c13b7e281fe516c8f0@git.kernel.org>
Cc:     dave.hansen@intel.com, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, mark.gross@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bin.yang@intel.com
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          bin.yang@intel.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, mark.gross@intel.com, dave.hansen@intel.com
In-Reply-To: <20180919085947.882287392@infradead.org>
References: <20180919085947.882287392@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Move flush_tlb_all()
Git-Commit-ID: c0a759abf5a686a37b9204c13b7e281fe516c8f0
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

Commit-ID:  c0a759abf5a686a37b9204c13b7e281fe516c8f0
Gitweb:     https://git.kernel.org/tip/c0a759abf5a686a37b9204c13b7e281fe516c8f0
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 19 Sep 2018 10:50:18 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:40 +0200

x86/mm/cpa: Move flush_tlb_all()

There is an atom errata, where we do a local TLB invalidate right
before we return and then do a global TLB invalidate.

Move the global invalidate up a little bit and avoid the local
invalidate entirely.

This does put the global invalidate under pgd_lock, but that shouldn't
matter.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180919085947.882287392@infradead.org

---
 arch/x86/mm/pageattr.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index a22f6b71a308..b6a4c638f086 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -999,14 +999,24 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	__set_pmd_pte(kpte, address, mk_pte(base, __pgprot(_KERNPG_TABLE)));
 
 	/*
-	 * Intel Atom errata AAH41 workaround.
+	 * Do a global flush tlb after splitting the large page
+	 * and before we do the actual change page attribute in the PTE.
 	 *
-	 * The real fix should be in hw or in a microcode update, but
-	 * we also probabilistically try to reduce the window of having
-	 * a large TLB mixed with 4K TLBs while instruction fetches are
-	 * going on.
+	 * Without this, we violate the TLB application note, that says:
+	 * "The TLBs may contain both ordinary and large-page
+	 *  translations for a 4-KByte range of linear addresses. This
+	 *  may occur if software modifies the paging structures so that
+	 *  the page size used for the address range changes. If the two
+	 *  translations differ with respect to page frame or attributes
+	 *  (e.g., permissions), processor behavior is undefined and may
+	 *  be implementation-specific."
+	 *
+	 * We do this global tlb flush inside the cpa_lock, so that we
+	 * don't allow any other cpu, with stale tlb entries change the
+	 * page attribute in parallel, that also falls into the
+	 * just split large page entry.
 	 */
-	__flush_tlb_all();
+	flush_tlb_all();
 	spin_unlock(&pgd_lock);
 
 	return 0;
@@ -1531,28 +1541,8 @@ repeat:
 	 * We have to split the large page:
 	 */
 	err = split_large_page(cpa, kpte, address);
-	if (!err) {
-		/*
-		 * Do a global flush tlb after splitting the large page
-		 * and before we do the actual change page attribute in the PTE.
-		 *
-		 * With out this, we violate the TLB application note, that says
-		 * "The TLBs may contain both ordinary and large-page
-		 *  translations for a 4-KByte range of linear addresses. This
-		 *  may occur if software modifies the paging structures so that
-		 *  the page size used for the address range changes. If the two
-		 *  translations differ with respect to page frame or attributes
-		 *  (e.g., permissions), processor behavior is undefined and may
-		 *  be implementation-specific."
-		 *
-		 * We do this global tlb flush inside the cpa_lock, so that we
-		 * don't allow any other cpu, with stale tlb entries change the
-		 * page attribute in parallel, that also falls into the
-		 * just split large page entry.
-		 */
-		flush_tlb_all();
+	if (!err)
 		goto repeat;
-	}
 
 	return err;
 }
