Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91896C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6055020880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550742189;
	bh=kwwxnzdSaMH9aU6oLXljzurxWSHk68Sbi0VBp6cMVSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sDnFyEUGuBPO5ZUJONVig0VtKbEaTKNZ5hlPHHGOZ16jALy1d7gG4lyYINbCs6vRV
	 Oc2IiFM+/dWudUSFwt4kGLK+ZhmucFAjY5Fy3eeCMzCxaY8VUQDZOvGc1bHQ+4PBDJ
	 U/DGVgLpeUPoOpwuSe9zLKfs6G0xug3rYzYB2oco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfBUJmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:42:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727625AbfBUJmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:42:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 199A63091D80;
        Thu, 21 Feb 2019 09:42:08 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E882360BE6;
        Thu, 21 Feb 2019 09:42:05 +0000 (UTC)
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
Subject: [PATCH 08/17] perf data: Don't store auxtrace index for directory data file
Date:   Thu, 21 Feb 2019 10:41:36 +0100
Message-Id: <20190221094145.9151-9-jolsa@kernel.org>
In-Reply-To: <20190221094145.9151-1-jolsa@kernel.org>
References: <20190221094145.9151-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 21 Feb 2019 09:42:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't store auxtrace index when we store to multiple files,
because we keep only offset for it, not the file.

The auxtrace data will be processed correctly in the 'pipe' mode.

Link: http://lkml.kernel.org/n/tip-og11od5s6nfxuf0ftxyu8m6k@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f3f7f3100336..e983c8d71a79 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -392,7 +392,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	size_t padding;
 	u8 pad[8] = {0};
 
-	if (!perf_data__is_pipe(data)) {
+	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
 		off_t file_offset;
 		int fd = perf_data__fd(data);
 		int err;
-- 
2.17.2

