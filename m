Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43072C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107F921855
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129734;
	bh=bOeSSL0Czk57erbdYVdsORQR861ZXZcmnJofGFFc5R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w5qLz9o+m7QPqcAS69N3BKQ5Y2DpQoL6oyPt4DUSTrzhcpvGnRhfssnAUB4VEodu8
	 74DrnyXeB9x7dA2PdZf52G2zy0ezMyoq37otebfVStqsj86QTB8fQI3y/fIkPGYPdW
	 EjRM/a5rxwsV9snbtkotKfwvTPuDuraI7erszo28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfBYVWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfBYVWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:04 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDDD21850;
        Mon, 25 Feb 2019 21:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129724;
        bh=bOeSSL0Czk57erbdYVdsORQR861ZXZcmnJofGFFc5R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E13eNLyouk7+rt1DCsqvb6gKhmGLmGCn3skfikTq9ezwxxeplbdeaI8qHXI4OleT+
         gHXF/IAB7XrqU2z1kbf/jGMaLGBvTZi6faCkX/0hyAHWbLpGp46bfUKDDo4Af8QZ/E
         3kxpxD73jcBktPf8cPlp7OZPjbQ/O7OqB8VKx9XQ=
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
Subject: [PATCH 20/37] perf tools: Add pattern name checking to rm_rf
Date:   Mon, 25 Feb 2019 18:20:18 -0300
Message-Id: <20190225212035.24781-21-acme@kernel.org>
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

Add pattern argument to rm_rf_depth() (and rename it to rm_rf_depth_pat())
to specify the name pattern files need to match inside the directory.

The function fails if we find different file to remove.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index bcf436892155..02b7a38f98ce 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -21,6 +21,7 @@
 #include <linux/time64.h>
 #include <unistd.h>
 #include "strlist.h"
+#include "string2.h"
 
 /*
  * XXX We need to find a better place for these things...
@@ -117,12 +118,38 @@ int mkdir_p(char *path, mode_t mode)
 	return (stat(path, &st) && mkdir(path, mode)) ? -1 : 0;
 }
 
+static bool match_pat(char *file, const char **pat)
+{
+	int i = 0;
+
+	if (!pat)
+		return true;
+
+	while (pat[i]) {
+		if (strglobmatch(file, pat[i]))
+			return true;
+
+		i++;
+	}
+
+	return false;
+}
+
 /*
  * The depth specify how deep the removal will go.
  * 0       - will remove only files under the 'path' directory
  * 1 .. x  - will dive in x-level deep under the 'path' directory
+ *
+ * If specified the pat is array of string patterns ended with NULL,
+ * which are checked upon every file/directory found. Only matching
+ * ones are removed.
+ *
+ * The function returns:
+ *    0 on success
+ *   -1 on removal failure with errno set
+ *   -2 on pattern failure
  */
-static int rm_rf_depth(const char *path, int depth)
+static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 {
 	DIR *dir;
 	int ret;
@@ -149,6 +176,9 @@ static int rm_rf_depth(const char *path, int depth)
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
+		if (!match_pat(d->d_name, pat))
+			return -2;
+
 		scnprintf(namebuf, sizeof(namebuf), "%s/%s",
 			  path, d->d_name);
 
@@ -160,7 +190,7 @@ static int rm_rf_depth(const char *path, int depth)
 		}
 
 		if (S_ISDIR(statbuf.st_mode))
-			ret = depth ? rm_rf_depth(namebuf, depth - 1) : 0;
+			ret = depth ? rm_rf_depth_pat(namebuf, depth - 1, pat) : 0;
 		else
 			ret = unlink(namebuf);
 	}
@@ -174,7 +204,7 @@ static int rm_rf_depth(const char *path, int depth)
 
 int rm_rf(const char *path)
 {
-	return rm_rf_depth(path, INT_MAX);
+	return rm_rf_depth_pat(path, INT_MAX, NULL);
 }
 
 /* A filter which removes dot files */
-- 
2.20.1

