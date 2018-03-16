Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932989AbeCPQ6h (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:58:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:53089 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932891AbeCPQ6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:58:34 -0400
Date: Fri, 16 Mar 2018 16:58:31 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, luto@kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        "Luis R . Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v2 02/36] kernel: use kernel_wait4() instead of
 sys_wait4()
Message-ID: <20180316165831.GV4449@wotan.suse.de>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-3-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315190529.20943-3-linux@dominikbrodowski.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 08:04:55PM +0100, Dominik Brodowski wrote:
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 18e5fa4b0e71..f4b557cadf08 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -135,7 +135,7 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
>  		 *
>  		 * Thus the __user pointer cast is valid here.
>  		 */
> -		sys_wait4(pid, (int __user *)&ret, 0, NULL);
> +		kernel_wait4(pid, (int __user *)&ret, 0, NULL);
>  
>  		/*
>  		 * If ret is 0, either call_usermodehelper_exec_async failed and

There is also a reference to sys_wait4() usage on umh.c:

        /* If SIGCLD is ignored sys_wait4 won't populate the status. */         
        kernel_sigaction(SIGCHLD, SIG_DFL);     

Does that remain true for kernel_wait4()? If so that comment should be updated
as well.

I don't see any kdoc for kernel_wait4(), can you update it and also clarify to
recommend it so that other users do the same? In fact not a kernel helper
which just takes no last argument, and passes NULL to kernel_wait4() as well?

  Luis
