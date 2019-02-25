Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28000C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B922184D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130356;
	bh=siyq8KckBiBaiaBcrzZsvAPbv3RxLcphqaH6pUDHgaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=scUUZeRDdfuTESAlJ5PGAUUJ5DngvusXjdsitPsCMahVI7gN5w1QQGvzdDKHC6ou7
	 1DXbPlZRo4Gsv4WVlLoEAFjlFu6SsyGmn98BZ6DCXpLPduk1ItaVngfXzhYNCyQHZp
	 7eODndjUVjO5rKnu8I3SEW7EdtGbdDJJo/RYagRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbfBYVce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbfBYVcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1552A21848;
        Mon, 25 Feb 2019 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130350;
        bh=siyq8KckBiBaiaBcrzZsvAPbv3RxLcphqaH6pUDHgaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ni+wV4dfFkAz+pN7jfptxbTRj61qvq/ZiZoBhAzowuYc2kUq/VXayESgyqR0lbexL
         +ffhGtB8aqCndeRrBr+ABfTJRAfFAe0nYtXzxM1uofMHb2jsz/LJ0TsvJJ9B0CS7z1
         If8uuHRSCDbyDHdPa4rbQzaQ0BpsEXvAIyT7VVkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 092/183] samples/bpf: workaround clang asm goto compilation errors
Date:   Mon, 25 Feb 2019 22:11:05 +0100
Message-Id: <20190225195110.161758676@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6bf3bbe1f4d4cf405e3c2bf07bbdff56d3223ec8 ]

x86 compilation has required asm goto support since 4.17.
Since clang does not support asm goto, at 4.17,
Commit b1ae32dbab50 ("x86/cpufeature: Guard asm_volatile_goto usage
for BPF compilation") worked around the issue by permitting an
alternative implementation without asm goto for clang.

At 5.0, more asm goto usages appeared.
  [yhs@148 x86]$ egrep -r asm_volatile_goto
  include/asm/cpufeature.h:     asm_volatile_goto("1: jmp 6f\n"
  include/asm/jump_label.h:     asm_volatile_goto("1:"
  include/asm/jump_label.h:     asm_volatile_goto("1:"
  include/asm/rmwcc.h:  asm_volatile_goto (fullop "; j" #cc " %l[cc_label]"     \
  include/asm/uaccess.h:        asm_volatile_goto("\n"                          \
  include/asm/uaccess.h:        asm_volatile_goto("\n"                          \
  [yhs@148 x86]$

Compiling samples/bpf directories, most bpf programs failed
compilation with error messages like:
  In file included from /home/yhs/work/bpf-next/samples/bpf/xdp_sample_pkts_kern.c:2:
  In file included from /home/yhs/work/bpf-next/include/linux/ptrace.h:6:
  In file included from /home/yhs/work/bpf-next/include/linux/sched.h:15:
  In file included from /home/yhs/work/bpf-next/include/linux/sem.h:5:
  In file included from /home/yhs/work/bpf-next/include/uapi/linux/sem.h:5:
  In file included from /home/yhs/work/bpf-next/include/linux/ipc.h:9:
  In file included from /home/yhs/work/bpf-next/include/linux/refcount.h:72:
  /home/yhs/work/bpf-next/arch/x86/include/asm/refcount.h:70:9: error: 'asm goto' constructs are not supported yet
        return GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
               ^
  /home/yhs/work/bpf-next/arch/x86/include/asm/rmwcc.h:67:2: note: expanded from macro 'GEN_BINARY_SUFFIXED_RMWcc'
        __GEN_RMWcc(op " %[val], %[var]\n\t" suffix, var, cc,           \
        ^
  /home/yhs/work/bpf-next/arch/x86/include/asm/rmwcc.h:21:2: note: expanded from macro '__GEN_RMWcc'
        asm_volatile_goto (fullop "; j" #cc " %l[cc_label]"             \
        ^
  /home/yhs/work/bpf-next/include/linux/compiler_types.h:188:37: note: expanded from macro 'asm_volatile_goto'
  #define asm_volatile_goto(x...) asm goto(x)

Most implementation does not even provide an alternative
implementation. And it is also not practical to make changes
for each call site.

This patch workarounded the asm goto issue by redefining the macro like below:
  #define asm_volatile_goto(x...) asm volatile("invalid use of asm_volatile_goto")

If asm_volatile_goto is not used by bpf programs, which is typically the case, nothing bad
will happen. If asm_volatile_goto is used by bpf programs, which is incorrect, the compiler
will issue an error since "invalid use of asm_volatile_goto" is not valid assembly codes.

With this patch, all bpf programs under samples/bpf can pass compilation.

Note that bpf programs under tools/testing/selftests/bpf/ compiled fine as
they do not access kernel internal headers.

Fixes: e769742d3584 ("Revert "x86/jump-labels: Macrofy inline assembly code to work around GCC inlining bugs"")
Fixes: 18fe58229d80 ("x86, asm: change the GEN_*_RMWcc() macros to not quote the condition")
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/Makefile              |  1 +
 samples/bpf/asm_goto_workaround.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 samples/bpf/asm_goto_workaround.h

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index be0a961450bc2..f5ce993c78e42 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -273,6 +273,7 @@ $(obj)/%.o: $(src)/%.c
 		-Wno-gnu-variable-sized-type-not-at-end \
 		-Wno-address-of-packed-member -Wno-tautological-compare \
 		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
+		-I$(srctree)/samples/bpf/ -include asm_goto_workaround.h \
 		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
 ifeq ($(DWARF2BTF),y)
 	$(BTF_PAHOLE) -J $@
diff --git a/samples/bpf/asm_goto_workaround.h b/samples/bpf/asm_goto_workaround.h
new file mode 100644
index 0000000000000..5cd7c1d1a5d56
--- /dev/null
+++ b/samples/bpf/asm_goto_workaround.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2019 Facebook */
+#ifndef __ASM_GOTO_WORKAROUND_H
+#define __ASM_GOTO_WORKAROUND_H
+
+/* this will bring in asm_volatile_goto macro definition
+ * if enabled by compiler and config options.
+ */
+#include <linux/types.h>
+
+#ifdef asm_volatile_goto
+#undef asm_volatile_goto
+#define asm_volatile_goto(x...) asm volatile("invalid use of asm_volatile_goto")
+#endif
+
+#endif
-- 
2.19.1



