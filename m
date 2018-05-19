Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeESLsI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:48:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49327 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeESLsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:48:07 -0400
Date: Sat, 19 May 2018 04:47:42 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-dbbd34a666ee117d0e39e71a47f38f02c4a5c698@git.kernel.org>
Cc: acme@redhat.com, dave.hansen@linux.intel.com, adrian.hunter@intel.com,
        mingo@kernel.org, joro@8bytes.org, jolsa@kernel.org, luto@kernel.org,
        peterz@infradead.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, alexander.shishkin@linux.intel.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
        joro@8bytes.org, acme@redhat.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, luto@kernel.org
In-Reply-To: <1526548928-20790-6-git-send-email-adrian.hunter@intel.com>
References: <1526548928-20790-6-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Add machine__is() to identify machine
 arch
Git-Commit-ID: dbbd34a666ee117d0e39e71a47f38f02c4a5c698
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

Commit-ID:  dbbd34a666ee117d0e39e71a47f38f02c4a5c698
Gitweb:     https://git.kernel.org/tip/dbbd34a666ee117d0e39e71a47f38f02c4a5c698
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 17 May 2018 12:21:53 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 19 May 2018 06:42:50 -0300

perf machine: Add machine__is() to identify machine arch

Add a function to identify the machine architecture.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1526548928-20790-6-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
@@ -76,4 +76,6 @@ int perf_env__read_cpu_topology_map(struct perf_env *env);
 void cpu_cache_level__free(struct cpu_cache_level *cache);
 
 const char *perf_env__arch(struct perf_env *env);
+const char *perf_env__raw_arch(struct perf_env *env);
+
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7c777cb32806..107bae7676b1 100644
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
 
