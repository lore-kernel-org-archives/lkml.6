Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeEOMpN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:45:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:14385 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753072AbeEOMpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:45:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="41390952"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH V1 06/19] perf tools: Fix kernel_start for PTI on x86
Date: Tue, 15 May 2018 15:43:20 +0300
Message-Id: <1526388213-30696-7-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
References: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64, PTI entry trampolines are less than the start of kernel text,
but still above 2^63. So leave kernel_start = 1ULL << 63 for x86_64.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/machine.c | 16 +++++++++++++++-
 tools/perf/util/machine.h |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 72a351613d85..2f39a4d014de 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2296,6 +2296,15 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 	return 0;
 }
 
+/*
+ * Compares the raw arch string. N.B. see instead perf_env__arch() if a
+ * normalized arch is needed.
+ */
+bool machine__is(struct machine *machine, const char *arch)
+{
+	return machine && machine->env && !strcmp(machine->env->arch, arch);
+}
+
 int machine__get_kernel_start(struct machine *machine)
 {
 	struct map *map = machine__kernel_map(machine);
@@ -2312,7 +2321,12 @@ int machine__get_kernel_start(struct machine *machine)
 	machine->kernel_start = 1ULL << 63;
 	if (map) {
 		err = map__load(map);
-		if (!err)
+		/*
+		 * On x86_64, PTI entry trampolines are less than the
+		 * start of kernel text, but still above 2^63. So leave
+		 * kernel_start = 1ULL << 63 for x86_64.
+		 */
+		if (!err && !machine__is(machine, "x86_64"))
 			machine->kernel_start = map->start;
 	}
 	return err;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 388fb4741c54..b31d33b5aa2a 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -188,6 +188,8 @@ static inline bool machine__is_host(struct machine *machine)
 	return machine ? machine->pid == HOST_KERNEL_ID : false;
 }
 
+bool machine__is(struct machine *machine, const char *arch);
+
 struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 
-- 
1.9.1
