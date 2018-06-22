Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CF5C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2984824001
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2984824001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=padovan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754276AbeFVKEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:04:24 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46346 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbeFVKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:04:22 -0400
Received: by mail-qt0-f194.google.com with SMTP id h5-v6so5415305qtm.13;
        Fri, 22 Jun 2018 03:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uY2Tty+6k4INftKOsVOrNisvRLtnhNLN2HfxLWC6VjA=;
        b=MndwIPGkV2l5aTk196EISEKiLPu4GfT//4/2KludymyaUtfFXt2MH36oEZVGZKynwp
         PeWovbqYUqfsHXKh0lYGrilmpFTHDwDqJliZuHeraHWxhKs6RTikNSF0jcLB1YCCUzEH
         Dw8GOOz2+H8thXp7ss3wuW2tZNznDMGv23dacgTI1HkGqKSRAVxUoFdxaEKn4LjShh8A
         Svv35gWY7k6ye+Waw5aaZCA74bGic+e3aLUMoSUHbsN6zaVEmNszJrtI5rfkrWgf9P56
         YDA3xCE1q4CevyRjKbF3IYC8LtIRfixzNQ+xt8l6cmZol1srtSX2R38xb7XBtGEWPUdM
         Gs8w==
X-Gm-Message-State: APt69E0Hw1C9tO89Wv8xpOzPctnUiybFJ0RjjiPW4Lsn+hP9luPRKePi
        zsqe/q+IzDP2/X1qH15ffdE=
X-Google-Smtp-Source: AAOMgpcbqnx8EQ93Cjwb80DCCpTmO7etnjgQHf/qBTJZ7LufUQkSol3t38PCsdhNQXS76DwK+Ca+og==
X-Received: by 2002:ac8:fd9:: with SMTP id f25-v6mr725444qtk.181.1529661861713;
        Fri, 22 Jun 2018 03:04:21 -0700 (PDT)
Received: from juma ([2804:14c:181:9195:9419:3bed:192:1e62])
        by smtp.gmail.com with ESMTPSA id y25-v6sm817207qtc.48.2018.06.22.03.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 03:04:21 -0700 (PDT)
Message-ID: <1529661856.7034.404.camel@padovan.org>
Subject: Re: [PATCH v2] dma-buf/fence: Take refcount on the module that owns
 the fence
From:   Gustavo Padovan <gustavo@padovan.org>
To:     Akhil P Oommen <akhilpo@codeaurora.org>, sumit.semwal@linaro.org,
        jcrouse@codeaurora.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     smasetty@codeaurora.org, linux-arm-msm@vger.kernel.org
Date:   Fri, 22 Jun 2018 07:04:16 -0300
In-Reply-To: <1529660407-6266-1-git-send-email-akhilpo@codeaurora.org>
References: <1529660407-6266-1-git-send-email-akhilpo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akhil,

On Fri, 2018-06-22 at 15:10 +0530, Akhil P Oommen wrote:
> Each fence object holds function pointers of the module that
> initialized
> it. Allowing the module to unload before this fence's release is
> catastrophic. So, keep a refcount on the module until the fence is
> released.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> ---
> Changes in v2:
> - added description for the new function parameter.
> 
>  drivers/dma-buf/dma-fence.c | 16 +++++++++++++---
>  include/linux/dma-fence.h   | 10 ++++++++--
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-
> fence.c
> index 4edb9fd..2aaa44e 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -18,6 +18,7 @@
>   * more details.
>   */
>  
> +#include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/atomic.h>
> @@ -168,6 +169,7 @@ void dma_fence_release(struct kref *kref)
>  {
>  	struct dma_fence *fence =
>  		container_of(kref, struct dma_fence, refcount);
> +	struct module *module = fence->owner;
>  
>  	trace_dma_fence_destroy(fence);
>  
> @@ -178,6 +180,8 @@ void dma_fence_release(struct kref *kref)
>  		fence->ops->release(fence);
>  	else
>  		dma_fence_free(fence);
> +
> +	module_put(module);
>  }
>  EXPORT_SYMBOL(dma_fence_release);
>  
> @@ -541,6 +545,7 @@ struct default_wait_cb {
>  
>  /**
>   * dma_fence_init - Initialize a custom fence.
> + * @module:	[in]	the module that calls this API
>   * @fence:	[in]	the fence to initialize
>   * @ops:	[in]	the dma_fence_ops for operations on this
> fence
>   * @lock:	[in]	the irqsafe spinlock to use for locking
> this fence
> @@ -556,8 +561,9 @@ struct default_wait_cb {
>   * to check which fence is later by simply using dma_fence_later.
>   */
>  void
> -dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops
> *ops,
> -	       spinlock_t *lock, u64 context, unsigned seqno)
> +_dma_fence_init(struct module *module, struct dma_fence *fence,
> +		const struct dma_fence_ops *ops, spinlock_t *lock,
> +		u64 context, unsigned seqno)
>  {
>  	BUG_ON(!lock);
>  	BUG_ON(!ops || !ops->wait || !ops->enable_signaling ||
> @@ -571,7 +577,11 @@ struct default_wait_cb {
>  	fence->seqno = seqno;
>  	fence->flags = 0UL;
>  	fence->error = 0;
> +	fence->owner = module;
> +
> +	if (!try_module_get(module))
> +		fence->owner = NULL;
>  
>  	trace_dma_fence_init(fence);
>  }
> -EXPORT_SYMBOL(dma_fence_init);
> +EXPORT_SYMBOL(_dma_fence_init);

Do we still need to export the symbol, it won't be called from outside
anymore? Other than that looks good to me:

Reviewed-by: Gustavo Padovan <gustavo.padovan@collabora.com>

Gustavo

