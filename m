Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1710C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6D2218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6D2218AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeHQMvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:51:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbeHQMvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:51:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A44EF406E81C;
        Fri, 17 Aug 2018 09:48:29 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34D901746E;
        Fri, 17 Aug 2018 09:48:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 08/13] perf tools: Use compression id in decompress_kmodule function
Date:   Fri, 17 Aug 2018 11:48:08 +0200
Message-Id: <20180817094813.15086-9-jolsa@kernel.org>
In-Reply-To: <20180817094813.15086-1-jolsa@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 09:48:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 09:48:29 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we parsed out the compression ID, we dont need to
iterate all available compressions and we can call it
directly.

Link: http://lkml.kernel.org/n/tip-55zrhxhr699pswx34d0hd4u9@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/dso.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index f0e4cc43c97e..1cee958c9a2a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -244,19 +244,6 @@ bool is_kernel_module(const char *pathname, int cpumode)
 	return m.kmod;
 }
 
-static bool
-decompress_to_file(const char *ext, const char *filename, int output_fd)
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
@@ -266,31 +253,25 @@ bool dso__needs_decompress(struct dso *dso)
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
2.17.1

