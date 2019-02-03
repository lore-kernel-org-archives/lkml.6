Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ED2C282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D552A217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207846;
	bh=0cdFBXvkAbI7qNkRJVmMh2rwlr7Vowa+yRhPZH37lOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kPulvSJn0o64Qfh5X5b4p/kI8G/MWlq1qFt2CzRvQJpdSyTtK0SoJo52nkYKBGviN
	 6Nit2hh4bCDan+Sy5J5rS2Iq0VzGZzNGD300cNuP9/h4euAQhjHQUQtg3O4SUJBhC7
	 Gnvquo4Ta2bZ83M2SyODt6am+Mz9ZKqK2vRWSGfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfBCPap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:30:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfBCPal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:30:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F00C14E916;
        Sun,  3 Feb 2019 15:30:40 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E91C5C238;
        Sun,  3 Feb 2019 15:30:38 +0000 (UTC)
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
Subject: [PATCH 06/14] perf data: Add perf_data__(create_dir|free_dir) functions
Date:   Sun,  3 Feb 2019 16:30:10 +0100
Message-Id: <20190203153018.9650-7-jolsa@kernel.org>
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 03 Feb 2019 15:30:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_data__create_dir to create nr files inside
struct perf_data path directory:
  int perf_data__create_dir(struct perf_data *data, int nr);

and function to free that data:
  void perf_data__free_dir(struct perf_data *data);

Link: http://lkml.kernel.org/n/tip-kl4s1f13cg6wycrg367p85qm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/data.h |  8 +++++++
 2 files changed, 55 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 0a3051cc0ea0..ff1d9e5bd68d 100644
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
 
+static void free_dir(struct perf_data_file *files, int nr)
+{
+	while (--nr >= 1) {
+		close(files[nr].fd);
+		free(files[nr].path);
+	}
+	free(files);
+}
+
+void perf_data__free_dir(struct perf_data *data)
+{
+	free_dir(data->dir.files, data->dir.nr);
+}
+
+int perf_data__create_dir(struct perf_data *data, int nr)
+{
+	struct perf_data_file *files = NULL;
+	int i, ret = -1;
+
+	files = malloc(nr * sizeof(*files));
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
+	free_dir(files, i);
+	return ret;
+}
+
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 2bce28117ccf..3b4115dc777f 100644
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
+void perf_data__free_dir(struct perf_data *data);
 #endif /* __PERF_DATA_H */
-- 
2.17.2

