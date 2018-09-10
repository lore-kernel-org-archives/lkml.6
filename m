Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6FDC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D18620880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D18620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeIJT7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:59:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeIJT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:59:47 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6B20CDE;
        Mon, 10 Sep 2018 15:05:15 +0000 (UTC)
Date:   Mon, 10 Sep 2018 17:05:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>, Joe Perches <joe@perches.com>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v6 3/3] staging: mt7621-mmc: Fix debug macro IRQ_MSG and
 its usages
Message-ID: <20180910150513.GA25530@kroah.com>
References: <cover.1535752537.git.nishadkamdar@gmail.com>
 <8f8cff3f1042e3fd303350baa261876cf4e3d7e7.1535752537.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8cff3f1042e3fd303350baa261876cf4e3d7e7.1535752537.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 03:51:10AM +0530, Nishad Kamdar wrote:
> Replace all usages of IRQ_MSG with with dev_<level> without __func__
> or __LINE__ or current->comm and current->pid. Remove the do {}
> while(0) loop for the single statement macro. Drop IRQ_MSG from dbg.h.
> Issue found by checkpatch.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v6:
>   - No change
> Changes in v5:
>   - No change
> ---
>  drivers/staging/mt7621-mmc/dbg.h | 12 -----------
>  drivers/staging/mt7621-mmc/sd.c  | 36 ++++++++++++++++++++++++--------
>  2 files changed, 27 insertions(+), 21 deletions(-)
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

So right now this define does nothing, yet:

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
> index 7474f9ed7b5b..f3ae19fe0f76 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -279,7 +279,9 @@ static void msdc_tasklet_card(struct work_struct *work)
>  		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
>  	}
>  
> -	IRQ_MSG("card found<%s>", inserted ? "inserted" : "removed");
> +	dev_err(mmc_dev(host->mmc),
> +		"%d -> card found<%s>\n",
> +		host->id, inserted ? "inserted" : "removed");

You are now printing out lots of "errors" that really are not errors.

As these messages are not being printed at all right now, why not just
delete these as well?

Your first 2 patches do look good, I've queued them up now.

thanks,

greg k-h
