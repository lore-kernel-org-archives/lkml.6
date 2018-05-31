Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeEaUqm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754234AbeEaUql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:46:41 -0400
Date: Thu, 31 May 2018 16:46:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] vsprintf: Use hw RNG for ptr_key
Message-ID: <20180531164638.2610ae5c@vmware.local.home>
In-Reply-To: <1527472002-11571-4-git-send-email-me@tobin.cc>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
        <1527472002-11571-4-git-send-email-me@tobin.cc>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018 11:46:41 +1000
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
> index 23920c5ff728..1545a8aa26a9 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1693,8 +1693,16 @@ static struct random_ready_callback random_ready = {
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
