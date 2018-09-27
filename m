Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6400DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAFD21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAFD21710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeI1BN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:13:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49899 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1BNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:13:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIr5DT130153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:53:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIr5aC130150;
        Thu, 27 Sep 2018 11:53:05 -0700
Date:   Thu, 27 Sep 2018 11:53:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-ddd07b750382adc2b78fdfbec47af8a6e0d8ef37@git.kernel.org>
Cc:     dave.hansen@intel.com, peterz@infradead.org, bin.yang@intel.com,
        mark.gross@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, mark.gross@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, bin.yang@intel.com,
          peterz@infradead.org, dave.hansen@intel.com
In-Reply-To: <20180919085947.933674526@infradead.org>
References: <20180919085947.933674526@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Unconditionally avoid WBINDV when we can
Git-Commit-ID: ddd07b750382adc2b78fdfbec47af8a6e0d8ef37
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

Commit-ID:  ddd07b750382adc2b78fdfbec47af8a6e0d8ef37
Gitweb:     https://git.kernel.org/tip/ddd07b750382adc2b78fdfbec47af8a6e0d8ef37
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 19 Sep 2018 10:50:19 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:41 +0200

x86/mm/cpa: Unconditionally avoid WBINDV when we can

CAT has happened, WBINDV is bad (even before CAT blowing away the
entire cache on a multi-core platform wasn't nice), try not to use it
ever.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180919085947.933674526@infradead.org

---
 arch/x86/mm/pageattr.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index b6a4c638f086..bd9b0ac07352 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -319,26 +319,12 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
 			    int in_flags, struct page **pages)
 {
 	unsigned int i, level;
-#ifdef CONFIG_PREEMPT
-	/*
-	 * Avoid wbinvd() because it causes latencies on all CPUs,
-	 * regardless of any CPU isolation that may be in effect.
-	 *
-	 * This should be extended for CAT enabled systems independent of
-	 * PREEMPT because wbinvd() does not respect the CAT partitions and
-	 * this is exposed to unpriviledged users through the graphics
-	 * subsystem.
-	 */
-	unsigned long do_wbinvd = 0;
-#else
-	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
-#endif
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
-	on_each_cpu(__cpa_flush_all, (void *) do_wbinvd, 1);
+	flush_tlb_all();
 
-	if (!cache || do_wbinvd)
+	if (!cache)
 		return;
 
 	/*
