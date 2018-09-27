Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08C4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614D5216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614D5216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeI1BQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:16:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57017 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1BQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:16:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RItrBC130523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:55:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RItqVQ130520;
        Thu, 27 Sep 2018 11:55:52 -0700
Date:   Thu, 27 Sep 2018 11:55:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-7904ba8a66f400182a204893c92098994e22a88d@git.kernel.org>
Cc:     dave.hansen@intel.com, tglx@linutronix.de, peterz@infradead.org,
        bin.yang@intel.com, mark.gross@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mark.gross@intel.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          bin.yang@intel.com, peterz@infradead.org, dave.hansen@intel.com
In-Reply-To: <20180919085948.195633798@infradead.org>
References: <20180919085948.195633798@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Optimize __cpa_flush_range()
Git-Commit-ID: 7904ba8a66f400182a204893c92098994e22a88d
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

Commit-ID:  7904ba8a66f400182a204893c92098994e22a88d
Gitweb:     https://git.kernel.org/tip/7904ba8a66f400182a204893c92098994e22a88d
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 19 Sep 2018 10:50:24 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:42 +0200

x86/mm/cpa: Optimize __cpa_flush_range()

If we IPI for WBINDV, then we might as well kill the entire TLB too.
But if we don't have to invalidate cache, there is no reason not to
use a range TLB flush.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180919085948.195633798@infradead.org

---
 arch/x86/mm/pageattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index dc552824e86a..62bb30b4bd2a 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -291,7 +291,7 @@ static bool __cpa_flush_range(unsigned long start, int numpages, int cache)
 
 	WARN_ON(PAGE_ALIGN(start) != start);
 
-	if (!static_cpu_has(X86_FEATURE_CLFLUSH)) {
+	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
 		cpa_flush_all(cache);
 		return true;
 	}
