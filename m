Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981BDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC9C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC9C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbeHWMMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:12:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbeHWMMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:12:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8hL783189317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:43:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8hL0a3189314;
        Thu, 23 Aug 2018 01:43:21 -0700
Date:   Thu, 23 Aug 2018 01:43:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c9a8a6131fb68f6eabec34fd855e69b4855155e4@git.kernel.org>
Cc:     dsahern@gmail.com, namhyung@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, mpetlan@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, peterz@infradead.org, acme@redhat.com
Reply-To: mpetlan@redhat.com, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, tglx@linutronix.de, namhyung@kernel.org,
          mingo@kernel.org, dsahern@gmail.com, acme@redhat.com,
          peterz@infradead.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180817094813.15086-10-jolsa@kernel.org>
References: <20180817094813.15086-10-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Move the temp file processing into
 decompress_kmodule
Git-Commit-ID: c9a8a6131fb68f6eabec34fd855e69b4855155e4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c9a8a6131fb68f6eabec34fd855e69b4855155e4
Gitweb:     https://git.kernel.org/tip/c9a8a6131fb68f6eabec34fd855e69b4855155e4
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:09 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Move the temp file processing into decompress_kmodule

We will add a compression check in the following patch and it makes it
easier if the file processing is done in a single place. It also makes
the current code simpler.

The decompress_kmodule function now returns the fd of the uncompressed
file and the file name in the pathname arg, if it's provided.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 54bfe1f4762f..cbeecf683333 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -250,8 +250,10 @@ bool dso__needs_decompress(struct dso *dso)
 		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
 }
 
-static int decompress_kmodule(struct dso *dso, const char *name, char *tmpbuf)
+static int decompress_kmodule(struct dso *dso, const char *name,
+			      char *pathname, size_t len)
 {
+	char tmpbuf[] = KMOD_DECOMP_NAME;
 	int fd = -1;
 
 	if (!dso__needs_decompress(dso))
@@ -272,34 +274,27 @@ static int decompress_kmodule(struct dso *dso, const char *name, char *tmpbuf)
 		fd = -1;
 	}
 
+	if (!pathname || (fd < 0))
+		unlink(tmpbuf);
+
+	if (pathname && (fd >= 0))
+		strncpy(pathname, tmpbuf, len);
+
 	return fd;
 }
 
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name)
 {
-	char tmpbuf[] = KMOD_DECOMP_NAME;
-	int fd;
-
-	fd = decompress_kmodule(dso, name, tmpbuf);
-	unlink(tmpbuf);
-	return fd;
+	return decompress_kmodule(dso, name, NULL, 0);
 }
 
 int dso__decompress_kmodule_path(struct dso *dso, const char *name,
 				 char *pathname, size_t len)
 {
-	char tmpbuf[] = KMOD_DECOMP_NAME;
-	int fd;
-
-	fd = decompress_kmodule(dso, name, tmpbuf);
-	if (fd < 0) {
-		unlink(tmpbuf);
-		return -1;
-	}
+	int fd = decompress_kmodule(dso, name, pathname, len);
 
-	strncpy(pathname, tmpbuf, len);
 	close(fd);
-	return 0;
+	return fd >= 0 ? 0 : -1;
 }
 
 /*
