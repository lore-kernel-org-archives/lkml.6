Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE195C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21DE20663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035247;
	bh=ykAhDONWw6YKws3AhO6o/xXze0FAvQsMBWw+XbzBKZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WRbsLEEUc2hBSWkNJOCfqfZjUi43jvfElI5O5b0irlpLWtpODM1Y+F531riV+BCIi
	 bINrxr8lkNMDVfYB0nHrXkmna4MCNOf0TSkMYaqOm9yzpRDQkG42eew3le9QRq9n9Y
	 GIJZ2z2/NtEN/ujg61eRd9IuBUnNjQO48w5v6jdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfBXTH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbfBXTHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5C005AFE3;
        Sun, 24 Feb 2019 19:07:20 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A7456013A;
        Sun, 24 Feb 2019 19:07:17 +0000 (UTC)
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
Subject: [PATCH 06/20] perf data: Make check_backup work over directories
Date:   Sun, 24 Feb 2019 20:06:42 +0100
Message-Id: <20190224190656.30163-7-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 24 Feb 2019 19:07:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing check_backup to call rm_rf_perf_data instead of unlink to
work over directory paths. Also moving the call earlier in the code,
before we fork for file/dir, so it can backup also directory data.

Link: http://lkml.kernel.org/n/tip-j4lwm20en1yk1hsaqb8zpxkr@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.2

