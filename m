Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F0EECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBE42086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBE42086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbeIRQ7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:59:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeIRQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:59:25 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C7DE2C03;
        Tue, 18 Sep 2018 11:27:14 +0000 (UTC)
Date:   Tue, 18 Sep 2018 13:27:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>, Joe Perches <joe@perches.com>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH] staging: mt7621-mmc: Remove do {} while (0) loop for
 single statement macro
Message-ID: <20180918112711.GA14453@kroah.com>
References: <20180915131748.GA19661@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180915131748.GA19661@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 06:47:51PM +0530, Nishad Kamdar wrote:
> This patch removes do {} while (0) loop for single statement macros.
> Issue found by checkpatch.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/sd.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index 7474f9ed7b5b..ec12a3a5a926 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -104,14 +104,10 @@ static int cd_active_low = 1;
>  /* gate means clock power down */
>  static int g_clk_gate = 0;
>  #define msdc_gate_clock(id) \
> -	do {					       \
> -		g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN));	\
> -	} while (0)
> +	(g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN)))

This should become an inline function, right?


>  /* not like power down register. 1 means clock on. */
>  #define msdc_ungate_clock(id) \
> -	do {					    \
> -		g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN);	\
> -	} while (0)
> +	(g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN))

Same here.

>  
>  // do we need sync object or not
>  void msdc_clk_status(int *status)
> @@ -170,9 +166,7 @@ static void msdc_clr_fifo(struct msdc_host *host)
>  	} while (0)
>  
>  #define msdc_irq_restore(val) \
> -	do {					\
> -		sdr_set_bits(host->base + MSDC_INTEN, val);	\
> -	} while (0)
> +	(sdr_set_bits(host->base + MSDC_INTEN, val))

Just call the one function where this is used and delete this #define.

Same type of changes for the rest of these as well.

thanks,

greg k-h
