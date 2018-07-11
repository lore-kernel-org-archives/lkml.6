Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCBBC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0203820C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0203820C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbeGKUIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbeGKUI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:08:29 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADB720C0E;
        Wed, 11 Jul 2018 20:02:33 +0000 (UTC)
Date:   Wed, 11 Jul 2018 16:02:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>
Subject: [GIT PULL][PATCH] tracing/kprobe: Release kprobe print_fmt properly
Message-ID: <20180711160231.6282da07@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This fixes a memory leak in the kprobe code.


Please pull the latest trace-v4.18-rc3-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.18-rc3-2

Tag SHA1: 2dc4f4a15fc23494d3fe5af7e1598923825d5da9
Head SHA1: 0fc8c3581dd42bc8f530314ca86db2d861485731


Jiri Olsa (1):
      tracing/kprobe: Release kprobe print_fmt properly

----
 kernel/trace/trace_kprobe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---------------------------
commit 0fc8c3581dd42bc8f530314ca86db2d861485731
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Mon Jul 9 16:19:06 2018 +0200

    tracing/kprobe: Release kprobe print_fmt properly
    
    We don't release tk->tp.call.print_fmt when destroying
    local uprobe. Also there's missing print_fmt kfree in
    create_local_trace_kprobe error path.
    
    Link: http://lkml.kernel.org/r/20180709141906.2390-1-jolsa@kernel.org
    
    Cc: stable@vger.kernel.org
    Fixes: e12f03d7031a ("perf/core: Implement the 'perf_kprobe' PMU")
    Acked-by: Song Liu <songliubraving@fb.com>
    Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Jiri Olsa <jolsa@kernel.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index daa81571b22a..21f718472942 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1480,8 +1480,10 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	}
 
 	ret = __register_trace_kprobe(tk);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(tk->tp.call.print_fmt);
 		goto error;
+	}
 
 	return &tk->tp.call;
 error:
@@ -1501,6 +1503,8 @@ void destroy_local_trace_kprobe(struct trace_event_call *event_call)
 	}
 
 	__unregister_trace_kprobe(tk);
+
+	kfree(tk->tp.call.print_fmt);
 	free_trace_kprobe(tk);
 }
 #endif /* CONFIG_PERF_EVENTS */
