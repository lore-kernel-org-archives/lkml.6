Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6AAA6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136542089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136542089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933167AbeFLSpF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932343AbeFLSpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:45:03 -0400
Received: from vmware.local.home (unknown [107.19.188.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D1520891;
        Tue, 12 Jun 2018 18:45:01 +0000 (UTC)
Date:   Tue, 12 Jun 2018 14:44:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] vsprintf: Use hw RNG for ptr_key
Message-ID: <20180612144458.31930370@vmware.local.home>
In-Reply-To: <1528763954-27731-4-git-send-email-me@tobin.cc>
References: <1528763954-27731-1-git-send-email-me@tobin.cc>
        <1528763954-27731-4-git-send-email-me@tobin.cc>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 10:39:13 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Currently we must wait for enough entropy to become available before
> hashed pointers can be printed.  We can remove this wait by using the
> hw RNG if available.
> 
> Use hw RNG to get keying material.
> 
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  lib/vsprintf.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index a48aaa79d352..c445f9f28760 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1675,8 +1675,16 @@ static struct random_ready_callback random_ready = {
>  
>  static int __init initialize_ptr_random(void)
>  {
> -	int ret = add_random_ready_callback(&random_ready);
> +	int key_size = sizeof(ptr_key);
> +	int ret;
> +
> +	/* Use hw RNG if available */
> +	if (get_random_bytes_arch(&ptr_key, key_size) == key_size) {
> +		static_branch_disable(&not_filled_random_ptr_key);
> +		return 0;
> +	}
>  
> +	ret = add_random_ready_callback(&random_ready);
>  	if (!ret) {
>  		return 0;
>  	} else if (ret == -EALREADY) {

