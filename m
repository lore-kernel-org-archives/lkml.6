Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2C6C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8EF2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8EF2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbeHNLeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:34:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:9453 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeHNLeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:34:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 01:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,237,1531810800"; 
   d="scan'208";a="65042552"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.153])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2018 01:47:54 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf auxtrace: Fix queue resize
Date:   Tue, 14 Aug 2018 11:46:08 +0300
Message-Id: <20180814084608.6563-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the number of queues grows beyond 32, the array of queues is resized
but not all members were being copied. Fix by also copying 'tid', 'cpu' and
'set'.

Fixes: e502789302a6e ("perf auxtrace: Add helpers for queuing AUX area tracing data")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.17.1

