Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA33C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE5F20893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtJkz5SV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE5F20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbeGYTP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeGYTP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:15:26 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD37320899;
        Wed, 25 Jul 2018 18:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541760;
        bh=HyO4dFZiJ95PPA2CuZLZbXEKifeuuTQm6E1il5aIgyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtJkz5SVWTc/DgzPVm5LDVjUhG/fTzzaUAM1/aVZgQdX0r6MfChEUgRfOoFVMH7S9
         r+iFAHQkwS/UhbEo45kRREsIpqRkWUEKRv7Y6Q2yu/RBfG/kyDRCXnuJx/BIuL2ve3
         Z5kYnHl1cPUSeefOta0UZE5Lxd1kGlKcR0G/nJF4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/27] perf tools: Use perf_evsel__match instead of open coded equivalent
Date:   Wed, 25 Jul 2018 14:59:59 -0300
Message-Id: <20180725180001.15108-26-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Use perf_evsel__match() helper in perf_evsel__is_bpf_output().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180720110036.32251-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

