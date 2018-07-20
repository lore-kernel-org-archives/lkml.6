Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD80ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A666E20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A666E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeGTLsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:48:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728468AbeGTLsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:48:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47F36CE1F2;
        Fri, 20 Jul 2018 11:00:38 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCDC1111DCF5;
        Fri, 20 Jul 2018 11:00:36 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/4] perf tools: Use perf_evsel__match in perf_evsel__is_bpf_output
Date:   Fri, 20 Jul 2018 13:00:33 +0200
Message-Id: <20180720110036.32251-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 11:00:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 11:00:38 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using perf_evsel__match helper in perf_evsel__is_bpf_output.

Link: http://lkml.kernel.org/n/tip-lquycuebqfcb56byv1qdjaix@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evsel.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d277930b19a1..890babf9ce86 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -402,10 +402,7 @@ bool perf_evsel__is_function_event(struct perf_evsel *evsel);
 
 static inline bool perf_evsel__is_bpf_output(struct perf_evsel *evsel)
 {
-	struct perf_event_attr *attr = &evsel->attr;
-
-	return (attr->config == PERF_COUNT_SW_BPF_OUTPUT) &&
-		(attr->type == PERF_TYPE_SOFTWARE);
+	return perf_evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
 }
 
 struct perf_attr_details {
-- 
2.17.1

