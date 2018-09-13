Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D23C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE9320854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE9320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeIMSEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbeIMSEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC3713084040;
        Thu, 13 Sep 2018 12:55:22 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C989A600C6;
        Thu, 13 Sep 2018 12:55:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 13/48] perf record: Add --index option for building index table
Date:   Thu, 13 Sep 2018 14:54:15 +0200
Message-Id: <20180913125450.21342-14-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 13 Sep 2018 12:55:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new --index option will create indexed data file which can be
processed by multiple threads parallelly.  It saves meta event and
sample data in separate files and merges them with an index table.

If there's an index table in the data file, the HEADER_DATA_INDEX
feature bit is set and session->header.index[0] will point to the meta
event area, and rest are sample data.  It'd look like below:

        +---------------------+
        |     file header     |
        |---------------------|
        |                     |
        |    meta events[0] <-+--+
        |                     |  |
        |---------------------|  |
        |                     |  |
        |    sample data[1] <-+--+
        |                     |  |
        |---------------------|  |
        |                     |  |
        |    sample data[2] <-|--+
        |                     |  |
        |---------------------|  |
        |         ...         | ...
        |---------------------|  |
        |     feature data    |  |
        |   (contains index) -+--+
        +---------------------+

Link: http://lkml.kernel.org/n/tip-x7uwxr8o0p54xf1vfqiqxav7@git.kernel.org
Original-patch-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |   4 +
 tools/perf/builtin-record.c              | 134 ++++++++++++++++++++++-
 tools/perf/perf.h                        |   1 +
 tools/perf/util/mmap.h                   |  23 ++--
 4 files changed, 146 insertions(+), 16 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 246dee081efd..ae19f6424e5f 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -500,6 +500,10 @@ config terms. For example: 'cycles/overwrite/' and 'instructions/no-overwrite/'.
 
 Implies --tail-synthesize.
 
+--index::
+Build an index table for sample data.  This will speed up perf report by
+parallel processing.
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1]
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9690c1f3e666..1b01cb4d06b8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -108,10 +108,15 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
-static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
+static int record__write(struct record *rec, struct perf_mmap *map,
 			 void *bf, size_t size)
 {
-	struct perf_data_file *file = &rec->session->data->file;
+	struct perf_data_file *file;
+
+	if (rec->opts.index && map)
+		file = map->file;
+	else
+		file = &rec->session->data->file;
 
 	if (perf_data_file__write(file, bf, size) < 0) {
 		pr_err("failed to write perf data, error: %m\n");
@@ -132,6 +137,7 @@ static int process_synthesized_event(struct perf_tool *tool,
 				     struct machine *machine __maybe_unused)
 {
 	struct record *rec = container_of(tool, struct record, tool);
+
 	return record__write(rec, NULL, event, event->header.size);
 }
 
@@ -331,7 +337,7 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode, false) < 0) {
+				 opts->auxtrace_snapshot_mode, opts->index) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -352,6 +358,31 @@ static int record__mmap_evlist(struct record *rec,
 	return 0;
 }
 
+static int record__mmap_index(struct record *rec)
+{
+	struct perf_evlist *evlist = rec->evlist;
+	struct perf_data *data = &rec->data;
+	int i, ret, nr = evlist->nr_mmaps;
+
+	ret = perf_data__create_index(data, nr);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr; i++) {
+		struct perf_mmap *map = &evlist->mmap[i];
+
+		map->file = &data->index[i];
+	}
+
+	for (i = 0; i < nr; i++) {
+		struct perf_mmap *map = &evlist->track_mmap[i];
+
+		map->file = &data->file;
+	}
+
+	return 0;
+}
+
 static int record__mmap(struct record *rec)
 {
 	return record__mmap_evlist(rec, rec->evlist);
@@ -604,7 +635,73 @@ static void record__init_features(struct record *rec)
 		perf_header__clear_feat(&session->header, HEADER_AUXTRACE);
 
 	perf_header__clear_feat(&session->header, HEADER_STAT);
-	perf_header__clear_feat(&session->header, HEADER_DATA_INDEX);
+
+	if (!rec->opts.index)
+		perf_header__clear_feat(&session->header, HEADER_DATA_INDEX);
+}
+
+static int record__merge_index(struct record *rec)
+{
+	struct perf_file_section *idx;
+	struct perf_data *data = &rec->data;
+	struct perf_session *session = rec->session;
+	int output_fd = perf_data__fd(data);
+	int i, nr_index, ret = -ENOMEM;
+	u64 offset;
+
+	/* +1 for header file itself */
+	nr_index = data->index_nr + 1;
+
+	idx = calloc(nr_index, sizeof(*idx));
+	if (idx == NULL)
+		goto out_close;
+
+	offset = lseek(output_fd, 0, SEEK_END);
+
+	idx[0].offset = session->header.data_offset;
+	idx[0].size   = offset - idx[0].offset;
+
+	for (i = 1; i < nr_index; i++) {
+		struct stat stbuf;
+		int fd = data->index[i - 1].fd;
+		char buf[20];
+
+		ret = fstat(fd, &stbuf);
+		if (ret < 0)
+			goto out_close;
+
+		idx[i].offset = offset;
+		idx[i].size   = stbuf.st_size;
+
+		offset += stbuf.st_size;
+
+		if (idx[i].size == 0)
+			continue;
+
+		unit_number__scnprintf(buf, sizeof(buf), idx[i].size);
+		pr_debug("storing index %d, size %s ...", i, buf);
+
+		ret = copyfile_offset(fd, 0, output_fd, idx[i].offset,
+				      idx[i].size);
+		if (ret < 0)
+			goto out_close;
+
+		pr_debug(" ok\n");
+	}
+
+	session->header.index = idx;
+	session->header.nr_index = nr_index;
+
+	perf_has_index = true;
+
+	ret = 0;
+
+out_close:
+	if (ret < 0)
+		pr_err("failed to merge index files: %d\n", ret);
+
+	perf_data__clean_index(data);
+	return ret;
 }
 
 static void
@@ -617,7 +714,11 @@ record__finish_output(struct record *rec)
 		return;
 
 	rec->session->header.data_size += rec->bytes_written;
-	data->size = lseek(perf_data__fd(data), 0, SEEK_CUR);
+
+	if (rec->opts.index)
+		record__merge_index(rec);
+
+	data->size = lseek(perf_data__fd(data), 0, SEEK_END);
 
 	if (!rec->no_buildid) {
 		process_buildids(rec);
@@ -929,11 +1030,22 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (data->is_pipe && rec->evlist->nr_entries == 1)
 		rec->opts.sample_id = true;
 
+	if (data->is_pipe && opts->index) {
+		pr_warning("Indexing is disabled for pipe output\n");
+		opts->index = false;
+	}
+
 	if (record__open(rec) != 0) {
 		err = -1;
 		goto out_child;
 	}
 
+	if (opts->index) {
+		err = record__mmap_index(rec);
+		if (err)
+			goto out_child;
+	}
+
 	err = bpf__apply_obj_config();
 	if (err) {
 		char errbuf[BUFSIZ];
@@ -1693,6 +1805,8 @@ static struct option __record_options[] = {
 			  "signal"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "Parse options then exit"),
+	OPT_BOOLEAN(0, "index", &record.opts.index,
+		    "make index for sample data to speed-up processing"),
 	OPT_END()
 };
 
@@ -1841,6 +1955,16 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	if (rec->opts.index) {
+		if (!rec->opts.sample_time) {
+			pr_err("Sample timestamp is required for indexing\n");
+			goto out;
+		}
+
+		perf_evlist__add_dummy_tracking(rec->evlist);
+	}
+
+
 	if (rec->opts.target.tid && !rec->opts.no_inherit_set)
 		rec->opts.no_inherit = true;
 
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index fba61cc5291f..4fd26c05a2d8 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -68,6 +68,7 @@ struct record_opts {
 	bool	     ignore_missing_thread;
 	bool	     strict_freq;
 	bool	     sample_id;
+	bool	     index;
 	unsigned int freq;
 	unsigned int mmap_pages;
 	unsigned int auxtrace_mmap_pages;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 9d2672d8f131..bad05b12b9df 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -15,17 +15,18 @@
  * @refcnt - e.g. code using PERF_EVENT_IOC_SET_OUTPUT to share this
  */
 struct perf_mmap {
-	void		 *base;
-	int		 mask;
-	int		 fd;
-	int		 cpu;
-	refcount_t	 refcnt;
-	u64		 prev;
-	u64		 start;
-	u64		 end;
-	bool		 overwrite;
-	struct auxtrace_mmap auxtrace_mmap;
-	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	void			 *base;
+	int			 mask;
+	int			 fd;
+	int			 cpu;
+	refcount_t		 refcnt;
+	u64			 prev;
+	u64			 start;
+	u64			 end;
+	bool			 overwrite;
+	struct auxtrace_mmap	 auxtrace_mmap;
+	struct perf_data_file	*file;
+	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
 
 /*
-- 
2.17.1

