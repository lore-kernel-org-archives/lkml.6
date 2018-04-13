Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbeDMOBj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753859AbeDMOBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:01:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0E721836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Brian Robbins <brianrob@microsoft.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/17] perf tests: Run dwarf unwind test on arm32
Date: Fri, 13 Apr 2018 11:00:57 -0300
Message-Id: <20180413140111.25313-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Enable the unwind test on arm32:

  $ perf test unwind
  58: DWARF unwind                                          : Ok

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Brian Robbins <brianrob@microsoft.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180410191624.a3a468670dd4548c66d3d094@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
