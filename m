Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF8C00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF4B206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035236;
	bh=lbeWJQ1qrBzRiX/4XINhR//89pbw3UrPkpSN4M7Il2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j7AzgBcyaSMZZMchCSsaxlIZzeUq7V9j1EW28/2q4lN1EgNNeh4xMx4+yuqtBfYgX
	 7bNtbaUt4inppG3IVZX2EBHgTNzrke0JYdI57PV4My+U9JIMWEKaHJzyQ2MpARxrZK
	 RUN5qzcZa01EuS2Khxq76dXwPMHmiPKrEvq4EDjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfBXTHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfBXTHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4C2BC010891;
        Sun, 24 Feb 2019 19:07:07 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 222DC6013A;
        Sun, 24 Feb 2019 19:07:04 +0000 (UTC)
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
Subject: [PATCH 02/20] perf tools: Add pattern name checking to rm_rf
Date:   Sun, 24 Feb 2019 20:06:38 +0100
Message-Id: <20190224190656.30163-3-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 24 Feb 2019 19:07:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding pattern argument to rm_rf_depth (and renaming it to
rm_rf_depth_pat) to specify the name pattern files need to
match inside the directory. The function fails if we find
different file to remove.

Link: http://lkml.kernel.org/n/tip-vnqs7ut0pnmrpih05xca6cvv@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.2

