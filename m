Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeDPGpT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:45:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeDPGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:45:18 -0400
Date: Sun, 15 Apr 2018 23:44:09 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-clbcnzbakdp18ibme4wt43ib@git.kernel.org>
Cc: miguel.bernal.marin@linux.intel.com, adrian.hunter@intel.com,
        peterz@infradead.org, jolsa@kernel.org, wangnan0@huawei.com,
        hpa@zytor.com, daniel@iogearbox.net, mka@chromium.org,
        dsahern@gmail.com, tglx@linutronix.de, luto@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, mingo@kernel.org,
        arnd@arndb.de, namhyung@kernel.org, torvalds@linux-foundation.org,
        yhs@fb.com, alexei.starovoitov@gmail.com, jpoimboe@redhat.com,
        dvyukov@google.com, linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: peterz@infradead.org, miguel.bernal.marin@linux.intel.com,
        adrian.hunter@intel.com, aryabinin@virtuozzo.com, glider@google.com,
        arnd@arndb.de, mingo@kernel.org, luto@kernel.org, dsahern@gmail.com,
        tglx@linutronix.de, wangnan0@huawei.com, daniel@iogearbox.net,
        hpa@zytor.com, jolsa@kernel.org, mka@chromium.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, yhs@fb.com,
        torvalds@linux-foundation.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, dvyukov@google.com
In-Reply-To: <613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com>
References: <613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests bpf: Remove unused ptrace.h include
 from LLVM test
Git-Commit-ID: c13009c1ef3a94cfea212c86bbb94c8361e5de0c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c13009c1ef3a94cfea212c86bbb94c8361e5de0c
Gitweb:     https://git.kernel.org/tip/c13009c1ef3a94cfea212c86bbb94c8361e5de0c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 11 Apr 2018 17:57:32 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 10:33:24 -0300

perf tests bpf: Remove unused ptrace.h include from LLVM test

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
