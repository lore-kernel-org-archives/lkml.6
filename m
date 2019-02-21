Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4F6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF3A21848
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712409;
	bh=93tHZ0REv2mdGBQzQwgMKrsTAh7KNBAPN67qT1AK0Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yMCttozzW3hKl/iVnqeY263MVsoLAzobGI/Sjviqc1hC8EocNvYA2S2Zt79uDu1vF
	 jx2XX7jRNBKba//WZNzfY9FpaUW7sjpTL+uC1btJOeIOBZHmqhweuvJ6uRzv2Ptsop
	 /76dkWslbsvokr3AvqjD8cwm9UnmFIS7P6COwc9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfBUB0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbfBUB0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:45 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A5E72147A;
        Thu, 21 Feb 2019 01:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712405;
        bh=93tHZ0REv2mdGBQzQwgMKrsTAh7KNBAPN67qT1AK0Eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3HWl8RsIPUMXXHhKQlFaho9J8eTC6yEa7nVzOGCsuhTbBc0rdVcJsabtVOlr1/1D
         YXCB5SPi7GspfpQZdzNk1sB65deLM39dBQSRoLf5LKnuzLPYgwOGin9x0NZVrh+aTW
         U3idsjVg4Qed+uhYokGPPu8SZD5hpoGaVyWWAT4k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/17] perf session: Don't report zero period samples for slave events
Date:   Wed, 20 Feb 2019 22:25:44 -0300
Message-Id: <20190221012549.4069-13-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no reason to deliver a sample with zero period.  It means there
was no value for slave event since its last group leader sample.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 18fb9c8cbf9c..c764bbc91009 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1202,6 +1202,13 @@ static int deliver_sample_value(struct perf_evlist *evlist,
 		return 0;
 	}
 
+	/*
+	 * There's no reason to deliver sample
+	 * for zero period, bail out.
+	 */
+	if (!sample->period)
+		return 0;
+
 	return tool->sample(tool, event, sample, sid->evsel, machine);
 }
 
-- 
2.19.1

