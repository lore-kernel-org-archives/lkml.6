Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D88C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9018320815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfACBcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:32:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:33818 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfACBcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:32:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 17:32:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,433,1539673200"; 
   d="scan'208";a="113747718"
Received: from unknown (HELO localhost.localdomain) ([10.10.37.145])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jan 2019 17:32:10 -0800
Message-ID: <1546480247.23374.14.camel@intel.com>
Subject: Re: [PATCH v2] misc: mic: fix a DMA pool free failure
From:   Sudeep Dutt <sudeep.dutt@intel.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>, Kangjie Lu <kjlu@umn.edu>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Jan 2019 17:50:47 -0800
In-Reply-To: <1543936604-6194-1-git-send-email-wang6495@umn.edu>
References: <1543936604-6194-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.12.11 (3.12.11-15.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 09:16 -0600, Wenwen Wang wrote:
> In _scif_prog_signal(), a DMA pool is allocated if the MIC Coprocessor is
> not X100, i.e., the boolean variable 'x100' is false. This DMA pool will be
> freed eventually through the callback function scif_prog_signal_cb() with
> the parameter of 'status', which actually points to the start of DMA pool.
> Specifically, in scif_prog_signal_cb(), the 'ep' field and the
> 'src_dma_addr' field of 'status' are used to free the DMA pool by invoking
> dma_pool_free(). Given that 'status' points to the start address of the DMA
> pool, both 'status->ep' and 'status->src_dma_addr' are in the DMA pool. And
> so, the device has the permission to access them. Even worse, a malicious
> device can modify them. As a result, dma_pool_free() will not succeed.
> 
> To avoid the above issue, this patch introduces a new data structure, i.e.,
> scif_cb_arg, to store the arguments required by the call back function. A
> variable 'cb_arg' is allocated in _scif_prog_signal() to pass the
> arguments. 'cb_arg' will be freed after dma_pool_free() in
> scif_prog_signal_cb().
> 

Thanks for incorporating the previous feedback Wenwen.

Reviewed-by: Sudeep Dutt <sudeep.dutt@intel.com>

> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/misc/mic/scif/scif_fence.c | 22 +++++++++++++++++-----
>  drivers/misc/mic/scif/scif_rma.h   | 13 +++++++++++++
>  2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/mic/scif/scif_fence.c b/drivers/misc/mic/scif/scif_fence.c
> index 7bb929f..2e7ce6a 100644
> --- a/drivers/misc/mic/scif/scif_fence.c
> +++ b/drivers/misc/mic/scif/scif_fence.c
> @@ -195,10 +195,11 @@ static inline void *scif_get_local_va(off_t off, struct scif_window *window)
>  
>  static void scif_prog_signal_cb(void *arg)
>  {
> -	struct scif_status *status = arg;
> +	struct scif_cb_arg *cb_arg = arg;
>  
> -	dma_pool_free(status->ep->remote_dev->signal_pool, status,
> -		      status->src_dma_addr);
> +	dma_pool_free(cb_arg->ep->remote_dev->signal_pool, cb_arg->status,
> +		      cb_arg->src_dma_addr);
> +	kfree(cb_arg);
>  }
>  
>  static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
> @@ -209,6 +210,7 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
>  	bool x100 = !is_dma_copy_aligned(chan->device, 1, 1, 1);
>  	struct dma_async_tx_descriptor *tx;
>  	struct scif_status *status = NULL;
> +	struct scif_cb_arg *cb_arg = NULL;
>  	dma_addr_t src;
>  	dma_cookie_t cookie;
>  	int err;
> @@ -257,8 +259,16 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
>  		goto dma_fail;
>  	}
>  	if (!x100) {
> +		cb_arg = kmalloc(sizeof(*cb_arg), GFP_KERNEL);
> +		if (!cb_arg) {
> +			err = -ENOMEM;
> +			goto dma_fail;
> +		}
> +		cb_arg->src_dma_addr = src;
> +		cb_arg->status = status;
> +		cb_arg->ep = ep;
>  		tx->callback = scif_prog_signal_cb;
> -		tx->callback_param = status;
> +		tx->callback_param = cb_arg;
>  	}
>  	cookie = tx->tx_submit(tx);
>  	if (dma_submit_error(cookie)) {
> @@ -270,9 +280,11 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
>  	dma_async_issue_pending(chan);
>  	return 0;
>  dma_fail:
> -	if (!x100)
> +	if (!x100) {
>  		dma_pool_free(ep->remote_dev->signal_pool, status,
>  			      src - offsetof(struct scif_status, val));
> +		kfree(cb_arg);
> +	}
>  alloc_fail:
>  	return err;
>  }
> diff --git a/drivers/misc/mic/scif/scif_rma.h b/drivers/misc/mic/scif/scif_rma.h
> index fa67222..84af303 100644
> --- a/drivers/misc/mic/scif/scif_rma.h
> +++ b/drivers/misc/mic/scif/scif_rma.h
> @@ -206,6 +206,19 @@ struct scif_status {
>  };
>  
>  /*
> + * struct scif_cb_arg - Stores the argument of the callback func
> + *
> + * @src_dma_addr: Source buffer DMA address
> + * @status: DMA status
> + * @ep: SCIF endpoint
> + */
> +struct scif_cb_arg {
> +	dma_addr_t src_dma_addr;
> +	struct scif_status *status;
> +	struct scif_endpt *ep;
> +};
> +
> +/*
>   * struct scif_window - Registration Window for Self and Remote
>   *
>   * @nr_pages: Number of pages which is defined as a s64 instead of an int


