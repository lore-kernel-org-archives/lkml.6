Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C2CC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1105220854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1105220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeIMSEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbeIMSEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81CAD3082E64;
        Thu, 13 Sep 2018 12:55:20 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3AFB600C6;
        Thu, 13 Sep 2018 12:55:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 12/48] perf tools: Add perf_data__create_index function
Date:   Thu, 13 Sep 2018 14:54:14 +0200
Message-Id: <20180913125450.21342-13-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 13 Sep 2018 12:55:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_data__create_index function to create
and open index files within perf_data struct.

Link: http://lkml.kernel.org/n/tip-kl4s1f13cg6wycrg367p85qm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c | 64 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/data.h |  5 ++++
 2 files changed, 69 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index d8cfc19ddb10..b856accfdace 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -187,3 +187,67 @@ int perf_data__switch(struct perf_data *data,
 	free(new_filepath);
 	return ret;
 }
+
+static void free_index(struct perf_data_file *index, int nr)
+{
+	while (--nr >= 1) {
+		close(index[nr].fd);
+		free((char *) index[nr].path);
+	}
+	free(index);
+}
+
+static void clean_index(struct perf_data *data,
+			struct perf_data_file *index,
+			int index_nr)
+{
+	char path[PATH_MAX];
+
+	scnprintf(path, sizeof(path), "%s.dir", data->file.path);
+	rm_rf(path);
+
+	free_index(index, index_nr);
+}
+
+void perf_data__clean_index(struct perf_data *data)
+{
+	clean_index(data, data->index, data->index_nr);
+}
+
+int perf_data__create_index(struct perf_data *data, int nr)
+{
+	struct perf_data_file *index;
+	char path[PATH_MAX];
+	int ret = -1, i = 0;
+
+	index = malloc(nr * sizeof(*index));
+	if (!index)
+		return -ENOMEM;
+
+	data->index    = index;
+	data->index_nr = nr;
+
+	scnprintf(path, sizeof(path), "%s.dir", data->file.path);
+	if (rm_rf(path) < 0 || mkdir(path, S_IRWXU) < 0)
+		goto out_err;
+
+	for (; i < nr; i++) {
+		struct perf_data_file *file = &index[i];
+
+		if (asprintf((char **) &file->path, "%s.dir/perf.data.%d",
+			     data->file.path, i) < 0)
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
+	clean_index(data, index, i);
+	return ret;
+}
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 4828f7feea89..33b62c30b053 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -20,6 +20,8 @@ struct perf_data {
 	bool			 force;
 	unsigned long		 size;
 	enum perf_data_mode	 mode;
+	struct perf_data_file	*index;
+	int			 index_nr;
 };
 
 static inline bool perf_data__is_read(struct perf_data *data)
@@ -63,4 +65,7 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
 int perf_data__switch(struct perf_data *data,
 			   const char *postfix,
 			   size_t pos, bool at_exit);
+int perf_data__create_index(struct perf_data *data,
+			    int nr);
+void perf_data__clean_index(struct perf_data *data);
 #endif /* __PERF_DATA_H */
-- 
2.17.1

