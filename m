Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A49C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFED20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFED20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIMSEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbeIMSEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3705C307D85F;
        Thu, 13 Sep 2018 12:55:16 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 564DC600C8;
        Thu, 13 Sep 2018 12:55:14 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 10/48] perf tools: Add HEADER_DATA_INDEX feature
Date:   Thu, 13 Sep 2018 14:54:12 +0200
Message-Id: <20180913125450.21342-11-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 13 Sep 2018 12:55:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

The HEADER_DATA_INDEX feature is to record index table for sample data
so that they can be processed by multiple thread concurrently.  Each
item is a struct perf_file_section which consists of an offset and size.

Link: http://lkml.kernel.org/n/tip-q5rh23fs1qlenc2s9fj0ug7u@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c |  1 +
 tools/perf/util/header.c    | 76 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/header.h    |  3 ++
 3 files changed, 80 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5d1433f92454..b5deda2e890c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -602,6 +602,7 @@ static void record__init_features(struct record *rec)
 		perf_header__clear_feat(&session->header, HEADER_AUXTRACE);
 
 	perf_header__clear_feat(&session->header, HEADER_STAT);
+	perf_header__clear_feat(&session->header, HEADER_DATA_INDEX);
 }
 
 static void
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c78051ad1fcc..b097bcc35d34 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -34,6 +34,7 @@
 #include "strbuf.h"
 #include "build-id.h"
 #include "data.h"
+#include "units.h"
 #include <api/fs/fs.h>
 #include "asm/bug.h"
 #include "tool.h"
@@ -1417,6 +1418,25 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
 	return ret;
 }
 
+static int write_data_index(struct feat_fd *ff,
+			    struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_header *ph = ff->ph;
+	int ret;
+	unsigned int i;
+
+	ret = do_write(ff, &ph->nr_index, sizeof(ph->nr_index));
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ph->nr_index; i++) {
+		ret = do_write(ff, &ph->index[i], sizeof(*ph->index));
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -1809,6 +1829,23 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
 	}
 }
 
+static void print_data_index(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_header *ph = ff->ph;
+	unsigned int i;
+
+	fprintf(fp, "# contains data index (%lu) for parallel processing\n",
+		ph->nr_index);
+
+	for (i = 0; i < ph->nr_index; i++) {
+		struct perf_file_section *s = &ph->index[i];
+		char buf[20];
+
+		unit_number__scnprintf(buf, sizeof(buf), s->size);
+		fprintf(fp, "#   %u: %s @ %lu\n", i, buf, s->offset);
+	}
+}
+
 static int __event_process_build_id(struct build_id_event *bev,
 				    char *filename,
 				    struct perf_session *session)
@@ -2531,6 +2568,44 @@ static int process_mem_topology(struct feat_fd *ff,
 	return ret;
 }
 
+static int process_data_index(struct feat_fd *ff, void *data __maybe_unused)
+{
+	struct perf_header *ph = ff->ph;
+	int fd = ff->fd;
+	ssize_t ret;
+	u64 nr_idx;
+	unsigned int i;
+	struct perf_file_section *idx;
+
+	ret = readn(fd, &nr_idx, sizeof(nr_idx));
+	if (ret != sizeof(nr_idx))
+		return -1;
+
+	if (ph->needs_swap)
+		nr_idx = bswap_64(nr_idx);
+
+	idx = calloc(nr_idx, sizeof(*idx));
+	if (idx == NULL)
+		return -1;
+
+	for (i = 0; i < nr_idx; i++) {
+		ret = readn(fd, &idx[i], sizeof(*idx));
+		if (ret != sizeof(*idx)) {
+			free(idx);
+			return -1;
+		}
+
+		if (ph->needs_swap) {
+			idx[i].offset = bswap_64(idx[i].offset);
+			idx[i].size   = bswap_64(idx[i].size);
+		}
+	}
+
+	ph->index = idx;
+	ph->nr_index = nr_idx;
+	return 0;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2590,6 +2665,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(CACHE,		cache,		true),
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
+	FEAT_OPN(DATA_INDEX,	data_index,	true),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index e17903caa71d..542a62167ecf 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -38,6 +38,7 @@ enum {
 	HEADER_CACHE,
 	HEADER_SAMPLE_TIME,
 	HEADER_MEM_TOPOLOGY,
+	HEADER_DATA_INDEX,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
@@ -78,6 +79,8 @@ struct perf_header {
 	bool				needs_swap;
 	u64				data_offset;
 	u64				data_size;
+	struct perf_file_section	*index;
+	u64				nr_index;
 	u64				feat_offset;
 	DECLARE_BITMAP(adds_features, HEADER_FEAT_BITS);
 	struct perf_env 	env;
-- 
2.17.1

