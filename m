Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29031C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E373120878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E373120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeGIOTN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:19:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932923AbeGIOTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:19:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC08087A6C;
        Mon,  9 Jul 2018 14:19:09 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-174.brq.redhat.com [10.40.204.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1467A2026D6B;
        Mon,  9 Jul 2018 14:19:06 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>, Josef Bacik <jbacik@fb.com>,
        daniel@iogearbox.net, davem@davemloft.net,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] tracing/kprobe: Release kprobe print_fmt properly
Date:   Mon,  9 Jul 2018 16:19:06 +0200
Message-Id: <20180709141906.2390-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 09 Jul 2018 14:19:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 09 Jul 2018 14:19:09 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't release tk->tp.call.print_fmt when destroying
local uprobe. Also there's missing print_fmt kfree in
create_local_trace_kprobe error path.

Fixes: e12f03d7031a ("perf/core: Implement the 'perf_kprobe' PMU")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/trace_kprobe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

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
-- 
2.17.1

