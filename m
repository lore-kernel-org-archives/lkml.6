Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeCTGbq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:31:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53243 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeCTGbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:31:44 -0400
Date: Mon, 19 Mar 2018 23:30:20 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c192524e6fe8a4bd18f2549f9556b81ed9e05a86@git.kernel.org>
Cc: jolsa@kernel.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, dsahern@gmail.com, hpa@zytor.com,
        peterz@infradead.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, leo.yan@linaro.org, hpa@zytor.com,
        peterz@infradead.org, dsahern@gmail.com, mingo@kernel.org,
        acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180312152406.10141-1-jolsa@kernel.org>
References: <20180312152406.10141-1-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Fix mmap name setup
Git-Commit-ID: c192524e6fe8a4bd18f2549f9556b81ed9e05a86
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

Commit-ID:  c192524e6fe8a4bd18f2549f9556b81ed9e05a86
Gitweb:     https://git.kernel.org/tip/c192524e6fe8a4bd18f2549f9556b81ed9e05a86
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 12 Mar 2018 16:24:06 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:56:25 -0300

perf machine: Fix mmap name setup

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
