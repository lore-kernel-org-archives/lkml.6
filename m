Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179AEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D073A2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D073A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbeHWMLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:11:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35611 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:11:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8goOV3189269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:42:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8go8x3189265;
        Thu, 23 Aug 2018 01:42:50 -0700
Date:   Thu, 23 Aug 2018 01:42:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-dde755a90e98a1c57f6a92d1a79bc5554024065c@git.kernel.org>
Cc:     hpa@zytor.com, dsahern@gmail.com, tglx@linutronix.de,
        mpetlan@redhat.com, peterz@infradead.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, mingo@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, acme@redhat.com,
          jolsa@kernel.org, peterz@infradead.org, mpetlan@redhat.com,
          tglx@linutronix.de, dsahern@gmail.com, hpa@zytor.com,
          mingo@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180817094813.15086-9-jolsa@kernel.org>
References: <20180817094813.15086-9-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Use compression id in
 decompress_kmodule()
Git-Commit-ID: dde755a90e98a1c57f6a92d1a79bc5554024065c
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

Commit-ID:  dde755a90e98a1c57f6a92d1a79bc5554024065c
Gitweb:     https://git.kernel.org/tip/dde755a90e98a1c57f6a92d1a79bc5554024065c
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:08 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Use compression id in decompress_kmodule()

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
 
