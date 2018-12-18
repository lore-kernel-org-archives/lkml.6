Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F69C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA79521871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171179;
	bh=+pPo5W/7rIpcd/VNwFpPBqe/YMuV134vB5WVeSXrsk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fdtQoFttxCKFjOSAFCltryLbCDVwk/195+A54Ricnjp1uEDvvwVd1H4KRdbHvDvSO
	 XUwp2SHFXsBB8MQn+FpScNs8adNAvvVM42j2+48mr7p3f6uYAwkmsNpbO8EhOjLKqN
	 7YVgj/EnSZr2xvamQYIxP3aPvzh3QBVN9LHPrXAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeLRWM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeLRWM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:12:57 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA03D218A2;
        Tue, 18 Dec 2018 22:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171176;
        bh=+pPo5W/7rIpcd/VNwFpPBqe/YMuV134vB5WVeSXrsk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbQTPDO2Zc/pyHMQIyDCqNFifqGxL4g38qFIEyNniRrQyXR2bQKa8ODyTmpt/8PEK
         PSJxMjS3GC9lxnak6ptYryu5u65h56S5x7ghY1+n68xDknWC46e7RVKWo1tN1H1lnq
         xBbv/w/9lAIQ/XNdIVpSNmVYpI72pq0TkTMH80CU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 35/63] perf trace: Allow specifying a set of events to add in perfconfig
Date:   Tue, 18 Dec 2018 19:07:05 -0300
Message-Id: <20181218220733.15839-36-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To add augmented_raw_syscalls to the events speficied by the user, or be
the only one if no events were specified by the user, one can add this
to perfconfig:

  # cat ~/.perfconfig
  [trace]
	  add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  #

I.e. pre-compile the augmented_raw_syscalls.c BPF program and make it
always load, this way:

  # perf trace -e open* cat /etc/passwd > /dev/null
     0.000 ( 0.013 ms): cat/31557 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
     0.035 ( 0.007 ms): cat/31557 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
     0.353 ( 0.009 ms): cat/31557 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
     0.424 ( 0.006 ms): cat/31557 openat(dfd: CWD, filename: /etc/passwd) = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-0lgj7vh64hg3ce44gsmvj7ud@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  8 ++++++++
 tools/perf/builtin-trace.c               | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 661b1fb3f8ba..423cb41f6e3f 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -521,6 +521,14 @@ diff.*::
 		Possible values are 'delta', 'delta-abs', 'ratio' and
 		'wdiff'.  Default is 'delta'.
 
+trace.*::
+	trace.add_events::
+		Allows adding a set of events to add to the ones specified
+		by the user, or use as a default one if none was specified.
+		The initial use case is to add augmented_raw_syscalls.o to
+		activate the 'perf trace' logic that looks for syscall
+		pointer contents after the normal tracepoint payload.
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 096380e8c213..d754a74aef46 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -22,6 +22,7 @@
 #include "builtin.h"
 #include "util/cgroup.h"
 #include "util/color.h"
+#include "util/config.h"
 #include "util/debug.h"
 #include "util/env.h"
 #include "util/event.h"
@@ -3523,6 +3524,21 @@ static void trace__set_bpf_map_syscalls(struct trace *trace)
 	trace->syscalls.map = bpf__find_map_by_name("syscalls");
 }
 
+static int trace__config(const char *var, const char *value, void *arg)
+{
+	int err = 0;
+
+	if (!strcmp(var, "trace.add_events")) {
+		struct trace *trace = arg;
+		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
+					       "event selector. use 'perf list' to list available events",
+					       parse_events_option);
+		err = parse_events_option(&o, value, 0);
+	}
+
+	return err;
+}
+
 int cmd_trace(int argc, const char **argv)
 {
 	const char *trace_usage[] = {
@@ -3645,6 +3661,10 @@ int cmd_trace(int argc, const char **argv)
 		goto out;
 	}
 
+	err = perf_config(trace__config, &trace);
+	if (err)
+		goto out;
+
 	argc = parse_options_subcommand(argc, argv, trace_options, trace_subcommands,
 				 trace_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
-- 
2.19.2

