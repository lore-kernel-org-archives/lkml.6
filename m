Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AFCC282DF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD322177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207862;
	bh=7VII1YGbKuC3hPJZ/cLvji+8pmGl6Lkcp4uE0oo5GR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ymD14k2hcMP5G06FUAwXj1sPlm6fZ9P6UOq7wxbEjLDN31CdOzSq52bmlt7TD4k07
	 BGy3iCI3Ljpl8quoSDyvEJ75SzMP87LGVkACanosl5kpC8nZ9M5gsWseymmbPKJbxz
	 TVoq6XC6kH/crA8quw0kp2+mZoYUxw5GdsYDG30I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfBCPbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:31:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbfBCPaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:30:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78569144041;
        Sun,  3 Feb 2019 15:30:55 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 083FD5C23D;
        Sun,  3 Feb 2019 15:30:52 +0000 (UTC)
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
Subject: [PATCH 11/14] perf data: Make perf_data__size to work over directory
Date:   Sun,  3 Feb 2019 16:30:15 +0100
Message-Id: <20190203153018.9650-12-jolsa@kernel.org>
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 03 Feb 2019 15:30:55 +0000 (UTC)
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
index fbe46dab8dbd..a36583bced1c 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -367,3 +367,20 @@ int perf_data__switch(struct perf_data *data,
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
index bd7affb69dba..c1b35e7352df 100644
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
@@ -79,4 +74,5 @@ int perf_data__switch(struct perf_data *data,
 int perf_data__create_dir(struct perf_data *data, int nr);
 void perf_data__free_dir(struct perf_data *data);
 int perf_data__update_dir(struct perf_data *data);
+unsigned long perf_data__size(struct perf_data *data);
 #endif /* __PERF_DATA_H */
-- 
2.17.2

