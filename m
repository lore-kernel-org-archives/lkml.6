Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5861C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750D62183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864665;
	bh=R7ioDcJThcdcfgrHYNNB4H67smKtmG8zuxqi3KyBMGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vl3AWoFVALLGK79ee2VebylyPWkDmtTRZkJdcc05GeL6tkwN6LhCZX/iWCgB+yk13
	 gz91PaEBPefB5BniZPUy0BJ/i75IYPVoR16tEf2DtQ2a02ocRIVcCQgaBNNf7aKYDd
	 GB3fOR8AMBITEvHIogwQz07d0zdFb4CIWBJTQhig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfAGMho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:37:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbfAGMhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:37:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8376206BB;
        Mon,  7 Jan 2019 12:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864660;
        bh=R7ioDcJThcdcfgrHYNNB4H67smKtmG8zuxqi3KyBMGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FV847/cbSA/wqAmnhWGw6yFsqIIZ8t7j68zJsjTbfKg+qYiaPW9UHiasqnH9tlX61
         62JuVTYd/cxo6+AZRuGvx87RLr9rFQcskXyAX0YbA2mAoXqBfq19OEO7lPoIlRFL4c
         XEHMWFzDcw+j/HfcRvn+qaYFbKhw86C7tH9SiAyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.20 064/145] perf machine: Record if a arch has a single user/kernel address space
Date:   Mon,  7 Jan 2019 13:31:41 +0100
Message-Id: <20190107104445.642515703@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit ec1891afae740be581ecf5abc8bda74c4549203f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/arch/common.c  |   10 ++++++++++
 tools/perf/arch/common.h  |    1 +
 tools/perf/util/machine.h |    1 +
 tools/perf/util/session.c |    4 ++++
 4 files changed, 16 insertions(+)

--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -200,3 +200,13 @@ int perf_env__lookup_objdump(struct perf
 
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
--- a/tools/perf/arch/common.h
+++ b/tools/perf/arch/common.h
@@ -5,5 +5,6 @@
 #include "../util/env.h"
 
 int perf_env__lookup_objdump(struct perf_env *env, const char **path);
+bool perf_env__single_address_space(struct perf_env *env);
 
 #endif /* ARCH_PERF_COMMON_H */
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
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -24,6 +24,7 @@
 #include "thread.h"
 #include "thread-stack.h"
 #include "stat.h"
+#include "arch/common.h"
 
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
@@ -150,6 +151,9 @@ struct perf_session *perf_session__new(s
 		session->machines.host.env = &perf_env;
 	}
 
+	session->machines.host.single_address_space =
+		perf_env__single_address_space(session->machines.host.env);
+
 	if (!data || perf_data__is_write(data)) {
 		/*
 		 * In O_RDONLY mode this will be performed when reading the


