Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C6C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D042150A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D042150A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeHIO1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:27:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730261AbeHIO1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:27:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1063C83221;
        Thu,  9 Aug 2018 12:03:20 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5300C10B7C95;
        Thu,  9 Aug 2018 12:03:18 +0000 (UTC)
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
Subject: [PATCH 5/5] perf/hw_breakpoint: Add fallback code for ptrace_set_breakpoint_addr
Date:   Thu,  9 Aug 2018 14:03:05 +0200
Message-Id: <20180809120305.20693-6-jolsa@kernel.org>
In-Reply-To: <20180809120305.20693-1-jolsa@kernel.org>
References: <20180809120305.20693-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 09 Aug 2018 12:03:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 09 Aug 2018 12:03:20 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restoring the breakpoint after unsuccesfull address change,
so following user code no longer produces disabled breakpoint.

  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[0]), addr_1)
  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[7]), dr7)
  ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[0]), -1)

The first 2 ptrace calls set breakpoint on addr_1. The 3rd ptrace
call tries to set it to bogus address (-1). This would normaly
end up with disabled breakpoint. This patch adds the code that
restores the breakpoint to its original state.

Link: http://lkml.kernel.org/n/tip-h9ut835vl297roen0v163zg6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/ptrace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index e2ee403865eb..22c06d0a38d1 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -693,9 +693,14 @@ static int ptrace_set_breakpoint_addr(struct task_struct *tsk, int nr,
 			t->ptrace_bps[nr] = bp;
 	} else {
 		struct perf_event_attr attr = bp->attr;
+		bool disabled = attr.disabled;
 
 		attr.bp_addr = addr;
 		err = modify_user_hw_breakpoint(bp, &attr);
+		if (err && !disabled) {
+			bp->attr.disabled = false;
+			WARN_ON(modify_user_hw_breakpoint(bp, &bp->attr));
+		}
 	}
 
 	return err;
-- 
2.17.1

