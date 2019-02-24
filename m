Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046D8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9E220663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035272;
	bh=fwaPm7JzBR19ME1e/wFanG7qUZYm8oopvgHE27sqCt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cuttc1Euoy0RNrOe0tj0u+OmVatOiyGV+f111jyCri1dAHq7frXs8sDFQNcYge7uC
	 8mtm2pbdtbE4biMiKOZuq0zNGZot41/vA0jTISdbR+sB4WrEiO3M8FCEcoPSPhiHq3
	 FBnV+8X5T73Ic0jKe2FFTdLrEOQKHASCLWsKZYEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfBXTHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbfBXTHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 936DD356EC;
        Sun, 24 Feb 2019 19:07:48 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A74566013A;
        Sun, 24 Feb 2019 19:07:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 14/20] perf header: Add DIR_FORMAT feature to describe directory data
Date:   Sun, 24 Feb 2019 20:06:50 +0100
Message-Id: <20190224190656.30163-15-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 24 Feb 2019 19:07:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data files layout is described by HEADER_DIR_FORMAT
feature.  Currently it holds only version number (1):

     uint64_t version;

The current version holds only version value (1) means
that data files:
  - follow the 'data.*' name format
  - contain raw events data in standard perf format as
    read from kernel (and need to be sorted)

Future versions are expected to describe different data
files layout according to special needs.

Link: http://lkml.kernel.org/n/tip-6l53s3oabwr1r4n6wke21d8g@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c |  2 ++
 tools/perf/util/data.c      | 10 +++++++--
 tools/perf/util/data.h      |  1 +
 tools/perf/util/header.c    | 44 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h    |  5 +++++
 5 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e983c8d71a79..a468d882e74f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -837,6 +837,8 @@ static void record__init_features(struct record *rec)
 	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
 		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
 
+	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 90bda7718bbd..b196325ee855 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -14,6 +14,7 @@
 #include "data.h"
 #include "util.h"
 #include "debug.h"
+#include "header.h"
 
 static void close_dir(struct perf_data_file *files, int nr)
 {
@@ -41,8 +42,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	if (!files)
 		return -ENOMEM;
 
-	data->dir.files = files;
-	data->dir.nr    = nr;
+	data->dir.version = PERF_DIR_VERSION;
+	data->dir.files   = files;
+	data->dir.nr      = nr;
 
 	for (i = 0; i < nr; i++) {
 		struct perf_data_file *file = &files[i];
@@ -75,6 +77,10 @@ int perf_data__open_dir(struct perf_data *data)
 	if (WARN_ON(!data->is_dir))
 		return -EINVAL;
 
+	/* The version is provided by DIR_FORMAT feature. */
+	if (WARN_ON(data->dir.version != PERF_DIR_VERSION))
+		return -1;
+
 	dir = opendir(data->path);
 	if (!dir)
 		return -EINVAL;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index d342469bdfda..6aef8746469f 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -24,6 +24,7 @@ struct perf_data {
 	enum perf_data_mode	 mode;
 
 	struct {
+		u64			 version;
 		struct perf_data_file	*files;
 		int			 nr;
 	} dir;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a2323d777dae..4adfbcdc551a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -867,6 +867,21 @@ static int write_clockid(struct feat_fd *ff,
 			sizeof(ff->ph->env.clockid_res_ns));
 }
 
+static int write_dir_format(struct feat_fd *ff,
+			    struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	if (WARN_ON(!perf_data__is_dir(data)))
+		return -1;
+
+	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
+}
+
 static int cpu_cache_level__sort(const void *a, const void *b)
 {
 	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
@@ -1347,6 +1362,17 @@ static void print_clockid(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.clockid_res_ns * 1000);
 }
 
+static void print_dir_format(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	fprintf(fp, "# directory data version : %"PRIu64"\n", data->dir.version);
+}
+
 static void free_event_desc(struct perf_evsel *events)
 {
 	struct perf_evsel *evsel;
@@ -2379,6 +2405,21 @@ static int process_clockid(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_dir_format(struct feat_fd *ff,
+			      void *_data __maybe_unused)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	if (WARN_ON(!perf_data__is_dir(data)))
+		return -1;
+
+	return do_read_u64(ff, &data->dir.version);
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2438,7 +2479,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(CACHE,		cache,		true),
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
-	FEAT_OPR(CLOCKID,       clockid,        false)
+	FEAT_OPR(CLOCKID,	clockid,	false),
+	FEAT_OPN(DIR_FORMAT,	dir_format,	false)
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0d553ddca0a3..6a231340238d 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -39,6 +39,7 @@ enum {
 	HEADER_SAMPLE_TIME,
 	HEADER_MEM_TOPOLOGY,
 	HEADER_CLOCKID,
+	HEADER_DIR_FORMAT,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
@@ -48,6 +49,10 @@ enum perf_header_version {
 	PERF_HEADER_VERSION_2,
 };
 
+enum perf_dir_version {
+	PERF_DIR_VERSION	= 1,
+};
+
 struct perf_file_section {
 	u64 offset;
 	u64 size;
-- 
2.17.2

