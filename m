Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCEDC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFD02178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFD02178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeHDSnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 14:43:45 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:55888 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeHDSno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 14:43:44 -0400
X-Greylist: delayed 2194 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Aug 2018 14:43:44 EDT
Received: from tun5.smaug.kot-begemot.co.uk ([192.168.18.6] helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1flz42-0007ju-L9; Sat, 04 Aug 2018 16:05:58 +0000
Received: from ppp-94-68-121-61.home.otenet.gr ([94.68.121.61] helo=[192.168.1.158])
        by smaug.kot-begemot.co.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1flz42-0003Jl-4R; Sat, 04 Aug 2018 17:05:58 +0100
Subject: Re: [PATCH] um: NULL check before kfree is not needed
To:     YueHaibing <yuehaibing@huawei.com>, jdike@addtoit.com,
        richard@nod.at, christophe.jaillet@wanadoo.fr,
        keescook@chromium.org
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180803063911.23384-1-yuehaibing@huawei.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <3b72e9da-c4ac-cee0-1833-7c2b346fcc28@cambridgegreys.com>
Date:   Sat, 4 Aug 2018 17:05:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180803063911.23384-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/18 07:39, YueHaibing wrote:

> kfree(NULL) is safe,so this removes NULL check before freeing the mem
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   arch/um/drivers/vector_kern.c | 15 +++++----------
>   arch/um/drivers/vector_user.c |  6 ++----
>   arch/um/kernel/irq.c          |  3 +--
>   3 files changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 50ee3bb..c84133c 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1118,16 +1118,11 @@ static int vector_net_close(struct net_device *dev)
>   		os_close_file(vp->fds->tx_fd);
>   		vp->fds->tx_fd = -1;
>   	}
> -	if (vp->bpf != NULL)
> -		kfree(vp->bpf);
> -	if (vp->fds->remote_addr != NULL)
> -		kfree(vp->fds->remote_addr);
> -	if (vp->transport_data != NULL)
> -		kfree(vp->transport_data);
> -	if (vp->header_rxbuffer != NULL)
> -		kfree(vp->header_rxbuffer);
> -	if (vp->header_txbuffer != NULL)
> -		kfree(vp->header_txbuffer);
> +	kfree(vp->bpf);
> +	kfree(vp->fds->remote_addr);
> +	kfree(vp->transport_data);
> +	kfree(vp->header_rxbuffer);
> +	kfree(vp->header_txbuffer);
>   	if (vp->rx_queue != NULL)
>   		destroy_queue(vp->rx_queue);
>   	if (vp->tx_queue != NULL)
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index 4d6a78e..3d8cdbd 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -267,8 +267,7 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
>   		os_close_file(rxfd);
>   	if (txfd >= 0)
>   		os_close_file(txfd);
> -	if (result != NULL)
> -		kfree(result);
> +	kfree(result);
>   	return NULL;
>   }
>   
> @@ -434,8 +433,7 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
>   	if (fd >= 0)
>   		os_close_file(fd);
>   	if (result != NULL) {
> -		if (result->remote_addr != NULL)
> -			kfree(result->remote_addr);
> +		kfree(result->remote_addr);
>   		kfree(result);
>   	}
>   	return NULL;
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index 6b7f382..8360fa3 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -244,8 +244,7 @@ static void garbage_collect_irq_entries(void)
>   			to_free = NULL;
>   		}
>   		walk = walk->next;
> -		if (to_free != NULL)
> -			kfree(to_free);
> +		kfree(to_free);
>   	}
>   }
>   
kfree in both slab and slob check for NULLs before freeing so this is 
correct. Thanks for noticing.

Richard, please apply,

A.
