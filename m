Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3E8C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5064121748
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5064121748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeHRO4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:56:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34652 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:56:51 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 65A733EE;
        Sat, 18 Aug 2018 11:49:25 +0000 (UTC)
Date:   Sat, 18 Aug 2018 13:49:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v2] staging: mt7621-mmc: Fix debug macros in dbg.h
Message-ID: <20180818114923.GB4137@kroah.com>
References: <20180818114313.GA6608@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818114313.GA6608@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 05:13:17PM +0530, Nishad Kamdar wrote:
> Fixed four debug macros by replacing printk with dev_<level>
> without __func__ or __LINE__ or current->comm and current->pid.
> Further removed the do {} while(0) loop for single statement
> macro. Issues found by checkpatch.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v2:
>   - Replace printk with dev_<level>.
>   - Remove __func__, __LINE__, current->comm, current->pid from arguments.
>   - Remove the do {} while(0) loop from these macros.
>   - Modify commit message to include other changes.
> ---
>  drivers/staging/mt7621-mmc/dbg.h | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> index 2f2c56b73987..e8091db3c1d6 100644
> --- a/drivers/staging/mt7621-mmc/dbg.h
> +++ b/drivers/staging/mt7621-mmc/dbg.h
> @@ -104,19 +104,13 @@ do { \
>  
>  #define N_MSG(evt, fmt, args...)
>  /*
> -do {    \
> -    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> -        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> -            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
> -    } \
> -} while(0)
> -*/
> + *if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> + *    dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args) \
> + *}
> + */

This can just be deleted, just drop it.

>  
>  #define ERR_MSG(fmt, args...) \
> -do { \
> -	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> -	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> -} while (0);
> +dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args)

No, please just replace all usages of ERR_MSG with dev_err() in the code
itself, and then drop ERR_MSG.  No driver/subsystem should have special
macros just for it.

>  #if 1
>  //defined CONFIG_MTK_MMC_CD_POLL
> @@ -124,17 +118,11 @@ do { \
>  #define IRQ_MSG(fmt, args...)
>  #else
>  #define INIT_MSG(fmt, args...) \
> -do { \
> -	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> -	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> -} while (0);
> +dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args)

Same here.  Actually I bet all INIT_MSG can just be removed :)

>  
>  /* PID in ISR in not corrent */
>  #define IRQ_MSG(fmt, args...) \
> -do { \
> -	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d>\n",	\
> -	       host->id,  ##args, __FUNCTION__, __LINE__);	\
> -} while (0);
> +dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args)

Same here, just replace the usage of these macros with the real thing.

thanks,

greg k-h
