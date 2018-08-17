Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DA5C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98343218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98343218AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeHQMvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:51:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727345AbeHQMvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:51:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA86440201C4;
        Fri, 17 Aug 2018 09:48:34 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D85C1746E;
        Fri, 17 Aug 2018 09:48:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 11/13] perf tools: Add lzma_is_compressed function
Date:   Fri, 17 Aug 2018 11:48:11 +0200
Message-Id: <20180817094813.15086-12-jolsa@kernel.org>
In-Reply-To: <20180817094813.15086-1-jolsa@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 17 Aug 2018 09:48:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 17 Aug 2018 09:48:34 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add implementation of the is_compressed callback for lzma.

Link: http://lkml.kernel.org/n/tip-tdgpdhdfk7sm5hsyjvfs2skh@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/lzma.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index 7032caaf75eb..b1dd29a9d915 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -3,9 +3,13 @@
 #include <lzma.h>
 #include <stdio.h>
 #include <linux/compiler.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include "compress.h"
 #include "util.h"
 #include "debug.h"
+#include <unistd.h>
 
 #define BUFSIZE 8192
 
@@ -100,7 +104,18 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 	return err;
 }
 
-bool lzma_is_compressed(const char *input __maybe_unused)
+bool lzma_is_compressed(const char *input)
 {
-	return true;
+	int fd = open(input, O_RDONLY);
+	const uint8_t magic[6] = { 0xFD, '7', 'z', 'X', 'Z', 0x00 };
+	char buf[6] = { 0 };
+	ssize_t rc;
+
+	if (fd < 0)
+		return -1;
+
+	rc = read(fd, buf, sizeof(buf));
+	close(fd);
+	return rc == sizeof(buf) ?
+	       memcmp(buf, magic, sizeof(buf)) == 0 : false;
 }
-- 
2.17.1

