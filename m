Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3C6C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94A9217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94A9217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeHKQYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbeHKQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1AB721D08;
        Sat, 11 Aug 2018 13:50:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHX-0006DA-LX; Sat, 11 Aug 2018 09:50:15 -0400
Message-Id: <20180811135015.564229760@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 25/34] tracing/kprobes: Fix within_notrace_func() to check only notrace
 functions
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix within_notrace_func() to check only notrace functions and to ignore the
kprobe-event which can not solve symbol addresses.

within_notrace_func() returns true if the given kprobe events probe point
seems to be out-of-range. But that is not the correct place to check for it,
it should be done in kprobes afterwards.

kprobe-events allow users to define a probe point on "currently unloaded
module" so that it can trace the event during module load. In this case, the
user will put a probe on a symbol which is not in kallsyms yet and it hits
the within_notrace_func().  As a result, kprobe-events always refuses if
user defines a probe on a "currenly unloaded module".

Fixes: commit 45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function")
Link: http://lkml.kernel.org/r/153319624799.29007.13604430345640129926.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 8 +++++---
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
-- 
2.18.0


