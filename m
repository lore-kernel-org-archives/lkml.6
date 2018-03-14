Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeCNIsG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:48:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeCNIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:48:05 -0400
Date: Wed, 14 Mar 2018 01:47:19 -0700
From: tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-b5069782453459f6ec1fdeb495d9901a4545fcb5@git.kernel.org>
Cc: dvlasenk@redhat.com, torvalds@linux-foundation.org, bp@alien8.de,
        bartoldeman@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, stsp@list.ru, luto@kernel.org, brgerst@gmail.com,
        mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org
Reply-To: brgerst@gmail.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, dvlasenk@redhat.com,
        hpa@zytor.com, stsp@list.ru, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        bp@alien8.de, bartoldeman@gmail.com
In-Reply-To: <ce95f40556e7b2178b6bc06ee9557827ff94bd28.1521003603.git.luto@kernel.org>
References: <ce95f40556e7b2178b6bc06ee9557827ff94bd28.1521003603.git.luto@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/vm86/32: Fix POPF emulation
Git-Commit-ID: b5069782453459f6ec1fdeb495d9901a4545fcb5
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

Commit-ID:  b5069782453459f6ec1fdeb495d9901a4545fcb5
Gitweb:     https://git.kernel.org/tip/b5069782453459f6ec1fdeb495d9901a4545fcb5
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 13 Mar 2018 22:03:12 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Mar 2018 09:21:01 +0100

x86/vm86/32: Fix POPF emulation

POPF would trap if VIP was set regardless of whether IF was set.  Fix it.

Suggested-by: Stas Sergeev <stsp@list.ru>
Reported-by: Bart Oldeman <bartoldeman@gmail.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: 5ed92a8ab71f ("x86/vm86: Use the normal pt_regs area for vm86")
Link: http://lkml.kernel.org/r/ce95f40556e7b2178b6bc06ee9557827ff94bd28.1521003603.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/vm86_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 5edb27f1a2c4..9d0b5af7db91 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -727,7 +727,8 @@ void handle_vm86_fault(struct kernel_vm86_regs *regs, long error_code)
 	return;
 
 check_vip:
-	if (VEFLAGS & X86_EFLAGS_VIP) {
+	if ((VEFLAGS & (X86_EFLAGS_VIP | X86_EFLAGS_VIF)) ==
+	    (X86_EFLAGS_VIP | X86_EFLAGS_VIF)) {
 		save_v86_state(regs, VM86_STI);
 		return;
 	}
