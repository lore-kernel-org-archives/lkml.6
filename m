Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48CBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718A220880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550742125;
	bh=N7El6gUWsl25EOlTnmY/tSvN6CEGPECghYidAK9ATmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eN5kX3pHWAKK8J1tj1FOQvLrjVgCy5yz9JcF3YZOKzGhlpp53YW+omhS4qi+SSZ/f
	 aTsPMhZdS89WTWiE3B44A/rWGCt512vrqzcG1CsVew2kh81sxRYXs3idvjkxbk0sWV
	 ouVYuGrAhwDcPn0T/0ZXWUmVwCzd1Nd1ghlg1uuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfBUJmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:42:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfBUJmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:42:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96922308AA1F;
        Thu, 21 Feb 2019 09:42:00 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69D9260BE6;
        Thu, 21 Feb 2019 09:41:58 +0000 (UTC)
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
Subject: [PATCH 05/17] perf data: Add perf_data__(create_dir|close_dir) functions
Date:   Thu, 21 Feb 2019 10:41:33 +0100
Message-Id: <20190221094145.9151-6-jolsa@kernel.org>
In-Reply-To: <20190221094145.9151-1-jolsa@kernel.org>
References: <20190221094145.9151-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 21 Feb 2019 09:42:00 +0000 (UTC)
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
index 18e5d94b0e97..7f13fbd9c043 100644
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

