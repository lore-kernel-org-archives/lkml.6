Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6943CC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C3820843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C3820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeGYPcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:32:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727881AbeGYPcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:32:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DBD8E40216E1;
        Wed, 25 Jul 2018 14:21:00 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFFC62026D68;
        Wed, 25 Jul 2018 14:21:00 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id CBB392C075D; Wed, 25 Jul 2018 16:20:59 +0200 (CEST)
From:   Artem Savkov <asavkov@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCH v2] tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure
Date:   Wed, 25 Jul 2018 16:20:38 +0200
Message-Id: <20180725142038.4765-1-asavkov@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 25 Jul 2018 14:21:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 25 Jul 2018 14:21:00 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'asavkov@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If enable_trace_kprobe fails to enable the probe in enable_k(ret)probe
it returns an error, but does not unset the tp flags it set previously.
This results in a probe being considered enabled and failures like being
unable to remove the probe through kprobe_events file since probes_open()
expects every probe to be disabled.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 kernel/trace/trace_kprobe.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 21f718472942..27ace4513c43 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -400,11 +400,10 @@ static struct trace_kprobe *find_trace_kprobe(const char *event,
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
@@ -424,6 +423,16 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
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
-- 
2.13.6

