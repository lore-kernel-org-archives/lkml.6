Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72211213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBZGKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:10:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:8309 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBZGKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:10:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 22:10:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,414,1544515200"; 
   d="scan'208";a="147314884"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 25 Feb 2019 22:10:50 -0800
Received: from [10.251.90.22] (abudanko-mobl.ccr.corp.intel.com [10.251.90.22])
        by linux.intel.com (Postfix) with ESMTP id 21452580261;
        Mon, 25 Feb 2019 22:10:47 -0800 (PST)
Subject: [PATCH v3 6/9] perf util: introduce Zstd based streaming compression
 API
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <10824243-040d-4b44-65c0-2c63870e9bb6@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1470ba6f-45bb-7b8b-cabb-c36097783617@linux.intel.com>
Date:   Tue, 26 Feb 2019 09:10:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <10824243-040d-4b44-65c0-2c63870e9bb6@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implemented functions are based on Zstd streaming compression
API. The functions are used in runtime to compress data that
come from mmaped kernel buffer data and then stored into a trace.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/Build      |  2 +
 tools/perf/util/compress.h | 18 ++++++++
 tools/perf/util/zstd.c     | 95 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 tools/perf/util/zstd.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8dd3102301ea..920ee8bebd83 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -145,6 +145,8 @@ perf-y += scripting-engines/
 
 perf-$(CONFIG_ZLIB) += zlib.o
 perf-$(CONFIG_LZMA) += lzma.o
+perf-y += zstd.o
+
 perf-y += demangle-java.o
 perf-y += demangle-rust.o
 
diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index 892e92e7e7fc..e0987616db94 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -2,6 +2,11 @@
 #ifndef PERF_COMPRESS_H
 #define PERF_COMPRESS_H
 
+#include <stdbool.h>
+#ifdef HAVE_ZSTD_SUPPORT
+#include <zstd.h>
+#endif
+
 #ifdef HAVE_ZLIB_SUPPORT
 int gzip_decompress_to_file(const char *input, int output_fd);
 bool gzip_is_compressed(const char *input);
@@ -12,4 +17,17 @@ int lzma_decompress_to_file(const char *input, int output_fd);
 bool lzma_is_compressed(const char *input);
 #endif
 
+struct zstd_data {
+#ifdef HAVE_ZSTD_SUPPORT
+	ZSTD_CStream	*cstream;
+#endif
+};
+
+int zstd_init(struct zstd_data *data, int level);
+int zstd_fini(struct zstd_data *data);
+
+size_t zstd_compress_stream_to_records(struct zstd_data *data,
+	void *dst, size_t dst_size, void *src, size_t src_size,	size_t max_record_size,
+	size_t process_header(void *record, size_t increment));
+
 #endif /* PERF_COMPRESS_H */
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
new file mode 100644
index 000000000000..686c3a347dcc
--- /dev/null
+++ b/tools/perf/util/zstd.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <string.h>
+
+#include "util/compress.h"
+#include "util/debug.h"
+
+#ifdef HAVE_ZSTD_SUPPORT
+
+int zstd_init(struct zstd_data *data, int level)
+{
+	size_t ret;
+
+	data->cstream = ZSTD_createCStream();
+	if (data->cstream == NULL) {
+		pr_err("Couldn't create compression stream.\n");
+		return -1;
+	}
+
+	ret = ZSTD_initCStream(data->cstream, level);
+	if (ZSTD_isError(ret)) {
+		pr_err("Failed to initialize compression stream: %s\n", ZSTD_getErrorName(ret));
+		return -1;
+	}
+
+	return 0;
+}
+
+int zstd_fini(struct zstd_data *data)
+{
+	if (data->cstream) {
+		ZSTD_freeCStream(data->cstream);
+		data->cstream = NULL;
+	}
+
+	return 0;
+}
+
+size_t zstd_compress_stream_to_records(struct zstd_data *data,
+	void *dst, size_t dst_size, void *src, size_t src_size,	size_t max_record_size,
+	size_t process_header(void *record, size_t increment))
+{
+	size_t ret, size, compressed = 0;
+	ZSTD_inBuffer input = { src, src_size, 0 };
+	ZSTD_outBuffer output;
+	void *record;
+
+	while (input.pos < input.size) {
+		record = dst;
+		size = process_header(record, 0);
+		compressed += size;
+		dst += size;
+		dst_size -= size;
+		output = (ZSTD_outBuffer){ dst, (dst_size > max_record_size) ?
+						max_record_size : dst_size, 0 };
+		ret = ZSTD_compressStream(data->cstream, &output, &input);
+		ZSTD_flushStream(data->cstream, &output);
+		if (ZSTD_isError(ret)) {
+			pr_err("failed to compress %ld bytes: %s\n",
+				(long)src_size, ZSTD_getErrorName(ret));
+			memcpy(dst, src, src_size);
+			return src_size;
+		}
+		size = output.pos;
+		size = process_header(record, size);
+		compressed += size;
+		dst += size;
+		dst_size -= size;
+	}
+
+	return compressed;
+}
+
+#else /* !HAVE_ZSTD_SUPPORT */
+
+int zstd_init(struct zstd_data *data __maybe_unused, int level __maybe_unused)
+{
+	return 0;
+}
+
+int zstd_fini(struct zstd_data *data __maybe_unused)
+{
+	return 0;
+}
+
+size_t zstd_compress_stream_to_records(struct zstd_data *data __maybe_unused,
+		void *dst, size_t dst_size __maybe_unused,
+		void *src, size_t src_size, size_t max_record_size __maybe_unused,
+		size_t process_header(void *record, size_t increment) __maybe_unused)
+{
+	memcpy(dst, src, src_size);
+	return 0;
+}
+
+#endif

