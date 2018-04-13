Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754811AbeDMOB5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753859AbeDMOBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:01:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D462178E
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
Subject: [PATCH 07/17] perf tests bpf: Remove unused ptrace.h include from LLVM test
Date: Fri, 13 Apr 2018 11:01:01 -0300
Message-Id: <20180413140111.25313-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The bpf-script-test-kbuild.c script, used in one of the LLVM subtests,
includes ptrace.h unnecessarily, and that ends up making it include a
header that uses asm(_ASM_SP), a feature that is not supported by clang
<= 4.0, breaking that 'perf test' entry.

This ended up leading to the ca26cffa4e4a ("x86/asm: Allow again using
asm.h when building for the 'bpf' clang target"), adding an ifndef
__BPF__ to the arch/x86/include/asm/asm.h file.

Newer clang versions accept that asm(_ASM_SP) construct, so just remove
the ptrace.h include, which paves the way for reverting ca26cffa4e4a
("x86/asm: Allow again using asm.h when building for the 'bpf' clang
target").

Suggested-by: Yonghong Song <yhs@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/r/613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com
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
Link: https://lkml.kernel.org/n/tip-clbcnzbakdp18ibme4wt43ib@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bpf-script-test-kbuild.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/bpf-script-test-kbuild.c b/tools/perf/tests/bpf-script-test-kbuild.c
index 3626924740d8..ff3ec8337f0a 100644
--- a/tools/perf/tests/bpf-script-test-kbuild.c
+++ b/tools/perf/tests/bpf-script-test-kbuild.c
@@ -9,7 +9,6 @@
 #define SEC(NAME) __attribute__((section(NAME), used))
 
 #include <uapi/linux/fs.h>
-#include <uapi/asm/ptrace.h>
 
 SEC("func=vfs_llseek")
 int bpf_func__vfs_llseek(void *ctx)
-- 
2.14.3
