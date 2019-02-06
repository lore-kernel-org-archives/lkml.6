Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACADFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD2C20823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479065;
	bh=y4C0AbYwPs/Nr/AmMLb/TUEabNi0p4kmZl+5Clc9G4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dYoU6XuMAYlRwMaHH+HMom2DzN02mC6pyNF1VWd6zb4R61uxopESyHVXI0Gx6R55R
	 Z8Y7g1jsK5O6+AT683MldCK0FmTeL1KJflWvNenrN+hRIhcSs8jjjJ1f3KsWIVrl4H
	 xKK2kpm1iznC17bTOi+S6P7wHdkGUhvaQi4YFfC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbfBFSvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:51:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfBFSvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:51:01 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB97E218E0;
        Wed,  6 Feb 2019 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479061;
        bh=y4C0AbYwPs/Nr/AmMLb/TUEabNi0p4kmZl+5Clc9G4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJplhmILYHY5Nafwmgvyd+QqZgzZ6ER/Q9Qrzz7rexuPHNevmzfHEFL9lu0xug8hW
         uM8A3Lho8U3IEPkEdnHHX25Zs2YWroaHIFQZRh9pg15Cofzffq6j0gWUIUEXOePXLB
         D142eJrU1OW7CUdXNEpQM5APwWBROc0IYTxw0BGk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 33/53] perf evsel: Add output_resort_cb method
Date:   Wed,  6 Feb 2019 15:48:43 -0300
Message-Id: <20190206184903.24054-34-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add perf_evsel__output_resort_cb() so we have an interface with a
callback for each hist entry. It will be used in the following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190204141808.23031-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

