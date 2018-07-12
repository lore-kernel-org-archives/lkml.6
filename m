Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED867C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C35F20652
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C35F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbeGLDFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbeGLDFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:05:10 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC8F20652;
        Thu, 12 Jul 2018 02:57:48 +0000 (UTC)
Date:   Wed, 11 Jul 2018 22:57:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring_buffer: Update logging to use single line output
Message-ID: <20180711225745.6e66c10f@vmware.local.home>
In-Reply-To: <24f146a8726f391736bc79306e64b204435eb4ec.camel@perches.com>
References: <cover.1525964381.git.joe@perches.com>
        <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
        <20180510122843.0b69b41a@gandalf.local.home>
        <24f146a8726f391736bc79306e64b204435eb4ec.camel@perches.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018 14:39:18 -0700
Joe Perches <joe@perches.com> wrote:

> With a possible change to pr_fmt coming, the logging output can
> become unbalanced when an initial line has a prefix and subsequent
> lines do not when a multiple line pr_<level> is emitted.
> 
> Fix it by emitting a single line.
> 
>  	Miscellanea:
> 
> o Convert consecutive tests of total_lost and !total_lost to if/else

I just noticed this patch. Please don't send patches Cc'd to other
threads. They need to start a new thread, otherwise, like this one, it
will most likely be lost.

If you want this applied still, please resend it properly.

-- Steve

> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  kernel/trace/ring_buffer.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c9cb9767d49b..ee74494a2da3 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5132,10 +5132,9 @@ static __init int test_ringbuffer(void)
>  		pr_info("        total events:   %ld\n", total_lost + total_read);
>  		pr_info("  recorded len bytes:   %ld\n", total_len);
>  		pr_info(" recorded size bytes:   %ld\n", total_size);
> -		if (total_lost)
> -			pr_info(" With dropped events, record len and size may not match\n"
> -				" alloced and written from above\n");
> -		if (!total_lost) {
> +		if (total_lost) {
> +			pr_info(" With dropped events, record len and size may not match alloced and written from above\n");
> +		} else {
>  			if (RB_WARN_ON(buffer, total_len != total_alloc ||
>  				       total_size != total_written))
>  				break;

