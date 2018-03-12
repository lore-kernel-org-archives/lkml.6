Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeCLPYM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:24:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751315AbeCLPYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:24:11 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf machine: Fix mmap name setup
Date: Mon, 12 Mar 2018 16:24:06 +0100
Message-Id: <20180312152406.10141-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leo reported broken -k option behavior. The reason is
that we used symbol_conf.vmlinux_name as a source for
mmap event name, but in fact it's a vmlinux path.

Moving the symbol_conf.vmlinux_name check for both
host and guest to the proper place and out of the
machine__set_mmap_name function.

Reported-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Fixes: commit ("8c7f1bb37b29 perf machine: Move kernel mmap name into struct machine")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 43fbbee409ec..2eca8478e24f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -50,21 +50,13 @@ static void machine__threads_init(struct machine *machine)
 
 static int machine__set_mmap_name(struct machine *machine)
 {
-	if (machine__is_host(machine)) {
-		if (symbol_conf.vmlinux_name)
-			machine->mmap_name = strdup(symbol_conf.vmlinux_name);
-		else
-			machine->mmap_name = strdup("[kernel.kallsyms]");
-	} else if (machine__is_default_guest(machine)) {
-		if (symbol_conf.default_guest_vmlinux_name)
-			machine->mmap_name = strdup(symbol_conf.default_guest_vmlinux_name);
-		else
-			machine->mmap_name = strdup("[guest.kernel.kallsyms]");
-	} else {
-		if (asprintf(&machine->mmap_name, "[guest.kernel.kallsyms.%d]",
-			 machine->pid) < 0)
-			machine->mmap_name = NULL;
-	}
+	if (machine__is_host(machine))
+		machine->mmap_name = strdup("[kernel.kallsyms]");
+	else if (machine__is_default_guest(machine))
+		machine->mmap_name = strdup("[guest.kernel.kallsyms]");
+	else if (asprintf(&machine->mmap_name, "[guest.kernel.kallsyms.%d]",
+			  machine->pid) < 0)
+		machine->mmap_name = NULL;
 
 	return machine->mmap_name ? 0 : -ENOMEM;
 }
@@ -794,9 +786,15 @@ static struct dso *machine__get_kernel(struct machine *machine)
 	struct dso *kernel;
 
 	if (machine__is_host(machine)) {
+		if (symbol_conf.vmlinux_name)
+			vmlinux_name = symbol_conf.vmlinux_name;
+
 		kernel = machine__findnew_kernel(machine, vmlinux_name,
 						 "[kernel]", DSO_TYPE_KERNEL);
 	} else {
+		if (symbol_conf.default_guest_vmlinux_name)
+			vmlinux_name = symbol_conf.default_guest_vmlinux_name;
+
 		kernel = machine__findnew_kernel(machine, vmlinux_name,
 						 "[guest.kernel]",
 						 DSO_TYPE_GUEST_KERNEL);
-- 
2.13.6
