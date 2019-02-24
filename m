Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10337C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D1A20663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035235;
	bh=nLCZqVfNuxr0RwfqakvXHMidwTNxgeDdeiGfmAyTcps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ngwVVqZ2pn2EoD9tb10I5WZcqYW6WHL4mgOWSZaRFphfH1GkP3ubQstTcwsws2iOv
	 x+drU/aH4HhPZXlqtK1zKn9D3kNm2Sle5dKuAlwH5AS0HSmLtjdUm1xIywhQuNT/bY
	 +SX9VNaPdOLKgnYobR5oqOQ5sL+SZVbububw4zGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfBXTHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfBXTHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A35C1307D931;
        Sun, 24 Feb 2019 19:07:04 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA2226013A;
        Sun, 24 Feb 2019 19:07:01 +0000 (UTC)
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
Subject: [PATCH 01/20] perf tools: Add depth checking to rm_rf
Date:   Sun, 24 Feb 2019 20:06:37 +0100
Message-Id: <20190224190656.30163-2-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 24 Feb 2019 19:07:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding depth argument to rm_rf (and renaming it to rm_rf_depth)
to specify the depth we will go searching for files to remove.

It will be used to specify single depth for perf.data directory
removal in following patch.

Link: http://lkml.kernel.org/n/tip-sylld4txjlqjc18nzhitaokc@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.2

