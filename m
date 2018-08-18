Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFBCC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE73521878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE73521878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeHRO2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:28:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:28:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBLPFe1283724
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:21:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBLOH31283721;
        Sat, 18 Aug 2018 04:21:24 -0700
Date:   Sat, 18 Aug 2018 04:21:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ogeenrpviwcpwl3oy1l55f3m@git.kernel.org>
Cc:     rostedt@goodmis.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, dsahern@gmail.com,
        adrian.hunter@intel.com, wangnan0@huawei.com, mingo@kernel.org,
        acme@redhat.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, dsahern@gmail.com,
          rostedt@goodmis.org, jolsa@kernel.org, namhyung@kernel.org,
          acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
          adrian.hunter@intel.com, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Setup struct syscall_tp for
 syscalls:sys_{enter,exit}_NAME events
Git-Commit-ID: d32855fa35b94a066c5860c94adc3ebcac7d2c66
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

Commit-ID:  d32855fa35b94a066c5860c94adc3ebcac7d2c66
Gitweb:     https://git.kernel.org/tip/d32855fa35b94a066c5860c94adc3ebcac7d2c66
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 2 Aug 2018 15:09:24 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 Aug 2018 15:38:57 -0300

perf trace: Setup struct syscall_tp for syscalls:sys_{enter,exit}_NAME events

Mapping "__syscall_nr" to "id" and setting up "args" from the offset of
"__syscall_nr" + sizeof(u64), as the payload for syscalls:* is the same
as for raw_syscalls:*, just the fields have different names.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ogeenrpviwcpwl3oy1l55f3m@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 53 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7fca844ced0b..41799596c045 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -247,6 +247,22 @@ static void perf_evsel__delete_priv(struct perf_evsel *evsel)
 	perf_evsel__delete(evsel);
 }
 
+static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
+
+	if (evsel->priv != NULL) {
+		if (perf_evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr"))
+			goto out_delete;
+		return 0;
+	}
+
+	return -ENOMEM;
+out_delete:
+	zfree(&evsel->priv);
+	return -ENOENT;
+}
+
 static int perf_evsel__init_raw_syscall_tp(struct perf_evsel *evsel, void *handler)
 {
 	evsel->priv = malloc(sizeof(struct syscall_tp));
@@ -2977,6 +2993,36 @@ static void evlist__set_evsel_handler(struct perf_evlist *evlist, void *handler)
 		evsel->handler = handler;
 }
 
+static int evlist__set_syscall_tp_fields(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->priv || !evsel->tp_format)
+			continue;
+
+		if (strcmp(evsel->tp_format->system, "syscalls"))
+			continue;
+
+		if (perf_evsel__init_syscall_tp(evsel))
+			return -1;
+
+		if (!strncmp(evsel->tp_format->name, "sys_enter_", 10)) {
+			struct syscall_tp *sc = evsel->priv;
+
+			if (__tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64)))
+				return -1;
+		} else if (!strncmp(evsel->tp_format->name, "sys_exit_", 9)) {
+			struct syscall_tp *sc = evsel->priv;
+
+			if (__tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap))
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * XXX: Hackish, just splitting the combined -e+--event (syscalls
  * (raw_syscalls:{sys_{enter,exit}} + events (tracepoints, HW, SW, etc) to use
@@ -3236,8 +3282,13 @@ int cmd_trace(int argc, const char **argv)
 		symbol_conf.use_callchain = true;
 	}
 
-	if (trace.evlist->nr_entries > 0)
+	if (trace.evlist->nr_entries > 0) {
 		evlist__set_evsel_handler(trace.evlist, trace__event_handler);
+		if (evlist__set_syscall_tp_fields(trace.evlist)) {
+			perror("failed to set syscalls:* tracepoint fields");
+			goto out;
+		}
+	}
 
 	if ((argc >= 1) && (strcmp(argv[0], "record") == 0))
 		return trace__record(&trace, argc-1, &argv[1]);
