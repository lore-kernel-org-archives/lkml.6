Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeEQJXp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:23:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:6649 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQJXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:23:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="41683571"
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
Subject: [PATCH V2 05/20] perf tools: Add machine__is() to identify machine arch
Date: Thu, 17 May 2018 12:21:53 +0300
Message-Id: <1526548928-20790-6-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
References: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to identify the machine architecture.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/env.c     | 18 ++++++++++++++++++
 tools/perf/util/env.h     |  2 ++
 tools/perf/util/machine.c |  9 +++++++++
 tools/perf/util/machine.h |  2 ++
 4 files changed, 31 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 4c842762e3f2..319fb0a0d05e 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -93,6 +93,24 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 	return 0;
 }
 
+static int perf_env__read_arch(struct perf_env *env)
+{
+	struct utsname uts;
+
+	if (env->arch)
+		return 0;
+
+	if (!uname(&uts))
+		env->arch = strdup(uts.machine);
+
+	return env->arch ? 0 : -ENOMEM;
+}
+
+const char *perf_env__raw_arch(struct perf_env *env)
+{
+	return env && !perf_env__read_arch(env) ? env->arch : "unknown";
+}
+
 void cpu_cache_level__free(struct cpu_cache_level *cache)
 {
 	free(cache->type);
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index c4ef2e523367..62e193948608 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -76,4 +76,6 @@ struct perf_env {
 void cpu_cache_level__free(struct cpu_cache_level *cache);
 
 const char *perf_env__arch(struct perf_env *env);
+const char *perf_env__raw_arch(struct perf_env *env);
+
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 72a351613d85..dcdf78ddc470 100644
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
+	return machine && !strcmp(perf_env__raw_arch(machine->env), arch);
+}
+
 int machine__get_kernel_start(struct machine *machine)
 {
 	struct map *map = machine__kernel_map(machine);
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
