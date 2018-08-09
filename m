Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD70C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9894C214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7HyuywH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9894C214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbeHIRYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732388AbeHIRYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:16 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F3582183D;
        Thu,  9 Aug 2018 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826739;
        bh=/4ZHp0TYoRSawmM9F1dWWCDAjnWXMu8d8pkHHz2KU5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7HyuywHdPFfxfD5gp67lc3wauTdSatOu9YfbX19wFPVegisuwJpwBr/PCxck2WyM
         A5lpP7neji0b01/6GimuOMgyacZLrRUYOp8J1+kL7jeZc+VYzPGDiTsC+LJ9ovojBD
         GOwrBa2jMgygXeTO7GhnwCuI58IX8WoDit151P/o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 03/44] perf trace: Rename some syscall_tp methods to raw_syscall
Date:   Thu,  9 Aug 2018 11:57:41 -0300
Message-Id: <20180809145822.21391-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Because raw_syscalls have the field for the syscall number as 'id' while
the syscalls:sys_{enter,exit}_NAME have it as __syscall_nr...

Since we want to support both for being able to enable just a
syscalls:sys_{enter,exit}_name instead of asking for
raw_syscalls:sys_{enter,exit} plus filters, make the method names for
each kind of tracepoint more explicit.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4rixbfzco6tsry0w9ghx3ktb@git.kernel.org
Signef-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7336552c22cf..039f94467968 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -239,7 +239,7 @@ static void perf_evsel__delete_priv(struct perf_evsel *evsel)
 	perf_evsel__delete(evsel);
 }
 
-static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel, void *handler)
+static int perf_evsel__init_raw_syscall_tp(struct perf_evsel *evsel, void *handler)
 {
 	evsel->priv = malloc(sizeof(struct syscall_tp));
 	if (evsel->priv != NULL) {
@@ -257,7 +257,7 @@ static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel, void *handler)
 	return -ENOENT;
 }
 
-static struct perf_evsel *perf_evsel__syscall_newtp(const char *direction, void *handler)
+static struct perf_evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *handler)
 {
 	struct perf_evsel *evsel = perf_evsel__newtp("raw_syscalls", direction);
 
@@ -268,7 +268,7 @@ static struct perf_evsel *perf_evsel__syscall_newtp(const char *direction, void
 	if (IS_ERR(evsel))
 		return NULL;
 
-	if (perf_evsel__init_syscall_tp(evsel, handler))
+	if (perf_evsel__init_raw_syscall_tp(evsel, handler))
 		goto out_delete;
 
 	return evsel;
@@ -2288,14 +2288,14 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	struct perf_evlist *evlist = trace->evlist;
 	struct perf_evsel *sys_enter, *sys_exit;
 
-	sys_enter = perf_evsel__syscall_newtp("sys_enter", trace__sys_enter);
+	sys_enter = perf_evsel__raw_syscall_newtp("sys_enter", trace__sys_enter);
 	if (sys_enter == NULL)
 		goto out;
 
 	if (perf_evsel__init_sc_tp_ptr_field(sys_enter, args))
 		goto out_delete_sys_enter;
 
-	sys_exit = perf_evsel__syscall_newtp("sys_exit", trace__sys_exit);
+	sys_exit = perf_evsel__raw_syscall_newtp("sys_exit", trace__sys_exit);
 	if (sys_exit == NULL)
 		goto out_delete_sys_enter;
 
@@ -2717,7 +2717,7 @@ static int trace__replay(struct trace *trace)
 							     "syscalls:sys_enter");
 
 	if (evsel &&
-	    (perf_evsel__init_syscall_tp(evsel, trace__sys_enter) < 0 ||
+	    (perf_evsel__init_raw_syscall_tp(evsel, trace__sys_enter) < 0 ||
 	    perf_evsel__init_sc_tp_ptr_field(evsel, args))) {
 		pr_err("Error during initialize raw_syscalls:sys_enter event\n");
 		goto out;
@@ -2729,7 +2729,7 @@ static int trace__replay(struct trace *trace)
 		evsel = perf_evlist__find_tracepoint_by_name(session->evlist,
 							     "syscalls:sys_exit");
 	if (evsel &&
-	    (perf_evsel__init_syscall_tp(evsel, trace__sys_exit) < 0 ||
+	    (perf_evsel__init_raw_syscall_tp(evsel, trace__sys_exit) < 0 ||
 	    perf_evsel__init_sc_tp_uint_field(evsel, ret))) {
 		pr_err("Error during initialize raw_syscalls:sys_exit event\n");
 		goto out;
-- 
2.14.4

