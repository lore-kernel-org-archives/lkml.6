Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1FBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2004B218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2004B218AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeHQMvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:51:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727181AbeHQMvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:51:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1042C26377;
        Fri, 17 Aug 2018 09:48:33 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97C1A1746E;
        Fri, 17 Aug 2018 09:48:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 10/13] perf tools: Add is_compressed callback to compressions array
Date:   Fri, 17 Aug 2018 11:48:10 +0200
Message-Id: <20180817094813.15086-11-jolsa@kernel.org>
In-Reply-To: <20180817094813.15086-1-jolsa@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 17 Aug 2018 09:48:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 17 Aug 2018 09:48:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding is_compressed callback to compressions array,
that returns 0 if the file is compressed or != 0 if not.

The new callback is used to recognize the situation when
we have 'compressed' object, like:
  /lib/modules/.../drivers/net/ethernet/intel/igb/igb.ko.xz

but we need to read its debug data from debuginfo files,
which might not be compressed, like:
  /root/.debug/.build-id/d6/...c4b301f/debug

So even for 'compressed' object we read data from plain
uncompressed object. To keep this transparent, we detect
this in decompress_kmodule and return the file descriptor
to the uncompressed file.

Link: http://lkml.kernel.org/n/tip-diw1xpztojz0pj2wgdt6axxr@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index 0f07aab30ffe..a7f2162ba730 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -196,15 +196,16 @@ enum {
 static const struct {
 	const char *fmt;
 	int (*decompress)(const char *input, int output);
+	bool (*is_compressed)(const char *input);
 } compressions[] = {
 	[COMP_ID__NONE] = { 0 },
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
@@ -99,3 +99,8 @@ int lzma_decompress_to_file(const char *input, int output_fd)
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
@@ -79,3 +80,8 @@ int gzip_decompress_to_file(const char *input, int output_fd)
 
 	return ret == Z_STREAM_END ? 0 : -1;
 }
+
+bool gzip_is_compressed(const char *input __maybe_unused)
+{
+	return true;
+}
-- 
2.17.1

