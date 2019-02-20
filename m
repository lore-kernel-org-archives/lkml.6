Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E28C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1291B2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550665718;
	bh=mfsZDQk8uGS4o9iV0tY56bUfiu/3sEpKNb/88axqmVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hKWbfuYXdJaNqdIuQ6PW6nnL7EeAeBh6UW3Gd4DhbN9s60nm81XL5LF2y2TUvvAvX
	 LbtSZpZfv1L9kSiM2lHmHTqdg+Kx25vnyA/9FEZp69Sdt4nSQ1r7fDuK2T+Orge6D3
	 3pJH82ijsZcBrlhko4zLp+h58GTW1G3Kwin+5af8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfBTM2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:28:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfBTM2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:28:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01240356E5;
        Wed, 20 Feb 2019 12:28:05 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52684600C0;
        Wed, 20 Feb 2019 12:28:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/6] perf tools: Don't report zero period samples for slave events
Date:   Wed, 20 Feb 2019 13:27:55 +0100
Message-Id: <20190220122800.864-2-jolsa@kernel.org>
In-Reply-To: <20190220122800.864-1-jolsa@kernel.org>
References: <20190220122800.864-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 20 Feb 2019 12:28:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to deliver sample for zero period.
It means there was no value for slave event since its
last group leader sample.

Link: http://lkml.kernel.org/n/tip-d5he0papol5dhwvfq33ess1p@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.2

