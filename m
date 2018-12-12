Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88165C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC5520839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC5520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeLLLVu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:21:50 -0500
Received: from ozlabs.org ([203.11.71.1]:34521 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbeLLLVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:21:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43FDsj3K6Dz9s3Z;
        Wed, 12 Dec 2018 22:21:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        jannh@google.com, keescook@chromium.org
Subject: Re: [PATCH v2 1/2] seq_buf: Make seq_buf_puts() null-terminate the buffer
In-Reply-To: <20181019042109.8064-1-mpe@ellerman.id.au>
References: <20181019042109.8064-1-mpe@ellerman.id.au>
Date:   Wed, 12 Dec 2018 22:21:46 +1100
Message-ID: <87imzzvvlh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Friendly ping :)

Do you mind picking this one up for 4.21 ?

cheers

Michael Ellerman <mpe@ellerman.id.au> writes:
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
>   Message is fooªªªªªsecret
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
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  lib/seq_buf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> v2: Fix NULL/null terminology.
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
> -- 
> 2.17.2
