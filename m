Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F872C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F6D2172D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnSrdlQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F6D2172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeHTTdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:33:08 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC9662172F;
        Mon, 20 Aug 2018 16:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781812;
        bh=xcN0QZoy76i2zVgjj1TAHMsFvYJiO0VA586v9AeEOdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnSrdlQhtUJzkQ01EkbYOD4oTsxeinllsE9L8tzaykY/w+DnRSQe5HnS+YiQ9ODG2
         pIB2ayw2P0Ur9gW4RlcjCgj3MxzJzxHl3Dcgjp1StfDHCJ7ZJ8jjuIYLym+BKeD2I2
         me1aIQhzEpb1+QNzjH7xIMA7vGSatwbsmLROEnzY=
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
Subject: [PATCH 12/21] perf tools: Use compression id in decompress_kmodule()
Date:   Mon, 20 Aug 2018 13:15:53 -0300
Message-Id: <20180820161602.6830-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Once we parsed out the compression ID, we dont need to iterate all
available compressions and we can call it directly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d875e6956a3e..54bfe1f4762f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -244,18 +244,6 @@ bool is_kernel_module(const char *pathname, int cpumode)
 	return m.kmod;
 }
 
-static bool decompress_to_file(const char *ext, const char *filename, int output_fd)
-{
-	unsigned i;
-
-	for (i = 0; compressions[i].fmt; i++) {
-		if (!strcmp(ext, compressions[i].fmt))
-			return !compressions[i].decompress(filename,
-							   output_fd);
-	}
-	return false;
-}
-
 bool dso__needs_decompress(struct dso *dso)
 {
 	return dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
@@ -265,31 +253,25 @@ bool dso__needs_decompress(struct dso *dso)
 static int decompress_kmodule(struct dso *dso, const char *name, char *tmpbuf)
 {
 	int fd = -1;
-	struct kmod_path m;
 
 	if (!dso__needs_decompress(dso))
 		return -1;
 
-	if (kmod_path__parse_ext(&m, dso->long_name))
+	if (dso->comp == COMP_ID__NONE)
 		return -1;
 
-	if (!m.comp)
-		goto out;
-
 	fd = mkstemp(tmpbuf);
 	if (fd < 0) {
 		dso->load_errno = errno;
-		goto out;
+		return -1;
 	}
 
-	if (!decompress_to_file(m.ext, name, fd)) {
+	if (compressions[dso->comp].decompress(name, fd)) {
 		dso->load_errno = DSO_LOAD_ERRNO__DECOMPRESSION_FAILURE;
 		close(fd);
 		fd = -1;
 	}
 
-out:
-	free(m.ext);
 	return fd;
 }
 
-- 
2.14.4

