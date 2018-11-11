Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A638CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA5620818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA5620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbeKLGQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:16:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50812 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730598AbeKLFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:26 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsl-0000lK-Cf; Sun, 11 Nov 2018 19:58:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001mf-Ce; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Artem Savkov" <asavkov@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.138562304@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 295/366] tracing/kprobes: Fix trace_probe flags on
 enable_trace_kprobe() failure
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Fixes: 41a7dd420c57 ("tracing/kprobes: Support ftrace_event_file base multibuffer")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/trace_kprobe.c | 13 +++++++++++--
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

