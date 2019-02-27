Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A3AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B152320661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551275925;
	bh=xdfuO3KcmfHBPobkwsPQXueU22hhZbgGPlwmvJR8SNQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XnHPOqLkvrS2UDzWC3RLlXcXs7CXZR8XwiwzeQIQk/AC/5hS8J++ojpcZ/BZDt+bf
	 3Ftf9sx/rN675E9C0b6HkpLUBxuxdzFCevBi3KC3LWkwZfkQNskhZYU+0YoqE56nrK
	 Ycu2UT80uiYsEzS0blgJGrZeXMfa79GaoHtU+hqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfB0N6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:58:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730440AbfB0N6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:58:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90063356F3;
        Wed, 27 Feb 2019 13:58:40 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7ABF65F9D5;
        Wed, 27 Feb 2019 13:58:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 1/2] perf tools: Add error path into hist_entry__init
Date:   Wed, 27 Feb 2019 14:58:36 +0100
Message-Id: <20190227135837.29392-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 27 Feb 2019 13:58:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding error path into hist_entry__init to unify error
handling, so every new member does not need to free
everything else.

Link: http://lkml.kernel.org/n/tip-v0ssws4hsr0tozb7lm0k5f70@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/hist.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 669f961316f0..74e307d17c49 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -396,11 +396,8 @@ static int hist_entry__init(struct hist_entry *he,
 		 * adding new entries.  So we need to save a copy.
 		 */
 		he->branch_info = malloc(sizeof(*he->branch_info));
-		if (he->branch_info == NULL) {
-			map__zput(he->ms.map);
-			free(he->stat_acc);
-			return -ENOMEM;
-		}
+		if (he->branch_info == NULL)
+			goto err;
 
 		memcpy(he->branch_info, template->branch_info,
 		       sizeof(*he->branch_info));
@@ -419,21 +416,8 @@ static int hist_entry__init(struct hist_entry *he,
 
 	if (he->raw_data) {
 		he->raw_data = memdup(he->raw_data, he->raw_size);
-
-		if (he->raw_data == NULL) {
-			map__put(he->ms.map);
-			if (he->branch_info) {
-				map__put(he->branch_info->from.map);
-				map__put(he->branch_info->to.map);
-				free(he->branch_info);
-			}
-			if (he->mem_info) {
-				map__put(he->mem_info->iaddr.map);
-				map__put(he->mem_info->daddr.map);
-			}
-			free(he->stat_acc);
-			return -ENOMEM;
-		}
+		if (he->raw_data == NULL)
+			goto err_infos;
 	}
 	INIT_LIST_HEAD(&he->pairs.node);
 	thread__get(he->thread);
@@ -444,6 +428,21 @@ static int hist_entry__init(struct hist_entry *he,
 		he->leaf = true;
 
 	return 0;
+
+err_infos:
+	if (he->branch_info) {
+		map__put(he->branch_info->from.map);
+		map__put(he->branch_info->to.map);
+		free(he->branch_info);
+	}
+	if (he->mem_info) {
+		map__put(he->mem_info->iaddr.map);
+		map__put(he->mem_info->daddr.map);
+	}
+err:
+	map__zput(he->ms.map);
+	free(he->stat_acc);
+	return -ENOMEM;
 }
 
 static void *hist_entry__zalloc(size_t size)
-- 
2.17.2

