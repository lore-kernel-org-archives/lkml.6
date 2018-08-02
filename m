Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9314AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E132124D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2UV+cI0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E132124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeHBJlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbeHBJlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:41:07 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9082620C0B;
        Thu,  2 Aug 2018 07:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533196272;
        bh=dRf4IWvsOb0+s5PNAkmVD8UOGmN1JIlmNnaCeXxrX9I=;
        h=From:To:Cc:Subject:Date:From;
        b=2UV+cI0Dy5ZJ0k3XbbrS9OhO1vofHn3pHbUSq289R29JxFcmymF+YpDTSqxVcTWLE
         iNgm1/3kMbXtVT9qSE+RWE9OPw4l96wM6pdeJo9lOhi9ncTcehVJD1oBf7+jbEAikA
         qGip37lEa63j/wPnmX9ea38zPnN5quVlbZoEYtMQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, Shuah Khan <shuah@kernel.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH] tracing/kprobes: Fix within_notrace_func() to check only notrace functions
Date:   Thu,  2 Aug 2018 16:50:48 +0900
Message-Id: <153319624799.29007.13604430345640129926.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix within_notrace_func() to check only notrace functions
and to ignore the kprobe-event which can not solve symbol
address.

within_notrace_func() returns true if the given kprobe events
probe point seems like out-of-range. But that is not correct
place to check it, it should be done in kprobes afterwards.

kprobe-events allows user to define a probe point on "currently
unloaded module" so that it can trace the event while module
load. In this case, user will put a probe on a symbol which
is not in kallsyms yet and it hits the within_notrace_func().
In the result, kprobe-events always refuses if user defines
a probe on "currenly unloaded module".

Fixes: commit 45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index deeb03ae21e1..2e13f77b9a37 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -88,6 +88,7 @@ static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
 	return nhit;
 }
 
+/* Return 0 if it fails to find the symbol address */
 static nokprobe_inline
 unsigned long trace_kprobe_address(struct trace_kprobe *tk)
 {
@@ -96,7 +97,8 @@ unsigned long trace_kprobe_address(struct trace_kprobe *tk)
 	if (tk->symbol) {
 		addr = (unsigned long)
 			kallsyms_lookup_name(trace_kprobe_symbol(tk));
-		addr += tk->rp.kp.offset;
+		if (addr)
+			addr += tk->rp.kp.offset;
 	} else {
 		addr = (unsigned long)tk->rp.kp.addr;
 	}
@@ -519,8 +521,8 @@ static bool within_notrace_func(struct trace_kprobe *tk)
 	unsigned long offset, size, addr;
 
 	addr = trace_kprobe_address(tk);
-	if (!kallsyms_lookup_size_offset(addr, &size, &offset))
-		return true;	/* Out of range. */
+	if (!addr || !kallsyms_lookup_size_offset(addr, &size, &offset))
+		return false;
 
 	return !ftrace_location_range(addr - offset, addr - offset + size);
 }

