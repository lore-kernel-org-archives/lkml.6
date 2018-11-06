Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5657CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013D92086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="E/rXd8Ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013D92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbeKGGVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:21:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51120 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbeKGGVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:21:08 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA6Kok2b001667
        for <linux-kernel@vger.kernel.org>; Tue, 6 Nov 2018 12:54:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=n/DQxe3gZp7TfDa+cxnCo70mw3oGTprFncu7jWo5U6w=;
 b=E/rXd8YsFDRz3yuOLj7hkmehDayH77nHmlpDI6vSI2DKEn+1YrzEfQ5YH+yiKD4KDwlx
 nCQCEb+woEyJiirW4zDVtGTfRJF8MfuMJQAJHlgGgqzar3g2ve7B5Kob9vex86wPlXBW
 N6Thu3z0TDOKJ1N2EgzYQQYy9NAONa7U1SM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nkf2xrp0s-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 12:54:02 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 6 Nov 2018 12:53:31 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 59CA462E1CAE; Tue,  6 Nov 2018 12:53:25 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <acme@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for short living bpf programs
Date:   Tue, 6 Nov 2018 12:52:46 -0800
Message-ID: <20181106205246.567448-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106205246.567448-1-songliubraving@fb.com>
References: <20181106205246.567448-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables perf-record to listen to bpf_event and generate
bpf_prog_info_event for bpf programs loaded and unloaded during
perf-record run.

To minimize latency between bpf_event and following bpf calls, separate
mmap with watermark of 1 is created to process these vip events. Then
a separate dummy event is attached to the special mmap.

By default, perf-record will listen to bpf_event. Option no-bpf-event is
added in case the user would opt out.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-record.c | 50 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.c    | 42 ++++++++++++++++++++++++++++---
 tools/perf/util/evlist.h    |  4 +++
 tools/perf/util/evsel.c     |  8 ++++++
 tools/perf/util/evsel.h     |  3 +++
 5 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 73b02bde1ebc..1036a64eb9f7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -80,6 +80,7 @@ struct record {
 	bool			buildid_all;
 	bool			timestamp_filename;
 	bool			timestamp_boundary;
+	bool			no_bpf_event;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 };
@@ -381,6 +382,8 @@ static int record__open(struct record *rec)
 		pos->tracking = 1;
 		pos->attr.enable_on_exec = 1;
 	}
+	if (!rec->no_bpf_event)
+		perf_evlist__add_bpf_tracker(evlist);
 
 	perf_evlist__config(evlist, opts, &callchain_param);
 
@@ -562,10 +565,55 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	return rc;
 }
 
+static int record__mmap_process_vip_events(struct record *rec)
+{
+	int i;
+
+	for (i = 0; i < rec->evlist->nr_mmaps; i++) {
+		struct perf_mmap *map = &rec->evlist->vip_mmap[i];
+		union perf_event *event;
+
+		perf_mmap__read_init(map);
+		while ((event = perf_mmap__read_event(map)) != NULL) {
+			pr_debug("processing vip event of type %d\n",
+				 event->header.type);
+			switch (event->header.type) {
+			case PERF_RECORD_BPF_EVENT:
+				switch (event->bpf_event.type) {
+				case PERF_BPF_EVENT_PROG_LOAD:
+					perf_event__synthesize_one_bpf_prog_info(
+						&rec->tool,
+						process_synthesized_event,
+						&rec->session->machines.host,
+						event->bpf_event.id);
+					/* fall through */
+				case PERF_BPF_EVENT_PROG_UNLOAD:
+					record__write(rec, NULL, event,
+						      event->header.size);
+				break;
+				default:
+					break;
+				}
+				break;
+			default:
+				break;
+			}
+			perf_mmap__consume(map);
+		}
+		perf_mmap__read_done(map);
+	}
+
+	return 0;
+}
+
 static int record__mmap_read_all(struct record *rec)
 {
 	int err;
 
+	err = record__mmap_process_vip_events(rec);
+	if (err)
+		return err;
+
 	err = record__mmap_read_evlist(rec, rec->evlist, false);
 	if (err)
 		return err;
@@ -1686,6 +1734,8 @@ static struct option __record_options[] = {
 			  "signal"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "Parse options then exit"),
+	OPT_BOOLEAN(0, "no-bpf-event", &record.no_bpf_event,
+		    "do not record event on bpf program load/unload"),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index be440df29615..466a9f7b1e93 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -45,6 +45,7 @@ void perf_evlist__init(struct perf_evlist *evlist, struct cpu_map *cpus,
 	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
 		INIT_HLIST_HEAD(&evlist->heads[i]);
 	INIT_LIST_HEAD(&evlist->entries);
+	INIT_LIST_HEAD(&evlist->vip_entries);
 	perf_evlist__set_maps(evlist, cpus, threads);
 	fdarray__init(&evlist->pollfd, 64);
 	evlist->workload.pid = -1;
@@ -177,6 +178,8 @@ void perf_evlist__add(struct perf_evlist *evlist, struct perf_evsel *entry)
 {
 	entry->evlist = evlist;
 	list_add_tail(&entry->node, &evlist->entries);
+	if (entry->vip)
+		list_add_tail(&entry->vip_node, &evlist->vip_entries);
 	entry->idx = evlist->nr_entries;
 	entry->tracking = !entry->idx;
 
@@ -267,6 +270,27 @@ int perf_evlist__add_dummy(struct perf_evlist *evlist)
 	return 0;
 }
 
+int perf_evlist__add_bpf_tracker(struct perf_evlist *evlist)
+{
+	struct perf_event_attr attr = {
+		.type	          = PERF_TYPE_SOFTWARE,
+		.config           = PERF_COUNT_SW_DUMMY,
+		.watermark        = 1,
+		.bpf_event        = 1,
+		.wakeup_watermark = 1,
+		.size	   = sizeof(attr), /* to capture ABI version */
+	};
+	struct perf_evsel *evsel = perf_evsel__new_idx(&attr,
+						       evlist->nr_entries);
+
+	if (evsel == NULL)
+		return -ENOMEM;
+
+	evsel->vip = true;
+	perf_evlist__add(evlist, evsel);
+	return 0;
+}
+
 static int perf_evlist__add_attrs(struct perf_evlist *evlist,
 				  struct perf_event_attr *attrs, size_t nr_attrs)
 {
@@ -770,6 +794,7 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 	int evlist_cpu = cpu_map__cpu(evlist->cpus, cpu_idx);
 
 	evlist__for_each_entry(evlist, evsel) {
+		struct perf_mmap *vip_maps = evlist->vip_mmap;
 		struct perf_mmap *maps = evlist->mmap;
 		int *output = _output;
 		int fd;
@@ -800,7 +825,11 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 
 		fd = FD(evsel, cpu, thread);
 
-		if (*output == -1) {
+		if (evsel->vip) {
+			if (perf_mmap__mmap(&vip_maps[idx], mp,
+					    fd, evlist_cpu) < 0)
+				return -1;
+		} else if (*output == -1) {
 			*output = fd;
 
 			if (perf_mmap__mmap(&maps[idx], mp, *output, evlist_cpu) < 0)
@@ -822,8 +851,12 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 		 * Therefore don't add it for polling.
 		 */
 		if (!evsel->system_wide &&
-		    __perf_evlist__add_pollfd(evlist, fd, &maps[idx], revent) < 0) {
-			perf_mmap__put(&maps[idx]);
+		    __perf_evlist__add_pollfd(
+			    evlist, fd,
+			    evsel->vip ? &vip_maps[idx] : &maps[idx],
+			    revent) < 0) {
+			perf_mmap__put(evsel->vip ?
+				       &vip_maps[idx] : &maps[idx]);
 			return -1;
 		}
 
@@ -1035,6 +1068,9 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	if (!evlist->mmap)
 		return -ENOMEM;
 
+	if (!evlist->vip_mmap)
+		evlist->vip_mmap = perf_evlist__alloc_mmap(evlist, false);
+
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index dc66436add98..6d99e8dab570 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -26,6 +26,7 @@ struct record_opts;
 
 struct perf_evlist {
 	struct list_head entries;
+	struct list_head vip_entries;
 	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
 	int		 nr_entries;
 	int		 nr_groups;
@@ -43,6 +44,7 @@ struct perf_evlist {
 	} workload;
 	struct fdarray	 pollfd;
 	struct perf_mmap *mmap;
+	struct perf_mmap *vip_mmap;
 	struct perf_mmap *overwrite_mmap;
 	struct thread_map *threads;
 	struct cpu_map	  *cpus;
@@ -84,6 +86,8 @@ int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
 
 int perf_evlist__add_dummy(struct perf_evlist *evlist);
 
+int perf_evlist__add_bpf_tracker(struct perf_evlist *evlist);
+
 int perf_evlist__add_newtp(struct perf_evlist *evlist,
 			   const char *sys, const char *name, void *handler);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index af9d539e4b6a..94456a493607 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -235,6 +235,7 @@ void perf_evsel__init(struct perf_evsel *evsel,
 	evsel->evlist	   = NULL;
 	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->node);
+	INIT_LIST_HEAD(&evsel->vip_node);
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
@@ -1795,6 +1796,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 				     PERF_SAMPLE_BRANCH_NO_CYCLES);
 	if (perf_missing_features.group_read && evsel->attr.inherit)
 		evsel->attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
+	if (perf_missing_features.bpf_event)
+		evsel->attr.bpf_event = 0;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->attr.sample_id_all = 0;
@@ -1939,6 +1942,11 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		perf_missing_features.exclude_guest = true;
 		pr_debug2("switching off exclude_guest, exclude_host\n");
 		goto fallback_missing_features;
+	} else if (!perf_missing_features.bpf_event &&
+		   evsel->attr.bpf_event) {
+		perf_missing_features.bpf_event = true;
+		pr_debug2("switching off bpf_event\n");
+		goto fallback_missing_features;
 	} else if (!perf_missing_features.sample_id_all) {
 		perf_missing_features.sample_id_all = true;
 		pr_debug2("switching off sample_id_all\n");
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4107c39f4a54..82b1d3e42603 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -89,6 +89,7 @@ struct perf_stat_evsel;
  */
 struct perf_evsel {
 	struct list_head	node;
+	struct list_head	vip_node;
 	struct perf_evlist	*evlist;
 	struct perf_event_attr	attr;
 	char			*filter;
@@ -128,6 +129,7 @@ struct perf_evsel {
 	bool			ignore_missing_thread;
 	bool			forced_leader;
 	bool			use_uncore_alias;
+	bool			vip;  /* vip events have their own mmap */
 	/* parse modifier helper */
 	int			exclude_GH;
 	int			nr_members;
@@ -163,6 +165,7 @@ struct perf_missing_features {
 	bool lbr_flags;
 	bool write_backward;
 	bool group_read;
+	bool bpf_event;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.17.1

