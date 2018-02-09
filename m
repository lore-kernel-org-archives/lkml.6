Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBIPjN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:39:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751038AbeBIPjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:39:11 -0500
Date: Fri, 9 Feb 2018 17:39:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH V4 1/2] ptr_ring: fail early if queue occupies more than
 KMALLOC_MAX_SIZE
Message-ID: <20180209173856-mutt-send-email-mst@kernel.org>
References: <1518169550-5987-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518169550-5987-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 05:45:49PM +0800, Jason Wang wrote:
> To avoid slab to warn about exceeded size, fail early if queue
> occupies more than KMALLOC_MAX_SIZE.
> 
> Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
> Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/ptr_ring.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 1883d61..6051a5f 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -466,6 +466,8 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>  
>  static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
>  {
> +	if (size * sizeof(void *) > KMALLOC_MAX_SIZE)
> +		return NULL;
>  	return kcalloc(size, sizeof(void *), gfp);
>  }
>  
> -- 
> 2.7.4
