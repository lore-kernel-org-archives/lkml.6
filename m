Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F80C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F8920663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035236;
	bh=2MuMA3YkzZUxiiaQTagfpxhii7wDQjwWlBjbVpOJNiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LZdQy4wOyxW5JkCQHjQhZvCH232Aa1a60rdWj0+ZUp0owVda87ND9AIDvgz29xRnD
	 fmp4ZVUt0RvYxX8AwT0BRGK27orbjnUcBRrLAtVNL9CaxWukmFRFLu4YDjs7NXbNbZ
	 ajot09KrfehkRyeG2vi2eEt7zPKq2wU/fR8VLy+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfBXTHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfBXTHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1AAAD301D217;
        Sun, 24 Feb 2019 19:07:11 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64EB86013A;
        Sun, 24 Feb 2019 19:07:08 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 03/20] perf tools: Add rm_rf_perf_data function
Date:   Sun, 24 Feb 2019 20:06:39 +0100
Message-Id: <20190224190656.30163-4-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sun, 24 Feb 2019 19:07:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To remove perf.data including the directory,
with checking on expected files and no other
directories inside.

Link: http://lkml.kernel.org/n/tip-co7i8qqliinktjw1limudw73@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/util.c | 11 +++++++++++
 tools/perf/util/util.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 02b7a38f98ce..706818693086 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -202,6 +202,17 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 	return rmdir(path);
 }
 
+int rm_rf_perf_data(const char *path)
+{
+	const char *pat[] = {
+		"header",
+		"data.*",
+		NULL,
+	};
+
+	return rm_rf_depth_pat(path, 0, pat);
+}
+
 int rm_rf(const char *path)
 {
 	return rm_rf_depth_pat(path, INT_MAX, NULL);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index ece040b799f6..01c538027c6f 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -31,6 +31,7 @@ struct strlist;
 
 int mkdir_p(char *path, mode_t mode);
 int rm_rf(const char *path);
+int rm_rf_perf_data(const char *path);
 struct strlist *lsdir(const char *name, bool (*filter)(const char *, struct dirent *));
 bool lsdir_no_dot_filter(const char *name, struct dirent *d);
 int copyfile(const char *from, const char *to);
-- 
2.17.2

