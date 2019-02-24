Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFBDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F02520663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035243;
	bh=sMXosdnHEhIro8M/GPoC4Igps0MFkMD5uAMs8kSXZd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VhHvb9kAfy8Dul0leZXP4nyNZyGgmFB4xNhggBzNZuW1NFVc6+mirGbq8vNZxUwTd
	 29vJxnAjxe8HO+aFYR8/STd8U7Z98QsJtolJxBHP4rMiKr1Nu+iLuklRgPuEsM1WTu
	 6xUGa2WLIN4R/7JvdY9DIj6izV5D/ug6tjW9x6v0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfBXTHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfBXTHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 492344ACD8;
        Sun, 24 Feb 2019 19:07:14 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F2476013B;
        Sun, 24 Feb 2019 19:07:11 +0000 (UTC)
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
Subject: [PATCH 04/20] perf data: Move size to struct perf_data_file
Date:   Sun, 24 Feb 2019 20:06:40 +0100
Message-Id: <20190224190656.30163-5-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 24 Feb 2019 19:07:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to add support for multiple files,
so we need each file to keep its size.

Link: http://lkml.kernel.org/n/tip-gcf5gtwxds3ggegu6evl0jvn@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 5 ++---
 tools/perf/util/data.c      | 2 +-
 tools/perf/util/data.h      | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6c3719ac901d..e5e9900c9039 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -660,10 +660,9 @@ static int process_sample_event(struct perf_tool *tool,
 
 static int process_buildids(struct record *rec)
 {
-	struct perf_data *data = &rec->data;
 	struct perf_session *session = rec->session;
 
-	if (data->size == 0)
+	if (perf_data__size(&rec->data) == 0)
 		return 0;
 
 	/*
@@ -851,7 +850,7 @@ record__finish_output(struct record *rec)
 		return;
 
 	rec->session->header.data_size += rec->bytes_written;
-	data->size = lseek(perf_data__fd(data), 0, SEEK_CUR);
+	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
 
 	if (!rec->no_buildid) {
 		process_buildids(rec);
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index d8cfc19ddb10..09eceda17fc2 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -82,7 +82,7 @@ static int open_file_read(struct perf_data *data)
 		goto out_close;
 	}
 
-	data->size = st.st_size;
+	data->file.size = st.st_size;
 	return fd;
 
  out_close:
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 4828f7feea89..85f9c0dbf982 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -12,13 +12,13 @@ enum perf_data_mode {
 struct perf_data_file {
 	const char	*path;
 	int		 fd;
+	unsigned long	 size;
 };
 
 struct perf_data {
 	struct perf_data_file	 file;
 	bool			 is_pipe;
 	bool			 force;
-	unsigned long		 size;
 	enum perf_data_mode	 mode;
 };
 
@@ -44,7 +44,7 @@ static inline int perf_data__fd(struct perf_data *data)
 
 static inline unsigned long perf_data__size(struct perf_data *data)
 {
-	return data->size;
+	return data->file.size;
 }
 
 int perf_data__open(struct perf_data *data);
-- 
2.17.2

