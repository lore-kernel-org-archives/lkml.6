Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1171C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739A02081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739A02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeJ3WI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbeJ3WI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:08:27 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A35A20831;
        Tue, 30 Oct 2018 13:15:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gHTrK-0002fv-68; Tue, 30 Oct 2018 09:15:02 -0400
Message-Id: <20181030131502.089269375@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 30 Oct 2018 09:13:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Rajvi Jingar <rajvi.jingar@intel.com>, stable@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/2] tracing: Return -ENOENT if there is no target synthetic event
References: <20181030131332.141023797@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Return -ENOENT error if there is no target synthetic event.
This notices an operation failure to user as below;

  # echo 'wakeup_latency u64 lat; pid_t pid;' > synthetic_events
  # echo '!wakeup' >> synthetic_events
  sh: write error: No such file or directory

Link: http://lkml.kernel.org/r/154013449986.25576.9487131386597290172.stgit@devbox

Acked-by: Tom Zanussi <zanussi@linux.intel.com>
Tested-by: Tom Zanussi <zanussi@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Rajvi Jingar <rajvi.jingar@intel.com>
Cc: stable@vger.kernel.org
Fixes: 4b147936fa50 ('tracing: Add support for 'synthetic' events')
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d239004aaf29..eb908ef2ecec 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1063,8 +1063,10 @@ static int create_synth_event(int argc, char **argv)
 		event = NULL;
 		ret = -EEXIST;
 		goto out;
-	} else if (delete_event)
+	} else if (delete_event) {
+		ret = -ENOENT;
 		goto out;
+	}
 
 	if (argc < 2) {
 		ret = -EINVAL;
-- 
2.19.0


