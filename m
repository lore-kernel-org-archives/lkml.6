Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E321C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0DF2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131716;
	bh=CKmgzXwpeOFEGpa6kLMiHbCo5BOeY4NeEDbswHebdBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mR4wzZXY+KDmimGmxIPgcq+/oNaaT7Lxqmp5WWkKl0YPdbXwXPGBDEB6umZxUR+yP
	 vEFbIynPsLY8rrCg3ukVW7BdopjCxvM0CHeGOTr7udQGnJNpzk8C8CJ9h4CxXZpepU
	 sXbbYsAN0ye9q6WDfHXPcr18fbelGdE0N5GfAyMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfBYVzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:55:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730736AbfBYVVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:53 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E2B721855;
        Mon, 25 Feb 2019 21:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129712;
        bh=CKmgzXwpeOFEGpa6kLMiHbCo5BOeY4NeEDbswHebdBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgdE7d+3bnX4/ZGQyJSyXtBq/1O2Z0N3Ua31u+bH2GAueqOT3NKOI9RAbhGq9tNX0
         vFIlO1bjAi8DNyeCnjHE0wo68Vxik5/eOxJEtdta6s6vRmZ+TguV58l0rUig9LM5zW
         SpgrZSRTt+eGctHjERWWJBWcfjjO8KjSM+UIbEG8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/37] perf data: Move size to struct perf_data_file
Date:   Mon, 25 Feb 2019 18:20:15 -0300
Message-Id: <20190225212035.24781-18-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We are about to add support for multiple files, so we need each file to
keep its size.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190221094145.9151-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

