Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27C7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2056217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551170944;
	bh=y+kjwX7HQHt0PHQUZl//8HGUrYUBZhWEKQJiyhX1FyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZWsVDugNe/owgBrdb1LhYUjVwJ9j+PAgKBXyd0lLNWxikHC5crisnSghpw6XUCru+
	 POADMID2loNmHvbo9WsIEqnz9DuGf4pMplnmBC7fam0H1B7rvWJ6HTpwGllUenbrRl
	 LZlTqO8NH7/jdtCenslwT04dgeEGVD6RIHQuNPPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfBZItD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:49:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfBZItC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:49:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E3A33DE08;
        Tue, 26 Feb 2019 08:49:01 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CAF81001DDF;
        Tue, 26 Feb 2019 08:48:59 +0000 (UTC)
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
Subject: [PATCH 01/11] perf data: Add directory support
Date:   Tue, 26 Feb 2019 09:48:45 +0100
Message-Id: <20190226084855.6340-2-jolsa@kernel.org>
In-Reply-To: <20190226084855.6340-1-jolsa@kernel.org>
References: <20190226084855.6340-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 26 Feb 2019 08:49:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to have directory as perf.data.

The caller needs to set 'struct perf_data::is_dir flag
and the path will be treated as directory.

The 'struct perf_data::file' is initialized and open
as 'path/header' file.

Adding check to direcory interface functions to check
on is_dir flag.

Link: http://lkml.kernel.org/n/tip-pvot1aywiem9epgqpfi1agaj@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c    | 49 ++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/data.h    |  6 +++++
 tools/perf/util/session.c |  4 ++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 7bd5ddeb7a41..a2d089876d79 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -34,6 +34,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	struct perf_data_file *files = NULL;
 	int i, ret = -1;
 
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
 	files = zalloc(nr * sizeof(*files));
 	if (!files)
 		return -ENOMEM;
@@ -69,6 +72,9 @@ int perf_data__open_dir(struct perf_data *data)
 	DIR *dir;
 	int nr = 0;
 
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
 	dir = opendir(data->path);
 	if (!dir)
 		return -EINVAL;
@@ -173,6 +179,16 @@ static int check_backup(struct perf_data *data)
 	return 0;
 }
 
+static bool is_dir(struct perf_data *data)
+{
+	struct stat st;
+
+	if (stat(data->path, &st))
+		return false;
+
+	return (st.st_mode & S_IFMT) == S_IFDIR;
+}
+
 static int open_file_read(struct perf_data *data)
 {
 	struct stat st;
@@ -254,6 +270,30 @@ static int open_file_dup(struct perf_data *data)
 	return open_file(data);
 }
 
+static int open_dir(struct perf_data *data)
+{
+	int ret;
+
+	/*
+	 * So far we open only the header, so we
+	 * can read the data version and layout.
+	 */
+	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
+		return -ENOMEM;
+
+	if (perf_data__is_write(data) &&
+	    mkdir(data->path, S_IRWXU) < 0)
+		return -1;
+
+	ret = open_file(data);
+
+	/* Cleanup whatever we managed to create so far. */
+	if (ret && perf_data__is_write(data))
+		rm_rf_perf_data(data->path);
+
+	return ret;
+}
+
 int perf_data__open(struct perf_data *data)
 {
 	if (check_pipe(data))
@@ -265,11 +305,18 @@ int perf_data__open(struct perf_data *data)
 	if (check_backup(data))
 		return -1;
 
-	return open_file_dup(data);
+	if (perf_data__is_read(data))
+		data->is_dir = is_dir(data);
+
+	return perf_data__is_dir(data) ?
+	       open_dir(data) : open_file_dup(data);
 }
 
 void perf_data__close(struct perf_data *data)
 {
+	if (perf_data__is_dir(data))
+		perf_data__close_dir(data);
+
 	free(data->file.path);
 	close(data->file.fd);
 }
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 14b47be2bd69..06aefeda311f 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -19,6 +19,7 @@ struct perf_data {
 	const char		*path;
 	struct perf_data_file	 file;
 	bool			 is_pipe;
+	bool			 is_dir;
 	bool			 force;
 	enum perf_data_mode	 mode;
 
@@ -43,6 +44,11 @@ static inline int perf_data__is_pipe(struct perf_data *data)
 	return data->is_pipe;
 }
 
+static inline bool perf_data__is_dir(struct perf_data *data)
+{
+	return data->is_dir;
+}
+
 static inline int perf_data__fd(struct perf_data *data)
 {
 	return data->file.fd;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c764bbc91009..9991e9a8bc12 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -152,6 +152,10 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			}
 
 			perf_evlist__init_trace_event_sample_raw(session->evlist);
+
+			/* Open the directory data. */
+			if (data->is_dir && perf_data__open_dir(data))
+				goto out_close;
 		}
 	} else  {
 		session->machines.host.env = &perf_env;
-- 
2.17.2

