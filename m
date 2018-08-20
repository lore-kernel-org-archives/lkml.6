Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F02CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC2421735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j00ek2r+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC2421735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeHTTdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:33:21 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303E82172F;
        Mon, 20 Aug 2018 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781825;
        bh=K2qEY6VzTjoYhS9/5ifaNAsFCy4hBYz1Z8J2j8UJZFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j00ek2r+c86UVPxP86T+bMtOhO6O8wp1Fj1kehvUCMBaQRt9bfwbIg/Gm2+Z1bXZh
         5MLqYqOecpxKb1HRhUbJCWc6x5kV5MSsLgvoeo0ykrimVCNA+iFgas3ruv9mods5x/
         Oz/mBqoQ58aAGL2H4tqifTMXxsHF5S0Z5JDswxv4=
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
Subject: [PATCH 16/21] perf tools: Add gzip_is_compressed function
Date:   Mon, 20 Aug 2018 13:15:57 -0300
Message-Id: <20180820161602.6830-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add implementation of the is_compressed callback for gzip.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/zlib.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index e68317214679..902ce6384f57 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -6,6 +6,7 @@
 #include <sys/mman.h>
 #include <zlib.h>
 #include <linux/compiler.h>
+#include <unistd.h>
 
 #include "util/compress.h"
 #include "util/util.h"
@@ -81,7 +82,18 @@ int gzip_decompress_to_file(const char *input, int output_fd)
 	return ret == Z_STREAM_END ? 0 : -1;
 }
 
-bool gzip_is_compressed(const char *input __maybe_unused)
+bool gzip_is_compressed(const char *input)
 {
-	return true;
+	int fd = open(input, O_RDONLY);
+	const uint8_t magic[2] = { 0x1f, 0x8b };
+	char buf[2] = { 0 };
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
2.14.4

