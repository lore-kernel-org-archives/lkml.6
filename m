Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6178C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E60320859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390631AbfAPNkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbfAPNkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:40:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83EA20675;
        Wed, 16 Jan 2019 13:40:22 +0000 (UTC)
Date:   Wed, 16 Jan 2019 08:40:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/uprobes: Fix output for multiple string
 arguments
Message-ID: <20190116084021.34b0beee@gandalf.local.home>
In-Reply-To: <20190116094112.16043-1-andreas.ziegler@fau.de>
References: <8b67136d-28d7-a734-6366-9511e30d66a7@fau.de>
        <20190116094112.16043-1-andreas.ziegler@fau.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 10:41:12 +0100
Andreas Ziegler <andreas.ziegler@fau.de> wrote:

> When printing multiple uprobe arguments as strings the output for the
> earlier arguments would also include all later string arguments.
> 
> This is best explained in an example:
> 
> Consider adding a uprobe to a function receiving two strings as
> parameters which is at offset 0xa0 in strlib.so and we want to print
> both parameters when the uprobe is hit (on x86_64):
> 
> $ echo 'p:func /lib/strlib.so:0xa0 +0(%di):string +0(%si):string' > \
>     /sys/kernel/debug/tracing/uprobe_events
> 
> When the function is called as func("foo", "bar") and we hit the probe,
> the trace file shows a line like the following:
> 
>   [...] func: (0x7f7e683706a0) arg1="foobar" arg2="bar"
> 
> Note the extra "bar" printed as part of arg1. This behaviour stacks up
> for additional string arguments.
> 
> The strings are stored in a dynamically growing part of the uprobe
> buffer by fetch_store_string() after copying them from userspace via
> strncpy_from_user(). The return value of strncpy_from_user() is then
> directly used as the required size for the string. However, this does
> not take the terminating null byte into account as the documentation
> for strncpy_from_user() cleary states that it "[...] returns the
> length of the string (not including the trailing NUL)" even though the
> null byte will be copied to the destination.
> 
> Therefore, subsequent calls to fetch_store_string() will overwrite
> the terminating null byte of the most recently fetched string with
> the first character of the current string, leading to the
> "accumulation" of strings in earlier arguments in the output.
> 
> Fix this by incrementing the return value of strncpy_from_user() by
> one if we did not hit the maximum buffer size.
> 
> Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
> ---
>  kernel/trace/trace_uprobe.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index e335576b9411..dfb9bbc7fd82 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -160,6 +160,13 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
>  	if (ret >= 0) {
>  		if (ret == maxlen)
>  			dst[ret - 1] = '\0';
> +		else if (ret > 0)

Do we need the ret > 0 check? What if the value is ""?

Doesn't that cause the same issue?

-- Steve

> +			/*
> +			 * Include the terminating null byte. In this case it
> +			 * was copied by strncpy_from_user but not accounted
> +			 * for in ret.
> +			 */
> +			ret++;
>  		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
>  	}
>  

