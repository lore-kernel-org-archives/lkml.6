Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933546AbeBUKvA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:51:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51169 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933526AbeBUKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:50:58 -0500
Date: Wed, 21 Feb 2018 02:50:27 -0800
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-fa509cf0f52628bb646f85fa12b16231060053e6@git.kernel.org>
Cc: luto@kernel.org, tglx@linutronix.de, brgerst@gmail.com,
        linux@dominikbrodowski.net, peterz@infradead.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, dan.j.williams@intel.com,
        mingo@kernel.org
Reply-To: linux@dominikbrodowski.net, peterz@infradead.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        dan.j.williams@intel.com, torvalds@linux-foundation.org,
        mingo@kernel.org, luto@kernel.org, tglx@linutronix.de,
        brgerst@gmail.com
In-Reply-To: <20180221024214.lhl5jfgw33c4vz3m@treble>
References: <20180221024214.lhl5jfgw33c4vz3m@treble>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Simplify ENCODE_FRAME_POINTER
Git-Commit-ID: fa509cf0f52628bb646f85fa12b16231060053e6
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

Commit-ID:  fa509cf0f52628bb646f85fa12b16231060053e6
Gitweb:     https://git.kernel.org/tip/fa509cf0f52628bb646f85fa12b16231060053e6
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Tue, 20 Feb 2018 20:42:14 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 10:13:59 +0100

x86/entry/64: Simplify ENCODE_FRAME_POINTER

On 64-bit, the stack pointer is always aligned on interrupt, so instead
of setting the LSB of the pt_regs address, we can just add 1 to it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrew Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180221024214.lhl5jfgw33c4vz3m@treble
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 5d10b7a..be63330 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -181,12 +181,7 @@ For 32-bit we have the following conventions - kernel is built with
  */
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
 #ifdef CONFIG_FRAME_POINTER
-	.if \ptregs_offset
-		leaq \ptregs_offset(%rsp), %rbp
-	.else
-		mov %rsp, %rbp
-	.endif
-	orq	$0x1, %rbp
+	leaq 1+\ptregs_offset(%rsp), %rbp
 #endif
 .endm
 
