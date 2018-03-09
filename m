Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeCIGFq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:05:46 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39144 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeCIGFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:05:43 -0500
X-Google-Smtp-Source: AG47ELu9l3qyV72YKxxTnGd9WngxeuQjJUb3gxTy51fd4V+8ok24L+hCR11xef1NoUITteFndNFP6g==
From: Leo Yan <leo.yan@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] perf machine: Fix load kernel symbol with '-k' option
Date: Fri,  9 Mar 2018 14:05:23 +0800
Message-Id: <1520575523-3838-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Hikey arm64 octa A53 platform, when use command './perf report -v
-k vmlinux --stdio' it outputs below error info, and it skips to load
kernel symbol and doesn't print symbol for event:
Failed to open [kernel.kallsyms]_text, continuing without symbols.

The regression is introduced by commit ("8c7f1bb37b29 perf machine: Move
kernel mmap name into struct machine"), which changes the logic for
machine mmap_name by removing function machine__mmap_name() and always
use 'machine->mmap_name'.  Comparing difference between
machine__mmap_name() and 'machine->mmap_name', the later one includes
the string for specified kernel vmlinux string with option '-k' in
command, but the old function machine__mmap_name() ignores vmlinux
path string.  As result, event's mmap file name doesn't match with
machine mmap file name anymore and it skips to load kernel symbol from
vmlinux file.

To resolve this issue, this patch adds extra checking for
'symbol_conf.vmlinux_name', when it has been set string so we can know
it includes vmlinux path string specified for option '-k'. For this
case it sets 'is_kernel_mmap' to true and run into flow to load kernel
symbol from vmlinux.

This patch has been verified with two commands: './perf report -v
-k vmlinux --stdio' and './perf script -v -F cpu,event,ip,sym,symoff
-k vmlinux'.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/machine.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 12b7427..3125871 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1299,9 +1299,18 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 	else
 		kernel_type = DSO_TYPE_GUEST_KERNEL;
 
-	is_kernel_mmap = memcmp(event->mmap.filename,
-				machine->mmap_name,
-				strlen(machine->mmap_name) - 1) == 0;
+	/*
+	 * When symbol_conf.vmlinux_name is not NULL, it includes the specified
+	 * kernel vmlinux path with option '-k'.  So set 'is_kernel_mmap' to
+	 * true for creating machine symbol map.
+	 */
+	if (symbol_conf.vmlinux_name)
+		is_kernel_mmap = true;
+	else
+		is_kernel_mmap = memcmp(event->mmap.filename,
+					machine->mmap_name,
+					strlen(machine->mmap_name) - 1) == 0;
+
 	if (event->mmap.filename[0] == '/' ||
 	    (!is_kernel_mmap && event->mmap.filename[0] == '[')) {
 		map = machine__findnew_module_map(machine, event->mmap.start,
-- 
2.7.4
