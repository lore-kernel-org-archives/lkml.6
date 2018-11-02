Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C6CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45232081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45232081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeKBXBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbeKBXBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:01:40 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4508A2081F;
        Fri,  2 Nov 2018 13:54:26 +0000 (UTC)
Date:   Fri, 2 Nov 2018 09:54:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH] tracing/kprobes: Fix strpbrk() argument order
Message-ID: <20181102095424.20c500ea@gandalf.local.home>
In-Reply-To: <20181102161459.86f0622bd01518a2eb06e1d5@kernel.org>
References: <154108256792.2604.1816052586385217811.stgit@devbox>
 <20181101151014.2feccd51@gandalf.local.home>
 <20181102161459.86f0622bd01518a2eb06e1d5@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018 16:14:59 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 1 Nov 2018 15:10:14 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu,  1 Nov 2018 23:29:28 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > Fix strpbrk()'s argument order, it must pass acceptable string
> > > in 2nd argument. Note that this can cause a kernel panic where
> > > it recovers backup character to code->data.
> > > 
> > > Fixes: a6682814f371 ("tracing/kprobes: Allow kprobe-events to record module symbol")
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>  
> > 
> > Thanks Masami,
> > 
> > I'm pulling this and starting to test it.  
> 
> Thank you! I still couldn't believe how this bug passed through the tests...

I am too. I'm running tests with and without this patch, and the patch
doesn't appear to be making much difference.

Then I tested with this:

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 3ef15a6683c0..4ddafddf1343 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -516,6 +516,7 @@ void traceprobe_free_probe_arg(struct probe_arg
*arg) kfree(code->data);
 		code++;
 	}
+	printk("free arg->code %s\n", arg->code);
 	kfree(arg->code);
 	kfree(arg->name);
 	kfree(arg->comm);
@@ -535,11 +536,15 @@ int traceprobe_update_arg(struct probe_arg *arg)
 			if (code[1].op != FETCH_OP_IMM)
 				return -EINVAL;
 
+			tmp = strpbrk(code->data, "+-");
+			printk("first tmp tmp=%s\n", tmp);
 			tmp = strpbrk("+-", code->data);
+			printk("second tmp=%s data=%s\n", tmp,
code->data); if (tmp)
 				c = *tmp;
 			ret =
traceprobe_split_symbol_offset(code->data, &offset);
+			printk("third data=%s\n", code->data);
 			if (ret)
 				return ret;
 
@@ -547,6 +552,7 @@ int traceprobe_update_arg(struct probe_arg *arg)
 				(unsigned
long)kallsyms_lookup_name(code->data); if (tmp)
 				*tmp = c;
+			printk("forth data=%s\n", code->data);
 			if (!code[1].immediate)
 				return -ENOENT;
 			code[1].immediate += offset;

And I don't see where that code->data is used elsewhere. That is, why
even bother saving the character?

-- Steve
