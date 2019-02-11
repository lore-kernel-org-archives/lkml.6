Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394BCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C9121B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfBKR7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:59:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55076 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfBKR7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:59:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D800F15BF;
        Mon, 11 Feb 2019 09:59:46 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DFFE3F675;
        Mon, 11 Feb 2019 09:59:45 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 3/4] mm: Add kconfig entries for user stack pointer checking
Date:   Mon, 11 Feb 2019 17:59:34 +0000
Message-Id: <20190211175935.4602-4-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190211175935.4602-1-will.deacon@arm.com>
References: <20190211175935.4602-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide Kconfig entries to enable/disable user stack pointer checking
and also for architectures to expose the system call controls via
prctl() once they have augmented their system call entry path to perform
the necessary checks.

Cc: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 mm/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 25c71eb8a7db..35f044162501 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -758,4 +758,21 @@ config GUP_BENCHMARK
 config ARCH_HAS_PTE_SPECIAL
 	bool
 
+config USER_STACK_POINTER_CHECKS
+	bool "Check user stack pointer points to stack pages"
+	depends on MMU
+	default y
+	help
+	  This feature can be used to enforce that the user stack pointer
+	  points to either the kernel-allocated user stack or a mapping
+	  created with the MAP_STACK flag.
+
+	  By default, no checks are performed, and an application must
+	  opt-in via the PR_SP_CHECK prctl() system call if it wishes to
+	  enable checking. Checking can be independently controlled for
+	  system calls and page fault handling.
+
+config ARCH_HAS_USP_CHECK_SYSCALL
+	bool
+
 endmenu
-- 
2.11.0

