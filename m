Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754194AbeDTDEw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 23:04:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753964AbeDTDEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 23:04:44 -0400
Subject: Re: [PATCH] virtio_ring: switch to dma_XX barriers for rpmsg
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <1524159181-351878-1-git-send-email-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <05e885b8-7677-9cad-28fc-1cfa87c1d1a9@redhat.com>
Date: Fri, 20 Apr 2018 11:04:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524159181-351878-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月20日 01:35, Michael S. Tsirkin wrote:
> virtio is using barriers to order memory accesses, thus
> dma_wmb/rmb is a good match.
>
> Build-tested on x86: Before
>
> [mst@tuck linux]$ size drivers/virtio/virtio_ring.o
>     text    data     bss     dec     hex filename
>    11392     820       0   12212    2fb4 drivers/virtio/virtio_ring.o
>
> After
> mst@tuck linux]$ size drivers/virtio/virtio_ring.o
>     text    data     bss     dec     hex filename
>    11284     820       0   12104    2f48 drivers/virtio/virtio_ring.o
>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: linux-remoteproc@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> It's good in theory, but could one of RPMSG maintainers please review
> and ack this patch? Or even better test it?
>
> All these barriers are useless on Intel anyway ...
>
>   include/linux/virtio_ring.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index bbf3252..fab0213 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -35,7 +35,7 @@ static inline void virtio_rmb(bool weak_barriers)
>   	if (weak_barriers)
>   		virt_rmb();
>   	else
> -		rmb();
> +		dma_rmb();
>   }
>   
>   static inline void virtio_wmb(bool weak_barriers)
> @@ -43,7 +43,7 @@ static inline void virtio_wmb(bool weak_barriers)
>   	if (weak_barriers)
>   		virt_wmb();
>   	else
> -		wmb();
> +		dma_wmb();
>   }
>   
>   static inline void virtio_store_mb(bool weak_barriers,

Acked-by: Jason Wang <jasowang@redhat.com>
