Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF05C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C21D22404
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C21D22404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeHJNRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:17:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbeHJNRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:17:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAFAC81663D7;
        Fri, 10 Aug 2018 10:47:40 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 856732026DEF;
        Fri, 10 Aug 2018 10:47:37 +0000 (UTC)
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
Subject: [PATCH 2/5] perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set
Date:   Fri, 10 Aug 2018 12:47:27 +0200
Message-Id: <20180810104730.3293-3-jolsa@kernel.org>
In-Reply-To: <20180810104730.3293-1-jolsa@kernel.org>
References: <20180810104730.3293-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 10 Aug 2018 10:47:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 10 Aug 2018 10:47:45 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to change the breakpoint even if the attr with
new fields has disabled set to true.

Current code prevents following user code to change
the breakpoint address:

  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[0]), addr_1)
  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[0]), addr_2)
  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[7]), dr7)

The first PTRACE_POKEUSER creates the breakpoint with
attr.disabled set to true:

  ptrace_set_breakpoint_addr(nr = 0)
    struct perf_event *bp = t->ptrace_bps[nr];

    ptrace_register_breakpoint(..., disabled = true)
      ptrace_fill_bp_fields(..., disabled)
      register_user_hw_breakpoint

So the second PTRACE_POKEUSER will be omitted:

  ptrace_set_breakpoint_addr(nr = 0)
    struct perf_event *bp = t->ptrace_bps[nr];
    struct perf_event_attr attr = bp->attr;

    modify_user_hw_breakpoint(bp, &attr)
      if (!attr->disabled)
        modify_user_hw_breakpoint_check

Acked-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Milind Chabbi <chabbi.milind@gmail.com>
Link: http://lkml.kernel.org/n/tip-yjhgplc28gk5gfzt7ceooe6z@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/hw_breakpoint.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index b3814fce5ecb..fb229d9c7f3c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -509,6 +509,8 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
  */
 int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr)
 {
+	int err;
+
 	/*
 	 * modify_user_hw_breakpoint can be invoked with IRQs disabled and hence it
 	 * will not be possible to raise IPIs that invoke __perf_event_disable.
@@ -520,11 +522,11 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 	else
 		perf_event_disable(bp);
 
-	if (!attr->disabled) {
-		int err = modify_user_hw_breakpoint_check(bp, attr, false);
+	err = modify_user_hw_breakpoint_check(bp, attr, false);
+	if (err)
+		return err;
 
-		if (err)
-			return err;
+	if (!attr->disabled) {
 		perf_event_enable(bp);
 		bp->attr.disabled = 0;
 	}
-- 
2.17.1

