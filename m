Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeB1PBr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:01:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:56134 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752485AbeB1PBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:01:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="33517419"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/mm: Avoid paravirtualization calls in native_set_p4d()
Date: Wed, 28 Feb 2018 18:00:22 +0300
Message-Id: <20180228150022.88560-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p4d_val() and pgd_val() are paravirtualized and we should avoid using
them in native_set_p4d().

Let's replace them with native_p4d_val() and native_pgd_val().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Fixes: 91f606a8fa68 ("x86/mm: Replace compile-time checks for 5-level paging with runtime-time checks")
---
 arch/x86/include/asm/pgtable_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 81dda8d1d0bd..163e01a0631d 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -224,9 +224,9 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 		return;
 	}
 
-	pgd = native_make_pgd(p4d_val(p4d));
+	pgd = native_make_pgd(native_p4d_val(p4d));
 	pgd = pti_set_user_pgd((pgd_t *)p4dp, pgd);
-	*p4dp = native_make_p4d(pgd_val(pgd));
+	*p4dp = native_make_p4d(native_pgd_val(pgd));
 }
 
 static inline void native_p4d_clear(p4d_t *p4d)
-- 
2.16.1
