Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C289020661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551275930;
	bh=KPMnys5GN9gI3WARy0LfjjVIyBQSEIoBAoDcvpp9ju4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pigCh1B1o+Yl27qLDlR3WARZPlGP73K2grfXZ4kWQ/i4JN6h1+/j/adw8kkf3/lDZ
	 B87Bdov4NhRSBXnNdT3EjVrEGCBtqw1kRUOPI2NLaqs4NGEwebiLY3B5fBUZ2a1t13
	 QbZVd+8QCyHF65wHIfAKiRKt+8j/D5MPeV+dxPK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfB0N6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:58:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730514AbfB0N6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:58:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B8E530BEA52;
        Wed, 27 Feb 2019 13:58:42 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D81B7679D7;
        Wed, 27 Feb 2019 13:58:40 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 2/2] perf hist: Fix memory leak of srcline
Date:   Wed, 27 Feb 2019 14:58:37 +0100
Message-Id: <20190227135837.29392-2-jolsa@kernel.org>
In-Reply-To: <20190227135837.29392-1-jolsa@kernel.org>
References: <20190227135837.29392-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 27 Feb 2019 13:58:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

We can't allocate he->srcline unconditionaly, only when
new hist_entry is created. Moving he->srcline allocation
into hist_entry__init function.

Original-patch-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/n/tip-2ijaiiwlzmk4cae3zs97pq0x@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/hist.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 74e307d17c49..f9eb95bf3938 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -419,6 +419,13 @@ static int hist_entry__init(struct hist_entry *he,
 		if (he->raw_data == NULL)
 			goto err_infos;
 	}
+
+	if (he->srcline) {
+		he->srcline = strdup(he->srcline);
+		if (he->srcline == NULL)
+			goto err_rawdata;
+	}
+
 	INIT_LIST_HEAD(&he->pairs.node);
 	thread__get(he->thread);
 	he->hroot_in  = RB_ROOT_CACHED;
@@ -429,6 +436,9 @@ static int hist_entry__init(struct hist_entry *he,
 
 	return 0;
 
+err_rawdata:
+	free(he->raw_data);
+
 err_infos:
 	if (he->branch_info) {
 		map__put(he->branch_info->from.map);
@@ -605,7 +615,7 @@ __hists__add_entry(struct hists *hists,
 			.map	= al->map,
 			.sym	= al->sym,
 		},
-		.srcline = al->srcline ? strdup(al->srcline) : NULL,
+		.srcline = (char *) al->srcline,
 		.socket	 = al->socket,
 		.cpu	 = al->cpu,
 		.cpumode = al->cpumode,
@@ -962,7 +972,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			.map = al->map,
 			.sym = al->sym,
 		},
-		.srcline = al->srcline ? strdup(al->srcline) : NULL,
+		.srcline = (char *) al->srcline,
 		.parent = iter->parent,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
-- 
2.17.2

