Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933509AbeCMMHO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932629AbeCMMHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:07:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56FC204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/31] perf machine: Fix mmap name setup
Date: Tue, 13 Mar 2018 09:05:07 -0300
Message-Id: <20180313120508.29327-31-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Leo reported broken -k option behavior. The reason is that we used
symbol_conf.vmlinux_name as a source for mmap event name, but in fact
it's a vmlinux path.

Moving the symbol_conf.vmlinux_name check for both host and guest to the
proper place and out of the machine__set_mmap_name function.

Reported-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: commit ("8c7f1bb37b29 perf machine: Move kernel mmap name into struct machine")
Link: http://lkml.kernel.org/r/20180312152406.10141-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
