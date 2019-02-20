Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973FDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6543A2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550665699;
	bh=5TKo2HUka1MM9DchkyZm13bHPn76A1ZftEMcy7QStQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yTOS1SR20opv7aZyi1GdMP/HQJLRNE9Apr2c5qNg6I095UOo63EGTgYpyghM/faCc
	 8v6yvjLEtW+MAl78OwSbbexshjYrOwJx21PzEXnYis1CJzNIhThAytpZO/Iw/BGzNW
	 vFRwlQdBoQJbmr3e2/m5gGBojTPTSPZMc+k7ZjAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfBTM2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:28:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfBTM2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:28:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0643C66978;
        Wed, 20 Feb 2019 12:28:15 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 304A5600C0;
        Wed, 20 Feb 2019 12:28:13 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 6/6] perf tools: Make rm_rf to remove single file
Date:   Wed, 20 Feb 2019 13:28:00 +0100
Message-Id: <20190220122800.864-7-jolsa@kernel.org>
In-Reply-To: <20190220122800.864-1-jolsa@kernel.org>
References: <20190220122800.864-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 20 Feb 2019 12:28:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let rm_rf remove file if it's provided by path.

Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Link: http://lkml.kernel.org/n/tip-whhp3ej5795l9dc86xfyyp74@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/util.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 320b0fef249a..3ee410fc047a 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -120,16 +120,26 @@ int mkdir_p(char *path, mode_t mode)
 int rm_rf(const char *path)
 {
 	DIR *dir;
-	int ret = 0;
+	int ret;
 	struct dirent *d;
 	char namebuf[PATH_MAX];
+	struct stat statbuf;
 
+	/* Do not fail if there's no file. */
+	ret = lstat(path, &statbuf);
+	if (ret)
+		return 0;
+
+	/* Try to remove any file we get. */
+	if (!(statbuf.st_mode & S_IFDIR))
+		return unlink(path);
+
+	/* We have directory in path. */
 	dir = opendir(path);
 	if (dir == NULL)
-		return 0;
+		return -1;
 
 	while ((d = readdir(dir)) != NULL && !ret) {
-		struct stat statbuf;
 
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
-- 
2.17.2

