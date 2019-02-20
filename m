Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D5EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4605F21902
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550665692;
	bh=sc7O4MvY27uK0n6iq0uMpcHdKV9WZ+5X1W+rF87opCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZruWRXdqbIACvoLi46j/CkdsXIwyD75Cdk0ipojAXD2lJSn1NTa5E3gIo4Aecw3S7
	 Z7HMwUK2RxQvuH/jZ9Yl1k+emXrNrg48sHmSZRa5UMMSNRek6fa4+Gw69WCuIlWS/P
	 c17AbLHg3u+n+/8w4IJZcCTwv1fsgcgykubmur/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfBTM2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:28:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfBTM2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:28:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAB6080474;
        Wed, 20 Feb 2019 12:28:06 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C42560141;
        Wed, 20 Feb 2019 12:28:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/6] perf tools: Force sample_type for slave events
Date:   Wed, 20 Feb 2019 13:27:56 +0100
Message-Id: <20190220122800.864-3-jolsa@kernel.org>
In-Reply-To: <20190220122800.864-1-jolsa@kernel.org>
References: <20190220122800.864-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 20 Feb 2019 12:28:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forcing sample_type setup for slave events in group
leader sessions.

We don't get sample for slave events, we make them
when delivering group leader sample. Set the slave
event to follow the master sample_type to ease up
report.

Link: http://lkml.kernel.org/n/tip-mqhyqhxm0p2jyzqjffwgbll0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evsel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 684c893ca6bc..dfe2958e6287 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -956,6 +956,14 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->sample_freq    = 0;
 		attr->sample_period  = 0;
 		attr->write_backward = 0;
+
+		/*
+		 * We don't get sample for slave events, we make them
+		 * when delivering group leader sample. Set the slave
+		 * event to follow the master sample_type to ease up
+		 * report.
+		 */
+		attr->sample_type = leader->attr.sample_type;
 	}
 
 	if (opts->no_samples)
-- 
2.17.2

