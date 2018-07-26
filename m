Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFF3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA9920857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA9920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbeG0AZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731953AbeG0AZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:25:51 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 578202089B;
        Thu, 26 Jul 2018 23:06:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fipLQ-0006BZ-Ck; Thu, 26 Jul 2018 19:06:52 -0400
Message-Id: <20180726230652.286536726@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 26 Jul 2018 19:06:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>
Subject: [PATCH 6/7] tracing: Quiet gcc warning about maybe unused link variable
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Commit 57ea2a34adf4 ("tracing/kprobes: Fix trace_probe flags on
enable_trace_kprobe() failure") added an if statement that depends on another
if statement that gcc doesn't see will initialize the "link" variable and
gives the warning:

 "warning: 'link' may be used uninitialized in this function"

It is really a false positive, but to quiet the warning, and also to make
sure that it never actually is used uninitialized, initialize the "link"
variable to NULL and add an if (!WARN_ON_ONCE(!link)) where the compiler
thinks it could be used uninitialized.

Cc: stable@vger.kernel.org
Fixes: 57ea2a34adf4 ("tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 27ace4513c43..6b71860f3998 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -400,7 +400,7 @@ static struct trace_kprobe *find_trace_kprobe(const char *event,
 static int
 enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 {
-	struct event_file_link *link;
+	struct event_file_link *link = NULL;
 	int ret = 0;
 
 	if (file) {
@@ -426,7 +426,9 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 
 	if (ret) {
 		if (file) {
-			list_del_rcu(&link->list);
+			/* Notice the if is true on not WARN() */
+			if (!WARN_ON_ONCE(!link))
+				list_del_rcu(&link->list);
 			kfree(link);
 			tk->tp.flags &= ~TP_FLAG_TRACE;
 		} else {
-- 
2.17.1


