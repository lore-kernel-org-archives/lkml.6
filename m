Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFC5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CB9206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035285;
	bh=N000AXNCVGLdESl+Kfo8je2fAK+pO950EWp3imBo53Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nuoOZSgelYytENevGcPNEyCA7zyyBj2U5pYQHG7eTm08mJttWIBtwkkdEbHNrEHLD
	 T6wWntS7E3lZWlx5CwlejiDIkxI2l/E1y+xaU1MGvufidNVuB/5xpHr6T8zO3fAiWi
	 yQkcHKpDgwZz9u3ajaLjle8+FUkI8T7Kn5FkJEWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfBXTIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:08:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbfBXTIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:08:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9D9AC057F40;
        Sun, 24 Feb 2019 19:08:01 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC1536013A;
        Sun, 24 Feb 2019 19:07:58 +0000 (UTC)
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
Subject: [PATCH 18/20] perf record: Add --dir option to store data in directory
Date:   Sun, 24 Feb 2019 20:06:54 +0100
Message-Id: <20190224190656.30163-19-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 24 Feb 2019 19:08:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --dir option to store data in directory. It's next
step for multiple threads in record. It's now possible to
make directory data via --dir option, like:

  $ perf record --dir perf bench sched messaging
  $ ls -l perf.data
  total 344
  -rw-------. 1 jolsa jolsa 43864 Jan 20 22:26 data.0
  -rw-------. 1 jolsa jolsa 30464 Jan 20 22:26 data.1
  -rw-------. 1 jolsa jolsa 53816 Jan 20 22:26 data.2
  -rw-------. 1 jolsa jolsa 30368 Jan 20 22:26 data.3
  -rw-------. 1 jolsa jolsa 40088 Jan 20 22:26 data.4
  -rw-------. 1 jolsa jolsa 42592 Jan 20 22:26 data.5
  -rw-------. 1 jolsa jolsa 56136 Jan 20 22:26 data.6
  -rw-------. 1 jolsa jolsa 25992 Jan 20 22:26 data.7
  -rw-------. 1 jolsa jolsa  8832 Jan 20 22:26 header

There's a data file created for every cpu and it's storing
data for those cpu maps.

It's possible to transform directory data into standard
perf.data file via following inject command:

  $ perf inject -o perf.data.file -i perf.data

The --dir option enabled DIR_FORMAT feature to be stored
in header file to indicate the directory layout.

Don't allow to use --dir with --aio yet. It needs
to be investigated first.

Link: http://lkml.kernel.org/n/tip-0kjm8wpglzu2tm18tpagfm4d@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |  3 +
 tools/perf/builtin-record.c              | 80 ++++++++++++++++++++++--
 tools/perf/util/mmap.h                   | 23 +++----
 3 files changed, 90 insertions(+), 16 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 8f0c2be34848..445b7a4eb130 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -524,6 +524,9 @@ config terms. For example: 'cycles/overwrite/' and 'instructions/no-overwrite/'.
 
 Implies --tail-synthesize.
 
+--dir::
+Store data into directory with one data file for cpu.
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1]
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a468d882e74f..26981be13aa0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -112,10 +112,13 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
-static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
+static int record__write(struct record *rec, struct perf_mmap *map,
 			 void *bf, size_t size)
 {
-	struct perf_data_file *file = &rec->session->data->file;
+	struct perf_data_file *file = &rec->data.file;
+
+	if (map && map->file)
+		file = map->file;
 
 	if (perf_data_file__write(file, bf, size) < 0) {
 		pr_err("failed to write perf data, error: %m\n");
@@ -124,6 +127,15 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
 
 	rec->bytes_written += size;
 
+	/*
+	 * Update header file size manualy, data files size are
+	 * ok to be updated by stat command, but header files
+	 * contains more stuff, so we need to track data size
+	 * manualy.
+	 */
+	if (file == &rec->data.file)
+		rec->session->header.data_size += size;
+
 	if (switch_output_size(rec))
 		trigger_hit(&switch_output_trigger);
 
@@ -247,6 +259,7 @@ static int record__aio_pushfn(void *to, struct aiocb *cblock, void *bf, size_t s
 	ret = record__aio_write(cblock, trace_fd, bf, size, off);
 	if (!ret) {
 		rec->bytes_written += size;
+		rec->session->header.data_size += size;
 		if (switch_output_size(rec))
 			trigger_hit(&switch_output_trigger);
 	}
@@ -564,6 +577,25 @@ static int record__mmap_evlist(struct record *rec,
 	return 0;
 }
 
+static int record__mmap_dir_data(struct record *rec)
+{
+	struct perf_evlist *evlist = rec->evlist;
+	struct perf_data *data = &rec->data;
+	int i, ret, nr = evlist->nr_mmaps;
+
+	ret = perf_data__create_dir(data, nr);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr; i++) {
+		struct perf_mmap *map = &evlist->mmap[i];
+
+		map->file = &data->dir.files[i];
+	}
+
+	return 0;
+}
+
 static int record__mmap(struct record *rec)
 {
 	return record__mmap_evlist(rec, rec->evlist);
@@ -793,8 +825,12 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	/*
 	 * Mark the round finished in case we wrote
 	 * at least one event.
+	 *
+	 * No need for round events in directory mode,
+	 * because per-cpu files/maps have sorted data
+	 * from kernel.
 	 */
-	if (bytes_written != rec->bytes_written)
+	if (!perf_data__is_dir(&rec->data) && bytes_written != rec->bytes_written)
 		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
 
 	if (overwrite)
@@ -837,7 +873,8 @@ static void record__init_features(struct record *rec)
 	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
 		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
 
-	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+	if (!perf_data__is_dir(session->data))
+		perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
 
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
@@ -851,9 +888,11 @@ record__finish_output(struct record *rec)
 	if (data->is_pipe)
 		return;
 
-	rec->session->header.data_size += rec->bytes_written;
 	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
 
+	if (perf_data__is_dir(data))
+		perf_data__update_dir(data);
+
 	if (!rec->no_buildid) {
 		process_buildids(rec);
 
@@ -924,6 +963,12 @@ record__switch_output(struct record *rec, bool at_exit)
 
 	/* Output tracking events */
 	if (!at_exit) {
+		if (perf_data__is_dir(data)) {
+			err = record__mmap_dir_data(rec);
+			if (err)
+				return -1;
+		}
+
 		record__synthesize(rec, false);
 
 		/*
@@ -1173,11 +1218,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (data->is_pipe && rec->evlist->nr_entries == 1)
 		rec->opts.sample_id = true;
 
+	if (data->is_pipe && perf_data__is_dir(data)) {
+		pr_err("Directory output is not allowed for pipe output\n");
+		err = -1;
+		goto out_child;
+	}
+
 	if (record__open(rec) != 0) {
 		err = -1;
 		goto out_child;
 	}
 
+	if (perf_data__is_dir(data)) {
+		err = record__mmap_dir_data(rec);
+		if (err)
+			goto out_child;
+	}
+
 	err = bpf__apply_obj_config();
 	if (err) {
 		char errbuf[BUFSIZ];
@@ -1983,6 +2040,8 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
 		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
 		     record__parse_affinity),
+	OPT_BOOLEAN(0, "dir", &record.data.is_dir,
+		    "Store data into directory perf.data"),
 	OPT_END()
 };
 
@@ -2134,6 +2193,17 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	if (perf_data__is_dir(&rec->data)) {
+		if (!rec->opts.sample_time) {
+			pr_err("Sample timestamp is required for indexing\n");
+			goto out;
+		}
+		if (record__aio_enabled(rec)) {
+			pr_err("Cannot use both --dir and --aio yet.\n");
+			goto out;
+		}
+	}
+
 	if (rec->opts.target.tid && !rec->opts.no_inherit_set)
 		rec->opts.no_inherit = true;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e566c19b242b..3e8595a8d6ce 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -19,17 +19,18 @@ struct aiocb;
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
 #ifdef HAVE_AIO_SUPPORT
 	struct {
 		void		 **data;
-- 
2.17.2

