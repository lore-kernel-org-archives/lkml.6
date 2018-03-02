Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeCBTv2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:51:28 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33261 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeCBTv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:51:27 -0500
X-Google-Smtp-Source: AG47ELsBJCyK4JLUMCIqflSGS52AV53TzGJwBmaKhwXbgdtpMmG0OMHjEnJLwPbSzTTpGR5/Qvlosw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/21] powerpc: Avoid comparison of unsigned long >= 0 in __access_ok
Date: Fri,  2 Mar 2018 20:50:51 +0100
Message-Id: <20180302195051.4472-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-7-malat@debian.org>
References: <20180225172236.29650-7-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite function-like macro into regular static inline function to avoid a
warning during macro expansion.
Fix warning (treated as error in W=1):

  CC      arch/powerpc/kernel/signal_32.o
In file included from ./include/linux/uaccess.h:14:0,
                 from ./include/asm-generic/termios-base.h:8,
                 from ./arch/powerpc/include/asm/termios.h:20,
                 from ./include/uapi/linux/termios.h:6,
                 from ./include/linux/tty.h:7,
                 from arch/powerpc/kernel/signal_32.c:36:
./include/asm-generic/termios-base.h: In function ‘user_termio_to_kernel_termios’:
./arch/powerpc/include/asm/uaccess.h:52:35: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
   (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                   ^
./arch/powerpc/include/asm/uaccess.h:58:3: note: in expansion of macro ‘__access_ok’
   __access_ok((__force unsigned long)(addr), (size), get_fs()))
   ^~~~~~~~~~~
./arch/powerpc/include/asm/uaccess.h:262:6: note: in expansion of macro ‘access_ok’
  if (access_ok(VERIFY_READ, __gu_addr, (size)))   \
      ^~~~~~~~~
./arch/powerpc/include/asm/uaccess.h:80:2: note: in expansion of macro ‘__get_user_check’
  __get_user_check((x), (ptr), sizeof(*(ptr)))
  ^~~~~~~~~~~~~~~~
./include/asm-generic/termios-base.h:36:6: note: in expansion of macro ‘get_user’
  if (get_user(termios->c_line, &termio->c_line) < 0)
      ^~~~~~~~
[...]
cc1: all warnings being treated as errors

Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/uaccess.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 51bfeb8777f0..a62ee663b2c8 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -47,9 +47,13 @@
 
 #else
 
-#define __access_ok(addr, size, segment)	\
-	(((addr) <= (segment).seg) &&		\
-	 (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
+static inline int __access_ok(unsigned long addr, unsigned long size,
+			mm_segment_t seg)
+{
+	if (addr > seg.seg)
+		return 0;
+	return (size == 0 || size - 1 <= seg.seg - addr);
+}
 
 #endif
 
-- 
2.11.0
