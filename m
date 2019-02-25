Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C39C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33E820449
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131651;
	bh=qI04JOCCw52dfQff7atiRN7Id7bjX9HJW4dEG34gKBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KKzaVypwuEBTsG6611k7KY/YzyoYrGKvST6IWEASi9syyMGuljH0FSlrI0EYNIeo9
	 /4Gb0DhJpxtnzcAqW16hHc9wzkILEngTmV1lz6cwwVShTW7TFkQXyQ6l231f/hToGj
	 DTWJTPtNT7zqaeEBTSeu/9LMMpUwylKMKQ0u4dHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfBYVyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:54:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730804AbfBYVWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:11 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5FE21850;
        Mon, 25 Feb 2019 21:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129731;
        bh=qI04JOCCw52dfQff7atiRN7Id7bjX9HJW4dEG34gKBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tz8yE5689CPwbvod0Ad2rEFkG+5z+pSSMfJun9psvUs8hIk3490ivctjYjovpd2F5
         SGiOJ4sjWbCM6NwtUr0fFTXMDnKewd7TA+enyVAw9Mi7pEZkLaD4pv6+gDSSI+c7J+
         pPr9pnZLpyinj0cT0y5WCLeLMX/khir8LGGl/fdE=
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
Subject: [PATCH 22/37] perf data: Make check_backup work over directories
Date:   Mon, 25 Feb 2019 18:20:20 -0300
Message-Id: <20190225212035.24781-23-acme@kernel.org>
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

Change check_backup() to call rm_rf_perf_data() instead of unlink() to
work over directory paths.

Also move the call earlier in the code, before we fork for file/dir, so
it can backup also directory data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index e16d06ed1100..bbf9a299615e 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -37,12 +37,15 @@ static int check_backup(struct perf_data *data)
 {
 	struct stat st;
 
+	if (perf_data__is_read(data))
+		return 0;
+
 	if (!stat(data->path, &st) && st.st_size) {
 		/* TODO check errors properly */
 		char oldname[PATH_MAX];
 		snprintf(oldname, sizeof(oldname), "%s.old",
 			 data->path);
-		unlink(oldname);
+		rm_rf_perf_data(oldname);
 		rename(data->path, oldname);
 	}
 
@@ -95,9 +98,6 @@ static int open_file_write(struct perf_data *data)
 	int fd;
 	char sbuf[STRERR_BUFSIZE];
 
-	if (check_backup(data))
-		return -1;
-
 	fd = open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
 		  S_IRUSR|S_IWUSR);
 
@@ -141,6 +141,9 @@ int perf_data__open(struct perf_data *data)
 	if (!data->path)
 		data->path = "perf.data";
 
+	if (check_backup(data))
+		return -1;
+
 	return open_file_dup(data);
 }
 
-- 
2.20.1

