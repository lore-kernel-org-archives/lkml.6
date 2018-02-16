Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757191AbeBPBzr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 20:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751057AbeBPBzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 20:55:46 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF25217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Thu, 15 Feb 2018 17:55:45 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: manual merge of the xen-tip tree with Linus' tree
In-Reply-To: <20180216120432.2f4e9c89@canb.auug.org.au>
Message-ID: <alpine.DEB.2.10.1802151754040.5392@sstabellini-ThinkPad-X260>
References: <20180216120432.2f4e9c89@canb.auug.org.au>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the xen-tip tree got a conflict in:
> 
>   drivers/xen/pvcalls-front.c
> 
> between commit:
> 
>   a9a08845e9ac ("vfs: do bulk POLL* -> EPOLL* replacement")
> 
> from Linus' tree and commit:
> 
>   1e7dbff356e5 ("pvcalls-front: introduce a per sock_mapping refcount")
> 
> from the xen-tip tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Hi Stephen,

it looks good.

Cheers,

Stefano


> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/xen/pvcalls-front.c
> index 753d9cb437d0,ca5b77309c7d..000000000000
> --- a/drivers/xen/pvcalls-front.c
> +++ b/drivers/xen/pvcalls-front.c
> @@@ -963,20 -942,13 +942,13 @@@ __poll_t pvcalls_front_poll(struct fil
>   {
>   	struct pvcalls_bedata *bedata;
>   	struct sock_mapping *map;
>  -	int ret;
>  +	__poll_t ret;
>   
> - 	pvcalls_enter();
> - 	if (!pvcalls_front_dev) {
> - 		pvcalls_exit();
> + 	map = pvcalls_enter_sock(sock);
> + 	if (IS_ERR(map))
>  -		return POLLNVAL;
>  +		return EPOLLNVAL;
> - 	}
>   	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
>   
> - 	map = (struct sock_mapping *) sock->sk->sk_send_head;
> - 	if (!map) {
> - 		pvcalls_exit();
> - 		return EPOLLNVAL;
> - 	}
>   	if (map->active_socket)
>   		ret = pvcalls_front_poll_active(file, bedata, map, wait);
>   	else
> 
