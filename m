Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D606BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DE6204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DE6204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbeIHCXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:23:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54376 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbeIHCXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:23:10 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BA1DDFEF;
        Fri,  7 Sep 2018 21:40:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.4 24/47] uprobes: Use synchronize_rcu() not synchronize_sched()
Date:   Fri,  7 Sep 2018 23:10:20 +0200
Message-Id: <20180907210907.327312282@linuxfoundation.org>
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

commit 016f8ffc48cb01d1e7701649c728c5d2e737d295 upstream.

While debugging another bug, I was looking at all the synchronize*()
functions being used in kernel/trace, and noticed that trace_uprobes was
using synchronize_sched(), with a comment to synchronize with
{u,ret}_probe_trace_func(). When looking at those functions, the data is
protected with "rcu_read_lock()" and not with "rcu_read_lock_sched()". This
is using the wrong synchronize_*() function.

Link: http://lkml.kernel.org/r/20180809160553.469e1e32@gandalf.local.home

Cc: stable@vger.kernel.org
Fixes: 70ed91c6ec7f8 ("tracing/uprobes: Support ftrace_event_file base multibuffer")
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_uprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -969,7 +969,7 @@ probe_event_disable(struct trace_uprobe
 
 		list_del_rcu(&link->list);
 		/* synchronize with u{,ret}probe_trace_func */
-		synchronize_sched();
+		synchronize_rcu();
 		kfree(link);
 
 		if (!list_empty(&tu->tp.files))


