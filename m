Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeDBO3b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:29:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41623 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbeDBO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:29:27 -0400
X-Google-Smtp-Source: AIpwx4+atKXnSlotyh8wqMlZ6RSmuC8wCP4nyatmQbYeQdJAosI8M3rMQjMwg8DPSMGSF/ixwNslOQ==
From: Jia He <hejianet@gmail.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Jia He <hejianet@gmail.com>,
        Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH] relax check regex for revert commit
Date: Mon,  2 Apr 2018 07:28:58 -0700
Message-Id: <1522679339-19067-1-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For revert commit, it might has two double quotation marks in its
commit log.
Relax the check condition for revert commit to avoid checkpatch
errors.

Without this patch, checkpatch.pl will report errors:
ERROR: Please use git commit description style
...

Attached testcases here:
[test case 1] test single line revert commit
============================================
>From 9639c10d1c2ae17ca83a1d446b146a23cbaf9a92 Mon Sep 17 00:00:00 2001
From: Jia He <hejianet@gmail.com>
Date: Wed, 28 Mar 2018 23:32:20 -0700
Subject: [PATCH v5 1/5] mm: page_alloc: remain memblock_next_valid_pfn() on

Commit f5c1350256fb ("Revert "mm/page_alloc: fix memmap_init_zone pageblock alignment"")

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 arch/arm/include/asm/page.h   |  2 ++

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 4355f0e..489875c 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -158,6 +158,8 @@ typedef struct page *pgtable_t;
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int pfn_valid(unsigned long);
+extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
+#define skip_to_last_invalid_pfn(pfn) (memblock_next_valid_pfn(pfn) - 1)
 #endif

[test case 2] test multiline revert commt
=========================================
>From 9639c10d1c2ae17ca83a1d446b146a23cbaf9a92 Mon Sep 17 00:00:00 2001
From: Jia He <hejianet@gmail.com>
Date: Wed, 28 Mar 2018 23:32:20 -0700
Subject: [PATCH v5 1/5] mm: page_alloc: remain memblock_next_valid_pfn() on

Commit f5c1350256fb ("Revert "mm/page_alloc: fix memmap_init_zone pageblock
alignment"")

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 arch/arm/include/asm/page.h   |  2 ++

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 4355f0e..489875c 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -158,6 +158,8 @@ typedef struct page *pgtable_t;
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int pfn_valid(unsigned long);
+extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
+#define skip_to_last_invalid_pfn(pfn) (memblock_next_valid_pfn(pfn) - 1)
 #endif

Jia He (1):
  checkpatch: relax check for revert commit

 scripts/checkpatch.pl | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.7.4
