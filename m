Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93DDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F1B206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035316;
	bh=aip1VVgmo65otjfoYj3+gbY5wlGMK6VB/7C3zuKsE5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uhluME/zXYMYaRMokmk6Iu0622+czDdZk/K8pZFGZLDpVUVP/X07YOL3ESCoACFsb
	 bdQnHnsFsox/6RsQEimDQidFjxn8iiT8NoGRXhtMZaVo9VkqcwZxxN+WU6s9Bc+iq3
	 zWvY88XbjV9wU2s+B7xmcC6qEF7NbPV4neIfu7d0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfBXTHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbfBXTH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B3C9C04BD22;
        Sun, 24 Feb 2019 19:07:27 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9198F6013A;
        Sun, 24 Feb 2019 19:07:24 +0000 (UTC)
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
Subject: [PATCH 08/20] perf data: Add perf_data__(create_dir|close_dir) functions
Date:   Sun, 24 Feb 2019 20:06:44 +0100
Message-Id: <20190224190656.30163-9-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 24 Feb 2019 19:07:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_data__create_dir to create nr files inside
struct perf_data path directory:
  int perf_data__create_dir(struct perf_data *data, int nr);

and function to close that data:
  void perf_data__close_dir(struct perf_data *data);

Link: http://lkml.kernel.org/n/tip-kl4s1f13cg6wycrg367p85qm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/data.h |  8 +++++++
 2 files changed, 55 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index d008c3973012..005b3909d1dc 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -7,11 +7,58 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <string.h>
+#include <asm/bug.h>
 
 #include "data.h"
 #include "util.h"
 #include "debug.h"
 
+static void close_dir(struct perf_data_file *files, int nr)
+{
+	while (--nr >= 1) {
+		close(files[nr].fd);
+		free(files[nr].path);
+	}
+	free(files);
+}
+
+void perf_data__close_dir(struct perf_data *data)
+{
+	close_dir(data->dir.files, data->dir.nr);
+}
+
+int perf_data__create_dir(struct perf_data *data, int nr)
+{
+	struct perf_data_file *files = NULL;
+	int i, ret = -1;
+
+	files = zalloc(nr * sizeof(*files));
+	if (!files)
+		return -ENOMEM;
+
+	data->dir.files = files;
+	data->dir.nr    = nr;
+
+	for (i = 0; i < nr; i++) {
+		struct perf_data_file *file = &files[i];
+
+		if (asprintf(&file->path, "%s/data.%d", data->path, i) < 0)
+			goto out_err;
+
+		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
+		if (ret < 0)
+			goto out_err;
+
+		file->fd = ret;
+	}
+
+	return 0;
+
+out_err:
+	close_dir(files, i);
+	return ret;
+}
+
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 2bce28117ccf..2d0d015a7d4d 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -21,6 +21,11 @@ struct perf_data {
 	bool			 is_pipe;
 	bool			 force;
 	enum perf_data_mode	 mode;
+
+	struct {
+		struct perf_data_file	*files;
+		int			 nr;
+	} dir;
 };
 
 static inline bool perf_data__is_read(struct perf_data *data)
@@ -64,4 +69,7 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
 int perf_data__switch(struct perf_data *data,
 			   const char *postfix,
 			   size_t pos, bool at_exit);
+
+int perf_data__create_dir(struct perf_data *data, int nr);
+void perf_data__close_dir(struct perf_data *data);
 #endif /* __PERF_DATA_H */
-- 
2.17.2

