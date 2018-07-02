Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FAA25BEA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FAA25BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeGBU5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:57:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752391AbeGBU5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:57:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B71A40255C9;
        Mon,  2 Jul 2018 20:57:20 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-25.brq.redhat.com [10.40.204.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEF541C55F;
        Mon,  2 Jul 2018 20:57:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/2] perf tools: Use perf_evsel__match in perf_evsel__is_bpf_output
Date:   Mon,  2 Jul 2018 22:57:16 +0200
Message-Id: <20180702205717.24945-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 02 Jul 2018 20:57:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 02 Jul 2018 20:57:20 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using perf_evsel__match helper in perf_evsel__is_bpf_output.

Cc: Andi Kleen <ak@linux.intel.com>
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

