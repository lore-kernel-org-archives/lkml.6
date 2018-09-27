Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2761C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5149721712
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5149721712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeI1BKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:10:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeI1BKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:10:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIoDFa129804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:50:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIoDwV129801;
        Thu, 27 Sep 2018 11:50:13 -0700
Date:   Thu, 27 Sep 2018 11:50:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-1c4b406ee89c2c4210f2e19b97d39215f445c316@git.kernel.org>
Cc:     dave.hansen@intel.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mark.gross@intel.com, tglx@linutronix.de, bin.yang@intel.com
Reply-To: peterz@infradead.org, hpa@zytor.com, dave.hansen@intel.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mark.gross@intel.com, bin.yang@intel.com
In-Reply-To: <20180917143546.424477581@linutronix.de>
References: <20180917143546.424477581@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Optimize same protection check
Git-Commit-ID: 1c4b406ee89c2c4210f2e19b97d39215f445c316
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

Commit-ID:  1c4b406ee89c2c4210f2e19b97d39215f445c316
Gitweb:     https://git.kernel.org/tip/1c4b406ee89c2c4210f2e19b97d39215f445c316
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 16:29:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:39 +0200

x86/mm/cpa: Optimize same protection check

When the existing mapping is correct and the new requested page protections
are the same as the existing ones, then further checks can be omitted and the
large page can be preserved. The slow path 4k wise check will not come up with
a different result.

Before:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  540
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               800709
 4K pages set-checked:             7668

After:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  538
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               560642
 4K pages set-checked:             7668

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180917143546.424477581@linutronix.de

---
 arch/x86/mm/pageattr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 19781b0ab4b4..5160334f9095 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -839,6 +839,20 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 		return 1;
 	}
 
+	/*
+	 * Optimization: If the requested pgprot is the same as the current
+	 * pgprot, then the large page can be preserved and no updates are
+	 * required independent of alignment and length of the requested
+	 * range. The above already established that the current pgprot is
+	 * correct, which in consequence makes the requested pgprot correct
+	 * as well if it is the same. The static protection scan below will
+	 * not come to a different conclusion.
+	 */
+	if (pgprot_val(req_prot) == pgprot_val(old_prot)) {
+		cpa_inc_lp_sameprot(level);
+		return 0;
+	}
+
 	/*
 	 * Make sure that the requested pgprot does not violate the static
 	 * protections. Check the full large page whether one of the pages
