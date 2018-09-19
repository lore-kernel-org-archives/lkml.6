Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDD3ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F0C2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F0C2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbeISXJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:09:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:33317 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732520AbeISXI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:08:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 10:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="87551379"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2018 10:30:01 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 1/6] perf/core: Add sanity check to deal with pinned event failure
Date:   Wed, 19 Sep 2018 10:29:06 -0700
Message-Id: <6486385d1f30336e9973b24c8c65f5079543d3d3.1537377064.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1537377064.git.reinette.chatre@intel.com>
References: <cover.1537377064.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1537377064.git.reinette.chatre@intel.com>
References: <cover.1537377064.git.reinette.chatre@intel.com>
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

