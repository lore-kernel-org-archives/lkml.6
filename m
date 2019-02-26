Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7049AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDD12147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551170954;
	bh=S3+U9aV+4v3sLsSw7iMFcEVS8atXUpoKnXpoPy8cUnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1kZSNmBoZvrM9/kcyxBn4ow7PbxqnWD9RCXtpafUfPfWYnhpE73rjgdiv7NiylYcg
	 3KKAZLu6InsOBCc6lylrn+JCxdlw8g+aqrU7bWG5fKiRIa8yz+kU2rmQlMvATU6/IY
	 U9oTQG+DQNlCDr3b0+r8D3+zlYIq0bFh4I0wsuz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfBZItM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:49:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfBZItJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:49:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE6DBAC2E1;
        Tue, 26 Feb 2019 08:49:08 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A90B31001E9B;
        Tue, 26 Feb 2019 08:49:06 +0000 (UTC)
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
Subject: [PATCH 04/11] perf data: Make perf_data__size to work over directory
Date:   Tue, 26 Feb 2019 09:48:48 +0100
Message-Id: <20190226084855.6340-5-jolsa@kernel.org>
In-Reply-To: <20190226084855.6340-1-jolsa@kernel.org>
References: <20190226084855.6340-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 26 Feb 2019 08:49:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making perf_data__size to return proper size
for directory data.

Link: http://lkml.kernel.org/n/tip-t4dm8cctat2ginmy2bb08xe8@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c | 17 +++++++++++++++++
 tools/perf/util/data.h |  6 +-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index cf8f84fb6295..f581906c6856 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -393,3 +393,20 @@ int perf_data__switch(struct perf_data *data,
 	free(new_filepath);
 	return ret;
 }
+
+unsigned long perf_data__size(struct perf_data *data)
+{
+	u64 size = data->file.size;
+	int i;
+
+	if (!data->is_dir)
+		return size;
+
+	for (i = 0; i < data->dir.nr; i++) {
+		struct perf_data_file *file = &data->dir.files[i];
+
+		size += file->size;
+	}
+
+	return size;
+}
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 0deeb1af9f54..d342469bdfda 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -54,11 +54,6 @@ static inline int perf_data__fd(struct perf_data *data)
 	return data->file.fd;
 }
 
-static inline unsigned long perf_data__size(struct perf_data *data)
-{
-	return data->file.size;
-}
-
 int perf_data__open(struct perf_data *data);
 void perf_data__close(struct perf_data *data);
 ssize_t perf_data__write(struct perf_data *data,
@@ -80,4 +75,5 @@ int perf_data__create_dir(struct perf_data *data, int nr);
 int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
 int perf_data__update_dir(struct perf_data *data);
+unsigned long perf_data__size(struct perf_data *data);
 #endif /* __PERF_DATA_H */
-- 
2.17.2

