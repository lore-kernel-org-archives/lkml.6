Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D63C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4142086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4142086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbeKGGgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:36:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:32232 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbeKGGgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:36:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 13:09:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="102068234"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2018 13:09:00 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH V2 1/3] perf tools: Add fallback functions for cases where cpumode is insufficient
Date:   Tue,  6 Nov 2018 23:07:10 +0200
Message-Id: <20181106210712.12098-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106210712.12098-1-adrian.hunter@intel.com>
References: <20181106210712.12098-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For branch stacks or branch samples, the sample cpumode might not be
correct because it applies only to the sample 'ip' and not necessary to
'addr' or branch stack addresses. Add fallback functions that can be used
to deal with those cases

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # 4.19
---
 tools/perf/arch/common.c  | 10 ++++++++++
 tools/perf/arch/common.h  |  1 +
 tools/perf/util/event.c   | 27 +++++++++++++++++++++++++++
 tools/perf/util/machine.c | 27 +++++++++++++++++++++++++++
 tools/perf/util/machine.h |  3 +++
 tools/perf/util/session.c |  4 ++++
 tools/perf/util/thread.h  |  4 ++++
 7 files changed, 76 insertions(+)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 82657c01a3b8..5f69fd0b745a 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -200,3 +200,13 @@ int perf_env__lookup_objdump(struct perf_env *env, const char **path)
 
 	return perf_env__lookup_binutils_path(env, "objdump", path);
 }
+
+/*
+ * Some architectures have a single address space for kernel and user addresses,
+ * which makes it possible to determine if an address is in kernel space or user
+ * space.
+ */
+bool perf_env__single_address_space(struct perf_env *env)
+{
+	return strcmp(perf_env__arch(env), "sparc");
+}
diff --git a/tools/perf/arch/common.h b/tools/perf/arch/common.h
index 2167001b18c5..c298a446d1f6 100644
--- a/tools/perf/arch/common.h
+++ b/tools/perf/arch/common.h
@@ -5,5 +5,6 @@
 #include "../util/env.h"
 
 int perf_env__lookup_objdump(struct perf_env *env, const char **path);
+bool perf_env__single_address_space(struct perf_env *env);
 
 #endif /* ARCH_PERF_COMMON_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index e9c108a6b1c3..9431b20c1337 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1577,6 +1577,24 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	return al->map;
 }
 
+/*
+ * For branch stacks or branch samples, the sample cpumode might not be correct
+ * because it applies only to the sample 'ip' and not necessary to 'addr' or
+ * branch stack addresses. If possible, use a fallback to deal with those cases.
+ */
+struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
+				struct addr_location *al)
+{
+	struct map *map = thread__find_map(thread, cpumode, addr, al);
+	struct machine *machine = thread->mg->machine;
+	u8 addr_cpumode = machine__addr_cpumode(machine, cpumode, addr);
+
+	if (map || addr_cpumode == cpumode)
+		return map;
+
+	return thread__find_map(thread, addr_cpumode, addr, al);
+}
+
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al)
 {
@@ -1586,6 +1604,15 @@ struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 	return al->sym;
 }
 
+struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
+				      u64 addr, struct addr_location *al)
+{
+	al->sym = NULL;
+	if (thread__find_map_fb(thread, cpumode, addr, al))
+		al->sym = map__find_symbol(al->map, al->addr);
+	return al->sym;
+}
+
 /*
  * Callers need to drop the reference to al->thread, obtained in
  * machine__findnew_thread()
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8f36ce813bc5..9397e3f2444d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2592,6 +2592,33 @@ int machine__get_kernel_start(struct machine *machine)
 	return err;
 }
 
+u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr)
+{
+	u8 addr_cpumode = cpumode;
+	bool kernel_ip;
+
+	if (!machine->single_address_space)
+		goto out;
+
+	kernel_ip = machine__kernel_ip(machine, addr);
+	switch (cpumode) {
+	case PERF_RECORD_MISC_KERNEL:
+	case PERF_RECORD_MISC_USER:
+		addr_cpumode = kernel_ip ? PERF_RECORD_MISC_KERNEL :
+					   PERF_RECORD_MISC_USER;
+		break;
+	case PERF_RECORD_MISC_GUEST_KERNEL:
+	case PERF_RECORD_MISC_GUEST_USER:
+		addr_cpumode = kernel_ip ? PERF_RECORD_MISC_GUEST_KERNEL :
+					   PERF_RECORD_MISC_GUEST_USER;
+		break;
+	default:
+		break;
+	}
+out:
+	return addr_cpumode;
+}
+
 struct dso *machine__findnew_dso(struct machine *machine, const char *filename)
 {
 	return dsos__findnew(&machine->dsos, filename);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d856b85862e2..ebde3ea70225 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -42,6 +42,7 @@ struct machine {
 	u16		  id_hdr_size;
 	bool		  comm_exec;
 	bool		  kptr_restrict_warned;
+	bool		  single_address_space;
 	char		  *root_dir;
 	char		  *mmap_name;
 	struct threads    threads[THREADS__TABLE_SIZE];
@@ -99,6 +100,8 @@ static inline bool machine__kernel_ip(struct machine *machine, u64 ip)
 	return ip >= kernel_start;
 }
 
+u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr);
+
 struct thread *machine__find_thread(struct machine *machine, pid_t pid,
 				    pid_t tid);
 struct comm *machine__thread_exec_comm(struct machine *machine,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7d2c8ce6cfad..f8eab197f35c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -24,6 +24,7 @@
 #include "thread.h"
 #include "thread-stack.h"
 #include "stat.h"
+#include "arch/common.h"
 
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
@@ -150,6 +151,9 @@ struct perf_session *perf_session__new(struct perf_data *data,
 		session->machines.host.env = &perf_env;
 	}
 
+	session->machines.host.single_address_space =
+		perf_env__single_address_space(session->machines.host.env);
+
 	if (!data || perf_data__is_write(data)) {
 		/*
 		 * In O_RDONLY mode this will be performed when reading the
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 30e2b4c165fe..5920c3bb8ffe 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -96,9 +96,13 @@ struct thread *thread__main_thread(struct machine *machine, struct thread *threa
 
 struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al);
+struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
+				struct addr_location *al);
 
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al);
+struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
+				      u64 addr, struct addr_location *al);
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 					struct addr_location *al);
-- 
2.17.1

