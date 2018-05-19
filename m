Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbeESLeZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:34:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41265 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbeESLeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:34:21 -0400
Date: Sat, 19 May 2018 04:33:46 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-30bbf728ba91b1e8b0e539126cd105ad7e2fa16a@git.kernel.org>
Cc: tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, torvalds@linux-foundation.org, hughd@google.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, hughd@google.com, torvalds@linux-foundation.org
In-Reply-To: <20180518103528.59260-2-kirill.shutemov@linux.intel.com>
References: <20180518103528.59260-2-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot/compressed/64: Fix trampoline page table
 address calculation
Git-Commit-ID: 30bbf728ba91b1e8b0e539126cd105ad7e2fa16a
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

Commit-ID:  30bbf728ba91b1e8b0e539126cd105ad7e2fa16a
Gitweb:     https://git.kernel.org/tip/30bbf728ba91b1e8b0e539126cd105ad7e2fa16a
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 18 May 2018 13:35:22 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 19 May 2018 11:56:57 +0200

x86/boot/compressed/64: Fix trampoline page table address calculation

Hugh noticied that we calculate the address of the trampoline page table
incorrectly in cleanup_trampoline().

TRAMPOLINE_32BIT_PGTABLE_OFFSET has to be divided by sizeof(unsigned long),
since trampoline_32bit is an 'unsigned long' pointer.

TRAMPOLINE_32BIT_PGTABLE_OFFSET is zero so the bug doesn't have a
visible effect.

Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")
Link: http://lkml.kernel.org/r/20180518103528.59260-2-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/pgtable_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index a362fa0b849c..23707e1da1ff 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -130,7 +130,7 @@ void cleanup_trampoline(void *pgtable)
 {
 	void *trampoline_pgtable;
 
-	trampoline_pgtable = trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET;
+	trampoline_pgtable = trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
 
 	/*
 	 * Move the top level page table out of trampoline memory,
