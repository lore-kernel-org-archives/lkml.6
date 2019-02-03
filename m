Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85600C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526AC20823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207850;
	bh=PVnGcfiZP1KJstYwXRk5u+j1nhqiJNULxGQJ6JjxQoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YI7f12KtvAm0hhiWRl1BnnEpjW2kCJLClzcm6EsT2L4yPqBZLQ1736IIyy4niFbo4
	 r0e+2D4Cg3+Gx5l2i9IuKpCwznVuwtkp3jzaVkZjJMCN0fellxRM1FObsInabwDd7i
	 XUaYvRSL9sY+BTbzwDVSB9AMQkPgLr7UstTBtIMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfBCPat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:30:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfBCPar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:30:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93C1919D32D;
        Sun,  3 Feb 2019 15:30:46 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 274525C238;
        Sun,  3 Feb 2019 15:30:43 +0000 (UTC)
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
Subject: [PATCH 08/14] perf data: Add directory support
Date:   Sun,  3 Feb 2019 16:30:12 +0100
Message-Id: <20190203153018.9650-9-jolsa@kernel.org>
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 03 Feb 2019 15:30:46 +0000 (UTC)
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
 tools/perf/util/data.c | 39 +++++++++++++++++++++++++++++++++++++--
 tools/perf/util/data.h |  6 ++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 7c37b67fbc3c..59c052454fac 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -34,6 +34,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	struct perf_data_file *files = NULL;
 	int i, ret = -1;
 
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
 	files = malloc(nr * sizeof(*files));
 	if (!files)
 		return -ENOMEM;
@@ -61,7 +64,6 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	return ret;
 }
 
-__maybe_unused
 static int perf_data__open_dir(struct perf_data *data)
 {
 	struct perf_data_file *files = NULL;
@@ -70,6 +72,9 @@ static int perf_data__open_dir(struct perf_data *data)
 	DIR *dir;
 	int nr = 0;
 
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
 	dir = opendir(data->path);
 	if (!dir)
 		return -EINVAL;
@@ -159,6 +164,16 @@ static int check_backup(struct perf_data *data)
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
@@ -240,6 +255,22 @@ static int open_file_dup(struct perf_data *data)
 	return open_file(data);
 }
 
+static int open_dir(struct perf_data *data)
+{
+	if (perf_data__is_write(data)) {
+		if (mkdir(data->path, S_IRWXU) < 0)
+			return -1;
+	} else {
+		if (perf_data__open_dir(data))
+			return -1;
+	}
+
+	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
+		return -ENOMEM;
+
+	return open_file(data);
+}
+
 int perf_data__open(struct perf_data *data)
 {
 	if (check_pipe(data))
@@ -251,7 +282,11 @@ int perf_data__open(struct perf_data *data)
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
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 3b4115dc777f..a1edf7e03a71 100644
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
-- 
2.17.2

