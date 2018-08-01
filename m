Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708A1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288F22083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288F22083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406735AbeHATMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:12:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405036AbeHATMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:12:06 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 18E46CC3;
        Wed,  1 Aug 2018 17:25:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Artem Savkov <asavkov@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.9 008/144] tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure
Date:   Wed,  1 Aug 2018 18:50:35 +0200
Message-Id: <20180801164949.509736802@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -359,11 +359,10 @@ static struct trace_kprobe *find_trace_k
 static int
 enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 {
+	struct event_file_link *link;
 	int ret = 0;
 
 	if (file) {
-		struct event_file_link *link;
-
 		link = kmalloc(sizeof(*link), GFP_KERNEL);
 		if (!link) {
 			ret = -ENOMEM;
@@ -383,6 +382,16 @@ enable_trace_kprobe(struct trace_kprobe
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


