Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACCDC282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7BF2183F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207853;
	bh=bIw8y7U6meHUsDnEKo8rouVM9T7rJsV3E9EoR02pNxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TUfrIZEuwm515H9SUTd8hxOXFKPhZEMSpzuid5knKAtckDHslB0iMTzYmrNxO2ZfK
	 flD7qDilJyQfsvu8nx/22kK5m0TVRdFGt4r9wUMKxusX85WxYzug6qzcDXSP2TgWt8
	 wePzBmJrC1n2iX2PJgYtoR4UAsdU9RIIuKmyPqtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfBCPaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:30:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfBCPat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:30:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7478513BF60;
        Sun,  3 Feb 2019 15:30:49 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3C885C238;
        Sun,  3 Feb 2019 15:30:46 +0000 (UTC)
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
Subject: [PATCH 09/14] perf data: Don't store auxtrace index for directory data file
Date:   Sun,  3 Feb 2019 16:30:13 +0100
Message-Id: <20190203153018.9650-10-jolsa@kernel.org>
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 03 Feb 2019 15:30:49 +0000 (UTC)
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
index fa21efb8bc74..cd02ab3ec4ff 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -391,7 +391,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	size_t padding;
 	u8 pad[8] = {0};
 
-	if (!perf_data__is_pipe(data)) {
+	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
 		off_t file_offset;
 		int fd = perf_data__fd(data);
 		int err;
-- 
2.17.2

