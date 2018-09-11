Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F9DC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C055A20891
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C055A20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeIKWPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:15:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:31116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbeIKWPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:15:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 10:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,361,1531810800"; 
   d="scan'208";a="79642205"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2018 10:14:57 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 1/6] perf/core: Add sanity check to deal with pinned event failure
Date:   Tue, 11 Sep 2018 10:14:32 -0700
Message-Id: <6486385d1f30336e9973b24c8c65f5079543d3d3.1536685533.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1536685533.git.reinette.chatre@intel.com>
References: <cover.1536685533.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1536685533.git.reinette.chatre@intel.com>
References: <cover.1536685533.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that a failure can occur during the scheduling of a
pinned event. The initial portion of perf_event_read_local() contains
the various error checks an event should pass before it can be
considered valid. Ensure that the potential scheduling failure
of a pinned event is checked for and have a credible error.

Link: http://lkml.kernel.org/r/20180807093615.GY2494@hirez.programming.kicks-ass.net
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2a62b96600ad..191c0c2e10de 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3940,6 +3940,12 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 		goto out;
 	}
 
+	/* If this is a pinned event it must be running on this CPU */
+	if (event->attr.pinned && event->oncpu != smp_processor_id()) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/*
 	 * If the event is currently on this CPU, its either a per-task event,
 	 * or local to this CPU. Furthermore it means its ACTIVE (otherwise
-- 
2.17.0

