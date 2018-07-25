Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA94C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788B120852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788B120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbeGYPtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:49:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeGYPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:49:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEbFZD403772
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:37:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEbFNB403769;
        Wed, 25 Jul 2018 07:37:15 -0700
Date:   Wed, 25 Jul 2018 07:37:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anders Roxell <tipbot@zytor.com>
Message-ID: <tip-063daa8129f94d651c4d30a8333b577c5bbf8090@git.kernel.org>
Cc:     tglx@linutronix.de, anders.roxell@linaro.org, peterz@infradead.org,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          anders.roxell@linaro.org, tglx@linutronix.de, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20180725095557.19668-1-anders.roxell@linaro.org>
References: <20180725095557.19668-1-anders.roxell@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] arm/asm/tlb.h: Fix build error implicit func
 declaration
Git-Commit-ID: 063daa8129f94d651c4d30a8333b577c5bbf8090
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

Commit-ID:  063daa8129f94d651c4d30a8333b577c5bbf8090
Gitweb:     https://git.kernel.org/tip/063daa8129f94d651c4d30a8333b577c5bbf8090
Author:     Anders Roxell <anders.roxell@linaro.org>
AuthorDate: Wed, 25 Jul 2018 11:55:57 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 12:09:09 +0200

arm/asm/tlb.h: Fix build error implicit func declaration

Building on arm 32 with LPAE enabled we don't include asm-generic/tlb.h,
where we have tlb_flush_remove_tables_local and tlb_flush_remove_tables
defined.

The build fails with:

  mm/memory.c: In function ‘tlb_remove_table_smp_sync’:
  mm/memory.c:339:2: error: implicit declaration of function ‘tlb_flush_remove_tables_local’; did you mean ‘tlb_remove_table’? [-Werror=implicit-function-declaration]
  ...

This bug got introduced in:

  2ff6ddf19c0e ("x86/mm/tlb: Leave lazy TLB mode at page table free time")

To fix this issue we define them in arm 32's specific asm/tlb.h file as well.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@intel.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux@armlinux.org.uk
Cc: riel@surriel.com
Cc: songliubraving@fb.com
Fixes: 2ff6ddf19c0e ("x86/mm/tlb: Leave lazy TLB mode at page table free time")
Link: http://lkml.kernel.org/r/20180725095557.19668-1-anders.roxell@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/include/asm/tlb.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index d5562f9ce600..f854148c8d7c 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -292,5 +292,13 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 {
 }
 
+static inline void tlb_flush_remove_tables(struct mm_struct *mm)
+{
+}
+
+static inline void tlb_flush_remove_tables_local(void *arg)
+{
+}
+
 #endif /* CONFIG_MMU */
 #endif
