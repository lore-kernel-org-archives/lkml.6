Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2436020880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550742128;
	bh=puoiQOFXqQ90Fuzy4GwiOMQrBa2eGB5WTV6QOq+Xq3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w5QGmY43IiGUhysBzuNux0S1fv0c+DT/pZpI+/8w2FbAXU2W6AUGW6Cr/LVN6nzLx
	 8s83bLbw4v1Bv7AoKP0DuhFViBAw1qDcywnd1I3DxDQ3fUwsxlN1P4VcHgnJoYWSNJ
	 W/sh1ocv0boz8QdPQjZ59UX7t6aKLP1HZC6ZFfQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfBUJmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:42:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727625AbfBUJmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:42:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FCFE8553B;
        Thu, 21 Feb 2019 09:42:03 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E190A60BE6;
        Thu, 21 Feb 2019 09:42:00 +0000 (UTC)
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
Subject: [PATCH 06/17] perf data: Add perf_data__open_dir_data function
Date:   Thu, 21 Feb 2019 10:41:34 +0100
Message-Id: <20190221094145.9151-7-jolsa@kernel.org>
In-Reply-To: <20190221094145.9151-1-jolsa@kernel.org>
References: <20190221094145.9151-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 21 Feb 2019 09:42:03 +0000 (UTC)
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
index 7f13fbd9c043..d9e766a16e70 100644
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

