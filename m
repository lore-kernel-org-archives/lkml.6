Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeEVK4Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:56:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:56460 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbeEVK4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:56:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="60711431"
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
Subject: [PATCH V3 04/17] perf tools: Add machine__nr_cpus_avail()
Date: Tue, 22 May 2018 13:54:32 +0300
Message-Id: <1526986485-6562-5-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to return the number of the machine's available CPUs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/env.c     | 13 +++++++++++++
 tools/perf/util/env.h     |  1 +
 tools/perf/util/machine.c |  5 +++++
 tools/perf/util/machine.h |  1 +
 4 files changed, 20 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 319fb0a0d05e..59f38c7693f8 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -106,11 +106,24 @@ static int perf_env__read_arch(struct perf_env *env)
 	return env->arch ? 0 : -ENOMEM;
 }
 
+static int perf_env__read_nr_cpus_avail(struct perf_env *env)
+{
+	if (env->nr_cpus_avail == 0)
+		env->nr_cpus_avail = cpu__max_present_cpu();
+
+	return env->nr_cpus_avail ? 0 : -ENOENT;
+}
+
 const char *perf_env__raw_arch(struct perf_env *env)
 {
 	return env && !perf_env__read_arch(env) ? env->arch : "unknown";
 }
 
+int perf_env__nr_cpus_avail(struct perf_env *env)
+{
+	return env && !perf_env__read_nr_cpus_avail(env) ? env->nr_cpus_avail : 0;
+}
+
 void cpu_cache_level__free(struct cpu_cache_level *cache)
 {
 	free(cache->type);
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 62e193948608..1f3ccc368530 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -77,5 +77,6 @@ struct perf_env {
 
 const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__raw_arch(struct perf_env *env);
+int perf_env__nr_cpus_avail(struct perf_env *env);
 
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e011a7160380..f62ecd9c36e8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2305,6 +2305,11 @@ bool machine__is(struct machine *machine, const char *arch)
 	return machine && !strcmp(perf_env__raw_arch(machine->env), arch);
 }
 
+int machine__nr_cpus_avail(struct machine *machine)
+{
+	return machine ? perf_env__nr_cpus_avail(machine->env) : 0;
+}
+
 int machine__get_kernel_start(struct machine *machine)
 {
 	struct map *map = machine__kernel_map(machine);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index b31d33b5aa2a..2d2b092ba753 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -189,6 +189,7 @@ static inline bool machine__is_host(struct machine *machine)
 }
 
 bool machine__is(struct machine *machine, const char *arch);
+int machine__nr_cpus_avail(struct machine *machine);
 
 struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
-- 
1.9.1
