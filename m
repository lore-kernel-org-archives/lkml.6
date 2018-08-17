Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414F9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041F8218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041F8218AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeHQMvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:51:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727181AbeHQMvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:51:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AB1A40201C6;
        Fri, 17 Aug 2018 09:48:31 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1CA91746E;
        Fri, 17 Aug 2018 09:48:29 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 09/13] perf tools: Move the temp file processing into decompress_kmodule
Date:   Fri, 17 Aug 2018 11:48:09 +0200
Message-Id: <20180817094813.15086-10-jolsa@kernel.org>
In-Reply-To: <20180817094813.15086-1-jolsa@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 17 Aug 2018 09:48:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 17 Aug 2018 09:48:31 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will add compression check in following patch and it
makes it easier if the tem file processing is done in the
single place. It also makes the current code simpler.

The decompress_kmodule function now returns the fd of the
uncompressed file and the file name in pathname arg, if it's
provided.

Link: http://lkml.kernel.org/n/tip-n8ul4r0tny6n16012uncxe6q@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/dso.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1cee958c9a2a..0f07aab30ffe 100644
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
-- 
2.17.1

