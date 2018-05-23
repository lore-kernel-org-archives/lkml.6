Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934896AbeEWUVf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933619AbeEWUVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:21:31 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/18] perf machine: Add nr_cpus_avail()
Date: Wed, 23 May 2018 17:20:52 -0300
Message-Id: <20180523202106.17286-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add a function to return the number of the machine's available CPUs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1526986485-6562-5-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
@@ -77,5 +77,6 @@ void cpu_cache_level__free(struct cpu_cache_level *cache);
 
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
2.14.3
