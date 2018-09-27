Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92789C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D96821710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D96821710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeI1BMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:12:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1BMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:12:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIpsQx130086
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:51:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIps9Y130083;
        Thu, 27 Sep 2018 11:51:54 -0700
Date:   Thu, 27 Sep 2018 11:51:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-c6185b1f21a47af94617fde3af7e803817b522a9@git.kernel.org>
Cc:     mark.gross@intel.com, dave.hansen@intel.com, mingo@kernel.org,
        peterz@infradead.org, hpa@zytor.com, bin.yang@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: dave.hansen@intel.com, mark.gross@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          hpa@zytor.com, bin.yang@intel.com, tglx@linutronix.de
In-Reply-To: <20180919085947.831102058@infradead.org>
References: <20180919085947.831102058@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Use flush_tlb_all()
Git-Commit-ID: c6185b1f21a47af94617fde3af7e803817b522a9
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

Commit-ID:  c6185b1f21a47af94617fde3af7e803817b522a9
Gitweb:     https://git.kernel.org/tip/c6185b1f21a47af94617fde3af7e803817b522a9
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 19 Sep 2018 10:50:17 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:40 +0200

x86/mm/cpa: Use flush_tlb_all()

Instead of open-coding it..

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180919085947.831102058@infradead.org

---
 arch/x86/mm/pageattr.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 4e55ded01be5..a22f6b71a308 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -285,16 +285,6 @@ static void cpa_flush_all(unsigned long cache)
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static void __cpa_flush_range(void *arg)
-{
-	/*
-	 * We could optimize that further and do individual per page
-	 * tlb invalidates for a low number of pages. Caveat: we must
-	 * flush the high aliases on 64bit as well.
-	 */
-	__flush_tlb_all();
-}
-
 static void cpa_flush_range(unsigned long start, int numpages, int cache)
 {
 	unsigned int i, level;
@@ -303,7 +293,7 @@ static void cpa_flush_range(unsigned long start, int numpages, int cache)
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 	WARN_ON(PAGE_ALIGN(start) != start);
 
-	on_each_cpu(__cpa_flush_range, NULL, 1);
+	flush_tlb_all();
 
 	if (!cache)
 		return;
