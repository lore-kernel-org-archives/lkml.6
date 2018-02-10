Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeBJTcH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 14:32:07 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33227 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbeBJTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 14:32:06 -0500
X-Google-Smtp-Source: AH8x225SnnY+efgmAOyiRma6SX6cObTNYe3k9VgXB5ghD114A+mujV8qpHY8RuU1czvvdKj/sBhX9Q==
Date: Sat, 10 Feb 2018 11:32:01 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH V4 1/2] ptr_ring: fail early if queue occupies more than
 KMALLOC_MAX_SIZE
Message-ID: <20180210193201.GB23737@zzz.localdomain>
References: <1518169550-5987-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518169550-5987-1-git-send-email-jasowang@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Feb 09, 2018 at 05:45:49PM +0800, Jason Wang wrote:
> To avoid slab to warn about exceeded size, fail early if queue
> occupies more than KMALLOC_MAX_SIZE.
> 
> Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
> Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
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

Are you sure that size can't be over 0x40000000?  The proper way to write this
(safe from integer overflow) would be:

	if (size > KMALLOC_MAX_SIZE / sizeof(void *))
		return NULL;

- Eric
