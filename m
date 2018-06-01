Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753591AbeFAQ4N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:56:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40036 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753542AbeFAQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:56:01 -0400
X-Google-Smtp-Source: ADUXVKKzZZ1Q18Ya1mpAhP6tnRrlYGkDbt7C9cvwHfgNsvVvNQ8ZmbKJmwfBWXC1o4eSxD9gTv1JYw==
From: Nick Desaulniers <ndesaulniers@google.com>
To: akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        aryabinin@virtuozzo.com, akataria@vmware.com,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        caoj.fnst@cn.fujitsu.com, gregkh@linuxfoundation.org, hpa@zytor.com,
        jan.kiszka@siemens.com, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        mingo@redhat.com, mjg59@google.com, mka@chromium.org,
        ndesaulniers@google.com, pombredanne@nexb.com, rostedt@goodmis.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, tweek@google.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH 2/3] x86/build: use -std=gnu89 for proper extern inline semantics
Date: Fri,  1 Jun 2018 09:55:49 -0700
Message-Id: <20180601165550.90053-3-ndesaulniers@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180601165550.90053-1-ndesaulniers@google.com>
References: <20180601165550.90053-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top level Makefile explicitly sets the C standard used in the kernel
to gnu89. By overriding KBUILD_CFLAGS, the C standard used for this
subdir is now implicit based on compiler and compiler version. GCC
changes this implicit default from gnu89 to gnu11 in v5.1.

This implies that depending on compiler version, parts of the kernel are
being linked together from object files that were compiled with
different C standard compiler flags.

This is problematic for symbols declared as extern inline, as the
semantics have switched since gnu89. See also:
http://blahg.josefsipek.net/?p=529

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index fa42f895fdde..1a04c7e9add1 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -26,7 +26,7 @@ KCOV_INSTRUMENT		:= n
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
 
-KBUILD_CFLAGS := -m$(BITS) -O2
+KBUILD_CFLAGS := -m$(BITS) -O2 -std=gnu89
 KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
-- 
2.17.0.921.gf22659ad46-goog
