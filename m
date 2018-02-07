Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeBGJSI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:18:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753370AbeBGJSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:18:05 -0500
Subject: Re: [PATCH net] ptr_ring: fail early if queue occupies more than
 KMALLOC_MAX_SIZE
To: linux-kernel@vger.kernel.org, mst@redhat.com
Cc: netdev@vger.kernel.org
References: <1517990905-15737-1-git-send-email-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <14eecede-e053-9f97-cc09-5ab58cd4d2cf@redhat.com>
Date: Wed, 7 Feb 2018 17:17:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517990905-15737-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月07日 16:08, Jason Wang wrote:
> To avoid slab to warn about exceeded size, fail early if queue
> occupies more than KMALLOC_MAX_SIZE.
>
> Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   include/linux/ptr_ring.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 1883d61..4b862da 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -466,6 +466,8 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>   
>   static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
>   {
> +	if (size > KMALLOC_MAX_SIZE)
> +		return NULL;
>   	return kcalloc(size, sizeof(void *), gfp);
>   }
>   

Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
