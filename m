Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAF0C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11D72082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549289899;
	bh=QEbZw9eLMZYgTZojEjPCkeA+6yNCIVaYqJyh4cciqZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DjV3fPhGLMP1gwIWqy10qu2fLWD61Dr7G5vx5uqw/U2enaSXId0SEQ9S7lUS31l1P
	 Wq/4bHWzsQ/wfi0w5AVS2j9NVS5FRLM/B9y+MzW/N8hvrBgPlce9mdiBCVqC4Y/Yn/
	 XyoFf1yK8Qk+IQt3XiTJisHlNQoynt3sSGQ7w7M8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfBDOSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:18:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731138AbfBDOSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:18:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA7A880F90;
        Mon,  4 Feb 2019 14:18:15 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2D4A60BA6;
        Mon,  4 Feb 2019 14:18:13 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/3] perf tools: Add perf_evsel__output_resort_cb function
Date:   Mon,  4 Feb 2019 15:18:07 +0100
Message-Id: <20190204141808.23031-3-jolsa@kernel.org>
In-Reply-To: <20190204141808.23031-1-jolsa@kernel.org>
References: <20190204141808.23031-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 04 Feb 2019 14:18:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evsel__output_resort_cb so we have an interface
with callback on each hist entry. It will be used in following
patch.

Link: http://lkml.kernel.org/n/tip-oakdwgxijwhxrlp9405qz612@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/hist.c | 10 ++++++++--
 tools/perf/util/hist.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 64ad603a0592..669f961316f0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1775,7 +1775,8 @@ static void output_resort(struct hists *hists, struct ui_progress *prog,
 	}
 }
 
-void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog)
+void perf_evsel__output_resort_cb(struct perf_evsel *evsel, struct ui_progress *prog,
+				  hists__resort_cb_t cb, void *cb_arg)
 {
 	bool use_callchain;
 
@@ -1786,7 +1787,12 @@ void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *pro
 
 	use_callchain |= symbol_conf.show_branchflag_count;
 
-	output_resort(evsel__hists(evsel), prog, use_callchain, NULL, NULL);
+	output_resort(evsel__hists(evsel), prog, use_callchain, cb, cb_arg);
+}
+
+void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog)
+{
+	return perf_evsel__output_resort_cb(evsel, prog, NULL, NULL);
 }
 
 void hists__output_resort(struct hists *hists, struct ui_progress *prog)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 69a367d4aeaf..4af27fbab24f 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -165,6 +165,8 @@ void hist_entry__delete(struct hist_entry *he);
 
 typedef int (*hists__resort_cb_t)(struct hist_entry *he, void *arg);
 
+void perf_evsel__output_resort_cb(struct perf_evsel *evsel, struct ui_progress *prog,
+				  hists__resort_cb_t cb, void *cb_arg);
 void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog);
 void hists__output_resort(struct hists *hists, struct ui_progress *prog);
 void hists__output_resort_cb(struct hists *hists, struct ui_progress *prog,
-- 
2.17.2

