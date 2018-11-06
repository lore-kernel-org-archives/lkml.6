Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD97C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2920685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF2920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbeKGA1c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:27:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54232 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbeKGA1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:27:31 -0500
Received: from beast.luon.net (unknown [IPv6:2001:470:78b1:0:40e2:7ff:fef4:3122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 18FFE26C6DA;
        Tue,  6 Nov 2018 15:01:53 +0000 (GMT)
Received: by beast.luon.net (Postfix, from userid 1000)
        id F144E3E238B; Tue,  6 Nov 2018 16:01:50 +0100 (CET)
Message-ID: <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
From:   Sjoerd Simons <sjoerd.simons@collabora.co.uk>
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-mmc@vger.kernel.org
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Bastian Stender <bst@pengutronix.de>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>
Date:   Tue, 06 Nov 2018 16:01:50 +0100
In-Reply-To: <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
         <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 19:34 +0530, Faiz Abbas wrote:
> Hi Sjoerd,
> 
> On Tuesday 06 November 2018 07:00 PM, Sjoerd Simons wrote:
> > On some of our boards containing Micron eMMC chips compatible with
> > the eMMC 5.0 specification we starting seeing boot failures due to
> > timeouts:
> >   mmc1: error -110 whilst initialising MMC card
> > 
> > It turns out that switching the cache on after a power loss event
> > can
> > take quite long. In some simple testing thusfar we've seen values
> > up to
> > 700ms, which is far longer then the GENERIC_CMD6_TIME of the chip
> > (250ms).
> > 
> > Looking at both the eMMC 4.51 and 5.0 specification there doesn't
> > seem
> > to be a defined upper bound for the CACHE_CTRL ON command. For both
> > CACHE_CTRL OFF and FLUSH_CACHE it is documented that they can take
> > essentially unbounded time, but CACHE_CTRL ON i get the impression
> > that
> > it's assumed to be "fast". Unfortunately this is not true in
> > reality.
> > 
> > To resolve this, simply drop the timeout from CACHE_CTRL ON and
> > assume
> > it might take an unbounded time similar to the FLUSH_CACHE command.
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > 
> 
> I have the exact same problem with micron cards. Specifically with
> CID: 
> R1J56L
> 
> The correct way to solve this would be to add a quirk for the
> specific 
> card. Does this patch solve your issue?

It would yes (unfortunately my google-foo failed to find your patch); 

That also happens to be one of the cards we deploy; However i did
wonder about adding a quirk but decided against it as it was not clear
to me from the specification that CACHE ON really is meant to complete
within GENERIC_CMD6_TIMEOUT. That and i fret about ending up in hit-a-
mole games as the failure is really quite tedious (boot failure). 

Our approved parts lists has more Micron eMMC 5.0 parts, I'm trying to
find out whether we actually had batches build with those and then we
check if they have the same behaviour or not.

  Sjoerd

> ---8<---
> From 9d470be59acd82859beb4c965a620c9a32858bb4 Mon Sep 17 00:00:00
> 2001
> From: Faiz Abbas <faiz_abbas@ti.com>
> Date: Wed, 20 Jun 2018 20:36:38 +0530
> Subject: [PATCH] mmc: core: Add QUIRK for eMMC CMD6 timeout for some
> Micron
>  cards
> 
> It seems that on some Micron eMMC cards present on TI's AM654 EVM
> the CACHE_CTRL_ENABLE function in CMD6 takes longer (~750 ms) than
> the specified timeout in the GENERIC_CMD6_TIMEOUT byte of the
> Extended CSD (~250 ms).
> 
> Therefore, add a quirk to detect this card and use a value of 1 sec
> for
> timeout.
> 
> Reported-by: Andreas Dannenberg <dannenberg@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/mmc/core/card.h   |  7 +++++++
>  drivers/mmc/core/mmc.c    | 14 +++++++++++++-
>  drivers/mmc/core/quirks.h |  8 ++++++++
>  include/linux/mmc/card.h  |  1 +
>  4 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 9c821eedd156..6b5e3c6253f5 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -84,6 +84,8 @@ struct mmc_fixup {
>  #define CID_MANFID_HYNIX	0x90
>  #define CID_MANFID_NUMONYX	0xFE
>  
> +#define CID_NAME_R1J56L	"R1J56L"
> +
>  #define END_FIXUP { NULL }
>  
>  #define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,	
> \
> @@ -221,4 +223,9 @@ static inline int mmc_card_broken_hpi(const
> struct mmc_card *c)
>  	return c->quirks & MMC_QUIRK_BROKEN_HPI;
>  }
>  
> +static inline int mmc_card_long_cache_ctrl(const struct mmc_card *c)
> +{
> +	return c->quirks & MMC_QUIRK_LONG_CACHE_ENABLE_TIME;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index bad5c1bf4ed9..667caeb640a3 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1522,6 +1522,7 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  	struct mmc_card *oldcard)
>  {
>  	struct mmc_card *card;
> +	unsigned int cache_ctrl_timeout;
>  	int err;
>  	u32 cid[4];
>  	u32 rocr;
> @@ -1766,9 +1767,20 @@ static int mmc_init_card(struct mmc_host
> *host, u32 ocr,
>  	 */
>  	if (!mmc_card_broken_hpi(card) &&
>  	    card->ext_csd.cache_size > 0) {
> +
> +		/*
> +		 * Some cards require a longer timeout than given in
> CSD.
> +		 * Use a one second timeout here which can be increased
> +		 * further if more cards needing larger timeouts are
> found
> +		 */
> +		if (mmc_card_long_cache_ctrl(card))
> +			cache_ctrl_timeout = 1000;
> +		else
> +			cache_ctrl_timeout = card-
> >ext_csd.generic_cmd6_time;
> +
>  		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  				EXT_CSD_CACHE_CTRL, 1,
> -				card->ext_csd.generic_cmd6_time);
> +				cache_ctrl_timeout);
>  		if (err && err != -EBADMSG)
>  			goto free_card;
>  
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 5153577754f0..934ca72ef2b1 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -116,6 +116,14 @@ static const struct mmc_fixup
> mmc_ext_csd_fixups[] = {
>  	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
>  			      0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI,
> 6),
>  
> +	/*
> +	 * Certain Micron eMMC cards need a longer CMD6:CACHE_CTRL
> timeout
> +	 * than indicated in CSD
> +	 */
> +	MMC_FIXUP_EXT_CSD_REV(CID_NAME_R1J56L, CID_MANFID_MICRON,
> +			      0x14e, add_quirk,
> +			      MMC_QUIRK_LONG_CACHE_ENABLE_TIME, 7),
> +
>  	END_FIXUP
>  };
>  
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 279b39008a33..5a8ce0bb222e 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -268,6 +268,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling
> SDIO_CCCR_INTx could create a fake interrupt */
>  #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim
> */
>  #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI
> support */
> +#define MMC_QUIRK_LONG_CACHE_ENABLE_TIME	(1 << 14) /* CACHE_CTRL
> enable time > CSD says */
>  
>  	bool			reenable_cmdq;	/* Re-enable Command
> Queue */
>  
-- 
Sjoerd Simons
Collabora Ltd.
