Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6F8C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78641206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78641206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbeHWMN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:13:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38239 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeHWMNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:13:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8hrrE3189397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:43:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8hraL3189394;
        Thu, 23 Aug 2018 01:43:53 -0700
Date:   Thu, 23 Aug 2018 01:43:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-8b42b7e5e8b5692bc5e57342bf00c40d64978407@git.kernel.org>
Cc:     namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        tglx@linutronix.de, acme@redhat.com, dsahern@gmail.com,
        mpetlan@redhat.com
Reply-To: tglx@linutronix.de, acme@redhat.com, mpetlan@redhat.com,
          dsahern@gmail.com, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          namhyung@kernel.org
In-Reply-To: <20180817094813.15086-11-jolsa@kernel.org>
References: <20180817094813.15086-11-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Add is_compressed callback to
 compressions array
Git-Commit-ID: 8b42b7e5e8b5692bc5e57342bf00c40d64978407
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

Commit-ID:  8b42b7e5e8b5692bc5e57342bf00c40d64978407
Gitweb:     https://git.kernel.org/tip/8b42b7e5e8b5692bc5e57342bf00c40d64978407
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:10 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Add is_compressed callback to compressions array

Add is_compressed callback to the compressions array, that returns 0 if
the file is compressed or != 0 if not.

The new callback is used to recognize the situation when we have a
'compressed' object, like:

  /lib/modules/.../drivers/net/ethernet/intel/igb/igb.ko.xz

but we need to read its debug data from debuginfo files, which might not
be compressed, like:

  /root/.debug/.build-id/d6/...c4b301f/debug

So even for a 'compressed' object we read debug data from a plain
uncompressed object. To keep this transparent, we detect this in
decompress_kmodule() and return the file descriptor to the uncompressed
file.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/compress.h |  2 ++
 tools/perf/util/dso.c      | 23 ++++++++++++++++++++---
 tools/perf/util/lzma.c     |  5 +++++
 tools/perf/util/zlib.c     |  6 ++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index ecca688a25fb..892e92e7e7fc 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -4,10 +4,12 @@
 
 #ifdef HAVE_ZLIB_SUPPORT
 int gzip_decompress_to_file(const char *input, int output_fd);
+bool gzip_is_compressed(const char *input);
 #endif
 
 #ifdef HAVE_LZMA_SUPPORT
 int lzma_decompress_to_file(const char *input, int output_fd);
+bool lzma_is_compressed(const char *input);
 #endif
 
 #endif /* PERF_COMPRESS_H */
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index cbeecf683333..8b9243f13b88 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -196,15 +196,16 @@ enum {
 static const struct {
 	const char *fmt;
 	int (*decompress)(const char *input, int output);
+	bool (*is_compressed)(const char *input);
 } compressions[] = {
 	[COMP_ID__NONE] = { .fmt = NULL, },
 #ifdef HAVE_ZLIB_SUPPORT
-	{ "gz", gzip_decompress_to_file },
+	{ "gz", gzip_decompress_to_file, gzip_is_compressed },
 #endif
 #ifdef HAVE_LZMA_SUPPORT
-	{ "xz", lzma_decompress_to_file },
+	{ "xz", lzma_decompress_to_file, lzma_is_compressed },
 #endif
-	{ NULL, NULL },
+	{ NULL, NULL, NULL },
 };
 
 static int is_supported_compression(const char *ext)
@@ -262,6 +263,22 @@ static int decompress_kmodule(struct dso *dso, const char *name,
 	if (dso->comp == COMP_ID__NONE)
 		return -1;
 
+	/*
+	 * We have proper compression id for DSO and yet the file
+	 * behind the 'name' can still be plain uncompressed object.
+	 *
+	 * The reason is behind the logic we open the DSO object files,
+	 * when we try all possible 'debug' objects until we find the
+	 * data. So even if the DSO is represented by 'krava.xz' module,
+	 * we can end up here opening ~/.debug/....23432432/debug' file
+	 * which is not compressed.
+	 *
+	 * To keep this transparent, we detect this and return the file
+	 * descriptor to the uncompressed file.
+	 */
+	if (!compressions[dso->comp].is_compressed(name))
+		return open(name, O_RDONLY);
+
 	fd = mkstemp(tmpbuf);
 	if (fd < 0) {
 		dso->load_errno = errno;
diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index 07498eaddc08..7032caaf75eb 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -99,3 +99,8 @@ err_fclose:
 	fclose(infile);
 	return err;
 }
+
+bool lzma_is_compressed(const char *input __maybe_unused)
+{
+	return true;
+}
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index a725b958cf31..e68317214679 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -5,6 +5,7 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <zlib.h>
+#include <linux/compiler.h>
 
 #include "util/compress.h"
 #include "util/util.h"
@@ -79,3 +80,8 @@ out_close:
 
 	return ret == Z_STREAM_END ? 0 : -1;
 }
+
+bool gzip_is_compressed(const char *input __maybe_unused)
+{
+	return true;
+}
