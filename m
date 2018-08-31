Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4743FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA5A2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA5A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeHaPVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:21:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:55694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbeHaPVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:21:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D39C6ACC4;
        Fri, 31 Aug 2018 11:14:38 +0000 (UTC)
Date:   Fri, 31 Aug 2018 13:14:36 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, WANG Cong <xiyou.wangcong@gmail.com>,
        Rainer Weikusat <rweikusat@mobileactivedefense.com>,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Cyril Hrubis <chrubis@suse.cz>,
        Junchi Chen <junchi.chen@intel.com>
Subject: Re: RFC: changed error code when binding unix socket twice
Message-ID: <20180831111436.GA23780@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20170630073448.GA9546@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170630073448.GA9546@unicorn.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> commit 0fb44559ffd6 ("af_unix: move unix_mknod() out of bindlock") moves
> the special file creation in unix_bind() before u->bindlock is taken in
> order to avoid an ABBA deadlock with do_splice(). As a side effect, it
> also moves the check for existence of the special file (which would
> result in -EADDRINUSE) before the check of u->addr (which would result
> in -EINVAL if socket is already bound). This means that the error
> returned for an attempt to bind a unix socket to the same path twice
> changed from -EINVAL to -EADDRINUSE with this commit.

> One way to restore the old error code is indicated below but before
> submitting it, I would like to ask if we need/want it.

> Pro:
>   - in general, we do not want to change return code for given testcase
>   - old error (-EINVAL) is consistent with AF_INET(6)
> Con:
>   - both POSIX and Linux man page only list error conditions without
>     stating which should take precedence if more of them apply so
>     neither of them seems wrong, strictly speaking

I'd be for restoring the original behavior (be conservative + looks like as not intended).

Any comment from netdev maintainers?


Kind regards,
Petr


> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 1a0c961f4ffe..509292bdf7ed 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -992,7 +992,7 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>  	struct unix_sock *u = unix_sk(sk);
>  	struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
>  	char *sun_path = sunaddr->sun_path;
> -	int err;
> +	int err, mknod_err;
>  	unsigned int hash;
>  	struct unix_address *addr;
>  	struct hlist_head *list;
> @@ -1016,12 +1016,10 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>  	if (sun_path[0]) {
>  		umode_t mode = S_IFSOCK |
>  		       (SOCK_INODE(sock)->i_mode & ~current_umask());
> -		err = unix_mknod(sun_path, mode, &path);
> -		if (err) {
> -			if (err == -EEXIST)
> -				err = -EADDRINUSE;
> -			goto out;
> -		}
> +		mknod_err = unix_mknod(sun_path, mode, &path);
> +		/* do not exit on error until after u->addr check */
> +		if (mknod_err == -EEXIST)
> +			mknod_err = -EADDRINUSE;
>  	}

>  	err = mutex_lock_interruptible(&u->bindlock);
> @@ -1031,6 +1029,10 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>  	err = -EINVAL;
>  	if (u->addr)
>  		goto out_up;
> +	if (mknod_err) {
> +		err = mknod_err;
> +		goto out_up;
> +	}

>  	err = -ENOMEM;
>  	addr = kmalloc(sizeof(*addr)+addr_len, GFP_KERNEL);
