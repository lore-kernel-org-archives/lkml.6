Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC971C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C99206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C99206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeI2DO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:14:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeI2DO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:14:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8SKmrlp558133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Sep 2018 13:48:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8SKmqFm558130;
        Fri, 28 Sep 2018 13:48:52 -0700
Date:   Fri, 28 Sep 2018 13:48:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-befb1b3c2703897c5b8ffb0044dc5d0e5f27c5d7@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, reinette.chatre@intel.com,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          reinette.chatre@intel.com, peterz@infradead.org, mingo@kernel.org
In-Reply-To: <6486385d1f30336e9973b24c8c65f5079543d3d3.1537377064.git.reinette.chatre@intel.com>
References: <6486385d1f30336e9973b24c8c65f5079543d3d3.1537377064.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/core: Add sanity check to deal with pinned
 event failure
Git-Commit-ID: befb1b3c2703897c5b8ffb0044dc5d0e5f27c5d7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  befb1b3c2703897c5b8ffb0044dc5d0e5f27c5d7
Gitweb:     https://git.kernel.org/tip/befb1b3c2703897c5b8ffb0044dc5d0e5f27c5d7
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Wed, 19 Sep 2018 10:29:06 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Sep 2018 22:44:53 +0200

perf/core: Add sanity check to deal with pinned event failure

It is possible that a failure can occur during the scheduling of a
pinned event. The initial portion of perf_event_read_local() contains
the various error checks an event should pass before it can be
considered valid. Ensure that the potential scheduling failure
of a pinned event is checked for and have a credible error.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: acme@kernel.org
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/6486385d1f30336e9973b24c8c65f5079543d3d3.1537377064.git.reinette.chatre@intel.com

---
 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c80549bf82c6..dcb093e7b377 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3935,6 +3935,12 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
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
