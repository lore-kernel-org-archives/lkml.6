Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB96C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7008A20842
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035264;
	bh=WhjtXFefIUcLWfSzy61UnEg2fte3LwHAOYm+9PlCqbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QwcGJi05xCMraaiec660BUpl7qqiYxQUq0RLyScs9Gd48dm3lGiOCsrVd+ZP5dih0
	 azkAimjAXe1qP2TxzUljuDjiV322kqCFbUEaTERMp9U2zeTgMHn9ENbQIX67yKJRQO
	 KDyAdgTyq2Wreo5FEvL3Ljo1647LRWFz1mB6M0e8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfBXTHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbfBXTHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C8B03095870;
        Sun, 24 Feb 2019 19:07:41 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66F326017E;
        Sun, 24 Feb 2019 19:07:38 +0000 (UTC)
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
Subject: [PATCH 12/20] perf data: Add perf_data__update_dir function
Date:   Sun, 24 Feb 2019 20:06:48 +0100
Message-Id: <20190224190656.30163-13-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 24 Feb 2019 19:07:41 +0000 (UTC)
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
index 72ac4dbb5c69..54e4f01aeb2f 100644
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

