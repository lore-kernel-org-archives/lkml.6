Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73C1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B3821871
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129724;
	bh=I45FCoALcbCAumtAQ/SJhR2qgR09P6tUD9cCFBD883o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lfPPfxNbdEQdCjOSXTqrPWTZ0X50RtXZp9qGxLtBDV499hr/8SyhOTeCRcmjneAp8
	 TblQbXneh2aW9iQ1KQUuJfQd1FQ4+nZjAZr6E/zDV8SyHsGKgnxX8wiDWAPk+SgHvV
	 /YgdtQEZ0Aj/mZw0jKuDQn+Sf7EyzWpIpSYm8+Nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfBYVWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730770AbfBYVWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:01 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59AC721848;
        Mon, 25 Feb 2019 21:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129720;
        bh=I45FCoALcbCAumtAQ/SJhR2qgR09P6tUD9cCFBD883o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKH/LB9NWLHW+tTBMZeY2XsBOnGGaYWFB6RkgKlgT9f1Yr3PDEBbLEGINNcBEBKsi
         Ib7cdWaekcnNMxwrBpuVXEBS3bSKkHPrik90O4T4Rag3TCWOHODxA1sHVj+mUkRA16
         5nOAx/1NZFzvVOancopb6GEFZ2g8kdCnmSI+a0uo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/37] perf tools: Add depth checking to rm_rf
Date:   Mon, 25 Feb 2019 18:20:17 -0300
Message-Id: <20190225212035.24781-20-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding depth argument to rm_rf (and renaming it to rm_rf_depth) to
specify the depth we will go searching for files to remove.

It will be used to specify single depth for perf.data directory removal
in following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 3ee410fc047a..bcf436892155 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -117,7 +117,12 @@ int mkdir_p(char *path, mode_t mode)
 	return (stat(path, &st) && mkdir(path, mode)) ? -1 : 0;
 }
 
-int rm_rf(const char *path)
+/*
+ * The depth specify how deep the removal will go.
+ * 0       - will remove only files under the 'path' directory
+ * 1 .. x  - will dive in x-level deep under the 'path' directory
+ */
+static int rm_rf_depth(const char *path, int depth)
 {
 	DIR *dir;
 	int ret;
@@ -155,7 +160,7 @@ int rm_rf(const char *path)
 		}
 
 		if (S_ISDIR(statbuf.st_mode))
-			ret = rm_rf(namebuf);
+			ret = depth ? rm_rf_depth(namebuf, depth - 1) : 0;
 		else
 			ret = unlink(namebuf);
 	}
@@ -167,6 +172,11 @@ int rm_rf(const char *path)
 	return rmdir(path);
 }
 
+int rm_rf(const char *path)
+{
+	return rm_rf_depth(path, INT_MAX);
+}
+
 /* A filter which removes dot files */
 bool lsdir_no_dot_filter(const char *name __maybe_unused, struct dirent *d)
 {
-- 
2.20.1

