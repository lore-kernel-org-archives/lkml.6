Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBA5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE4A2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712429;
	bh=AVUqAWXJGCW6uc8B+mh21TJwHa21K5RhNKhfXSX4VdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XXzuZHdjJdW4sae47i6X7XRpHUmwYXDbv19pPpn+BH27LcPIOgl1OK6n33XpGZwfj
	 vRkbejO27aDpeRxtjiEh+KUG3hJ5jmAmoLS9y2H1EMlU2vXH7d/9HTBSg+9ZocLn+Z
	 3OUHLapcgZQn9UCqCcbQcUoapnIBxTkdvTw4UCt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfBUB1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfBUB1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:27:06 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30D42146E;
        Thu, 21 Feb 2019 01:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712425;
        bh=AVUqAWXJGCW6uc8B+mh21TJwHa21K5RhNKhfXSX4VdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZI+ywmLrQCk5H1SwEPovYf3oYRjI98fe9f0PzV1PeHTBcwSjkwWglniF+wBkISVI
         qEGUCMG7tz1mYUWCM6g3Hyftb9Lbr+fL4bc5cdjimqBo3g8VtkhWsABbXBQcENDw2y
         7GTuHizbsGdW24BjAo3FVCT0WAZA2EYX1NdLbbs4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/17] perf tools: Make rm_rf() remove single file
Date:   Wed, 20 Feb 2019 22:25:49 -0300
Message-Id: <20190221012549.4069-18-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Let rm_rf() remove a file if it's provided by path, not just
directories.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.19.1

