Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275A6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B6F20896
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxbiO/GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B6F20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbeKFVc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:32:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387404AbeKFVc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:32:26 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A392086C;
        Tue,  6 Nov 2018 12:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541506052;
        bh=K3FpymTv1yNg5koCmmIa2XqE8YlcpboJypUQcZ6Ubn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxbiO/GCOPAG66np93T1jfF2UsnLIQx+wrLSZ/VkegOjqVQHSartzJZgFKmAmx8MM
         i7SDBdjEndZ116Rle+OwpYhtGzwR45eIPJGnYUmmUbBEyMk/AiueEMhBMFTFgfqqIS
         7K5nAI9IFhl2xh+iFSCxr2As6nY542tEgoWSycYM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/18] perf tools: Do not zero sample_id_all for group members
Date:   Tue,  6 Nov 2018 09:06:12 -0300
Message-Id: <20181106120612.8262-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Andi reported following malfunction:

  # perf record -e '{ref-cycles,cycles}:S' -a sleep 1
  # perf script
  non matching sample_id_all

That's because we disable sample_id_all bit for non-sampling group
members. We can't do that, because it needs to be the same over the
whole event list. This patch keeps it untouched again.

Reported-by: Andi Kleen <andi@firstfloor.org>
Tested-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180923150420.27327-1-jolsa@kernel.org
Fixes: e9add8bac6c6 ("perf evsel: Disable write_backward for leader sampling group events")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/test-record-group-sampling | 1 -
 tools/perf/util/evsel.c                          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index 8a33ca4f9e1f..f0729c454f16 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -37,4 +37,3 @@ sample_freq=0
 sample_period=0
 freq=0
 write_backward=0
-sample_id_all=0
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d187059a373..d37bb1566cd9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -956,7 +956,6 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->sample_freq    = 0;
 		attr->sample_period  = 0;
 		attr->write_backward = 0;
-		attr->sample_id_all  = 0;
 	}
 
 	if (opts->no_samples)
-- 
2.14.4

