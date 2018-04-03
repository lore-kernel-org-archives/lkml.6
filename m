Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755331AbeDCWjb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753801AbeDCWj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:39:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFCD2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
From: Andy Lutomirski <luto@kernel.org>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/entry/64: Drop idtentry's manual stack switch for user entries
Date: Tue,  3 Apr 2018 15:39:26 -0700
Message-Id: <90aab80c1f906e70742eaa4512e3c9b5e62d59d4.1522794757.git.luto@kernel.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For non-paranoid entries, idtentry knows how to switch from the
kernel stack to the user stack, as does error_entry.  This results
in pointless duplication and code bloat.  Make idtentry stop
thinking about stacks for non-paranoid entries.

This reduces text size by 5377 bytes.

This goes back to commit 7f2590a110b8 ("x86/entry/64: Use a per-CPU
trampoline stack for IDT entries").

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

Hi all-

I have more cleanups in the works, but this is enough of I win by itself
that I wanted to get it out there.

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
-- 
2.14.3
