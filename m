Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20954C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE9A21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE9A21710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbeI1BOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:14:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33809 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbeI1BOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:14:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIsD71130398
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:54:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIsCOI130395;
        Thu, 27 Sep 2018 11:54:12 -0700
Date:   Thu, 27 Sep 2018 11:54:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-5f464b33b17219a233af1267c621632225bc7acc@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mark.gross@intel.com,
        dave.hansen@intel.com, bin.yang@intel.com
Reply-To: bin.yang@intel.com, dave.hansen@intel.com, mark.gross@intel.com,
          tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180919085948.036195503@infradead.org>
References: <20180919085948.036195503@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Move CLFLUSH test into cpa_flush_range()
Git-Commit-ID: 5f464b33b17219a233af1267c621632225bc7acc
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

Commit-ID:  5f464b33b17219a233af1267c621632225bc7acc
Gitweb:     https://git.kernel.org/tip/5f464b33b17219a233af1267c621632225bc7acc
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 19 Sep 2018 10:50:21 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:41 +0200

x86/mm/cpa: Move CLFLUSH test into cpa_flush_range()

Rather than guarding all cpa_flush_range() uses with a CLFLUSH test,
put it inside.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180919085948.036195503@infradead.org

---
 arch/x86/mm/pageattr.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 02eb18403594..3cc4a2ae4dbb 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -293,6 +293,11 @@ static void cpa_flush_range(unsigned long start, int numpages, int cache)
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 	WARN_ON(PAGE_ALIGN(start) != start);
 
+	if (!static_cpu_has(X86_FEATURE_CLFLUSH)) {
+		cpa_flush_all(cache);
+		return;
+	}
+
 	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
 
 	if (!cache)
@@ -2078,10 +2083,7 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
 	 */
-	if (static_cpu_has(X86_FEATURE_CLFLUSH))
-		cpa_flush_range(start, numpages, 1);
-	else
-		cpa_flush_all(1);
+	cpa_flush_range(start, numpages, 1);
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2092,10 +2094,7 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	 * in case TLB flushing gets optimized in the cpa_flush_range()
 	 * path use the same logic as above.
 	 */
-	if (static_cpu_has(X86_FEATURE_CLFLUSH))
-		cpa_flush_range(start, numpages, 0);
-	else
-		cpa_flush_all(0);
+	cpa_flush_range(start, numpages, 0);
 
 	return ret;
 }
