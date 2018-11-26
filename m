Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6ECC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557B021104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms6Nib3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557B021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeKZVyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:54:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbeKZVyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:54:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E56121479;
        Mon, 26 Nov 2018 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230026;
        bh=mm+9F2NfVglNG1eUx+wfcNHnF0Tp1B3cjJ28jvUBgVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ms6Nib3d/+N1OovR8hFVyOaVLCX1txGhA7YynWW1ynReTt8eymGZVFCk18bsW4/ad
         adiZ83E2idqQ1LCKtH1F6bUINRdXSnEtfKbILt1kPCQPtH1wwr0CD8EGVPECKSrpI9
         vg67mlZ9X6iiasMEzouSjN3lpZwfGWudJP1Y3bt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 43/62] perf machine: Add machine__is() to identify machine arch
Date:   Mon, 26 Nov 2018 11:51:24 +0100
Message-Id: <20181126105054.071715561@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit dbbd34a666ee117d0e39e71a47f38f02c4a5c698 upstream.

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/env.c     | 19 +++++++++++++++++++
 tools/perf/util/env.h     |  3 +++
 tools/perf/util/machine.c |  9 +++++++++
 tools/perf/util/machine.h |  2 ++
 4 files changed, 33 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 6276b340f893..49f58921a968 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -3,6 +3,7 @@
 #include "env.h"
 #include "util.h"
 #include <errno.h>
+#include <sys/utsname.h>
 
 struct perf_env perf_env;
 
@@ -87,6 +88,24 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
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
index 1eb35b190b34..bd3869913907 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -65,4 +65,7 @@ int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 int perf_env__read_cpu_topology_map(struct perf_env *env);
 
 void cpu_cache_level__free(struct cpu_cache_level *cache);
+
+const char *perf_env__raw_arch(struct perf_env *env);
+
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index bd5d5b5e2218..2af879693fbe 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2238,6 +2238,15 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
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
index d551aa80a59b..fbc5133fb27c 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -169,6 +169,8 @@ static inline bool machine__is_host(struct machine *machine)
 	return machine ? machine->pid == HOST_KERNEL_ID : false;
 }
 
+bool machine__is(struct machine *machine, const char *arch);
+
 struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 
-- 
2.17.1



