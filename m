Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeDKAQ2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 20:16:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44204 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751770AbeDKAQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 20:16:27 -0400
Date: Tue, 10 Apr 2018 19:16:24 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Brian Robbins <brianrob@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tests: run dwarf unwind test on arm32
Message-Id: <20180410191624.a3a468670dd4548c66d3d094@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the unwind test on arm32:

$ ./perf test unwind
58: DWARF unwind                                          : Ok

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 tools/perf/arch/arm/include/arch-tests.h | 12 ++++++++++++
 tools/perf/arch/arm/tests/Build          |  2 ++
 tools/perf/arch/arm/tests/arch-tests.c   | 16 ++++++++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 tools/perf/arch/arm/include/arch-tests.h
 create mode 100644 tools/perf/arch/arm/tests/arch-tests.c

diff --git a/tools/perf/arch/arm/include/arch-tests.h b/tools/perf/arch/arm/include/arch-tests.h
new file mode 100644
index 000000000000..90ec4c8cb880
--- /dev/null
+++ b/tools/perf/arch/arm/include/arch-tests.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_TESTS_H
+#define ARCH_TESTS_H
+
+#ifdef HAVE_DWARF_UNWIND_SUPPORT
+struct thread;
+struct perf_sample;
+#endif
+
+extern struct test arch_tests[];
+
+#endif
diff --git a/tools/perf/arch/arm/tests/Build b/tools/perf/arch/arm/tests/Build
index b30eff9bcc83..883c57ff0c08 100644
--- a/tools/perf/arch/arm/tests/Build
+++ b/tools/perf/arch/arm/tests/Build
@@ -1,2 +1,4 @@
 libperf-y += regs_load.o
 libperf-y += dwarf-unwind.o
+
+libperf-y += arch-tests.o
diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
new file mode 100644
index 000000000000..5b1543c98022
--- /dev/null
+++ b/tools/perf/arch/arm/tests/arch-tests.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+struct test arch_tests[] = {
+#ifdef HAVE_DWARF_UNWIND_SUPPORT
+	{
+		.desc = "DWARF unwind",
+		.func = test__dwarf_unwind,
+	},
+#endif
+	{
+		.func = NULL,
+	},
+};
-- 
2.17.0
