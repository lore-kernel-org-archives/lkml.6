Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeBBQVa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:21:30 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:50709 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBBQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:21:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/7] [HACK] x86: lto: always link in library files
Date: Fri,  2 Feb 2018 17:20:59 +0100
Message-Id: <20180202162104.2300532-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202161550.2106846-1-arnd@arndb.de>
References: <20180202161550.2106846-1-arnd@arndb.de>
X-Provags-ID: V03:K0:flrZBbhZi9cVDoFvU6AbbD1Tee2W5kB4tW4tJHT4axv8i4Nr6Qr
 8VWSu79MnFO2jMQAFxRemfswQVR9OTG9LjoKTzyFChH0HWcXQ9KkB7Vz2XlcjmMP+ElLEmF
 Q2SluilVpqWH3LXH4U9m1Xpm663xJAmwgj1MYOW6lkk3cFwxtl00JbgErdgFUaSgVrgkrON
 wODlJlIVQmdVnyyPA06IQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+1UQAN6iyMM=:oE8mK+bBWNbNvSspm7tuP+
 un3qJ3U7cEx/zPiWKjaoyUtNZ2B/79GS9qIj2h71TrPaVdt9JiDJB4593tiR63MNmbqnnNndO
 R2xbGxNieZXHT26UOmaScyyZhNnYUojoib5fs6olj6W6+iIFJvlo7G2liO9EgLMOkBaPTZiA2
 asyY+J57Rg5T751Pdk7ketlavlOuTNf7aMl47KxItIAU2CDGVbOJ3qSUoFpVGJ+g+EBhjWzNg
 oKl1nYGDK7IpEd7I3XnDimoM6hKtfnBJR6wM6n8WsR5TqefRjCTjwKn/z/8nz5UT/KeSppKLS
 WIGYWSXUnD+qWG67nY1p0byQSW7mGStkQB9Ck/5luPYJFKoUF4fsl4zgwBcQJwsV33HDbCLBI
 k9Ezz7J1syD8o3CiTrs4iEsa5m7J6Bza2Ew1o+JI1LlkOWb5RJh3aLQ98R2FkBqaB3oWkQ+VC
 srSbT3UbFDCGYhWgcoFduTj7z0UbAn7vVtAA3gQYPd5B51rmV4mCmgq4kY2dlqdRU5uUGBR9T
 LXTM6EKkG6vkNL23Iy/dk6f11GPoRacDT3/qKmJA7VGm5/jt0VbBqODrzz5dJKr1EImRx8nd4
 Pns93BKpRZ2TDNfRZ3+EzS9Sx/JVxseIr7T1g4e9Wqhh59tyjdwv190oAcSD2VbnWJSovIea3
 Isy7mVrFU0NshNoY8f9s4GsoCdYHyKqMEXp2dWDH4YT09L9zZodh84RWLeosspPSMF4UTl2WT
 GmzpiNqvG4Og3bKw/g5kje8mxMzbrD+8ZMT6aQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with LTO on gcc-8, I got many link failures like this:

./ccWpIHzj.ltrans0.ltrans.o: In function `siox_poll_thread':
<artificial>:(.text+0x3042): undefined reference to `memset'
./ccWpIHzj.ltrans0.ltrans.o: In function `iio_push_to_buffers':
<artificial>:(.text+0xdd22): undefined reference to `memcpy'
./ccWpIHzj.ltrans0.ltrans.o: In function `dln2_adc_trigger_h':
<artificial>:(.text+0x24175): undefined reference to `memcpy'
<artificial>:(.text+0x241ec): undefined reference to `memset'
./ccWpIHzj.ltrans3.ltrans.o: In function `ir_update_mapping.isra.1':
<artificial>:(.text+0x1d5a5): undefined reference to `memmove'
./ccWpIHzj.ltrans3.ltrans.o: In function `ir_establish_scancode':
<artificial>:(.text+0x1d6c9): undefined reference to `memmove'
./ccWpIHzj.ltrans9.ltrans.o: In function `write_rbu_image_type':
<artificial>:(.text+0x92d6): undefined reference to `strstr'

It seems that the linker fails to pull in the lib.a file for some
reason I have not found out. We want a proper fix for this, but
in the meantime, this simply makes all those files built-in
all the time, which does the right thing with LTO but might
produce a slightly larger kernel image without it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/lib/Makefile | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 25a972c61b0a..d49f02fd79d6 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -20,32 +20,33 @@ clean-files := inat-tables.c
 
 obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
 
-lib-y := delay.o misc.o cmdline.o cpu.o
-lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
-lib-y += memcpy_$(BITS).o
-lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
-lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
-lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
-lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
-lib-$(CONFIG_RETPOLINE) += retpoline.o
+lib-y += delay.o
+obj-y += misc.o cmdline.o cpu.o
+obj-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
+obj-y += memcpy_$(BITS).o
+obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
+obj-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
+obj-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
+obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
+obj-$(CONFIG_RETPOLINE) += retpoline.o
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 
 ifeq ($(CONFIG_X86_32),y)
         obj-y += atomic64_32.o
-        lib-y += atomic64_cx8_32.o
-        lib-y += checksum_32.o
-        lib-y += strstr_32.o
-        lib-y += string_32.o
+        obj-y += atomic64_cx8_32.o
+        obj-y += checksum_32.o
+        obj-y += strstr_32.o
+        obj-y += string_32.o
 ifneq ($(CONFIG_X86_CMPXCHG64),y)
-        lib-y += cmpxchg8b_emu.o atomic64_386_32.o
+        obj-y += cmpxchg8b_emu.o atomic64_386_32.o
 endif
-        lib-$(CONFIG_X86_USE_3DNOW) += mmx_32.o
+        obj-$(CONFIG_X86_USE_3DNOW) += mmx_32.o
 else
         obj-y += iomap_copy_64.o
-        lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
-        lib-y += clear_page_64.o copy_page_64.o
-        lib-y += memmove_64.o memset_64.o
-        lib-y += copy_user_64.o
-	lib-y += cmpxchg16b_emu.o
+        obj-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
+        obj-y += clear_page_64.o copy_page_64.o
+        obj-y += memmove_64.o memset_64.o
+        obj-y += copy_user_64.o
+	obj-y += cmpxchg16b_emu.o
 endif
-- 
2.9.0
