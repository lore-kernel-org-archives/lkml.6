Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51927ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0593820864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0593820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbeGPIDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:03:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPIDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:03:47 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3EF0CA0;
        Mon, 16 Jul 2018 07:37:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.17 19/67] tracing/kprobe: Release kprobe print_fmt properly
Date:   Mon, 16 Jul 2018 09:34:48 +0200
Message-Id: <20180716073446.154544715@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 0fc8c3581dd42bc8f530314ca86db2d861485731 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_kprobe.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1451,8 +1451,10 @@ create_local_trace_kprobe(char *func, vo
 	}
 
 	ret = __register_trace_kprobe(tk);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(tk->tp.call.print_fmt);
 		goto error;
+	}
 
 	return &tk->tp.call;
 error:
@@ -1472,6 +1474,8 @@ void destroy_local_trace_kprobe(struct t
 	}
 
 	__unregister_trace_kprobe(tk);
+
+	kfree(tk->tp.call.print_fmt);
 	free_trace_kprobe(tk);
 }
 #endif /* CONFIG_PERF_EVENTS */


