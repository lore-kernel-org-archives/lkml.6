Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbeCTC36 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:29:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750969AbeCTC34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:29:56 -0400
Subject: Re: [PATCH] ptr_ring: fix build
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
References: <1521506496-455194-1-git-send-email-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <62a7a572-bba8-0beb-9a4a-1a4b80b244e4@redhat.com>
Date: Tue, 20 Mar 2018 10:29:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521506496-455194-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月20日 08:41, Michael S. Tsirkin wrote:
> Fixes after recent use of kvmalloc
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   tools/virtio/ringtest/ptr_ring.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/tools/virtio/ringtest/ptr_ring.c b/tools/virtio/ringtest/ptr_ring.c
> index 477899c..2d566fb 100644
> --- a/tools/virtio/ringtest/ptr_ring.c
> +++ b/tools/virtio/ringtest/ptr_ring.c
> @@ -17,6 +17,8 @@
>   #define likely(x)    (__builtin_expect(!!(x), 1))
>   #define ALIGN(x, a) (((x) + (a) - 1) / (a) * (a))
>   #define SIZE_MAX        (~(size_t)0)
> +#define KMALLOC_MAX_SIZE SIZE_MAX
> +#define BUG_ON(x) assert(x)
>   
>   typedef pthread_spinlock_t  spinlock_t;
>   
> @@ -57,6 +59,9 @@ static void kfree(void *p)
>   		free(p);
>   }
>   
> +#define kvmalloc_array kmalloc_array
> +#define kvfree kfree
> +
>   static void spin_lock_init(spinlock_t *lock)
>   {
>   	int r = pthread_spin_init(lock, 0);

Acked-by: Jason Wang <jasowang@redhat.com>
