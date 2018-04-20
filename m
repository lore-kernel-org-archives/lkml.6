Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753860AbeDTFr1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 01:47:27 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:47950 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753697AbeDTFrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 01:47:24 -0400
Date: Fri, 20 Apr 2018 07:47:09 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: update to new syscall stub naming convention
Message-ID: <20180420054709.GB19013@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For v4.17-rc1, the naming of syscall stubs changed. Update the
perf scripts/utils/tests which need to be aware of the syscall
stub naming accordingly.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 53d83d7e6a09..9a970e334cea 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -32,10 +32,10 @@ int arch__choose_best_symbol(struct symbol *syma,
 	if (*sym == '.')
 		sym++;
 
-	/* Avoid "SyS" kernel syscall aliases */
-	if (strlen(sym) >= 3 && !strncmp(sym, "SyS", 3))
+	/* Avoid "__se_sys" kernel syscall aliases */
+	if (strlen(sym) >= 8 && !strncmp(sym,  "__se_sys", 8))
 		return SYMBOL_B;
-	if (strlen(sym) >= 10 && !strncmp(sym, "compat_SyS", 10))
+	if (strlen(sym) >= 15 && !strncmp(sym, "__se_compat_sys", 15))
 		return SYMBOL_B;
 
 	return SYMBOL_A;
diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
index e4123c1b0e88..5839baa3d766 100644
--- a/tools/perf/tests/bpf-script-example.c
+++ b/tools/perf/tests/bpf-script-example.c
@@ -31,8 +31,8 @@ struct bpf_map_def SEC("maps") flip_table = {
 	.max_entries = 1,
 };
 
-SEC("func=SyS_epoll_pwait")
-int bpf_func__SyS_epoll_pwait(void *ctx)
+SEC("func=__se_sys_epoll_pwait")
+int bpf_func____se_sys_epoll_pwait(void *ctx)
 {
 	int ind =0;
 	int *flag = bpf_map_lookup_elem(&flip_table, &ind);
diff --git a/tools/perf/util/c++/clang-test.cpp b/tools/perf/util/c++/clang-test.cpp
index 7b042a5ebc68..67a39ac8626d 100644
--- a/tools/perf/util/c++/clang-test.cpp
+++ b/tools/perf/util/c++/clang-test.cpp
@@ -41,7 +41,7 @@ int test__clang_to_IR(void)
 	if (!M)
 		return -1;
 	for (llvm::Function& F : *M)
-		if (F.getName() == "bpf_func__SyS_epoll_pwait")
+		if (F.getName() == "bpf_func____se_sys_epoll_pwait")
 			return 0;
 	return -1;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 62b2dd2253eb..32e156992dfc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -113,10 +113,11 @@ int __weak arch__compare_symbol_names_n(const char *namea, const char *nameb,
 int __weak arch__choose_best_symbol(struct symbol *syma,
 				    struct symbol *symb __maybe_unused)
 {
-	/* Avoid "SyS" kernel syscall aliases */
-	if (strlen(syma->name) >= 3 && !strncmp(syma->name, "SyS", 3))
+	/* Avoid "__se_sys" kernel syscall aliases */
+	if (strlen(syma->name) >= 8 && !strncmp(syma->name,  "__se_sys", 8))
 		return SYMBOL_B;
-	if (strlen(syma->name) >= 10 && !strncmp(syma->name, "compat_SyS", 10))
+	if (strlen(syma->name) >= 15 &&
+		!strncmp(syma->name, "__se_compat_sys", 15))
 		return SYMBOL_B;
 
 	return SYMBOL_A;
