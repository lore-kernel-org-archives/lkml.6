Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA0DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E74F218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389270AbeLTSdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:33:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33115 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387657AbeLTSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:33:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIWxIB3687283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:32:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIWx7M3687280;
        Thu, 20 Dec 2018 10:32:59 -0800
Date:   Thu, 20 Dec 2018 10:32:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-tk2jgo2v4v2yjuj28axbpppo@git.kernel.org>
Cc:     mingo@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        penberg@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        acme@redhat.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
        hitalos@gmail.com, hpa@zytor.com, jolsa@kernel.org
Reply-To: namhyung@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
          peterz@infradead.org, tglx@linutronix.de, penberg@kernel.org,
          acme@redhat.com, fweisbec@gmail.com,
          linux-kernel@vger.kernel.org, hitalos@gmail.com, hpa@zytor.com,
          jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Relax checks on perf-PID.map
 ownership
Git-Commit-ID: bc055c54b887961bc3545c54e61c844fd4499c2b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bc055c54b887961bc3545c54e61c844fd4499c2b
Gitweb:     https://git.kernel.org/tip/bc055c54b887961bc3545c54e61c844fd4499c2b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Dec 2018 12:39:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:17:41 -0300

perf symbols: Relax checks on perf-PID.map ownership

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
