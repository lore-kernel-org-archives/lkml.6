Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D417C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F314620658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F314620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeH3Kdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:33:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbeH3Kdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:33:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 556A840201C3;
        Thu, 30 Aug 2018 06:32:56 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6906A9F09;
        Thu, 30 Aug 2018 06:32:54 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 01/43] perf stat: Use evsel->threads in create_perf_stat_counter
Date:   Thu, 30 Aug 2018 08:32:10 +0200
Message-Id: <20180830063252.23729-2-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 06:32:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 06:32:56 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting rid of the evsel_list dependency, here we can use
the evsel->threads copy of the struct thread_map.

Link: http://lkml.kernel.org/n/tip-rkkk6a7dkmczvm8vj59aa326@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d097b5b47eb8..d389ed623715 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -293,7 +293,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel)
 	if (target__has_cpu(&target) && !target__has_per_thread(&target))
 		return perf_evsel__open_per_cpu(evsel, perf_evsel__cpus(evsel));
 
-	return perf_evsel__open_per_thread(evsel, evsel_list->threads);
+	return perf_evsel__open_per_thread(evsel, evsel->threads);
 }
 
 static int process_synthesized_event(struct perf_tool *tool __maybe_unused,
-- 
2.17.1

