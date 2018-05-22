Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbeEVV70 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:59:26 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37412 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeEVV7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:59:24 -0400
X-Google-Smtp-Source: AB8JxZrKrEvrBlXegJ0WUtKin9PGw/6V8VKXnOG8Ne+ZzMIeZvQuVsI4wbRaTuXP7SJ963zwn2mw9Q==
From: Nathan Chancellor <natechancellor@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] arm64: vdso32: Use full path to Clang instead of relying on PATH
Date: Tue, 22 May 2018 14:59:35 -0700
Message-Id: <20180522215935.12029-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in order to build the compat VDSO with Clang, this format
has to be used:

  PATH=${BIN_FOLDER}:${PATH} make CC=clang

Prior to the addition of this file, this format would also be
acceptable:

  make CC=${BIN_FOLDER}/clang

This is because the vdso32 Makefile uses cc-name instead of CC. After
this path, CC will still evaluate to clang for the first case as
expected but now the second case will use the specified Clang, rather
than the host's copy, which may not be compatible as shown below.

/usr/bin/as: unrecognized option '-mfloat-abi=soft'
clang-6.0: error: assembler command failed with exit code 1

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Hi everyone,

I noticed this issue when building the Pixel 2's kernel. Since this
is a supplement to https://patchwork.kernel.org/patch/10186671/, I
was instructed by Mark to push it here. I could not find a public git
tree for this patch, I am not sure if it has been applied or not so I
couldn't add a fixes tag. If there are any other issues, please let me
know!

Nathan

 arch/arm64/kernel/vdso32/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 6d44d972e89d..837e877a326b 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -5,7 +5,7 @@
 # A mix between the arm64 and arm vDSO Makefiles.
 
 ifeq ($(cc-name),clang)
-  CC_ARM32 := $(cc-name) $(CLANG_TARGET_ARM32) -no-integrated-as
+  CC_ARM32 := $(CC) $(CLANG_TARGET_ARM32) -no-integrated-as
 else
   CC_ARM32 := $(CROSS_COMPILE_ARM32)$(cc-name)
 endif
-- 
2.17.0
