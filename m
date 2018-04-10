Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeDJKE4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:04:56 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40069 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeDJKEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:04:54 -0400
X-Google-Smtp-Source: AIpwx4+Xu4/wjAIzM677Roo0ITYwhKCo97V56/ysh2eTkaaV/goW/0G3Nlv9+0MVYabuVx4Ys0DTEw==
Subject: Re: [RFC,v2,9/9] hyper_dmabuf: threaded interrupt in Xen-backend
To: Dongwon Kim <dongwon.kim@intel.com>, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, xen-devel@lists.xenproject.org
Cc: dri-devel@lists.freedesktop.org, mateuszx.potrola@intel.com
References: <20180214015008.9513-10-dongwon.kim@intel.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <b644b126-b4aa-0dd7-34f3-6c105cc79490@gmail.com>
Date: Tue, 10 Apr 2018 13:04:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180214015008.9513-10-dongwon.kim@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 03:50 AM, Dongwon Kim wrote:
> Use threaded interrupt intead of regular one because most part of ISR
> is time-critical and possibly sleeps
>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>   .../hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c
> index 30bc4b6304ac..65af5ddfb2d7 100644
> --- a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c
> +++ b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c
> @@ -332,11 +332,14 @@ int xen_be_init_tx_rbuf(int domid)
>   	}
>   
>   	/* setting up interrupt */
> -	ret = bind_evtchn_to_irqhandler(alloc_unbound.port,
> -					front_ring_isr, 0,
> -					NULL, (void *) ring_info);
> +	ring_info->irq = bind_evtchn_to_irq(alloc_unbound.port);
>   
> -	if (ret < 0) {
> +	ret = request_threaded_irq(ring_info->irq,
> +				   NULL,
> +				   front_ring_isr,
> +				   IRQF_ONESHOT, NULL, ring_info);
> +
Why don't you go with threaded IRQ from the beginning and change it
in the patch #9?
> +	if (ret != 0) {
>   		dev_err(hy_drv_priv->dev,
>   			"Failed to setup event channel\n");
>   		close.port = alloc_unbound.port;
> @@ -348,7 +351,6 @@ int xen_be_init_tx_rbuf(int domid)
>   	}
>   
>   	ring_info->rdomain = domid;
> -	ring_info->irq = ret;
>   	ring_info->port = alloc_unbound.port;
>   
>   	mutex_init(&ring_info->lock);
> @@ -535,9 +537,10 @@ int xen_be_init_rx_rbuf(int domid)
>   	if (!xen_comm_find_tx_ring(domid))
>   		ret = xen_be_init_tx_rbuf(domid);
>   
> -	ret = request_irq(ring_info->irq,
> -			  back_ring_isr, 0,
> -			  NULL, (void *)ring_info);
> +	ret = request_threaded_irq(ring_info->irq,
> +				   NULL,
> +				   back_ring_isr, IRQF_ONESHOT,
> +				   NULL, (void *)ring_info);
>   
Ditto
>   	return ret;
>   
>
>
