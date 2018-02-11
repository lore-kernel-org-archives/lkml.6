Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeBKWCd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 17:02:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753503AbeBKWCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 17:02:32 -0500
Date: Mon, 12 Feb 2018 00:02:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ebiggers3@gmail.com
Subject: Re: [PATCH net] ptr_ring: prevent integer overflow when calculating
 size
Message-ID: <20180212000219-mutt-send-email-mst@kernel.org>
References: <1518319692-5421-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518319692-5421-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 11:28:12AM +0800, Jason Wang wrote:
> Switch to use dividing to prevent integer overflow when size is too
> big to calculate allocation size properly.
> 
> Reported-by: Eric Biggers <ebiggers3@gmail.com>
> Fixes: 6e6e41c31122 ("ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/ptr_ring.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index b884b77..e633522 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -469,7 +469,7 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>   */
>  static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
>  {
> -	if (size * sizeof(void *) > KMALLOC_MAX_SIZE)
> +	if (size > KMALLOC_MAX_SIZE / sizeof(void *))
>  		return NULL;
>  	return kvmalloc_array(size, sizeof(void *), gfp | __GFP_ZERO);
>  }
> -- 
> 2.7.4
