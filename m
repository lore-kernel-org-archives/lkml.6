Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E76BECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31893214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31893214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeJTJj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbeJTJj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:39:28 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E853B21502;
        Sat, 20 Oct 2018 01:30:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gDg6M-0006Ez-Vy; Fri, 19 Oct 2018 21:30:50 -0400
Message-Id: <20181020013050.887139521@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Oct 2018 21:30:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/3] tracing: Fix synthetic event to allow semicolon at end
References: <20181020012958.223064271@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix synthetic event to allow independent semicolon at end.

The synthetic_events interface accepts a semicolon after the
last word if there is no space.

 # echo "myevent u64 var;" >> synthetic_events

But if there is a space, it returns an error.

 # echo "myevent u64 var ;" > synthetic_events
 sh: write error: Invalid argument

This behavior is difficult for users to understand. Let's
allow the last independent semicolon too.

Link: http://lkml.kernel.org/r/153986835420.18251.2191216690677025744.stgit@devbox

Cc: Shuah Khan <shuah@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: stable@vger.kernel.org
Fixes: commit 4b147936fa50 ("tracing: Add support for 'synthetic' events")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6ff83941065a..d239004aaf29 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1088,7 +1088,7 @@ static int create_synth_event(int argc, char **argv)
 		i += consumed - 1;
 	}
 
-	if (i < argc) {
+	if (i < argc && strcmp(argv[i], ";") != 0) {
 		ret = -EINVAL;
 		goto err;
 	}
-- 
2.19.0


