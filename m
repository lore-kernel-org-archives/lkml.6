Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D732F2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Mlj7o/eX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfBZAVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:21:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729427AbfBZAU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:20:56 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q0Haa9005223
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:20:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=/cxOZT0XLIEH3tmdcPdjth1Yr8ix+eiWR/4rVWuPUe8=;
 b=Mlj7o/eXmRtNvZ+meRZWPnPdwiRKLQS8YoWeRos9mLfINuXHCTzf8Yk6GL7+EyQiZmeK
 7SrXIaAlBLHRPzZRhHMpn0VCOXgMPRSIHGhZB40/aNJeJthxBukMSnOUvY5U8xlVlGoe
 mibbqR0kFxnkRoLjmpc3X/52dSOLslS3qjg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2qvqf0gqea-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:20:54 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 25 Feb 2019 16:20:54 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 91E4B62E1F7B; Mon, 25 Feb 2019 16:20:53 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 perf,bpf 13/15] perf, bpf: process PERF_BPF_EVENT_PROG_LOAD for annotation
Date:   Mon, 25 Feb 2019 16:20:17 -0800
Message-ID: <20190226002019.3748539-14-songliubraving@fb.com>
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

This patch adds processing of PERF_BPF_EVENT_PROG_LOAD, which sets proper
DSO type/id/etc of memory regions mapped to BPF programs to
DSO_BINARY_TYPE__BPF_PROG_INFO

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf-event.c | 53 +++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 370b830f2433..048ef00371ad 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -25,12 +25,65 @@ static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
 	return ret;
 }
 
+static int machine__process_bpf_event_load(struct machine *machine __maybe_unused,
+					   union perf_event *event,
+					   struct perf_sample *sample __maybe_unused)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info_node *info_node;
+	struct perf_env *env = machine->env;
+	int id = event->bpf_event.id;
+	unsigned int i;
+
+	/* perf-record, no need to handle bpf-event */
+	if (env == NULL)
+		return 0;
+
+	info_node = perf_env__find_bpf_prog_info(env, id);
+	if (!info_node)
+		return 0;
+	info_linear = info_node->info_linear;
+
+	for (i = 0; i < info_linear->info.nr_jited_ksyms; i++) {
+		u64 *addrs = (u64 *)(info_linear->info.jited_ksyms);
+		u64 addr = addrs[i];
+		struct map *map;
+
+		map = map_groups__find(&machine->kmaps, addr);
+
+		if (map) {
+			map->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
+			map->dso->bpf_prog.id = id;
+			map->dso->bpf_prog.sub_id = i;
+			map->dso->bpf_prog.env = env;
+		}
+	}
+	return 0;
+}
+
 int machine__process_bpf_event(struct machine *machine __maybe_unused,
 			       union perf_event *event,
 			       struct perf_sample *sample __maybe_unused)
 {
 	if (dump_trace)
 		perf_event__fprintf_bpf_event(event, stdout);
+
+	switch (event->bpf_event.type) {
+	case PERF_BPF_EVENT_PROG_LOAD:
+		return machine__process_bpf_event_load(machine, event, sample);
+
+	case PERF_BPF_EVENT_PROG_UNLOAD:
+		/*
+		 * Do not free bpf_prog_info and btf of the program here,
+		 * as annotation still need them. They will be freed at
+		 * the end of the session.
+		 */
+		break;
+	default:
+		pr_debug("unexpected bpf_event type of %d\n",
+			 event->bpf_event.type);
+		break;
+	}
 	return 0;
 }
 
-- 
2.17.1

