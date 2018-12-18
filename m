Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5C0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7682721871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeLRNtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:49:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42397 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeLRNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:49:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDmvJN2850437
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:48:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDmvEA2850434;
        Tue, 18 Dec 2018 05:48:57 -0800
Date:   Tue, 18 Dec 2018 05:48:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-ec1891afae740be581ecf5abc8bda74c4549203f@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        mathieu.poirier@linaro.org, acme@redhat.com, ak@linux.intel.com,
        davem@davemloft.net, leo.yan@linaro.org, mingo@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, leo.yan@linaro.org, davem@davemloft.net,
          tglx@linutronix.de, hpa@zytor.com, adrian.hunter@intel.com,
          mathieu.poirier@linaro.org, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, acme@redhat.com, ak@linux.intel.com
In-Reply-To: <20181106210712.12098-2-adrian.hunter@intel.com>
References: <20181106210712.12098-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Record if a arch has a single
 user/kernel address space
Git-Commit-ID: ec1891afae740be581ecf5abc8bda74c4549203f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ec1891afae740be581ecf5abc8bda74c4549203f
Gitweb:     https://git.kernel.org/tip/ec1891afae740be581ecf5abc8bda74c4549203f
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Nov 2018 23:07:10 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:54:07 -0300

perf machine: Record if a arch has a single user/kernel address space

Some architectures have a single address space for kernel and user
addresses, which makes it possible to determine if an address is in
kernel space or user space. Some don't, e.g.: sparc.

Cache that info in perf_env so that, for instance, code needing to
fallback failed symbol lookups at the kernel space in single address
space arches can lookup at userspace.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org # 4.19
Link: http://lkml.kernel.org/r/20181106210712.12098-2-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/common.c  | 10 ++++++++++
 tools/perf/arch/common.h  |  1 +
 tools/perf/util/machine.h |  1 +
 tools/perf/util/session.c |  4 ++++
 4 files changed, 16 insertions(+)

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
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d856b85862e2..ca897a73014c 100644
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
