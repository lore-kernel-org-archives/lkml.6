Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbeDSTry (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:47:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55396 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeDSTrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:47:52 -0400
Date: Thu, 19 Apr 2018 12:47:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-mm@kvack.org,
        eric.dumazet@gmail.com, edumazet@google.com, bhutchings@solarflare.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        dm-devel@redhat.com, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] kvmalloc: always use vmalloc if CONFIG_DEBUG_VM
Message-Id: <20180419124751.8884e516e99825d83da3d87a@linux-foundation.org>
In-Reply-To: <alpine.LRH.2.02.1804191207380.31175@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com>
        <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
        <alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
        <20180418.134651.2225112489265654270.davem@davemloft.net>
        <alpine.LRH.2.02.1804181350050.17942@file01.intranet.prod.int.rdu2.redhat.com>
        <alpine.LRH.2.02.1804191207380.31175@file01.intranet.prod.int.rdu2.redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 12:12:38 -0400 (EDT) Mikulas Patocka <mpatocka@redhat.com> wrote:

> The kvmalloc function tries to use kmalloc and falls back to vmalloc if
> kmalloc fails.
> 
> Unfortunatelly, some kernel code has bugs - it uses kvmalloc and then
> uses DMA-API on the returned memory or frees it with kfree. Such bugs were
> found in the virtio-net driver, dm-integrity or RHEL7 powerpc-specific
> code.
> 
> These bugs are hard to reproduce because vmalloc falls back to kmalloc
> only if memory is fragmented.

Yes, that's nasty.

> In order to detect these bugs reliably I submit this patch that changes
> kvmalloc to always use vmalloc if CONFIG_DEBUG_VM is turned on.
> 
> ...
>
> --- linux-2.6.orig/mm/util.c	2018-04-18 15:46:23.000000000 +0200
> +++ linux-2.6/mm/util.c	2018-04-18 16:00:43.000000000 +0200
> @@ -395,6 +395,7 @@ EXPORT_SYMBOL(vm_mmap);
>   */
>  void *kvmalloc_node(size_t size, gfp_t flags, int node)
>  {
> +#ifndef CONFIG_DEBUG_VM
>  	gfp_t kmalloc_flags = flags;
>  	void *ret;
>  
> @@ -426,6 +427,7 @@ void *kvmalloc_node(size_t size, gfp_t f
>  	 */
>  	if (ret || size <= PAGE_SIZE)
>  		return ret;
> +#endif
>  
>  	return __vmalloc_node_flags_caller(size, node, flags,
>  			__builtin_return_address(0));

Well, it doesn't have to be done at compile-time, does it?  We could
add a knob (in debugfs, presumably) which enables this at runtime. 
That's far more user-friendly.
