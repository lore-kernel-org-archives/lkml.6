Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF31C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCBB21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbeLUSAY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbeLUSAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:00:24 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC6B3218E0;
        Fri, 21 Dec 2018 18:00:22 +0000 (UTC)
Date:   Fri, 21 Dec 2018 13:00:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [for-next][PATCH 09/24] seq_buf: Make seq_buf_puts()
 null-terminate the buffer
Message-ID: <20181221130021.6e66484f@gandalf.local.home>
In-Reply-To: <20181221175656.827708767@goodmis.org>
References: <20181221175618.968519903@goodmis.org>
        <20181221175656.827708767@goodmis.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 12:56:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> Currently seq_buf_puts() will happily create a non null-terminated
> string for you in the buffer. This is particularly dangerous if the
> buffer is on the stack.
> 
> For example:
> 
>   char buf[8];
>   char secret = "secret";
>   struct seq_buf s;
> 
>   seq_buf_init(&s, buf, sizeof(buf));
>   seq_buf_puts(&s, "foo");
>   printk("Message is %s\n", buf);
> 
> Can result in:
> 
>   Message is fooÂªÂªÂªÂªÂªsecret

Sending this via quilt, and that we have non UTF8 characters causes
LKML to blow up.

There's a couple more patches with this issue. I'm going to fix up the
change logs and rebase them.

-- Steve

> 
> We could require all users to memset() their buffer to zero before
> use. But that seems likely to be forgotten and lead to bugs.
> 
> Instead we can change seq_buf_puts() to always leave the buffer in a
> null-terminated state.
> 
> The only downside is that this makes the buffer 1 character smaller
> for seq_buf_puts(), but that seems like a good trade off.
> 
> Link: http://lkml.kernel.org/r/20181019042109.8064-1-mpe@ellerman.id.au
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  lib/seq_buf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 11f2ae0f9099..6aabb609dd87 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -144,9 +144,13 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
>  
>  	WARN_ON(s->size == 0);
>  
> +	/* Add 1 to len for the trailing null byte which must be there */
> +	len += 1;
> +
>  	if (seq_buf_can_fit(s, len)) {
>  		memcpy(s->buffer + s->len, str, len);
> -		s->len += len;
> +		/* Don't count the trailing null byte against the capacity */
> +		s->len += len - 1;
>  		return 0;
>  	}
>  	seq_buf_set_overflow(s);

