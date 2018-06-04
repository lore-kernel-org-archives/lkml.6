Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeFDUC3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:02:29 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41276 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeFDUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:02:27 -0400
X-Google-Smtp-Source: ADUXVKIQqxevhbA5XUs3WaD6TyhGcRHN34JsSfkN6Q4Nqy5y+HhSeES/YP6lOctWukQIknl14YA6Sw==
Date: Mon, 4 Jun 2018 13:02:24 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Suman Anna <s-anna@ti.com>,
        Loic Pallardy <loic.pallardy@st.com>
Cc: linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio_ring: switch to dma_XX barriers for rpmsg
Message-ID: <20180604200224.GA9960@builder>
References: <1524159181-351878-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524159181-351878-1-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 Apr 10:35 PDT 2018, Michael S. Tsirkin wrote:

> virtio is using barriers to order memory accesses, thus
> dma_wmb/rmb is a good match.
> 
> Build-tested on x86: Before
> 
> [mst@tuck linux]$ size drivers/virtio/virtio_ring.o
>    text    data     bss     dec     hex filename
>   11392     820       0   12212    2fb4 drivers/virtio/virtio_ring.o
> 
> After
> mst@tuck linux]$ size drivers/virtio/virtio_ring.o
>    text    data     bss     dec     hex filename
>   11284     820       0   12104    2f48 drivers/virtio/virtio_ring.o
> 
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: linux-remoteproc@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> It's good in theory, but could one of RPMSG maintainers please review
> and ack this patch? Or even better test it?
> 
> All these barriers are useless on Intel anyway ...
> 
>  include/linux/virtio_ring.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index bbf3252..fab0213 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -35,7 +35,7 @@ static inline void virtio_rmb(bool weak_barriers)
>  	if (weak_barriers)
>  		virt_rmb();
>  	else
> -		rmb();
> +		dma_rmb();
>  }
>  
>  static inline void virtio_wmb(bool weak_barriers)
> @@ -43,7 +43,7 @@ static inline void virtio_wmb(bool weak_barriers)
>  	if (weak_barriers)
>  		virt_wmb();
>  	else
> -		wmb();
> +		dma_wmb();
>  }
>  
>  static inline void virtio_store_mb(bool weak_barriers,
> -- 
> MST
