Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8432C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F45F2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F45F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeKELWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:22:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:31647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbeKELWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:22:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 18:05:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="271357213"
Received: from unknown (HELO localhost.localdomain) ([10.10.37.145])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2018 18:05:09 -0800
Message-ID: <1541384613.28670.5.camel@intel.com>
Subject: Re: [PATCH] misc: mic: fix a DMA pool free failure
From:   Sudeep Dutt <sudeep.dutt@intel.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>, Kangjie Lu <kjlu@umn.edu>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Sun, 04 Nov 2018 18:23:33 -0800
In-Reply-To: <1539891966-8017-1-git-send-email-wang6495@umn.edu>
References: <1539891966-8017-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.12.11 (3.12.11-15.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-18 at 14:46 -0500, Wenwen Wang wrote:
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
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/misc/mic/scif/scif_fence.c | 17 +++++++++++++----
>  drivers/misc/mic/scif/scif_rma.h   | 14 ++++++++++++++
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/mic/scif/scif_fence.c b/drivers/misc/mic/scif/scif_fence.c
> index cac3bcc..30f7d9b 100644
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
> @@ -257,8 +259,15 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
>  		goto dma_fail;
>  	}
>  	if (!x100) {
> +		err = -ENOMEM;

Should err be set to -ENOMEM only if the cb_arg allocation fails?

> +		cb_arg = kmalloc(sizeof(*cb_arg), GFP_KERNEL);
> +		if (!cb_arg)
> +			goto dma_fail;
> +		cb_arg->src_dma_addr = src;
> +		cb_arg->status = status;
> +		cb_arg->ep = ep;
>  		tx->callback = scif_prog_signal_cb;
> -		tx->callback_param = status;
> +		tx->callback_param = cb_arg;
>  	}

cb_arg should be freed if there is a dma_submit_error(..) below in the
dma_fail path.

Wenwen, can you please fix these up and resend the patch?

Thanks,
Sudeep Dutt

