Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1844EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F282184E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Jo3cP6em"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfBZAVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:21:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55478 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729459AbfBZAU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:20:58 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1Q0JLUh021194
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:20:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ZodP6c/sisq3UbUd+SO8NMgA2CIeD9sdrF6Q32A6V+8=;
 b=Jo3cP6emOZHt8QuCqaxuk5xJwx5diRnUuQWUN6tRy3R2lMlBfZGAZQqQH23EjDf5t7v9
 f+PXLJtpfnpMjYd4moxcnY2mllEWtJcn2Vi37KD0W0fKp8ARuFNUibrIMbtCj7FSvsiE
 CwEOCTq0G7By/WC9oz0LTLqLBeB8+0wy4jI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2qvsebr99e-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:20:57 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 25 Feb 2019 16:20:56 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 2FFEC62E1F81; Mon, 25 Feb 2019 16:20:55 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 perf,bpf 14/15] perf: introduce side band thread
Date:   Mon, 25 Feb 2019 16:20:18 -0800
Message-ID: <20190226002019.3748539-15-songliubraving@fb.com>
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

This patch introduces side band thread that captures extended information
for events like PERF_RECORD_BPF_EVENT.

This new thread uses its own evlist that uses ring buffer with very low
watermark for lower latency. In the next patch, we uses this thread to
handle PERF_RECORD_BPF_EVENT.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-record.c |   7 +++
 tools/perf/builtin-top.c    |   7 +++
 tools/perf/util/evlist.c    | 100 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  13 +++++
 4 files changed, 127 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2355e0a9eda0..d10c1d5a9e89 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1106,6 +1106,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_data *data = &rec->data;
 	struct perf_session *session;
 	bool disabled = false, draining = false;
+	struct perf_evlist_sb_poll_args poll_args;
 	int fd;
 
 	atexit(record__sig_exit);
@@ -1206,6 +1207,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	poll_args.env = &session->header.env;
+	poll_args.done = &done;
+	perf_evlist__start_polling_thread(&rec->opts.target, &poll_args);
+
 	err = record__synthesize(rec, false);
 	if (err < 0)
 		goto out_child;
@@ -1456,6 +1461,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 out_delete_session:
 	perf_session__delete(session);
+
+	perf_evlist__stop_polling_thread();
 	return status;
 }
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ccdf5689452f..f41545445917 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1524,6 +1524,7 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_END()
 	};
+	struct perf_evlist_sb_poll_args poll_args;
 	const char * const top_usage[] = {
 		"perf top [<options>]",
 		NULL
@@ -1654,8 +1655,14 @@ int cmd_top(int argc, const char **argv)
 
 	top.record_opts.bpf_event = !top.no_bpf_event;
 
+	poll_args.env = &perf_env;
+	poll_args.done = &done;
+	perf_evlist__start_polling_thread(target, &poll_args);
+
 	status = __cmd_top(&top);
 
+	perf_evlist__stop_polling_thread();
+
 out_delete_evlist:
 	perf_evlist__delete(top.evlist);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8c902276d4b4..61b87c8111e6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -19,6 +19,7 @@
 #include "debug.h"
 #include "units.h"
 #include "asm/bug.h"
+#include "bpf-event.h"
 #include <signal.h>
 #include <unistd.h>
 
@@ -1841,3 +1842,102 @@ struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
 	}
 	return leader;
 }
+
+static struct perf_evlist *sb_evlist;
+pthread_t poll_thread;
+
+int perf_evlist__new_side_band_event(struct perf_event_attr *attr)
+{
+	struct perf_evsel *evsel;
+
+	if (!sb_evlist)
+		sb_evlist = perf_evlist__new();
+
+	if (!sb_evlist)
+		return -1;
+
+	evsel = perf_evsel__new_idx(attr, sb_evlist->nr_entries);
+	if (!evsel)
+		goto out_err;
+
+	perf_evlist__add(sb_evlist, evsel);
+	return 0;
+
+out_err:
+	perf_evlist__delete(sb_evlist);
+	return -1;
+}
+
+static void *perf_evlist__poll_thread(void *arg)
+{
+	struct perf_evlist_sb_poll_args *args = arg;
+	int i;
+
+	while (!*(args->done)) {
+		perf_evlist__poll(sb_evlist, 1000);
+
+		for (i = 0; i < sb_evlist->nr_mmaps; i++) {
+			struct perf_mmap *map = &sb_evlist->mmap[i];
+			union perf_event *event;
+
+			if (perf_mmap__read_init(map))
+				continue;
+			while ((event = perf_mmap__read_event(map)) != NULL) {
+				pr_debug("processing vip event of type %d\n",
+					 event->header.type);
+				switch (event->header.type) {
+				default:
+					break;
+				}
+				perf_mmap__consume(map);
+			}
+			perf_mmap__read_done(map);
+		}
+	}
+	return NULL;
+}
+
+int perf_evlist__start_polling_thread(struct target *target,
+				      struct perf_evlist_sb_poll_args *args)
+{
+	struct perf_evsel *counter;
+
+	if (sb_evlist == NULL)
+		return 0;
+
+	if (perf_evlist__create_maps(sb_evlist, target))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(sb_evlist, counter) {
+		if (perf_evsel__open(counter, sb_evlist->cpus,
+				     sb_evlist->threads) < 0)
+			goto out_delete_evlist;
+	}
+
+	if (perf_evlist__mmap(sb_evlist, UINT_MAX))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(sb_evlist, counter) {
+		if (perf_evsel__enable(counter))
+			goto out_delete_evlist;
+	}
+
+	if (pthread_create(&poll_thread, NULL, perf_evlist__poll_thread, args))
+		goto out_delete_evlist;
+
+	return 0;
+
+out_delete_evlist:
+	perf_evlist__delete(sb_evlist);
+	sb_evlist = NULL;
+	return -1;
+}
+
+void perf_evlist__stop_polling_thread(void)
+{
+	if (!sb_evlist)
+		return;
+	pthread_join(poll_thread, NULL);
+	perf_evlist__exit(sb_evlist);
+	sb_evlist = NULL;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 868294491194..4182e50659e0 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -58,6 +58,12 @@ struct perf_evsel_str_handler {
 	void	   *handler;
 };
 
+struct perf_evlist_sb_poll_args {
+	struct perf_env	*env;
+
+	volatile int	*done;
+};
+
 struct perf_evlist *perf_evlist__new(void);
 struct perf_evlist *perf_evlist__new_default(void);
 struct perf_evlist *perf_evlist__new_dummy(void);
@@ -84,6 +90,13 @@ int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
 
 int perf_evlist__add_dummy(struct perf_evlist *evlist);
 
+int perf_evlist__new_side_band_event(struct perf_event_attr *attr);
+
+int perf_evlist__start_polling_thread(struct target *target,
+				      struct perf_evlist_sb_poll_args *args);
+
+void perf_evlist__stop_polling_thread(void);
+
 int perf_evlist__add_newtp(struct perf_evlist *evlist,
 			   const char *sys, const char *name, void *handler);
 
-- 
2.17.1

