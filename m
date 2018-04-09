Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeDIRML (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:12:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33491 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeDIRMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:12:09 -0400
Date: Mon, 9 Apr 2018 10:11:25 -0700
From: tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-071ccc966ba5db1ac8f5c24b0faebb37698f68db@git.kernel.org>
Cc: luto@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org, peterz@infradead.org,
        linux@dominikbrodowski.net, hpa@zytor.com, tglx@linutronix.de,
        bp@alien8.de
Reply-To: hpa@zytor.com, linux@dominikbrodowski.net, peterz@infradead.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <90aab80c1f906e70742eaa4512e3c9b5e62d59d4.1522794757.git.luto@kernel.org>
References: <90aab80c1f906e70742eaa4512e3c9b5e62d59d4.1522794757.git.luto@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Drop idtentry's manual stack switch for
 user entries
Git-Commit-ID: 071ccc966ba5db1ac8f5c24b0faebb37698f68db
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

Commit-ID:  071ccc966ba5db1ac8f5c24b0faebb37698f68db
Gitweb:     https://git.kernel.org/tip/071ccc966ba5db1ac8f5c24b0faebb37698f68db
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 3 Apr 2018 15:39:26 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:23:50 +0200

x86/entry/64: Drop idtentry's manual stack switch for user entries

For non-paranoid entries, idtentry knows how to switch from the
kernel stack to the user stack, as does error_entry.  This results
in pointless duplication and code bloat.  Make idtentry stop
thinking about stacks for non-paranoid entries.

This reduces text size by 5377 bytes.

This goes back to the following commit:

  7f2590a110b8 ("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/90aab80c1f906e70742eaa4512e3c9b5e62d59d4.1522794757.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9b114675fbc0..e237913a056b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -908,7 +908,7 @@ ENTRY(\sym)
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 	.endif
 
-	.if \paranoid < 2
+	.if \paranoid == 1
 	testb	$3, CS-ORIG_RAX(%rsp)		/* If coming from userspace, switch stacks */
 	jnz	.Lfrom_usermode_switch_stack_\@
 	.endif
@@ -955,7 +955,7 @@ ENTRY(\sym)
 	jmp	error_exit
 	.endif
 
-	.if \paranoid < 2
+	.if \paranoid == 1
 	/*
 	 * Entry from userspace.  Switch stacks and treat it
 	 * as a normal entry.  This means that paranoid handlers
