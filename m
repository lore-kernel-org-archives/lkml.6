Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA1FC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3121421D62
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="we6I9jAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3121421D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733221AbeHIR1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbeHIR1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:27:13 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F84D2183D;
        Thu,  9 Aug 2018 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826915;
        bh=oWlAJyg24/utvwgo5abGtsf4qsLlHwKnFKURy2VsR54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=we6I9jAwtDYrv4I/ivL1g5cAv1018ytfGo8Sz/gjFb4o0ui6m8OLngtz7v0yNDENv
         Z0I/klN1I6UKsrEbGouRFF8B958IXNqS7+LA9fAcZ+aJLo5UUBuPUjinsWce7hwFR/
         ai4Cr/cW6aLDsVSJj0s7s4yqRwm0EfmjpulTimes=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 41/44] perf trace: Setup the augmented syscalls bpf-output event fields
Date:   Thu,  9 Aug 2018 11:58:19 -0300
Message-Id: <20180809145822.21391-42-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The payload that is put in place by the eBPF script attached to
syscalls:sys_enter_openat (and other syscalls with pointers, in the
future) can be consumed by the existing sys_enter beautifiers if
evsel->priv is setup with a struct syscall_tp with struct tp_fields for
the 'syscall_id' and 'args' fields expected by the beautifiers, this
patch does just that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xfjyog8oveg2fjys9r1yy1es@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 43a699cfcadf..06215acb1481 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -77,7 +77,8 @@ struct trace {
 		struct syscall  *table;
 		struct {
 			struct perf_evsel *sys_enter,
-					  *sys_exit;
+					  *sys_exit,
+					  *augmented;
 		}		events;
 	} syscalls;
 	struct record_opts	opts;
@@ -263,6 +264,30 @@ static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel)
 	return -ENOENT;
 }
 
+static int perf_evsel__init_augmented_syscall_tp(struct perf_evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
+
+	if (evsel->priv != NULL) {       /* field, sizeof_field, offsetof_field */
+		if (__tp_field__init_uint(&sc->id, sizeof(long), sizeof(long long), evsel->needs_swap))
+			goto out_delete;
+
+		return 0;
+	}
+
+	return -ENOMEM;
+out_delete:
+	zfree(&evsel->priv);
+	return -EINVAL;
+}
+
+static int perf_evsel__init_augmented_syscall_tp_args(struct perf_evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv;
+
+	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
+}
+
 static int perf_evsel__init_raw_syscall_tp(struct perf_evsel *evsel, void *handler)
 {
 	evsel->priv = malloc(sizeof(struct syscall_tp));
@@ -3248,6 +3273,13 @@ int cmd_trace(int argc, const char **argv)
 		goto out;
 	}
 
+	if (evsel) {
+		if (perf_evsel__init_augmented_syscall_tp(evsel) ||
+		    perf_evsel__init_augmented_syscall_tp_args(evsel))
+			goto out;
+		trace.syscalls.events.augmented = evsel;
+	}
+
 	err = bpf__setup_stdout(trace.evlist);
 	if (err) {
 		bpf__strerror_setup_stdout(trace.evlist, err, bf, sizeof(bf));
-- 
2.14.4

