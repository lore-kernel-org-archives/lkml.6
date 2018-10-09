Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A28AC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EF0214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EF0214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJEmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeJJEmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:42:06 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC8520C0A;
        Tue,  9 Oct 2018 21:23:13 +0000 (UTC)
Date:   Tue, 9 Oct 2018 17:23:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: Re: [RFC PATCH] kernel/panic: Filter out a potential trailing
 newline
Message-ID: <20181009172311.38c5dfef@vmware.local.home>
In-Reply-To: <20181009205019.2786-1-bp@alien8.de>
References: <20181009205019.2786-1-bp@alien8.de>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Oct 2018 22:50:19 +0200
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> If a call to panic() terminates the string with a \n, the result puts
> the closing brace ']---' on a newline because panic() itself adds \n
> too.
> 
> Now, if one goes and removes the newline chars from all panic()
> invocations - and the stats right now look like this:
> 
> ~300 calls with an \n
> ~500 calls without a \n
> 
> one is destined to a neverending game of whack-a-mole because the usual
> thing to do is add a newline at the end of a string a function is
> supposed to print.
> 
> Therefore, simply zap any \n at the end of the panic string to avoid
> touching so many places in the kernel.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: x86@kernel.org
> ---
>  kernel/panic.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 8b2e002d52eb..5776d2879650 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -136,7 +136,7 @@ void panic(const char *fmt, ...)
>  {
>  	static char buf[1024];
>  	va_list args;
> -	long i, i_next = 0;
> +	long i, i_next = 0, len;
>  	int state = 0;
>  	int old_cpu, this_cpu;
>  	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
> @@ -173,8 +173,12 @@ void panic(const char *fmt, ...)
>  	console_verbose();
>  	bust_spinlocks(1);
>  	va_start(args, fmt);
> -	vsnprintf(buf, sizeof(buf), fmt, args);
> +	len = vscnprintf(buf, sizeof(buf), fmt, args);
>  	va_end(args);
> +
> +	if (len && buf[len - 1] == '\n')
> +		buf[len - 1] = '\0';
> +
>  	pr_emerg("Kernel panic - not syncing: %s\n", buf);
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  	/*

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
