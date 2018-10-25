Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBA2C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C1B2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHJ7X/qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C1B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeJYTni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbeJYTni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:38 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA4572083E;
        Thu, 25 Oct 2018 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465880;
        bh=dSwlhai7v+Hm3+OghedSf/W4a2x1Rti1Np3vexRQSXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHJ7X/qb45DZHt/DeVulcItr5LHZy/kUvYHyGjj6gBhx/idCLfkIYuLFn0j71wPNn
         Cd5S/TAAa2WIIdKzmMJFD1hKmKAH8tcTVD7rQaeF524d3mOmxRYPEAfXogr3YlrZLD
         +IuQRZ6A5LE7kAu6OrqH6/atTYr2QztRwsAH//fo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 11/37] perf trace: Drop thread refcount in trace__event_handler()
Date:   Thu, 25 Oct 2018 08:10:05 -0300
Message-Id: <20181025111031.3440-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We must pair:

   thread = machine__findnew_thread();

with thread__put(thread). Fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: c4191e55b874 ("perf trace: Show comm and tid for tracepoint events")
Link: https://lkml.kernel.org/n/tip-dkxsb8cwg87rmkrzrbns1o4z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 77b8748ad5ed..589e0412652a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2152,8 +2152,8 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
 		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
-	thread__put(thread);
 out:
+	thread__put(thread);
 	return 0;
 }
 
-- 
2.14.4

