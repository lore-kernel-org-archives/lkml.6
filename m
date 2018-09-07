Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52D2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893FB2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893FB2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeIHCXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:23:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeIHCXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:23:00 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 54085FEF;
        Fri,  7 Sep 2018 21:40:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erica Bugden <erica.bugden@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.4 21/47] tracing: Do not call start/stop() functions when tracing_on does not change
Date:   Fri,  7 Sep 2018 23:10:17 +0200
Message-Id: <20180907210906.641124584@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
References: <20180907210904.607934824@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit f143641bfef9a4a60c57af30de26c63057e7e695 upstream.

Currently, when one echo's in 1 into tracing_on, the current tracer's
"start()" function is executed, even if tracing_on was already one. This can
lead to strange side effects. One being that if the hwlat tracer is enabled,
and someone does "echo 1 > tracing_on" into tracing_on, the hwlat tracer's
start() function is called again which will recreate another kernel thread,
and make it unable to remove the old one.

Link: http://lkml.kernel.org/r/1533120354-22923-1-git-send-email-erica.bugden@linutronix.de

Cc: stable@vger.kernel.org
Fixes: 2df8f8a6a897e ("tracing: Fix regression with irqsoff tracer and tracing_on file")
Reported-by: Erica Bugden <erica.bugden@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6496,7 +6496,9 @@ rb_simple_write(struct file *filp, const
 
 	if (buffer) {
 		mutex_lock(&trace_types_lock);
-		if (val) {
+		if (!!val == tracer_tracing_is_on(tr)) {
+			val = 0; /* do nothing */
+		} else if (val) {
 			tracer_tracing_on(tr);
 			if (tr->current_trace->start)
 				tr->current_trace->start(tr);


