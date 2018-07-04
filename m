Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92353C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C06921A71
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iDMuoQTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C06921A71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934211AbeGDMOS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:14:18 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:57016 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932997AbeGDMOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:14:16 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 1F54E47D02;
        Wed,  4 Jul 2018 14:14:14 +0200 (CEST)
Authentication-Results: spamfilter02.heinlein-hosting.de (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mailbox.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        message-id:date:date:subject:subject:from:from:received; s=
        mail20150812; t=1530706452; bh=PIMmb/R2oEz69hrRND/29s0orkFV6x//M
        p1jZvjBpWk=; b=iDMuoQTMR5ZbfK4hKmTBWD5MSL/qn60qjW3v2tR3LlGpWc4vE
        S5YbhxF3ke1tDzIVO7WN/KHgqhnGDr6MaoFjf4ykLYhh3+wADHwORoEfSfwajKDN
        eHdGzARXWEa2LsSCIby3+QUmGWMEfZ62rKnTPgCA/U/CBr7ulN0A5aNy++L4YN47
        dSYur8ffpMis25i9st4Q75u8/dhha3ffMPXMWWIFaZCNp+pd20wogl857+XR12ZN
        juL+BZwBRL3vH2fdPwk8XElO8Je1XWhu/xJguoOGT5GucsDRe94CaoN38rwAkTNx
        +eH5aGc2W2Pt6ctCFFyETBO0KZEZFk8z3myCQ==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 3C5hcQNyIzhK; Wed,  4 Jul 2018 14:14:12 +0200 (CEST)
From:   Jack Henschel <jackdev@mailbox.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jack Henschel <jackdev@mailbox.org>
Subject: [PATCH V2] perf parser: Improve error message for PMU address filters
Date:   Wed,  4 Jul 2018 14:13:45 +0200
Message-Id: <20180704121345.19025-1-jackdev@mailbox.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of a patch that improves the error
message of the perf events parser when the PMU hardware does not support
address filters.

Previously, the perf returned the following error:
> $ perf record -e intel_pt// --filter 'filter sys_write'
> --filter option should follow a -e tracepoint or HW tracer option
This implies there is some syntax error present in the command line,
which is not true. Rather, notify the user that the CPU does not have
support for this feature.

For example, Intel chips based on the Broadwell micro-archticture have
the Intel PT PMU, but do not support address filtering.

Now, perf prints the following error message:
> $ perf record -e intel_pt// --filter 'filter sys_write'
> This CPU does not support address filtering

Signed-off-by: Jack Henschel <jackdev@mailbox.org>
---
 tools/perf/util/parse-events.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 15eec49e71a1..f8cd3e7c9186 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1991,8 +1991,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 	int nr_addr_filters = 0;
 	struct perf_pmu *pmu = NULL;
 
-	if (evsel == NULL)
-		goto err;
+	if (evsel == NULL) {
+		fprintf(stderr,
+			"--filter option should follow a -e tracepoint or HW tracer option\n");
+		return -1;
+	}
 
 	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
 		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
@@ -2014,8 +2017,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 		perf_pmu__scan_file(pmu, "nr_addr_filters",
 				    "%d", &nr_addr_filters);
 
-	if (!nr_addr_filters)
-		goto err;
+	if (!nr_addr_filters) {
+		fprintf(stderr,
+			"This CPU does not support address filtering\n");
+		return -1;
+	}
 
 	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
 		fprintf(stderr,
@@ -2024,12 +2030,6 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 	}
 
 	return 0;
-
-err:
-	fprintf(stderr,
-		"--filter option should follow a -e tracepoint or HW tracer option\n");
-
-	return -1;
 }
 
 int parse_filter(const struct option *opt, const char *str,
-- 
2.18.0

