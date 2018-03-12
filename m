Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeCLMRM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:17:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52031 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeCLMRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:17:10 -0400
Date: Mon, 12 Mar 2018 05:16:03 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-a5b162b2ecb013ed517ab5ce90079117ada743f4@git.kernel.org>
Cc: hpa@zytor.com, bp@alien8.de, dvlasenk@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        luto@kernel.org, brgerst@gmail.com, kirill.shutemov@linux.intel.com,
        fengguang.wu@intel.com
Reply-To: mingo@kernel.org, peterz@infradead.org, dvlasenk@redhat.com,
        bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, luto@kernel.org,
        kirill.shutemov@linux.intel.com, brgerst@gmail.com,
        torvalds@linux-foundation.org, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com
In-Reply-To: <20180305081641.4290-1-kirill.shutemov@linux.intel.com>
References: <20180305081641.4290-1-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Do not use paravirtualized calls in
 native_set_p4d()
Git-Commit-ID: a5b162b2ecb013ed517ab5ce90079117ada743f4
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

Commit-ID:  a5b162b2ecb013ed517ab5ce90079117ada743f4
Gitweb:     https://git.kernel.org/tip/a5b162b2ecb013ed517ab5ce90079117ada743f4
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 5 Mar 2018 11:16:41 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 10:30:48 +0100

x86/mm: Do not use paravirtualized calls in native_set_p4d()

In 4-level paging mode, native_set_p4d() updates the entry in the top-level
page table. With PTI, update to the top-level kernel page table requires
update to the userspace copy of the table as well, using pti_set_user_pgd().

native_set_p4d() uses p4d_val() and pgd_val() to convert types between
p4d_t and pgd_t.

p4d_val() and pgd_val() are paravirtualized and we must not use them in
native helpers, as they crash the boot in paravirtualized environments.

Replace p4d_val() and pgd_val() with native_p4d_val() and
native_pgd_val() in native_set_p4d().

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 91f606a8fa68 ("x86/mm: Replace compile-time checks for 5-level paging with runtime-time checks")
Link: http://lkml.kernel.org/r/20180305081641.4290-1-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
