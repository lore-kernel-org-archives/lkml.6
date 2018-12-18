Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3521C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72613218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171468;
	bh=QvX1FT/J4txISmekqCbCmvyNEUbSp6T3jY4PTkQLn6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E6ZSxt27J+2lye1yIY88LDIaZW8fsHGFpeDY3WZqvaVyXgPdYp9nIUSh7d5dnY03k
	 zIRs+hAVVRICYhwNxC4GvnazokfthjbWdlksbLOBsLbqqquMPGtdJaWpOrH8eSF1xL
	 xc//Dymycd//H+Otijtii6QldGBnxrpygj9pdcwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeLRWRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:17:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeLRWRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:17:46 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0787217D9;
        Tue, 18 Dec 2018 22:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171466;
        bh=QvX1FT/J4txISmekqCbCmvyNEUbSp6T3jY4PTkQLn6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdxFopp6OTp/uWfH4PR/eUepsLRUKvnXIXyf4tG1Vp1ztXTkFF+5qLnW62h5Bseks
         TB2NYjHDiDm4jjZLTqT0YEZOM15gGkuCk3V7lfxHYPSCozBAMcJe0J8JjHhsUaMLux
         7n28J9mMv5W6fDbuvNdS2hP3opINOKiN/UU/geqQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        =?UTF-8?q?H=C3=ADtalo=20Silva?= <hitalos@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 62/63] perf symbols: Relax checks on perf-PID.map ownership
Date:   Tue, 18 Dec 2018 19:07:32 -0300
Message-Id: <20181218220733.15839-63-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Those are simple enough, and usually not produced by root, instead by
whatever user is running java, rust, Node.js JIT code that end up
generating those /tmp/perf-PID.map for resolution of symbols in the
anonymous executable maps.

Having to use --force to resolve symbols in 'perf top' is a distraction,
as recently I experienced when node.js symbols were not being resolved
by 'perf top'.

Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Hítalo Silva <hitalos@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-tk2jgo2v4v2yjuj28axbpppo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index dcce74bae6de..01f2c7385e38 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1537,17 +1537,6 @@ int dso__load(struct dso *dso, struct map *map)
 	dso->adjust_symbols = 0;
 
 	if (perfmap) {
-		struct stat st;
-
-		if (lstat(map_path, &st) < 0)
-			goto out;
-
-		if (!symbol_conf.force && st.st_uid && (st.st_uid != geteuid())) {
-			pr_warning("File %s not owned by current user or root, "
-				   "ignoring it (use -f to override).\n", map_path);
-			goto out;
-		}
-
 		ret = dso__load_perf_map(map_path, dso);
 		dso->symtab_type = ret > 0 ? DSO_BINARY_TYPE__JAVA_JIT :
 					     DSO_BINARY_TYPE__NOT_FOUND;
-- 
2.19.2

