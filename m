Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeEBRpU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:45:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55763 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBRpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:45:16 -0400
Date: Wed, 2 May 2018 10:44:09 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-tlk3klbkfyjrbfjvryyznfju@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        adrian.hunter@intel.com, namhyung@kernel.org, acme@redhat.com,
        jolsa@kernel.org, tglx@linutronix.de, wangnan0@huawei.com,
        mingo@kernel.org
Reply-To: wangnan0@huawei.com, mingo@kernel.org, jolsa@kernel.org,
        acme@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        dsahern@gmail.com, adrian.hunter@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf dso: Add dso__has_symbols() method
Git-Commit-ID: d88205db9caa0e9d42dde8ff6c2fa0c7b57cd11d
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

Commit-ID:  d88205db9caa0e9d42dde8ff6c2fa0c7b57cd11d
Gitweb:     https://git.kernel.org/tip/d88205db9caa0e9d42dde8ff6c2fa0c7b57cd11d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 23 Apr 2018 17:08:02 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:05 -0300

perf dso: Add dso__has_symbols() method

To replace longer code sequences in various places.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-tlk3klbkfyjrbfjvryyznfju@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 2 +-
 tools/perf/builtin-top.c    | 4 ++--
 tools/perf/util/dso.h       | 5 +++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0f198f6d9b77..a4104e447f56 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -525,7 +525,7 @@ static void report__warn_kptr_restrict(const struct report *rep)
 
 		if (kernel_map) {
 			const struct dso *kdso = kernel_map->dso;
-			if (!RB_EMPTY_ROOT(&kdso->symbols[MAP__FUNCTION])) {
+			if (dso__has_symbols(kdso, MAP__FUNCTION)) {
 				desc = "If some relocation was applied (e.g. "
 				       "kexec) symbols may be misresolved.";
 			}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4e975f3ee3be..c11b46b411d5 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -742,7 +742,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 "Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
 "Check /proc/sys/kernel/kptr_restrict.\n\n"
 "Kernel%s samples will not be resolved.\n",
-			  al.map && !RB_EMPTY_ROOT(&al.map->dso->symbols[MAP__FUNCTION]) ?
+			  al.map && dso__has_symbols(al.map->dso, MAP__FUNCTION) ?
 			  " modules" : "");
 			if (use_browser <= 0)
 				sleep(5);
@@ -765,7 +765,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		 */
 		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
 		    __map__is_kernel(al.map) &&
-		    RB_EMPTY_ROOT(&al.map->dso->symbols[MAP__FUNCTION])) {
+		    dso__has_symbols(al.map->dso, MAP__FUNCTION)) {
 			if (symbol_conf.vmlinux_name) {
 				char serr[256];
 				dso__strerror_load(al.map->dso, serr, sizeof(serr));
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index c229dbe0277a..881d572be6aa 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -233,6 +233,11 @@ static inline void __dso__zput(struct dso **dso)
 
 bool dso__loaded(const struct dso *dso, enum map_type type);
 
+static inline bool dso__has_symbols(const struct dso *dso, enum map_type type)
+{
+	return !RB_EMPTY_ROOT(&dso->symbols[type]);
+}
+
 bool dso__sorted_by_name(const struct dso *dso, enum map_type type);
 void dso__set_sorted_by_name(struct dso *dso, enum map_type type);
 void dso__sort_by_name(struct dso *dso, enum map_type type);
