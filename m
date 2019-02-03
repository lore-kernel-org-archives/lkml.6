Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD44C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A4B20823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207887;
	bh=LyqGGd72daLdAUUznN/Tn38sPYbOjwDTRM+qGjbdOsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IvRuFPf5KD7DABMiBqrHaYEd1gLtikCcfQ8mURmBI0nu9MNXBm+edIjZLnHr+ku1S
	 FZNqUWYRFGGiWNnvtfcBUufUHCjDU0cIZdhINfUCSMeygSfE92grS1hlAUe6lfFq0M
	 8zktthmJh59MbWTkgF51xZBBC4f8/z4z8sIM5ktk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfBCPbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:31:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbfBCPao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:30:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD9A3356E7;
        Sun,  3 Feb 2019 15:30:43 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C2D65C23D;
        Sun,  3 Feb 2019 15:30:41 +0000 (UTC)
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
Subject: [PATCH 07/14] perf data: Add perf_data__open_dir_data function
Date:   Sun,  3 Feb 2019 16:30:11 +0100
Message-Id: <20190203153018.9650-8-jolsa@kernel.org>
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 03 Feb 2019 15:30:44 +0000 (UTC)
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
 tools/perf/util/data.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index ff1d9e5bd68d..7c37b67fbc3c 100644
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
@@ -59,6 +61,64 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	return ret;
 }
 
+__maybe_unused
+static int perf_data__open_dir(struct perf_data *data)
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
+	free_dir(files, nr);
+	return ret;
+}
+
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
-- 
2.17.2

