Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeCEIQz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:16:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:41758 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbeCEIQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:16:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="39253552"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/mm: Do not use paravirtualized calls in native_set_p4d()
Date: Mon,  5 Mar 2018 11:16:41 +0300
Message-Id: <20180305081641.4290-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <alpine.DEB.2.21.1803021309020.1803@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1803021309020.1803@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 4-level paging mode, native_set_p4d() updates entry in the top-level
page table. With PTI, update to top-level kernel page table requires
update to userspace copy of the table using pti_set_user_pgd().

native_set_p4d() uses p4d_val() and pgd_val() to convert types between
p4d_t and pgd_t.

p4d_val() and pgd_val() are paravirtualized and we must not use them in
native helpers. They cause boot failure in paravirtualized environments.

Replace p4d_val() and pgd_val() with native_p4d_val() and
native_pgd_val() in native_set_p4d().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Fixes: 91f606a8fa68 ("x86/mm: Replace compile-time checks for 5-level paging with runtime-time checks")
---
 arch/x86/include/asm/pgtable_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index af0cb0d2b7d2..877bc27718ae 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -225,9 +225,9 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
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
