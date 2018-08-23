Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDDDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F623208DC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F623208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbeHWMNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:13:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33793 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWMNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:13:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8iOC83190930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:44:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8iOsO3190927;
        Thu, 23 Aug 2018 01:44:24 -0700
Date:   Thu, 23 Aug 2018 01:44:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-4b57fd44b61beb51b7d64f21c72941ba10c1ea2b@git.kernel.org>
Cc:     mpetlan@redhat.com, peterz@infradead.org, acme@redhat.com,
        dsahern@gmail.com, tglx@linutronix.de, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, mingo@kernel.org
Reply-To: mpetlan@redhat.com, peterz@infradead.org, acme@redhat.com,
          dsahern@gmail.com, tglx@linutronix.de, jolsa@kernel.org,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          mingo@kernel.org
In-Reply-To: <20180817094813.15086-12-jolsa@kernel.org>
References: <20180817094813.15086-12-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Add lzma_is_compressed function
Git-Commit-ID: 4b57fd44b61beb51b7d64f21c72941ba10c1ea2b
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

Commit-ID:  4b57fd44b61beb51b7d64f21c72941ba10c1ea2b
Gitweb:     https://git.kernel.org/tip/4b57fd44b61beb51b7d64f21c72941ba10c1ea2b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:11 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Add lzma_is_compressed function

Add implementation of the is_compressed callback for lzma.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
 
@@ -100,7 +104,18 @@ err_fclose:
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
