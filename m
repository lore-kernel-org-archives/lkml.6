Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeBEPEA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:04:00 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54826 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeBEPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:03:49 -0500
Date: Mon, 05 Feb 2018 10:03:47 -0500 (EST)
Message-Id: <20180205.100347.176614123780866781.davem@davemloft.net>
To: keescook@chromium.org
Cc: syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ebiggers3@gmail.com, james.morse@arm.com, keun-o.park@darkmatter.ae,
        labbott@redhat.com, linux-mm@kvack.org, mingo@kernel.org
Subject: Re: [PATCH v2] socket: Provide put_cmsg_whitelist() for constant
 size copies
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180202102749.GA34019@beast>
References: <20180202102749.GA34019@beast>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Fri, 2 Feb 2018 02:27:49 -0800

> @@ -343,6 +343,14 @@ struct ucred {
>  
>  extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
>  extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
> +/*
> + * Provide a bounce buffer for copying cmsg data to userspace when the
> + * target memory isn't already whitelisted for hardened usercopy.
> + */
> +#define put_cmsg_whitelist(_msg, _level, _type, _ptr) ({		\
> +		typeof(*(_ptr)) _val = *(_ptr);				\
> +		put_cmsg(_msg, _level, _type, sizeof(_val), &_val);	\
> +	})

I understand what you are trying to achieve, but it's at a real cost
here.  Some of these objects are structures, for example the struct
sock_extended_err is 16 bytes.

And now we're going to copy it twice, once into the on-stack copy,
and then once again into the CMSG blob.

Please find a way to make hardened user copy happy without adding
new overhead.

Thank you.
