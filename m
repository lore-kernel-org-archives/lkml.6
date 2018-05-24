Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755035AbeEXFjt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:39:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37043 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935396AbeEXFjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:39:45 -0400
Date: Wed, 23 May 2018 22:38:21 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-9cecca325ea879c84fcd31a5e609a514c1a1dbd1@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, peterz@infradead.org,
        jolsa@redhat.com, ak@linux.intel.com, acme@redhat.com, luto@kernel.org,
        joro@8bytes.org, mingo@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, dave.hansen@linux.intel.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, adrian.hunter@intel.com, mingo@kernel.org,
        hpa@zytor.com, joro@8bytes.org, acme@redhat.com, luto@kernel.org,
        ak@linux.intel.com, jolsa@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com
In-Reply-To: <1526986485-6562-5-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-5-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Add nr_cpus_avail()
Git-Commit-ID: 9cecca325ea879c84fcd31a5e609a514c1a1dbd1
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

Commit-ID:  9cecca325ea879c84fcd31a5e609a514c1a1dbd1
Gitweb:     https://git.kernel.org/tip/9cecca325ea879c84fcd31a5e609a514c1a1dbd1
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:32 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 22 May 2018 10:52:49 -0300

perf machine: Add nr_cpus_avail()

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
