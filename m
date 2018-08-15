Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234BAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DB020C09
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQajOxaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DB020C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbeHOSBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbeHOSBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:01:14 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73D7621475;
        Wed, 15 Aug 2018 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345721;
        bh=P94DbGQ8wMZvqhYLe5rIePl5mdtYvFPlMjyK4xIN9ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQajOxawihtJlmii5MhLrELNCgLh9VYAqxUNEgYgLkd8LQlShDhRkOFxj276+ij6l
         q+vzN7beONrCGhOQEHYodYQVkrLSdnija+6ck+36z+TccjUvtwwggBctD8EiQvX9Rf
         GXt7Idpe8CkjjTrXJyXGC8URsAh5J0Qkb890sBLM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 32/35] perf auxtrace: Fix queue resize
Date:   Wed, 15 Aug 2018 12:06:08 -0300
Message-Id: <20180815150611.32080-33-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

When the number of queues grows beyond 32, the array of queues is
resized but not all members were being copied. Fix by also copying
'tid', 'cpu' and 'set'.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: e502789302a6e ("perf auxtrace: Add helpers for queuing AUX area tracing data")
Link: http://lkml.kernel.org/r/20180814084608.6563-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ae8c37b219c9..db1511359c5e 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -203,6 +203,9 @@ static int auxtrace_queues__grow(struct auxtrace_queues *queues,
 	for (i = 0; i < queues->nr_queues; i++) {
 		list_splice_tail(&queues->queue_array[i].head,
 				 &queue_array[i].head);
+		queue_array[i].tid = queues->queue_array[i].tid;
+		queue_array[i].cpu = queues->queue_array[i].cpu;
+		queue_array[i].set = queues->queue_array[i].set;
 		queue_array[i].priv = queues->queue_array[i].priv;
 	}
 
-- 
2.14.4

