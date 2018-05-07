Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeEGViB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:38:01 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:39329 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeEGVh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:37:59 -0400
X-Google-Smtp-Source: AB8JxZpWLyxX/3T4ggJ/+bgPUEv5CyrTtU0PbUENyAtW9RmReGxHZo4Gcr0QywujzeeBYHU8xp7GPg==
Date: Tue, 8 May 2018 00:37:55 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86: pad assembly functions with INT3
Message-ID: <20180507213755.GA32406@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use INT3 instead of NOP. All that padding between functions is
an illegal area, no legitimate code should jump into it.

I've checked x86_64 allyesconfig disassembly, all changes looks sane:
INT3 is only used after RET or unconditional JMP.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/linkage.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -18,7 +18,7 @@
 	name:
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
-#define __ALIGN		.p2align 4, 0x90
+#define __ALIGN		.p2align 4, 0xCC
 #define __ALIGN_STR	__stringify(__ALIGN)
 #endif
 
