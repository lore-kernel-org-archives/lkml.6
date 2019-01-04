Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0690DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD70E218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546623184;
	bh=6UJumnS8wZ3Fe5ZJrXjNWL1o0unjWmWWV3ERjneOztM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xa5GYS9lC5Jt0qeej7oafNt5EYinPUssouiaRCkWa6jBmbR/ddiprML/68QYlmoo1
	 2QN0ph6OAYD5KFuTWQw/V+beeoXLuGzvBLgsl+w/qMj1mtQtCqYCPor0GG3TGyb7Gx
	 /X28Cj/ydKztXm+FKOXDwcoS0sZMUPTNlg+hKnLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfADRdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfADRdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:33:03 -0500
Received: from localhost (unknown [49.207.53.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3376B218CD;
        Fri,  4 Jan 2019 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546623183;
        bh=6UJumnS8wZ3Fe5ZJrXjNWL1o0unjWmWWV3ERjneOztM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYjr0eoyctmXnqT7inJ+xRVrFuH5V5Qot4uwYa2XL0UZHQow0bKUPgdsuSQRyqYBR
         aB40YSogckNRsXnulpGFUCsLNjy60IID3g8MVy+7nOLEWrIb9Z3moVtTPZR8eMKOkS
         23RWushw2Suirl0UrDHw6g8KVon4rJtZ5jq4kZwM=
Date:   Fri, 4 Jan 2019 23:01:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc:     okaya@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH 2/2] dmaengine: qcom_hidma: assign channel cookie
 correctly
Message-ID: <20190104173111.GS13372@vkoul-mobl.Dlink>
References: <81c9fe2de4b5dac1d5b974f5305e35bf1cf5d127.1544156508.git.shunyong.yang@hxt-semitech.com>
 <ea6c6317dabffdcfa28cdb391b50edce98ce875d.1544156508.git.shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6c6317dabffdcfa28cdb391b50edce98ce875d.1544156508.git.shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-12-18, 12:29, Shunyong Yang wrote:
> When dma_cookie_complete() is called in hidma_process_completed(),
> dma_cookie_status() will return DMA_COMPLETE in hidma_tx_status(). Then,
> hidma_txn_is_success() will be called to use channel cookie
> mchan->last_success to do additional DMA status check. Current code
> assigns mchan->last_success after dma_cookie_complete(). This causes
> a race condition of dma_cookie_status() returns DMA_COMPLETE before
> mchan->last_success is assigned correctly. The race will cause
> hidma_tx_status() return DMA_ERROR but the transaction is actually a
> success. Moreover, in async_tx case, it will cause a timeout panic
> in async_tx_quiesce().
> 
>  Kernel panic - not syncing: async_tx_quiesce: DMA error waiting for
>  transaction
>  ...
>  Call trace:
>  [<ffff000008089994>] dump_backtrace+0x0/0x1f4
>  [<ffff000008089bac>] show_stack+0x24/0x2c
>  [<ffff00000891e198>] dump_stack+0x84/0xa8
>  [<ffff0000080da544>] panic+0x12c/0x29c
>  [<ffff0000045d0334>] async_tx_quiesce+0xa4/0xc8 [async_tx]
>  [<ffff0000045d03c8>] async_trigger_callback+0x70/0x1c0 [async_tx]
>  [<ffff0000048b7d74>] raid_run_ops+0x86c/0x1540 [raid456]
>  [<ffff0000048bd084>] handle_stripe+0x5e8/0x1c7c [raid456]
>  [<ffff0000048be9ec>] handle_active_stripes.isra.45+0x2d4/0x550 [raid456]
>  [<ffff0000048beff4>] raid5d+0x38c/0x5d0 [raid456]
>  [<ffff000008736538>] md_thread+0x108/0x168
>  [<ffff0000080fb1cc>] kthread+0x10c/0x138
>  [<ffff000008084d34>] ret_from_fork+0x10/0x18
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> ---
>  drivers/dma/qcom/hidma.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
> index 9d639ed1955a..aa88bcceda20 100644
> --- a/drivers/dma/qcom/hidma.c
> +++ b/drivers/dma/qcom/hidma.c
> @@ -138,24 +138,24 @@ static void hidma_process_completed(struct hidma_chan *mchan)
>  		desc = &mdesc->desc;
>  		last_cookie = desc->cookie;
>  
> +		llstat = hidma_ll_status(mdma->lldev, mdesc->tre_ch);
> +
>  		spin_lock_irqsave(&mchan->lock, irqflags);
> +		if (llstat == DMA_COMPLETE) {
> +			mchan->last_success = last_cookie;
> +			result.result = DMA_TRANS_NOERROR;
> +		} else
> +			result.result = DMA_TRANS_ABORTED;

Coding style mandates that else should also have braces, please fix that

-- 
~Vinod
