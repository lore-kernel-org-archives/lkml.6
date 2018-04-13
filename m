Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754827AbeDMOCC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753859AbeDMOB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:01:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E742177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>, Dmitriy Vyukov <dvyukov@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 08/17] Revert "x86/asm: Allow again using asm.h when building for the 'bpf' clang target"
Date: Fri, 13 Apr 2018 11:01:02 -0300
Message-Id: <20180413140111.25313-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This reverts commit ca26cffa4e4aaeb09bb9e308f95c7835cb149248.

Newer clang versions accept that asm(_ASM_SP) construct, and now that
the bpf-script-test-kbuild.c script, used in one of the 'perf test LLVM'
subtests doesn't include ptrace.h, which ended up including
arch/x86/include/asm/asm.h, we can revert this patch.

Suggested-by: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/r/613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com
Acked-by: Yonghong Song <yhs@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-nqozcv8loq40tkqpfw997993@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/include/asm/asm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 386a6900e206..219faaec51df 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -136,7 +136,6 @@
 #endif
 
 #ifndef __ASSEMBLY__
-#ifndef __BPF__
 /*
  * This output constraint should be used for any inline asm which has a "call"
  * instruction.  Otherwise the asm may be inserted before the frame pointer
@@ -146,6 +145,5 @@
 register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
 #endif
-#endif
 
 #endif /* _ASM_X86_ASM_H */
-- 
2.14.3
