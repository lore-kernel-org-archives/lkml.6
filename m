Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0212C2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131619;
	bh=zejx0u4uJsmqlyVL1g1VQ9G4sYWXuIQ4dOuKsIGXQ0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xeqn7mawE1l8R1lzK+GgBVXbRn2RJfHo7y8oAT5v/eBgyzqgX9Sk+erRP4y4MA4hW
	 9D29gNjmOh7YaKoNg1A8rxaR8AoBqHdqp4zuFkRgJOJEm8eJyxtvlPTBTmtVk0u2Xb
	 0fzRiYwdgTUPbWf20mvW/eofiSAa2vRqgO5Wmm/I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0212C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeLFV05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:26:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeLFV04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:26:56 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AFBC2082B;
        Thu,  6 Dec 2018 21:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131615;
        bh=zejx0u4uJsmqlyVL1g1VQ9G4sYWXuIQ4dOuKsIGXQ0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOS9y1Lrwkxr8dqilvd8gkmTJZruLCV8seA32nfsNdkPApQ6Q8aUeGZ7z4bWoy6OP
         2ZDP0I4lwkMnqtB+87VZqB6aNXAeZbjBRLGALhAoGUP+8Jn/VZQH+fCM618DL6+BLP
         TazMlcvPtyEwFatQu3CifDE+Vtb+doY44nz3Q0S8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/75] perf machine: Record if a arch has a single user/kernel address space
Date:   Thu,  6 Dec 2018 18:24:53 -0300
Message-Id: <20181206212602.20474-7-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
Cc: stable@vger.kernel.org
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
-- 
2.19.2

