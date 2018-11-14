Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B94EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF53722546
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/vWTxGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF53722546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbeKOI3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732896AbeKOI3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:51 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADB132252A;
        Wed, 14 Nov 2018 22:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234286;
        bh=3pgNGboFW7qWweOIrusQnlifn8muSDhWpj6xSkj2MrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/vWTxGvo7SNrYdt9Jygu/ax4qVF06Vg69xI8yLtglyj+LcW7znmyatQomEPEetPx
         pWtKjTCDMnPYu8ojpNPvLTOa1jspEZRoxxAaohFfQHCU7zBt9uFyaEZRv4wIWewMh7
         kiOsQwpo/TIrM2fIrOVr6n9P2MTfvXBsJXdVE6fU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 42/59] perf tools: Do not zero sample_id_all for group members
Date:   Wed, 14 Nov 2018 17:23:14 -0500
Message-Id: <20181114222335.99339-42-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 8e88c29b351ed4e09dd63f825f1c8260b0cb0ab3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 6324afba8fdd..75073c4925cc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -941,7 +941,6 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->sample_freq    = 0;
 		attr->sample_period  = 0;
 		attr->write_backward = 0;
-		attr->sample_id_all  = 0;
 	}
 
 	if (opts->no_samples)
-- 
2.17.1

