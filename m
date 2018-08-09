Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB305C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E79721D62
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pee/OhDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E79721D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbeHIRY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbeHIRY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:27 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2917C21DEC;
        Thu,  9 Aug 2018 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826750;
        bh=NhxF/KPYqlG09bou1X2GiL5PFXrb4VA7XKy5nwIklmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pee/OhDF1xsvbJg9t386yrghkN+vCw6dvP9bhjbfm4DJ8ZiojyihmJPze+jO5N4yK
         ovDV2sh11Hx0EqaP6yQO01HSVDGBurDwqMPhBOSheuLvKylFkPaUedySDBM2w+2i2M
         Kc4kTSvJ1ISHO2rAIVPHabI/pGE8BCjrgUEjsZn8=
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
Subject: [PATCH 05/44] perf trace: Setup struct syscall_tp for syscalls:sys_{enter,exit}_NAME events
Date:   Thu,  9 Aug 2018 11:57:43 -0300
Message-Id: <20180809145822.21391-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

