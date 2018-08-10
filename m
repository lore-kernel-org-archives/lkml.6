Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C78EC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3160622404
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3160622404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeHJNRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:17:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbeHJNRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:17:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52F3472620;
        Fri, 10 Aug 2018 10:47:46 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 980132026D65;
        Fri, 10 Aug 2018 10:47:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 4/5] perf/hw_breakpoint: Enable breakpoint in modify_user_hw_breakpoint
Date:   Fri, 10 Aug 2018 12:47:29 +0200
Message-Id: <20180810104730.3293-5-jolsa@kernel.org>
In-Reply-To: <20180810104730.3293-1-jolsa@kernel.org>
References: <20180810104730.3293-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 10 Aug 2018 10:47:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 10 Aug 2018 10:47:51 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we enable the breakpoint back only if the breakpoint
modification was successful. If it fails we can leave the
breakpoint in disabled state with attr->disabled == 0.

We can safely enable the breakpoint back for both the fail
and success paths by checking the bp->attr.disabled, which
either holds the new 'requested' disabled state or the
original breakpoint state.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Link: http://lkml.kernel.org/n/tip-79p9ttocwy2ju2s6qh25dvre@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/hw_breakpoint.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 3e560d7609fd..d6b56180827c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -523,13 +523,11 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 		perf_event_disable(bp);
 
 	err = modify_user_hw_breakpoint_check(bp, attr, false);
-	if (err)
-		return err;
 
-	if (!attr->disabled)
+	if (!bp->attr.disabled)
 		perf_event_enable(bp);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
 
-- 
2.17.1

