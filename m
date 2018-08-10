Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9354BC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A672240E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A672240E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeHJOFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:05:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727445AbeHJOFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:05:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 695CD40241C3;
        Fri, 10 Aug 2018 11:35:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 00DC910F1C0B;
        Fri, 10 Aug 2018 11:35:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 10 Aug 2018 13:35:51 +0200 (CEST)
Date:   Fri, 10 Aug 2018 13:35:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "zhangwei(Jovi)" <jovi.zhangwei@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] uprobes: Use synchronize_rcu() not synchronize_sched()
Message-ID: <20180810113548.GA3677@redhat.com>
References: <20180809160553.469e1e32@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809160553.469e1e32@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 10 Aug 2018 11:35:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 10 Aug 2018 11:35:51 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09, Steven Rostedt wrote:
>
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -952,7 +952,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
>
>  		list_del_rcu(&link->list);
>  		/* synchronize with u{,ret}probe_trace_func */
> -		synchronize_sched();
> +		synchronize_rcu();

Can't we change uprobe_trace_func() and uretprobe_trace_func() to use
rcu_read_lock_sched() instead? It is more cheap.


Hmm. probe_event_enable() does list_del + kfree on failure, this doesn't
look right... Not only because kfree() can race with list_for_each_entry_rcu(),
we should not put the 1st link on list until uprobe_buffer_enable().

Does the patch below make sense or I am confused?

Oleg.


--- x/kernel/trace/trace_uprobe.c
+++ x/kernel/trace/trace_uprobe.c
@@ -896,8 +896,6 @@ probe_event_enable(struct trace_uprobe *
 			return -ENOMEM;
 
 		link->file = file;
-		list_add_tail_rcu(&link->list, &tu->tp.files);
-
 		tu->tp.flags |= TP_FLAG_TRACE;
 	} else {
 		if (tu->tp.flags & TP_FLAG_TRACE)
@@ -909,7 +907,7 @@ probe_event_enable(struct trace_uprobe *
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
 
 	if (enabled)
-		return 0;
+		goto add;
 
 	ret = uprobe_buffer_enable();
 	if (ret)
@@ -920,7 +918,8 @@ probe_event_enable(struct trace_uprobe *
 	ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
 	if (ret)
 		goto err_buffer;
-
+ add:
+	list_add_tail_rcu(&link->list, &tu->tp.files);
 	return 0;
 
  err_buffer:
@@ -928,7 +927,6 @@ probe_event_enable(struct trace_uprobe *
 
  err_flags:
 	if (file) {
-		list_del(&link->list);
 		kfree(link);
 		tu->tp.flags &= ~TP_FLAG_TRACE;
 	} else {

