Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C6F56070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeFFKOK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:14:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33033 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbeFFKOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:14:09 -0400
Date: Wed, 6 Jun 2018 03:12:50 -0700
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-046c0dbec0238c25b7526c26c9a9687664229ce2@git.kernel.org>
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        n-horiguchi@ah.jp.nec.com, dave.hansen@linux.intel.com,
        arnd@arndb.de, mingo@kernel.org
Reply-To: mingo@kernel.org, arnd@arndb.de, dave.hansen@linux.intel.com,
          n-horiguchi@ah.jp.nec.com, zi.yan@cs.rutgers.edu,
          akpm@linux-foundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
          tglx@linutronix.de, gregkh@linuxfoundation.org
In-Reply-To: <20180605113715.1133726-1-arnd@arndb.de>
References: <20180605113715.1133726-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86: Mark native_set_p4d() as __always_inline
Git-Commit-ID: 046c0dbec0238c25b7526c26c9a9687664229ce2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  046c0dbec0238c25b7526c26c9a9687664229ce2
Gitweb:     https://git.kernel.org/tip/046c0dbec0238c25b7526c26c9a9687664229ce2
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Tue, 5 Jun 2018 13:35:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 12:09:45 +0200

x86: Mark native_set_p4d() as __always_inline

When CONFIG_OPTIMIZE_INLINING is enabled, the function native_set_p4d()
may not be fully inlined into the caller, resulting in a false-positive
warning about an access to the __pgtable_l5_enabled variable from a
non-__init function, despite the original caller being an __init function:

WARNING: vmlinux.o(.text.unlikely+0x1429): Section mismatch in reference from the function native_set_p4d() to the variable .init.data:__pgtable_l5_enabled
WARNING: vmlinux.o(.text.unlikely+0x1429): Section mismatch in reference from the function native_p4d_clear() to the variable .init.data:__pgtable_l5_enabled

The function native_set_p4d() references the variable __initdata
__pgtable_l5_enabled.  This is often because native_set_p4d lacks a
__initdata annotation or the annotation of __pgtable_l5_enabled is wrong.

Marking the native_set_p4d function and its caller native_p4d_clear()
avoids this problem.

I did not bisect the original cause, but I assume this is related to the
recent rework that turned pgtable_l5_enabled() into an inline function,
which in turn caused the compiler to make different inlining decisions.

Fixes: ad3fe525b950 ("x86/mm: Unify pgtable_l5_enabled usage in early boot code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Link: https://lkml.kernel.org/r/20180605113715.1133726-1-arnd@arndb.de

---
 arch/x86/include/asm/pgtable_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 877bc27718ae..c750112cb416 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -216,7 +216,7 @@ static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
 }
 #endif
 
-static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
+static __always_inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
 
@@ -230,7 +230,7 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 	*p4dp = native_make_p4d(native_pgd_val(pgd));
 }
 
-static inline void native_p4d_clear(p4d_t *p4d)
+static __always_inline void native_p4d_clear(p4d_t *p4d)
 {
 	native_set_p4d(p4d, native_make_p4d(0));
 }
