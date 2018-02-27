Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbeB0HSM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:18:12 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35011 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeB0HSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:18:11 -0500
X-Google-Smtp-Source: AG47ELtjU1IIkIgK4oLFOw9GY24JLtUgx8Utt4u4zW3a2s0mB08ZAnVr40j9d41t4YK8xiH5oNxQeQ==
From: Leo Yan <leo.yan@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf machine: Fix load kernel symbol with '-k' option
Date: Tue, 27 Feb 2018 15:17:52 +0800
Message-Id: <1519715872-31050-1-git-send-email-leo.yan@linaro.org>
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
'machine->mmap_name', when its start char is not '[' then we can know
it includes vmlinux path string specified for option '-k'. For this
case it sets 'is_kernel_mmap = true' and run into flow to load kernel
symbol from vmlinux.

This patch has been verified with two commands: './perf report -v
-k vmlinux --stdio' and './perf script -v -F cpu,event,ip,sym,symoff
-k vmlinux'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/machine.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 12b7427..ffd709d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1299,9 +1299,18 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 	else
 		kernel_type = DSO_TYPE_GUEST_KERNEL;
 
-	is_kernel_mmap = memcmp(event->mmap.filename,
-				machine->mmap_name,
-				strlen(machine->mmap_name) - 1) == 0;
+	/*
+	 * If machine mmap_name doesn't start with char '[', it includes
+	 * the specified kernel vmlinux name with option '-k'.  So set
+	 * is_kernel_mmap as true to create machine symbol map.
+	 */
+	if (machine->mmap_name[0] != '[')
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
