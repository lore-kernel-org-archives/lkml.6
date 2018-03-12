Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeCLIfT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:35:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbeCLIfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:35:18 -0400
Date: Mon, 12 Mar 2018 01:35:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 04/35] syscalls: do not call sys_getpgid() within the
 kernel
Message-ID: <20180312083517.GA11010@infradead.org>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
 <20180311105557.20807-5-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180311105557.20807-5-linux@dominikbrodowski.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject (and lack of description) for this and the following patches
is rather confusing.

I'd expect something like:

---- snip ----
Subject: kernel: add a do_getpgid helper

And use it to avoid an in-kernel sys_getpgid call.

---- snip ----

instead.

On Sun, Mar 11, 2018 at 11:55:26AM +0100, Dominik Brodowski wrote:
> CC: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  kernel/sys.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index f2289de20e19..ebb138b841c8 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1027,7 +1027,7 @@ SYSCALL_DEFINE2(setpgid, pid_t, pid, pid_t, pgid)
>  	return err;
>  }
>  
> -SYSCALL_DEFINE1(getpgid, pid_t, pid)
> +static int do_getpgid(pid_t pid)
>  {
>  	struct task_struct *p;
>  	struct pid *grp;
> @@ -1055,11 +1055,16 @@ SYSCALL_DEFINE1(getpgid, pid_t, pid)
>  	return retval;
>  }
>  
> +SYSCALL_DEFINE1(getpgid, pid_t, pid)
> +{
> +	return do_getpgid(pid);
> +}
> +
>  #ifdef __ARCH_WANT_SYS_GETPGRP
>  
>  SYSCALL_DEFINE0(getpgrp)
>  {
> -	return sys_getpgid(0);
> +	return do_getpgid(0);
>  }
>  
>  #endif
> -- 
> 2.16.2
> 
---end quoted text---
