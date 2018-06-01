Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeFAPWE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:22:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54662 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752981AbeFAPVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:21:33 -0400
X-Google-Smtp-Source: ADUXVKLtDZuwFTZDLG18mzvp+J7Wy4Ods1bccpmgyIRL2tzBAVaKG1XcJ53XSr6gN62kwResCgIctA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
Date: Fri,  1 Jun 2018 17:21:23 +0200
Message-Id: <20180601152123.47256-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601152123.47256-1-luc.vanoostenryck@gmail.com>
References: <20180601152123.47256-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__copy_user() is a function, written in assembly, used to copy
memory between kernel & user space. As such its to & from args
may both take a user pointer or a kernel pointer.

However the prototype for this function declare these two args
as 'void __user *', which is no more & no less correct than
declaring them as 'void *'. In fact theer is no possible correct
annotation for such a function.

The problem is worked around here by declaring these args as
unsigned long and casting them to the right type in each of
two callers raw_copy_{to,from}_user() as some kind of cast would
be needed anyway.

Note: another solution, maybe cleaner but slightly more complex,
      would be to declare two version of __copy_user,
      either in the asm file or via an alias, each having already
      the correct typing for raw_copy_{to,from}_user().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/riscv/include/asm/uaccess.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 14b0b22fb..c7a6a4a4a 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -392,19 +392,19 @@ do {								\
 })
 
 
-extern unsigned long __must_check __copy_user(void __user *to,
-	const void __user *from, unsigned long n);
+extern unsigned long __must_check __copy_user(unsigned long to,
+	const unsigned long from, unsigned long n);
 
 static inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	return __copy_user(to, from, n);
+	return __copy_user((unsigned long)to, (unsigned long)from, n);
 }
 
 static inline unsigned long
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	return __copy_user(to, from, n);
+	return __copy_user((unsigned long)to, (unsigned long)from, n);
 }
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
-- 
2.17.1
