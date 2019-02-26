Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0395C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A130F2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fxFzSxvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfBZAVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:21:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60010 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729480AbfBZAVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:21:00 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q0IjOx015865
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:20:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=8clvYy8HEJrzLyCdVLBKK30ObF+9osXtjmqHcnYB1l4=;
 b=fxFzSxvndLOui5SVa8aetKOpqbI/7OaabFkIziW1C6hTc8wZb6aDrHC4uuGDcYs94I/B
 +fw4+H/SG1drZFWzY88W/6iqBgw3qZ303bYEJVrbaaisDRoaz+4sJfkMzvPFUjwyLK+h
 ZtoKqgWp370+OLIx4HZAgDgctROVg5wpeFQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvten02dr-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:20:59 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 25 Feb 2019 16:20:57 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B1D6262E1F81; Mon, 25 Feb 2019 16:20:56 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 perf,bpf 15/15] perf, bpf: save information about short living bpf programs
Date:   Mon, 25 Feb 2019 16:20:19 -0800
Message-ID: <20190226002019.3748539-16-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226002019.3748539-1-songliubraving@fb.com>
References: <20190226002019.3748539-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds and side band event to capture bpf_prog_info and btf of
short living bpf programs.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-record.c |  3 ++
 tools/perf/builtin-top.c    |  3 ++
 tools/perf/util/bpf-event.c | 66 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h | 18 ++++++++++
 tools/perf/util/evlist.c    |  5 +++
 5 files changed, 95 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d10c1d5a9e89..ce26d37c2871 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1207,6 +1207,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	if (opts->bpf_event)
+		bpf_event__add_polling_event();
+
 	poll_args.env = &session->header.env;
 	poll_args.done = &done;
 	perf_evlist__start_polling_thread(&rec->opts.target, &poll_args);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f41545445917..851c4dcce66f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1655,6 +1655,9 @@ int cmd_top(int argc, const char **argv)
 
 	top.record_opts.bpf_event = !top.no_bpf_event;
 
+	if (top.record_opts.bpf_event)
+		bpf_event__add_polling_event();
+
 	poll_args.env = &perf_env;
 	poll_args.done = &done;
 	perf_evlist__start_polling_thread(target, &poll_args);
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 048ef00371ad..664906237ffb 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -12,6 +12,7 @@
 #include "machine.h"
 #include "env.h"
 #include "session.h"
+#include "evlist.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -332,3 +333,68 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 	free(event);
 	return err;
 }
+
+void perf_env__add_bpf_info(struct perf_env *env, u32 id)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info_node *info_node;
+	struct btf *btf = NULL;
+	u64 arrays;
+	u32 btf_id;
+	int fd;
+
+	fd = bpf_prog_get_fd_by_id(id);
+	if (fd < 0)
+		return;
+
+	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_INSNS;
+	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
+
+	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
+	if (IS_ERR_OR_NULL(info_linear)) {
+		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
+		goto out;
+	}
+
+	btf_id = info_linear->info.btf_id;
+
+	info_node = malloc(sizeof(struct bpf_prog_info_node));
+	if (info_node) {
+		info_node->info_linear = info_linear;
+		perf_env__insert_bpf_prog_info(env, info_node);
+	} else
+		free(info_linear);
+
+	if (btf_id == 0)
+		goto out;
+
+	if (btf__get_from_id(btf_id, &btf)) {
+		pr_debug("%s: failed to get BTF of id %u, aborting\n",
+			 __func__, btf_id);
+		goto out;
+	}
+	perf_env__fetch_btf(env, btf_id, btf);
+
+out:
+	free(btf);
+	close(fd);
+}
+
+int bpf_event__add_polling_event(void)
+{
+	struct perf_event_attr attr = {
+		.type	          = PERF_TYPE_SOFTWARE,
+		.config           = PERF_COUNT_SW_DUMMY,
+		.watermark        = 1,
+		.bpf_event        = 1,
+		.wakeup_watermark = 1,
+		.size	   = sizeof(attr), /* to capture ABI version */
+	};
+
+	return perf_evlist__new_side_band_event(&attr);
+}
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index b9ec394dc7c7..03a6f018e219 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -4,12 +4,17 @@
 
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
+#include <pthread.h>
+#include <api/fd/array.h>
 #include "event.h"
 
 struct machine;
 union perf_event;
+struct perf_env;
 struct perf_sample;
 struct record_opts;
+struct evlist;
+struct target;
 
 struct bpf_prog_info_node {
 	struct bpf_prog_info_linear	*info_linear;
@@ -31,6 +36,9 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts);
+int bpf_event__add_polling_event(void);
+void perf_env__add_bpf_info(struct perf_env *env, u32 id);
+
 #else
 static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
 					     union perf_event *event __maybe_unused,
@@ -46,5 +54,15 @@ static inline int perf_event__synthesize_bpf_events(struct perf_session *session
 {
 	return 0;
 }
+
+static inline int bpf_event__add_polling_event(void)
+{
+	return 0;
+}
+
+void perf_env__add_bpf_info(struct perf_env *env __maybe_unused,
+			    u32 id __maybe_unused)
+{
+}
 #endif // HAVE_LIBBPF_SUPPORT
 #endif
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 61b87c8111e6..58ac42878c0a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1886,6 +1886,11 @@ static void *perf_evlist__poll_thread(void *arg)
 				pr_debug("processing vip event of type %d\n",
 					 event->header.type);
 				switch (event->header.type) {
+				case PERF_RECORD_BPF_EVENT:
+					if (event->bpf_event.type != PERF_BPF_EVENT_PROG_LOAD)
+						break;
+					perf_env__add_bpf_info(args->env, event->bpf_event.id);
+					break;
 				default:
 					break;
 				}
-- 
2.17.1

