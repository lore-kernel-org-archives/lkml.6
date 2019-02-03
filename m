Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A324EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F1620823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207869;
	bh=EdjFCl5Dr3HwAZXnPIiyvJoQ8eG7WDA2PxtrvdEtRPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oBvDNpRXx8zTd6pfxWT1+i6jn++D8LN0HLO9DAu54tue8Zpwpo/IMLvbH2o0s2US+
	 ndPOX6hiq6NnBiLTrM/34KmRnAVg9R0abvB+tBT90AEdTsog9XXRTGXkOKUuBB9GvM
	 epotNxTlKEpJBdiu1gJV7hbokYGcJby4+xZ3N/pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfBCPbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:31:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbfBCPbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:31:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 671DAC04BD2F;
        Sun,  3 Feb 2019 15:31:04 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEF3C5C238;
        Sun,  3 Feb 2019 15:31:01 +0000 (UTC)
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
Subject: [PATCH 14/14] perf record: Add --dir option to store data in directory
Date:   Sun,  3 Feb 2019 16:30:18 +0100
Message-Id: <20190203153018.9650-15-jolsa@kernel.org>
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 03 Feb 2019 15:31:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --dir option to store data in directory. It's next
step for multiple threads in record. It's not possible
to make directory data via --dir option, like:

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

Link: http://lkml.kernel.org/n/tip-0kjm8wpglzu2tm18tpagfm4d@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |  3 ++
 tools/perf/builtin-record.c              | 59 ++++++++++++++++++++++--
 tools/perf/util/mmap.h                   | 23 ++++-----
 3 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d232b13ea713..8dcdc8cabcad 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -505,6 +505,9 @@ config terms. For example: 'cycles/overwrite/' and 'instructions/no-overwrite/'.
 
 Implies --tail-synthesize.
 
+--dir::
+Store data into directory with one data file for cpu.
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1]
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cd02ab3ec4ff..87e39b9cc7bd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -111,17 +111,21 @@ static bool switch_output_time(struct record *rec)
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
 		return -1;
 	}
 
-	rec->bytes_written += size;
+	if (file == &rec->data.file)
+		rec->bytes_written += size;
 
 	if (switch_output_size(rec))
 		trigger_hit(&switch_output_trigger);
@@ -563,6 +567,25 @@ static int record__mmap_evlist(struct record *rec,
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
@@ -792,8 +815,12 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
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
@@ -851,6 +878,9 @@ record__finish_output(struct record *rec)
 	rec->session->header.data_size += rec->bytes_written;
 	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
 
+	if (perf_data__is_dir(data))
+		perf_data__update_dir(data);
+
 	if (!rec->no_buildid) {
 		process_buildids(rec);
 
@@ -1170,11 +1200,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
@@ -1962,6 +2004,8 @@ static struct option __record_options[] = {
 		     &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
 		     record__aio_parse),
 #endif
+	OPT_BOOLEAN(0, "dir", &record.data.is_dir,
+		    "Store data into directory perf.data"),
 	OPT_END()
 };
 
@@ -2113,6 +2157,13 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	if (perf_data__is_dir(&rec->data)) {
+		if (!rec->opts.sample_time) {
+			pr_err("Sample timestamp is required for indexing\n");
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

