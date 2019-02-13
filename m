Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95B6C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD57222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbfBMBlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:41:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfBMBlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:41:16 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C4402190A;
        Wed, 13 Feb 2019 01:41:14 +0000 (UTC)
Date:   Tue, 12 Feb 2019 20:41:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     CC Hwang <cc.hwang@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andress Kuo <andress.kuo@mediatek.com>
Subject: Re: [PATCH 1/1] tracing: Fix event_trace_printk loss on
 printk_format.
Message-ID: <20190212204113.5ecaa2a1@gandalf.local.home>
In-Reply-To: <1549971717-4693-1-git-send-email-mars.cheng@mediatek.com>
References: <1549971717-4693-1-git-send-email-mars.cheng@mediatek.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 19:41:57 +0800
Mars Cheng <mars.cheng@mediatek.com> wrote:

> From: Andress Kuo <andress.kuo@mediatek.com>
> 
> If fmt on event_trace_printk is not a constant, It means that something not
> guaranteed, so the compiler optimizes the fmt out, and then the
> __trace_printk_fmt section is not filled. if __trace_printk_fmt is not
> filled, the kernel will not allocate the special buffers needed for the
> event_trace_printk() and then not shown in the file output
> sys/kernel/debug/tracing/print_formats.
> 
> Adding a "__used" to the variable in the __trace_printk_fmt section on
> event_trace_printk() will keep it around, even though it is set to NULL.
> This will keep the string from being printed in the
> sys/kernel/debug/tracing/printk_formats section.
> 
> We can also refer to commit 3debb0a9ddb1 ("tracing: Fix trace_printk()
> to print when not using bprintk()")that it had similar issue on path of
> trace_printk().

Honestly, I don't even remember why that macro was created. I think
it's a remnant from the creation of the trace events. I think the best
solution is just to nuke it. It shouldn't be used anymore.

I'll dig a bit deeper into the history of that macro, but I'm thinking
it shouldn't exist anymore.

[ /me returns from walking down memory lane ]

Wow, that brings back some wild memories. Yes, that macro must die, and
I wish the history of it could die along with it ;-) The horror of the
old ways I tell you. The event_trace_printk() was the original way we
displayed events! No real formatting, no parsing my userspace tools. It
was just a glamorized printk. It was called TRACE_FORMAT() which was
deprecated by today's TRACE_EVENT().

That macro should have been removed by commit b8e65554d80b4.

Please just send a patch to delete that macro. Let's not be maintaining
it. It gives me nightmares.

-- Steve

> 
> Signed-off-by: Andress Kuo <andress.kuo@mediatek.com>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  include/linux/trace_events.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 8a62731..26bd7c4 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -551,7 +551,7 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
>  	__trace_printk_check_format(fmt, ##args);			\
>  	tracing_record_cmdline(current);				\
>  	if (__builtin_constant_p(fmt)) {				\
> -		static const char *trace_printk_fmt			\
> +		static const char *trace_printk_fmt __used		\
>  		  __attribute__((section("__trace_printk_fmt"))) =	\
>  			__builtin_constant_p(fmt) ? fmt : NULL;		\
>  									\

