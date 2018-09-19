Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCD8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3A121523
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5FLSxsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3A121523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbeISUEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731889AbeISUEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:04:35 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA0CC2151C;
        Wed, 19 Sep 2018 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537367184;
        bh=dJV3HxDMExQipUfrsJqwWqcsK3JAcra5+4h2YtkktV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5FLSxsp4WVkz+t7MWsENzsB0PWZQmvhlW+qHdRXzYrz3AHMCgHeMGnePoLCr8FFY
         u4MpMvw4HmBQHgNO5TqXoTupMqYLimx07lMdwY7DQc2/PWrjoEnVVHtOlhoYhygEBv
         pJwJLv/xbBrQSaQMM8R8FsnGWDT9rPweEksZKflA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/13] perf util: Make copyfile_offset() global
Date:   Wed, 19 Sep 2018 11:25:35 -0300
Message-Id: <20180919142537.29985-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

It will be used outside of util object in following patches.

Committer note:

We need to have the header with the definition for loff_t in util.h
since we now use it in the copyfile_offset() signature.

Also move that prototype closer to the other copyfile_ prefixed
functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180913125450.21342-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 2 +-
 tools/perf/util/util.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index eac5b858a371..093352e93d50 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -221,7 +221,7 @@ static int slow_copyfile(const char *from, const char *to, struct nsinfo *nsi)
 	return err;
 }
 
-static int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
+int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
 {
 	void *ptr;
 	loff_t pgoff;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index dc58254a2b69..14508ee7707a 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -6,6 +6,7 @@
 /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
 #define _DEFAULT_SOURCE 1
 
+#include <fcntl.h>
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdlib.h>
@@ -35,6 +36,7 @@ bool lsdir_no_dot_filter(const char *name, struct dirent *d);
 int copyfile(const char *from, const char *to);
 int copyfile_mode(const char *from, const char *to, mode_t mode);
 int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi);
+int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 
 ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
-- 
2.14.4

