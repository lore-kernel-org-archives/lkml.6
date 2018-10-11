Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9764BC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B08B21476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHl6Jdg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B08B21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbeJKXOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731169AbeJKXOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:14:31 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D5632147C;
        Thu, 11 Oct 2018 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272805;
        bh=QKhIXKrPwFSHu34qpSeIM0J82O0+CN/nKS6vw9Emy4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHl6Jdg0TUVc5NSfDHSJtgSg3PPWifJNQhzBKWnRHkOvjX9wE/QKbjdYb8qUYMrVo
         SBaaNq2bfs1mNbDMvYyvdNYBrtZP9rzAqQSFdo16wquTXXpSKO5fRzVmLlXfkrdrpN
         LgbRPn2FcbXyLwvu9mkhIKUdVazhsDivlaTNZQK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH 4.14 38/45] perf utils: Move is_directory() to path.h
Date:   Thu, 11 Oct 2018 17:40:05 +0200
Message-Id: <20181011152510.587911082@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 06c3f2aa9fc68e7f3fe3d83e7569d2a2801d9f99 upstream.

So that it can be used more widely, like in the next patch, when it will
be used to fix a bug in 'perf test' handling of dirent.d_type ==
DT_UNKNOWN.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171206174535.25380-1-jolsa@kernel.org
[ Split from a larger patch, removed needless includes in path.h ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Ignat Korchagin <ignat@cloudflare.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/builtin-script.c |   14 +-------------
 tools/perf/util/path.c      |   14 ++++++++++++++
 tools/perf/util/path.h      |    3 +++
 3 files changed, 18 insertions(+), 13 deletions(-)

--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -25,6 +25,7 @@
 #include "util/string2.h"
 #include "util/thread-stack.h"
 #include "util/time-utils.h"
+#include "util/path.h"
 #include "print_binary.h"
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
@@ -2129,19 +2130,6 @@ out:
 	return rc;
 }
 
-/* Helper function for filesystems that return a dent->d_type DT_UNKNOWN */
-static int is_directory(const char *base_path, const struct dirent *dent)
-{
-	char path[PATH_MAX];
-	struct stat st;
-
-	sprintf(path, "%s/%s", base_path, dent->d_name);
-	if (stat(path, &st))
-		return 0;
-
-	return S_ISDIR(st.st_mode);
-}
-
 #define for_each_lang(scripts_path, scripts_dir, lang_dirent)		\
 	while ((lang_dirent = readdir(scripts_dir)) != NULL)		\
 		if ((lang_dirent->d_type == DT_DIR ||			\
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -18,6 +18,7 @@
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <dirent.h>
 #include <unistd.h>
 
 static char bad_path[] = "/bad-path/";
@@ -77,3 +78,16 @@ bool is_regular_file(const char *file)
 
 	return S_ISREG(st.st_mode);
 }
+
+/* Helper function for filesystems that return a dent->d_type DT_UNKNOWN */
+bool is_directory(const char *base_path, const struct dirent *dent)
+{
+	char path[PATH_MAX];
+	struct stat st;
+
+	sprintf(path, "%s/%s", base_path, dent->d_name);
+	if (stat(path, &st))
+		return false;
+
+	return S_ISDIR(st.st_mode);
+}
--- a/tools/perf/util/path.h
+++ b/tools/perf/util/path.h
@@ -2,9 +2,12 @@
 #ifndef _PERF_PATH_H
 #define _PERF_PATH_H
 
+struct dirent;
+
 int path__join(char *bf, size_t size, const char *path1, const char *path2);
 int path__join3(char *bf, size_t size, const char *path1, const char *path2, const char *path3);
 
 bool is_regular_file(const char *file);
+bool is_directory(const char *base_path, const struct dirent *dent);
 
 #endif /* _PERF_PATH_H */


