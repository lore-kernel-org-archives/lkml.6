Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49F2C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B284A20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131621;
	bh=R/lV/fiJuZHHtoP8pb14tsfg/RG9UWD1k2Pr7vPXdWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rxZ3iUVtZNKbkl9Y/oFE1jCrfcK1VkX/wJcNxpbY0gDbUq+FPPHmlek3QZf2Crhq/
	 M8Kan6ykes45UsQBmJJuDMtmGWEnCh5lyGc/vJQNGbtzKhZ2csZ+i7wXqKeqWXHAOf
	 jTwEoLG4Hmhe21naDVUclZ6G8EVyAqhbcajYkQ5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfBYVxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730848AbfBYVWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:23 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB12A2186A;
        Mon, 25 Feb 2019 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129741;
        bh=R/lV/fiJuZHHtoP8pb14tsfg/RG9UWD1k2Pr7vPXdWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AssERg7Dd65iIylzeI1zXvfhceS8A/doYEEtdDdzywlvFAUJa8kK99GnH1KlRiDnA
         LtdEEOD9HuYRXJoPmnLuXdOVWYzMKHIZBBAGQXoTOyioY4Xrl/ITfwq1O6CHK7A36Z
         yB6Jr1ThMVxJDMQ2VduVOSwIFrfRCdFGkYZiE1z0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/37] perf data: Add perf_data__open_dir_data function
Date:   Mon, 25 Feb 2019 18:20:23 -0300
Message-Id: <20190225212035.24781-26-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add perf_data__open_dir_data to open files inside 'struct perf_data'
path directory:

   static int perf_data__open_dir(struct perf_data *data);

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

