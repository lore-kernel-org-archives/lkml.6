Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeCYSKP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 14:10:15 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54684 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeCYSKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 14:10:06 -0400
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de
Cc: robin.murphy@arm.com, nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 6/6] ARM: uaccess: remove const to avoid duplicate specifier
Date: Sun, 25 Mar 2018 20:09:59 +0200
Message-Id: <20180325180959.28008-7-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180325180959.28008-1-stefan@agner.ch>
References: <20180325180959.28008-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of get_user use the macro with an argument p which
is already specified as static. When using clang this leads to
a duplicate specifier:
    CC      arch/arm/kernel/process.o
  In file included from init/do_mounts.c:15:
  In file included from ./include/linux/tty.h:7:
  In file included from ./include/uapi/linux/termios.h:6:
  In file included from ./arch/arm/include/generated/uapi/asm/termios.h:1:
  ./include/asm-generic/termios.h:25:6: warning: duplicate 'const' declaration
          specifier [-Wduplicate-decl-specifier]
          if (get_user(tmp, &termio->c_iflag) < 0)
              ^
  ./arch/arm/include/asm/uaccess.h:195:3: note: expanded from macro 'get_user'
                  __get_user_check(x, p);                                 \
                  ^
  ./arch/arm/include/asm/uaccess.h:155:12: note: expanded from macro
          '__get_user_check'
                  register const typeof(*(p)) __user *__p asm("r0") = (p);\

Remove the const attribute from the register declaration
to avoid the duplicate const specifier. In a test with ptrace.c
and traps.c (both using get_user with non-const arguments for p)
the generated code was exactly the same.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Similar issue has already been discussed here:
https://patchwork.kernel.org/patch/9693821/

 arch/arm/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 0bf2347495f1..3d614e90c19f 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -152,7 +152,7 @@ extern int __get_user_64t_4(void *);
 #define __get_user_check(x, p)						\
 	({								\
 		unsigned long __limit = current_thread_info()->addr_limit - 1; \
-		register const typeof(*(p)) __user *__p asm("r0") = (p);\
+		register typeof(*(p)) __user *__p asm("r0") = (p);	\
 		register typeof(x) __r2 asm("r2");			\
 		register unsigned long __l asm("r1") = __limit;		\
 		register int __e asm("r0");				\
-- 
2.16.2
