Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF83C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492A3214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2InRomX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492A3214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbeHIR1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbeHIR1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:27:08 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78EA0214FF;
        Thu,  9 Aug 2018 15:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826909;
        bh=8oyfXrBgyaApOWIj6AiQVL067iOj+AHzgDO+JwAVmZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2InRomX9IgUxxXKXbFlpqp8RGJAySgyEOSt8KtQlFj0WiZezKkh3QOYgWyXSQ1B+
         W3Zjk3Ifp/ZBSxFv7DzaSgwkNlfraomivD0FmUuVOatns2vF69s39Xk1kPKtfcNwE+
         IPlkDinPoKF0UX+Bk81SouxDBITjAtYxDzFRlf5s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 40/44] perf bpf: Make bpf__setup_output_event() return the bpf-output event
Date:   Thu,  9 Aug 2018 11:58:18 -0300
Message-Id: <20180809145822.21391-41-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We're calling it to setup that event, and we'll need it later to decide
if the bpf-output event we're handling is the one setup for a specific
purpose, return it using ERR_PTR, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zhachv7il2n1lopt9aonwhu7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c   |  9 +++++----
 tools/perf/util/bpf-loader.c | 23 ++++++++++++-----------
 tools/perf/util/bpf-loader.h |  7 ++++---
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9b4e24217c46..43a699cfcadf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3216,8 +3216,9 @@ int cmd_trace(int argc, const char **argv)
 	};
 	bool __maybe_unused max_stack_user_set = true;
 	bool mmap_pages_user_set = true;
+	struct perf_evsel *evsel;
 	const char * const trace_subcommands[] = { "record", NULL };
-	int err;
+	int err = -1;
 	char bf[BUFSIZ];
 
 	signal(SIGSEGV, sighandler_dump_stack);
@@ -3240,9 +3241,9 @@ int cmd_trace(int argc, const char **argv)
 				       "cgroup monitoring only available in system-wide mode");
 	}
 
-	err = bpf__setup_output_event(trace.evlist, "__augmented_syscalls__");
-	if (err) {
-		bpf__strerror_setup_output_event(trace.evlist, err, bf, sizeof(bf));
+	evsel = bpf__setup_output_event(trace.evlist, "__augmented_syscalls__");
+	if (IS_ERR(evsel)) {
+		bpf__strerror_setup_output_event(trace.evlist, PTR_ERR(evsel), bf, sizeof(bf));
 		pr_err("ERROR: Setup trace syscalls enter failed: %s\n", bf);
 		goto out;
 	}
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 80dead642719..47aac41349a2 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1535,7 +1535,7 @@ int bpf__apply_obj_config(void)
 			(strcmp(name, 			\
 				bpf_map__name(pos)) == 0))
 
-int bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
+struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;
 	struct bpf_object *obj, *tmp;
@@ -1548,7 +1548,7 @@ int bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
-			return -BPF_LOADER_ERRNO__INTERNAL;
+			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
 
 		/*
 		 * No need to check map type: type should have been
@@ -1561,20 +1561,20 @@ int bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
 	}
 
 	if (!need_init)
-		return 0;
+		return NULL;
 
 	if (!tmpl_priv) {
 		char *event_definition = NULL;
 
 		if (asprintf(&event_definition, "bpf-output/no-inherit=1,name=%s/", name) < 0)
-			return -ENOMEM;
+			return ERR_PTR(-ENOMEM);
 
 		err = parse_events(evlist, event_definition, NULL);
 		free(event_definition);
 
 		if (err) {
 			pr_debug("ERROR: failed to create the \"%s\" bpf-output event\n", name);
-			return -err;
+			return ERR_PTR(-err);
 		}
 
 		evsel = perf_evlist__last(evlist);
@@ -1584,37 +1584,38 @@ int bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
-			return -BPF_LOADER_ERRNO__INTERNAL;
+			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
 		if (priv)
 			continue;
 
 		if (tmpl_priv) {
 			priv = bpf_map_priv__clone(tmpl_priv);
 			if (!priv)
-				return -ENOMEM;
+				return ERR_PTR(-ENOMEM);
 
 			err = bpf_map__set_priv(map, priv, bpf_map_priv__clear);
 			if (err) {
 				bpf_map_priv__clear(map, priv);
-				return err;
+				return ERR_PTR(err);
 			}
 		} else if (evsel) {
 			struct bpf_map_op *op;
 
 			op = bpf_map__add_newop(map, NULL);
 			if (IS_ERR(op))
-				return PTR_ERR(op);
+				return ERR_PTR(PTR_ERR(op));
 			op->op_type = BPF_MAP_OP_SET_EVSEL;
 			op->v.evsel = evsel;
 		}
 	}
 
-	return 0;
+	return evsel;
 }
 
 int bpf__setup_stdout(struct perf_evlist *evlist)
 {
-	return bpf__setup_output_event(evlist, "__bpf_stdout__");
+	struct perf_evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
+	return IS_ERR(evsel) ? PTR_ERR(evsel) : 0;
 }
 
 #define ERRNO_OFFSET(e)		((e) - __BPF_LOADER_ERRNO__START)
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 8eca75145ac2..62d245a90e1d 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -43,6 +43,7 @@ enum bpf_loader_errno {
 	__BPF_LOADER_ERRNO__END,
 };
 
+struct perf_evsel;
 struct bpf_object;
 struct parse_events_term;
 #define PERF_BPF_PROBE_GROUP "perf_bpf_probe"
@@ -82,7 +83,7 @@ int bpf__apply_obj_config(void);
 int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
 
 int bpf__setup_stdout(struct perf_evlist *evlist);
-int bpf__setup_output_event(struct perf_evlist *evlist, const char *name);
+struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name);
 int bpf__strerror_setup_output_event(struct perf_evlist *evlist, int err, char *buf, size_t size);
 #else
 #include <errno.h>
@@ -137,10 +138,10 @@ bpf__setup_stdout(struct perf_evlist *evlist __maybe_unused)
 	return 0;
 }
 
-static inline int
+static inline struct perf_evsel *
 bpf__setup_output_event(struct perf_evlist *evlist __maybe_unused, const char *name __maybe_unused)
 {
-	return 0;
+	return NULL;
 }
 
 static inline int
-- 
2.14.4

