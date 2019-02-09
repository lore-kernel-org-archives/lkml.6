Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A67C282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1169C21841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CMjqB/Dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBIBRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 20:17:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37174 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbfBIBRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 20:17:13 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x191AI71018801
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 17:17:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=3f1/7dNVoU4JrPYZXuXMuxBJH9f0uYqRb7kWZjII/UI=;
 b=CMjqB/DcmrWcd8j45f//2Y+6J9Vny8W+sFngNyQ0jqsY/1nk/O2q3pSvIXMU9J3Btck8
 DAiwIEQ5MRyBifVWegysr2YBrbcnQz1RFErVIqv+z3uSh1eP8ruXJQCqvC+Z9Ulbmy9Z
 IPW+9Zg5Bq73hN5VXgplc8tfgZ8dK8oXg28= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qhkntg794-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 17:17:12 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 8 Feb 2019 17:17:11 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id D19B562E2A07; Fri,  8 Feb 2019 17:17:08 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 4/9] perf, bpf: synthesize bpf events with bpf_program__get_prog_info_linear()
Date:   Fri, 8 Feb 2019 17:17:00 -0800
Message-ID: <20190209011705.2160185-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209011705.2160185-1-songliubraving@fb.com>
References: <20190209011705.2160185-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-09_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With bpf_program__get_prog_info_linear, we can simplify the logic that
synthesizes bpf events.

This patch doesn't change the behavior of the code.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf-event.c | 118 ++++++++++++------------------------
 1 file changed, 40 insertions(+), 78 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 796ef793f4ce..e6dfb95029e5 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -3,7 +3,9 @@
 #include <stdlib.h>
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
+#include <bpf/libbpf.h>
 #include <linux/btf.h>
+#include <linux/err.h>
 #include "bpf-event.h"
 #include "debug.h"
 #include "symbol.h"
@@ -49,99 +51,62 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 {
 	struct ksymbol_event *ksymbol_event = &event->ksymbol_event;
 	struct bpf_event *bpf_event = &event->bpf_event;
-	u32 sub_prog_cnt, i, func_info_rec_size = 0;
-	u8 (*prog_tags)[BPF_TAG_SIZE] = NULL;
-	struct bpf_prog_info info = { .type = 0, };
-	u32 info_len = sizeof(info);
-	void *func_infos = NULL;
-	u64 *prog_addrs = NULL;
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info *info;
 	struct btf *btf = NULL;
-	u32 *prog_lens = NULL;
 	bool has_btf = false;
-	char errbuf[512];
+	u32 sub_prog_cnt, i;
 	int err = 0;
+	u64 arrays;
 
-	/* Call bpf_obj_get_info_by_fd() to get sizes of arrays */
-	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
+	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
 
-	if (err) {
-		pr_debug("%s: failed to get BPF program info: %s, aborting\n",
-			 __func__, str_error_r(errno, errbuf, sizeof(errbuf)));
+	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
+	if (IS_ERR_OR_NULL(info_linear)) {
+		info_linear = NULL;
+		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
 		return -1;
 	}
-	if (info_len < offsetof(struct bpf_prog_info, prog_tags)) {
+
+	if (info_linear->info_len < offsetof(struct bpf_prog_info, prog_tags)) {
 		pr_debug("%s: the kernel is too old, aborting\n", __func__);
 		return -2;
 	}
 
+	info = &info_linear->info;
+
 	/* number of ksyms, func_lengths, and tags should match */
-	sub_prog_cnt = info.nr_jited_ksyms;
-	if (sub_prog_cnt != info.nr_prog_tags ||
-	    sub_prog_cnt != info.nr_jited_func_lens)
+	sub_prog_cnt = info->nr_jited_ksyms;
+	if (sub_prog_cnt != info->nr_prog_tags ||
+	    sub_prog_cnt != info->nr_jited_func_lens)
 		return -1;
 
 	/* check BTF func info support */
-	if (info.btf_id && info.nr_func_info && info.func_info_rec_size) {
+	if (info->btf_id && info->nr_func_info && info->func_info_rec_size) {
 		/* btf func info number should be same as sub_prog_cnt */
-		if (sub_prog_cnt != info.nr_func_info) {
+		if (sub_prog_cnt != info->nr_func_info) {
 			pr_debug("%s: mismatch in BPF sub program count and BTF function info count, aborting\n", __func__);
-			return -1;
-		}
-		if (btf__get_from_id(info.btf_id, &btf)) {
-			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info.btf_id);
-			return -1;
+			err = -1;
+			goto out;
 		}
-		func_info_rec_size = info.func_info_rec_size;
-		func_infos = calloc(sub_prog_cnt, func_info_rec_size);
-		if (!func_infos) {
-			pr_debug("%s: failed to allocate memory for func_infos, aborting\n", __func__);
-			return -1;
+		if (btf__get_from_id(info->btf_id, &btf)) {
+			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info->btf_id);
+			err = -1;
+			btf = NULL;
+			goto out;
 		}
 		has_btf = true;
 	}
 
-	/*
-	 * We need address, length, and tag for each sub program.
-	 * Allocate memory and call bpf_obj_get_info_by_fd() again
-	 */
-	prog_addrs = calloc(sub_prog_cnt, sizeof(u64));
-	if (!prog_addrs) {
-		pr_debug("%s: failed to allocate memory for prog_addrs, aborting\n", __func__);
-		goto out;
-	}
-	prog_lens = calloc(sub_prog_cnt, sizeof(u32));
-	if (!prog_lens) {
-		pr_debug("%s: failed to allocate memory for prog_lens, aborting\n", __func__);
-		goto out;
-	}
-	prog_tags = calloc(sub_prog_cnt, BPF_TAG_SIZE);
-	if (!prog_tags) {
-		pr_debug("%s: failed to allocate memory for prog_tags, aborting\n", __func__);
-		goto out;
-	}
-
-	memset(&info, 0, sizeof(info));
-	info.nr_jited_ksyms = sub_prog_cnt;
-	info.nr_jited_func_lens = sub_prog_cnt;
-	info.nr_prog_tags = sub_prog_cnt;
-	info.jited_ksyms = ptr_to_u64(prog_addrs);
-	info.jited_func_lens = ptr_to_u64(prog_lens);
-	info.prog_tags = ptr_to_u64(prog_tags);
-	info_len = sizeof(info);
-	if (has_btf) {
-		info.nr_func_info = sub_prog_cnt;
-		info.func_info_rec_size = func_info_rec_size;
-		info.func_info = ptr_to_u64(func_infos);
-	}
-
-	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
-	if (err) {
-		pr_debug("%s: failed to get BPF program info, aborting\n", __func__);
-		goto out;
-	}
-
 	/* Synthesize PERF_RECORD_KSYMBOL */
 	for (i = 0; i < sub_prog_cnt; i++) {
+		u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);
+		__u32 *prog_lens = (__u32 *)(info->jited_func_lens);
+		__u64 *prog_addrs = (__u64 *)(info->jited_ksyms);
+		void *func_infos = (void *)(info->func_info);
 		const struct bpf_func_info *finfo;
 		const char *short_name = NULL;
 		const struct btf_type *t;
@@ -163,13 +128,13 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 					 KSYM_NAME_LEN - name_len,
 					 prog_tags[i], BPF_TAG_SIZE);
 		if (has_btf) {
-			finfo = func_infos + i * info.func_info_rec_size;
+			finfo = func_infos + i * info->func_info_rec_size;
 			t = btf__type_by_id(btf, finfo->type_id);
 			short_name = btf__name_by_offset(btf, t->name_off);
 		} else if (i == 0 && sub_prog_cnt == 1) {
 			/* no subprog */
-			if (info.name[0])
-				short_name = info.name;
+			if (info->name[0])
+				short_name = info->name;
 		} else
 			short_name = "F";
 		if (short_name)
@@ -195,9 +160,9 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 			},
 			.type = PERF_BPF_EVENT_PROG_LOAD,
 			.flags = 0,
-			.id = info.id,
+			.id = info->id,
 		};
-		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
+		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
 		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
 		event->header.size += machine->id_hdr_size;
 		err = perf_tool__process_synth_event(tool, event,
@@ -205,10 +170,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 	}
 
 out:
-	free(prog_tags);
-	free(prog_lens);
-	free(prog_addrs);
-	free(func_infos);
+	free(info_linear);
 	free(btf);
 	return err ? -1 : 0;
 }
-- 
2.17.1

