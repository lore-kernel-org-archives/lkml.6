Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B2BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DBD20663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035260;
	bh=bRSWTKi7EpCTPqtdRQUMUxx/RK8PrXRO653vwtH7tnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZZAgxwwqxLFeFrs3x6yos+we4DFNsoVUv9kiAImW94J/p2WmR2v4+YTkzLwrWWAM7
	 uVASwqDE9TGG7A2CeKja7hFAARPnON9tshi5Sz45eQw/0FWF41bTdAIWWFayR5FBET
	 uUbz4D8VmAO1aFNOXFra4sYZ6IBsERBL5P7pu7JU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfBXTHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbfBXTHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A45983DE05;
        Sun, 24 Feb 2019 19:07:30 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECEEA6013A;
        Sun, 24 Feb 2019 19:07:27 +0000 (UTC)
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
Subject: [PATCH 09/20] perf data: Add perf_data__open_dir_data function
Date:   Sun, 24 Feb 2019 20:06:45 +0100
Message-Id: <20190224190656.30163-10-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 24 Feb 2019 19:07:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_data__open_dir_data to open files inside
struct perf_data path directory:
   static int perf_data__open_dir(struct perf_data *data);

Link: http://lkml.kernel.org/n/tip-sv97z5mh9j273mz2cthzaq4n@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c | 59 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/data.h |  1 +
 2 files changed, 60 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 005b3909d1dc..7bd5ddeb7a41 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -8,6 +8,8 @@
 #include <unistd.h>
 #include <string.h>
 #include <asm/bug.h>
+#include <sys/types.h>
+#include <dirent.h>
 
 #include "data.h"
 #include "util.h"
@@ -59,6 +61,63 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	return ret;
 }
 
+int perf_data__open_dir(struct perf_data *data)
+{
+	struct perf_data_file *files = NULL;
+	struct dirent *dent;
+	int ret = -1;
+	DIR *dir;
+	int nr = 0;
+
+	dir = opendir(data->path);
+	if (!dir)
+		return -EINVAL;
+
+	while ((dent = readdir(dir)) != NULL) {
+		struct perf_data_file *file;
+		char path[PATH_MAX];
+		struct stat st;
+
+		snprintf(path, sizeof(path), "%s/%s", data->path, dent->d_name);
+		if (stat(path, &st))
+			continue;
+
+		if (!S_ISREG(st.st_mode) || strncmp(dent->d_name, "data", 4))
+			continue;
+
+		ret = -ENOMEM;
+
+		file = realloc(files, (nr + 1) * sizeof(*files));
+		if (!file)
+			goto out_err;
+
+		files = file;
+		file = &files[nr++];
+
+		file->path = strdup(path);
+		if (!file->path)
+			goto out_err;
+
+		ret = open(file->path, O_RDONLY);
+		if (ret < 0)
+			goto out_err;
+
+		file->fd = ret;
+		file->size = st.st_size;
+	}
+
+	if (!files)
+		return -EINVAL;
+
+	data->dir.files = files;
+	data->dir.nr    = nr;
+	return 0;
+
+out_err:
+	close_dir(files, nr);
+	return ret;
+}
+
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 2d0d015a7d4d..14b47be2bd69 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -71,5 +71,6 @@ int perf_data__switch(struct perf_data *data,
 			   size_t pos, bool at_exit);
 
 int perf_data__create_dir(struct perf_data *data, int nr);
+int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
 #endif /* __PERF_DATA_H */
-- 
2.17.2

