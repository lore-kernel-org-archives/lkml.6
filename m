Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20329C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFD9217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551170990;
	bh=Qxg49GMxcUAnJI22oD2BAKMRqDi4+5LBzfyG/H8ZNSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EUJ7w2EyUZxpR/o/V6XGf1RfUKhL3XS/bllUo/bSaSQTrrmtgalnyfeaAe3DoIxeH
	 YNLl9aNWEMUHysmyg1pRIDfXiljbUZ6N2ajigq78D6JJXOwLpY01LRaxjJmxgEK8oe
	 ZmCSVDZ2IAhJGT+4l1ZlAHPblELbkdtkTscB7f3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfBZItJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:49:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfBZItG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:49:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 614EF3002C97;
        Tue, 26 Feb 2019 08:49:06 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B7691001E99;
        Tue, 26 Feb 2019 08:49:04 +0000 (UTC)
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
Subject: [PATCH 03/11] perf data: Add perf_data__update_dir function
Date:   Tue, 26 Feb 2019 09:48:47 +0100
Message-Id: <20190226084855.6340-4-jolsa@kernel.org>
In-Reply-To: <20190226084855.6340-1-jolsa@kernel.org>
References: <20190226084855.6340-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 26 Feb 2019 08:49:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_data__update_dir function to update
size for every file within the perf.data directory.

Link: http://lkml.kernel.org/n/tip-3ii12l48u4tyvrzxo1797w7e@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c | 20 ++++++++++++++++++++
 tools/perf/util/data.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index a2d089876d79..cf8f84fb6295 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -124,6 +124,26 @@ int perf_data__open_dir(struct perf_data *data)
 	return ret;
 }
 
+int perf_data__update_dir(struct perf_data *data)
+{
+	int i;
+
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
+	for (i = 0; i < data->dir.nr; i++) {
+		struct perf_data_file *file = &data->dir.files[i];
+		struct stat st;
+
+		if (fstat(file->fd, &st))
+			return -1;
+
+		file->size = st.st_size;
+	}
+
+	return 0;
+}
+
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 06aefeda311f..0deeb1af9f54 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -79,4 +79,5 @@ int perf_data__switch(struct perf_data *data,
 int perf_data__create_dir(struct perf_data *data, int nr);
 int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
+int perf_data__update_dir(struct perf_data *data);
 #endif /* __PERF_DATA_H */
-- 
2.17.2

