Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966455AbeEJQ2r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935410AbeEJQ2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:28:45 -0400
Date: Thu, 10 May 2018 12:28:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joe Perches <joe@perches.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to
 KBUILD_MODNAME
Message-ID: <20180510122843.0b69b41a@gandalf.local.home>
In-Reply-To: <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
        <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018 08:45:29 -0700
Joe Perches <joe@perches.com> wrote:

> There are more than 1000 uses of #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> Make that the default define so these uses can be removed later via script.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  include/linux/printk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 6d7e800affd8..172dce24e1b6 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -285,7 +285,7 @@ static inline void printk_safe_flush_on_panic(void)
>  extern int kptr_restrict;
>  
>  #ifndef pr_fmt
> -#define pr_fmt(fmt) fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  #endif

Interesting change. The ring buffer test went from:

[   12.778404] CPU 0:
[   12.780488]               events:    1596368
[   12.784841]        dropped bytes:    0
[   12.788682]        alloced bytes:    124382988
[   12.793206]        written bytes:    121852123
[   12.797711]        biggest event:    263
[   12.801706]       smallest event:    4
[   12.809384]          read events:   12106
[   12.813464]          lost events:   1584262
[   12.817709]         total events:   1596368
[   12.821951]   recorded len bytes:   975776
[   12.826107]  recorded size bytes:   955733
[   12.830263]  With dropped events, record len and size may not match
[   12.830263]  alloced and written from above

  to

[   12.779526] ring_buffer: CPU 0:
[   12.782753] ring_buffer:               events:    1812797
[   12.788223] ring_buffer:        dropped bytes:    0
[   12.793179] ring_buffer:        alloced bytes:    142291920
[   12.798815] ring_buffer:        written bytes:    139410962
[   12.804446] ring_buffer:        biggest event:    211
[   12.809558] ring_buffer:       smallest event:    4
[   12.818571] ring_buffer:          read events:   13099
[   12.824929] ring_buffer:          lost events:   1799698
[   12.830293] ring_buffer:         total events:   1812797
[   12.835657] ring_buffer:   recorded len bytes:   974336
[   12.840935] ring_buffer:  recorded size bytes:   953514
[   12.846218] ring_buffer:  With dropped events, record len and size may not match
[   12.846218]  alloced and written from above

I'm fine with it.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
