Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F045C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0622151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0622151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390627AbeHGVNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:13:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390615AbeHGVNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:13:00 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E3DEF74;
        Tue,  7 Aug 2018 18:57:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Artem Savkov <asavkov@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 3.18 03/85] tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure
Date:   Tue,  7 Aug 2018 20:51:05 +0200
Message-Id: <20180807172357.484221359@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Savkov <asavkov@redhat.com>

commit 57ea2a34adf40f3a6e88409aafcf803b8945619a upstream.

If enable_trace_kprobe fails to enable the probe in enable_k(ret)probe
it returns an error, but does not unset the tp flags it set previously.
This results in a probe being considered enabled and failures like being
unable to remove the probe through kprobe_events file since probes_open()
expects every probe to be disabled.

Link: http://lkml.kernel.org/r/20180725102826.8300-1-asavkov@redhat.com
Link: http://lkml.kernel.org/r/20180725142038.4765-1-asavkov@redhat.com

Cc: Ingo Molnar <mingo@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 41a7dd420c57 ("tracing/kprobes: Support ftrace_event_file base multibuffer")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_kprobe.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -361,11 +361,10 @@ static struct trace_kprobe *find_trace_k
 static int
 enable_trace_kprobe(struct trace_kprobe *tk, struct ftrace_event_file *file)
 {
+	struct event_file_link *link;
 	int ret = 0;
 
 	if (file) {
-		struct event_file_link *link;
-
 		link = kmalloc(sizeof(*link), GFP_KERNEL);
 		if (!link) {
 			ret = -ENOMEM;
@@ -385,6 +384,16 @@ enable_trace_kprobe(struct trace_kprobe
 		else
 			ret = enable_kprobe(&tk->rp.kp);
 	}
+
+	if (ret) {
+		if (file) {
+			list_del_rcu(&link->list);
+			kfree(link);
+			tk->tp.flags &= ~TP_FLAG_TRACE;
+		} else {
+			tk->tp.flags &= ~TP_FLAG_PROFILE;
+		}
+	}
  out:
 	return ret;
 }


