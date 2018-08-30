Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D4DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27ACC20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27ACC20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeH3Kec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728268AbeH3Keb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3553840201BC;
        Thu, 30 Aug 2018 06:33:56 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5EF5A9F0B;
        Thu, 30 Aug 2018 06:33:54 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 37/43] perf stat: Do not use glovab evsel_list in print functions
Date:   Thu, 30 Aug 2018 08:32:46 +0200
Message-Id: <20180830063252.23729-38-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 06:33:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 06:33:56 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting rid of the evsel_list dependency, here we can
use the evlist pointer from the event.

Link: http://lkml.kernel.org/n/tip-wpuv5hoprhgljvo3k0ngprsz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2f606f76b66a..445673f688de 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -914,6 +914,7 @@ static void print_metric_header(struct perf_stat_config *config,
 static int first_shadow_cpu(struct perf_stat_config *config,
 			    struct perf_evsel *evsel, int id)
 {
+	struct perf_evlist *evlist = evsel->evlist;
 	int i;
 
 	if (!config->aggr_get_id)
@@ -928,7 +929,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
 		int cpu2 = perf_evsel__cpus(evsel)->map[i];
 
-		if (config->aggr_get_id(config, evsel_list->cpus, cpu2) == id)
+		if (config->aggr_get_id(config, evlist->cpus, cpu2) == id)
 			return cpu2;
 	}
 	return 0;
@@ -1103,7 +1104,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 		evlist__for_each_entry(evlist, counter) {
 			val = 0;
 			for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
-				s2 = config->aggr_get_id(config, evsel_list->cpus, cpu);
+				s2 = config->aggr_get_id(config, evlist->cpus, cpu);
 				if (s2 != id)
 					continue;
 				val += perf_counts(counter->counts, cpu, 0)->val;
-- 
2.17.1

