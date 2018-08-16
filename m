Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93D1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E24D21473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E24D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeHPXIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:08:14 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:51122 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbeHPXIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:08:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E7447180A813A;
        Thu, 16 Aug 2018 20:07:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: waste90_9401b01f0d51
X-Filterd-Recvd-Size: 3439
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 Aug 2018 20:07:43 +0000 (UTC)
Message-ID: <60b91f3fc3dce48e2da0c9f2a7896d84829e1d25.camel@perches.com>
Subject: Re: [PATCH] staging: mt7621-mmc: Use __func__ instead of
 __FUNCTION__ in dbg.h
From:   Joe Perches <joe@perches.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian =?ISO-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        NeilBrown <neil@brown.name>, John Crispin <blogic@openwrt.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Aug 2018 13:07:41 -0700
In-Reply-To: <20180816194943.GA25895@nishad>
References: <20180816194943.GA25895@nishad>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 01:19 +0530, Nishad Kamdar wrote:
> Use the identifier __func__ instead of gcc specific __FUNCTION__
> in dbg.h. Limit these lines to 80 characters. Issues found by
> checkpatch.

It looks like there are 4 uses in -next

drivers/staging/mt7621-mmc/dbg.h:110:            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);      \
drivers/staging/mt7621-mmc/dbg.h:118:          host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
drivers/staging/mt7621-mmc/dbg.h:129:          host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
drivers/staging/mt7621-mmc/dbg.h:136:          host->id,  ##args, __FUNCTION__, __LINE__);      \

If you are going to fix this by substitution,
please fix all of them, even if commented out.

And likely, all these uses should all be converted
to dev_<level> instead without __func__ or __LINE__
or current->comm and current->pid.

And relatedly, these are single statement macros and
don't need do while (0);

And the ; after while (0) is unnecessary.

> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/dbg.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> index 2f2c56b73987..5da275239d7c 100644
> --- a/drivers/staging/mt7621-mmc/dbg.h
> +++ b/drivers/staging/mt7621-mmc/dbg.h
> @@ -115,7 +115,8 @@ do {    \
>  #define ERR_MSG(fmt, args...) \
>  do { \
>  	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> -	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> +	       host->id,  ##args, __func__, __LINE__, current->comm, \
> +	       current->pid); \
>  } while (0);
>  
>  #if 1
> @@ -126,14 +127,15 @@ do { \
>  #define INIT_MSG(fmt, args...) \
>  do { \
>  	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> -	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> +	       host->id,  ##args, __func__, __LINE__, current->comm, \
> +	       current->pid); \
>  } while (0);
>  
>  /* PID in ISR in not corrent */
>  #define IRQ_MSG(fmt, args...) \
>  do { \
>  	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d>\n",	\
> -	       host->id,  ##args, __FUNCTION__, __LINE__);	\
> +	       host->id,  ##args, __func__, __LINE__);	\
>  } while (0);
>  #endif
>  
