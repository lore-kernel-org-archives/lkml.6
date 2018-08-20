Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57D9C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2E92172C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw6CbKI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2E92172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeHTTcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:32:49 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 704DC2173D;
        Mon, 20 Aug 2018 16:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781793;
        bh=TgmfJsc9X/1t3b/+FffpswKIydzXAVES29cEE/YYTC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aw6CbKI869zEh7kv74QFea8ZdHftzNUH2vN5g3Ru3dzGeI9kHJzPRik1CcXFGfz+i
         RkIGxzeagNokqSWGWf09H+3Ndr/IC+UM6YSNq0u9jst6n6VgNEjGBcAHQK49xV9w3B
         jyBZDSuDEG09vcdPSj8w+iv+MpTZtpmP03Ow1ZWY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/21] perf tools: Get rid of dso__needs_decompress() call in symbol__disassemble()
Date:   Mon, 20 Aug 2018 13:15:47 -0300
Message-Id: <20180820161602.6830-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need to call dso__needs_decompress() twice in the function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4268b948e0e..20061cf42288 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1629,6 +1629,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	char symfs_filename[PATH_MAX];
 	struct kcore_extract kce;
 	bool delete_extract = false;
+	bool decomp = false;
 	int stdout_fd[2];
 	int lineno = 0;
 	int nline;
@@ -1662,6 +1663,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 						 tmp, sizeof(tmp)) < 0)
 			goto out;
 
+		decomp = true;
 		strcpy(symfs_filename, tmp);
 	}
 
@@ -1748,7 +1750,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 out_remove_tmp:
 	close(stdout_fd[0]);
 
-	if (dso__needs_decompress(dso))
+	if (decomp)
 		unlink(symfs_filename);
 
 	if (delete_extract)
-- 
2.14.4

