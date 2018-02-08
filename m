Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBHPov (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:44:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750847AbeBHPot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:44:49 -0500
Date: Thu, 8 Feb 2018 17:44:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] ptr_ring: fail early if queue occupies more than
 KMALLOC_MAX_SIZE
Message-ID: <20180208174301-mutt-send-email-mst@kernel.org>
References: <1517990905-15737-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517990905-15737-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 04:08:25PM +0800, Jason Wang wrote:
> To avoid slab to warn about exceeded size, fail early if queue
> occupies more than KMALLOC_MAX_SIZE.
> 
> Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/ptr_ring.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 1883d61..4b862da 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -466,6 +466,8 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>  
>  static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
>  {
> +	if (size > KMALLOC_MAX_SIZE)
> +		return NULL;
>  	return kcalloc(size, sizeof(void *), gfp);
>  }

I guess this approach does begin to make more sense
at least as a temporary stop-gap.

But does this actually prevent the crash in all cases?

size is in void* entry units, KMALLOC_MAX_SIZE is in bytes.


>  
> -- 
> 2.7.4
