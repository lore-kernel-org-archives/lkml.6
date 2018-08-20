Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A16C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FD92172F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvxBkzvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FD92172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeHTTdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:33:15 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B782170E;
        Mon, 20 Aug 2018 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781819;
        bh=ui5VrRrBFXoymp7nJ62gC9g/rWYDKxg4sWFdYUls7U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvxBkzvw9G4MRYh7BAzfu4fJwS/jLKmqYzDePXrsBOLbvlem0qOM+xFbTHNNrrKWV
         UEbc3YYjj0Q/V/ms3EsdyJEAScj1rpfsAm+t77PCCjzIEEe9s0cOVj5y4Xob2TdNUk
         y+6TbBQiW4Vi0MiC0qqr3WbUQ5rk2DkJFHfP/nIc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/21] perf tools: Add is_compressed callback to compressions array
Date:   Mon, 20 Aug 2018 13:15:55 -0300
Message-Id: <20180820161602.6830-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
2.14.4

