Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C966C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC5320861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xp4ZqNXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC5320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeIFCj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbeIFCjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:55 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ECB22083E;
        Wed,  5 Sep 2018 22:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185263;
        bh=lkG2+AfvhRmXuzIcgRY7sbVcoCz4DlWH2Yb4lftS7Es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xp4ZqNXVvTaqBCcmLfw5bcoL5d9Wi8XMXB2jF2Yco+gKbOx6Id+gzXhYsqM+BlfsL
         FQokYWazeB4aRak8gxy8qwYwWFVryt3Tvt6XLNGTZtoMLUUMN6Z9WaFT223FsiTL4L
         60wrbwZoU4yicD6b9dc49ZYF8nVQ1P/NaJCTJBV0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 62/77] perf stat: Do not use the global 'evsel_list' in print functions
Date:   Wed,  5 Sep 2018 19:04:25 -0300
Message-Id: <20180905220440.20256-63-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Get rid of the the 'evsel_list' global variable dependency, here we can
use the 'evlist' pointer from the evsel.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-38-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

