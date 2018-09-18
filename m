Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F41ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AEA2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AEA2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbeIRRBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:01:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeIRRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:01:15 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF0B8CA6;
        Tue, 18 Sep 2018 11:29:03 +0000 (UTC)
Date:   Tue, 18 Sep 2018 13:29:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>, Joe Perches <joe@perches.com>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v7 1/1] staging: mt7621-mmc: Delete IRQ_MSG() and its
 users.
Message-ID: <20180918112901.GB14453@kroah.com>
References: <cover.1536978715.git.nishadkamdar@gmail.com>
 <0bc3daf340308eb8a1aa5510ee33417ef7d8bd89.1536978716.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc3daf340308eb8a1aa5510ee33417ef7d8bd89.1536978716.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 08:28:03AM +0530, Nishad Kamdar wrote:
> This patch removes IRQ_MSG() and its users as currently it is a no-op.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v7:
>   - Delete IRQ_MSG() and all its users
> Changes in v6:
>   - No change
> Changes in v5:
>   - No change
> ---
>  drivers/staging/mt7621-mmc/dbg.h | 12 ------------
>  drivers/staging/mt7621-mmc/sd.c  | 19 -------------------
>  2 files changed, 31 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> index 79914d98c573..4ab9f10dccc2 100644
> --- a/drivers/staging/mt7621-mmc/dbg.h
> +++ b/drivers/staging/mt7621-mmc/dbg.h
> @@ -102,18 +102,6 @@ do { \
>  } while (0)
>  #endif /* end of +++ */
>  
> -#if 1
> -//defined CONFIG_MTK_MMC_CD_POLL
> -#define IRQ_MSG(fmt, args...)
> -#else
> -/* PID in ISR in not corrent */
> -#define IRQ_MSG(fmt, args...) \
> -do { \
> -	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d>\n",	\
> -	       host->id,  ##args, __FUNCTION__, __LINE__);	\
> -} while (0);
> -#endif
> -
>  void msdc_debug_proc_init(void);
>  
>  #if 0 /* --- chhung */
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index 7474f9ed7b5b..273593427d3a 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -278,8 +278,6 @@ static void msdc_tasklet_card(struct work_struct *work)
>  		host->mmc->f_max = HOST_MAX_MCLK;
>  		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
>  	}
> -
> -	IRQ_MSG("card found<%s>", inserted ? "inserted" : "removed");
>  #endif
>  
>  	spin_unlock(&host->lock);
> @@ -1638,17 +1636,10 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>  	if (intsts & MSDC_INT_CDSC) {
>  		if (host->mmc->caps & MMC_CAP_NEEDS_POLL)
>  			return IRQ_HANDLED;
> -		IRQ_MSG("MSDC_INT_CDSC irq<0x%.8x>", intsts);
>  		schedule_delayed_work(&host->card_delaywork, HZ);
>  		/* tuning when plug card ? */
>  	}
>  
> -	/* sdio interrupt */
> -	if (intsts & MSDC_INT_SDIOIRQ) {
> -		IRQ_MSG("XXX MSDC_INT_SDIOIRQ");  /* seems not sdio irq */
> -		//mmc_signal_sdio_irq(host->mmc);
> -	}
> -
>  	/* transfer complete interrupt */
>  	if (data != NULL) {
>  		if (inten & MSDC_INT_XFER_COMPL) {
> @@ -1663,10 +1654,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>  			msdc_clr_int();
>  
>  			if (intsts & MSDC_INT_DATTMO) {
> -				IRQ_MSG("XXX CMD<%d> MSDC_INT_DATTMO", host->mrq->cmd->opcode);
>  				data->error = -ETIMEDOUT;
>  			} else if (intsts & MSDC_INT_DATCRCERR) {
> -				IRQ_MSG("XXX CMD<%d> MSDC_INT_DATCRCERR, SDC_DCRC_STS<0x%x>", host->mrq->cmd->opcode, readl(host->base + SDC_DCRC_STS));
>  				data->error = -EIO;
>  			}

The {} should be removed here, right?

thanks,

greg k-h
