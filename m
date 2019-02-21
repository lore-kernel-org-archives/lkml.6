Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1845EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BC62084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550765808;
	bh=6Z60J6V8iIRle+JocqSM9UBFISn6DpwigjnmsrYpiGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AiO/lc2i8r9ZJqUh6EecedhBIhZ4u3y6KOBjrBsUhvP4ChdjNQzX2xaPbsWn3oLAf
	 8YxuLBftkgVVIuPXf8nrBeEWMrlN0y3sy6BdJ2Hz/u0M5fNvmWLg67XkEt8THsLhSO
	 naBW7BBzPwkodKk7WaxXmXFwaiWkJI3B95YLtojo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfBUQQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:16:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfBUQQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:16:47 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE84C20836;
        Thu, 21 Feb 2019 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550765806;
        bh=6Z60J6V8iIRle+JocqSM9UBFISn6DpwigjnmsrYpiGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K6VU9BuY3UUT3bFcrnzUBckAtWv27p1NxOnh8FEGRrcBARkwhxIcFWxQipbw6Bnnj
         OKFCqAuIhaICGup7zITqfY5IHzDo7px2tzGayMur+AbHtoiugZlc5Adh/E5LXxVgqP
         +/vHRcqGGruQOc7h0F4IwkKpWOBpE68YOTi8fqGg=
Date:   Fri, 22 Feb 2019 01:16:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-Id: <20190222011643.3e19ade84a3db3e83518648f@kernel.org>
In-Reply-To: <20190222005812.04c5940c693b14cfdbe6ede7@kernel.org>
References: <20190215174712.372898450@goodmis.org>
        <20190215174945.557218316@goodmis.org>
        <20190221165252.4a9033b3348f30f9d973dbc4@kernel.org>
        <20190221093625.56afccd2@gandalf.local.home>
        <20190222005812.04c5940c693b14cfdbe6ede7@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, 22 Feb 2019 00:58:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 21 Feb 2019 09:36:25 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 21 Feb 2019 16:52:52 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Basically OK to me.
> > > Could you use probe_kernel_read() in this context, since probe_mem_read() is a
> > > wrapper function for template code.
> > > 
> > > With that change,
> > > 
> > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > This already hit Linus's tree. I was able to reproduce the crash, so I
> > streamlined it. I should have still pushed more for your ack first.
> > Sorry about that.
> 
> Oh, never mind. That seems urgent issue for kprobe event.
> Thank you very much for fixing it!
> 
> > For some reason, I thought the change was in the generic probe code,
> > and accepted the probe_mem_read(). Anyway, did you want to send a patch
> > to change it to probe_kernel_read(), for the merge window?
> 
> No problem.

Oops, I mean No, not yet. but it is a simple and cosmetic patch like below.
Feel free to merge it to ftrace/core.

---------
tracing/kprobes: Use probe_kernel_read instead of probe_mem_read

From: Masami Hiramatsu <mhiramat@kernel.org>

Use probe_kernel_read() instead of probe_mem_read() because
probe_mem_read() is a kind of wrapper for switching memory
read function between uprobes and kprobes.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9eaf07f99212..99592c27465e 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -865,7 +865,7 @@ fetch_store_strlen(unsigned long addr)
 	u8 c;
 
 	do {
-		ret = probe_mem_read(&c, (u8 *)addr + len, 1);
+		ret = probe_kernel_read(&c, (u8 *)addr + len, 1);
 		len++;
 	} while (c && ret == 0 && len < MAX_STRING_SIZE);
 

-- 
Masami Hiramatsu <mhiramat@kernel.org>
