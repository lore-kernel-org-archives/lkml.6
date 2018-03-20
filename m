Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeCTLFu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:05:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752942AbeCTLFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:44 -0400
Date: Tue, 20 Mar 2018 04:04:20 -0700
From: "tip-bot for H.J. Lu" <tipbot@zytor.com>
Message-ID: <tip-c55b8550fa57ba4f5e507be406ff9fc2845713e8@git.kernel.org>
Cc: jgross@suse.com, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, andy.shevchenko@gmail.com,
        hjl.tools@gmail.com, keescook@chromium.org, hpa@zytor.com
Reply-To: peterz@infradead.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, andy.shevchenko@gmail.com,
        hjl.tools@gmail.com, keescook@chromium.org, hpa@zytor.com,
        jgross@suse.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mingo@kernel.org
In-Reply-To: <CAMe9rOrR7xSJgUfiCoZLuqWUwymRxXPoGBW38+pN=9g+yKNhZw@mail.gmail.com>
References: <CAMe9rOrR7xSJgUfiCoZLuqWUwymRxXPoGBW38+pN=9g+yKNhZw@mail.gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/boot/64: Verify alignment of the LOAD segment
Git-Commit-ID: c55b8550fa57ba4f5e507be406ff9fc2845713e8
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

Commit-ID:  c55b8550fa57ba4f5e507be406ff9fc2845713e8
Gitweb:     https://git.kernel.org/tip/c55b8550fa57ba4f5e507be406ff9fc2845713e8
Author:     H.J. Lu <hjl.tools@gmail.com>
AuthorDate: Mon, 19 Mar 2018 14:08:11 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 08:03:03 +0100

x86/boot/64: Verify alignment of the LOAD segment

Since the x86-64 kernel must be aligned to 2MB, refuse to boot the
kernel if the alignment of the LOAD segment isn't a multiple of 2MB.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/CAMe9rOrR7xSJgUfiCoZLuqWUwymRxXPoGBW38%2BpN%3D9g%2ByKNhZw@mail.gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 98761a1576ce..252fee320816 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -309,6 +309,10 @@ static void parse_elf(void *output)
 
 		switch (phdr->p_type) {
 		case PT_LOAD:
+#ifdef CONFIG_X86_64
+			if ((phdr->p_align % 0x200000) != 0)
+				error("Alignment of LOAD segment isn't multiple of 2MB");
+#endif
 #ifdef CONFIG_RELOCATABLE
 			dest = output;
 			dest += (phdr->p_paddr - LOAD_PHYSICAL_ADDR);
