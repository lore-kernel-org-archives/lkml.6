Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEBFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B742086D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCDl43y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B742086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeICTNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICTNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:13:14 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93CE20869;
        Mon,  3 Sep 2018 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535986363;
        bh=pALdNEIFLknNrngQgyn1PFMaxYL7zQd3f2N+BJkwLjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCDl43y7SSxYQ7gK1JXx8xBUHJJiuoJ92qrIsCl/ai1Q0w0uRGRPfOydlGOfAvtwe
         FZkhcsKkRWzuWb7cDQrMPb9hZnJnc3V5sLPrnDcblmYI0AmV746cPB8m5d4zjoKpTM
         ZfSIoXU+eKXpNC0lxs/WY24ZFbYI65FoTy5vpHQM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/13] perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set
Date:   Mon,  3 Sep 2018 11:52:14 -0300
Message-Id: <20180903145224.12318-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We need to change the breakpoint even if the attr with new fields has
disabled set to true.

Current code prevents following user code to change the breakpoint
address:

  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[0]), addr_1)
  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[0]), addr_2)
  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[7]), dr7)

The first PTRACE_POKEUSER creates the breakpoint with attr.disabled set
to true:

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

Reported-by: Milind Chabbi <chabbi.milind@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180827091228.2878-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

