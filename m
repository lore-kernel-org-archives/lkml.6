Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6398EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B1220817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fp/+JC2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B1220817
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeKSUU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:20:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60366 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKSUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:20:57 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAJ9v9x2044217;
        Mon, 19 Nov 2018 03:57:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542621429;
        bh=5NGcmgrLOUZ1gxJ5u2nRAxeNjcAU3Af6W1bCov0IAf8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Fp/+JC2ApgtXRtLNsYTzDfYZlSZJs3ICYaF6mDnrB5GKa4Cqv3kov8KZCdR7c12iI
         +c/Tn+EDZnJnirgxvl+W7kjvrarSL1onV6CcSqhmCp2J261Z6jwu482JG4h+5YAF63
         cGANmpOTlJkui0NjL/cEZsjX9CZS8q4nzFotGIxU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAJ9v9Ks004674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 03:57:09 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 03:57:06 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 03:57:06 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAJ9v4Wr020539;
        Mon, 19 Nov 2018 03:57:04 -0600
Subject: Re: [PATCH] MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5912/OMAP310
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        <linux-mmc@vger.kernel.org>
CC:     Andrzej Zaborowski <balrogg@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181118201919.14401-1-aaro.koskinen@iki.fi>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ffdad271-943c-f4e7-8ec9-2af5769798a4@ti.com>
Date:   Mon, 19 Nov 2018 11:58:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181118201919.14401-1-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aaro,

On 2018-11-18 22:19, Aaro Koskinen wrote:
> Since v2.6.22 or so there has been reports [1] about OMAP MMC being
> broken on OMAP15XX based hardware (OMAP5912 and OMAP310). The breakage
> seems to have been caused by commit 46a6730e3ff9 ("mmc-omap: Fix
> omap to use MMC_POWER_ON") that changed clock enabling to be done
> on MMC_POWER_ON. This can happen multiple times in a row, and on 15XX
> the hardware doesn't seem to like it and the MMC just stops responding.
> Fix by memorizing the power mode and do the init only when necessary.
> 
> Before the patch (on Palm TE):
> 
> 	mmc0: new SD card at address b368
> 	mmcblk0: mmc0:b368 SDC   977 MiB
> 	mmci-omap mmci-omap.0: command timeout (CMD18)
> 	mmci-omap mmci-omap.0: command timeout (CMD13)
> 	mmci-omap mmci-omap.0: command timeout (CMD13)
> 	mmci-omap mmci-omap.0: command timeout (CMD12) [x 6]
> 	mmci-omap mmci-omap.0: command timeout (CMD13) [x 6]
> 	mmcblk0: error -110 requesting status
> 	mmci-omap mmci-omap.0: command timeout (CMD8)
> 	mmci-omap mmci-omap.0: command timeout (CMD18)
> 	mmci-omap mmci-omap.0: command timeout (CMD13)
> 	mmci-omap mmci-omap.0: command timeout (CMD13)
> 	mmci-omap mmci-omap.0: command timeout (CMD12) [x 6]
> 	mmci-omap mmci-omap.0: command timeout (CMD13) [x 6]
> 	mmcblk0: error -110 requesting status
> 	mmcblk0: recovery failed!
> 	print_req_error: I/O error, dev mmcblk0, sector 0
> 	Buffer I/O error on dev mmcblk0, logical block 0, async page read
> 	 mmcblk0: unable to read partition table
> 
> After the patch:
> 
> 	mmc0: new SD card at address b368
> 	mmcblk0: mmc0:b368 SDC   977 MiB
> 	 mmcblk0: p1
> 
> The patch is based on a fix and analysis done by Ladislav Michl.
> 
> Tested on OMAP15XX/OMAP310 (Palm TE), OMAP1710 (Nokia 770)
> and OMAP2420 (Nokia N810).

Do you know if the DMA is enabled for the MMC? It might not work via
DMAengine.

> [1] https://marc.info/?t=123175197000003&r=1&w=2
> 
> Fixes: 46a6730e3ff9 ("mmc-omap: Fix omap to use MMC_POWER_ON")
> Reported-by: Ladislav Michl <ladis@linux-mips.org>
> Reported-by: Andrzej Zaborowski <balrogg@gmail.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/mmc/host/omap.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index adf32682f27a..c60a7625b1fa 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -104,6 +104,7 @@ struct mmc_omap_slot {
>  	unsigned int		vdd;
>  	u16			saved_con;
>  	u16			bus_mode;
> +	u16			power_mode;
>  	unsigned int		fclk_freq;
>  
>  	struct tasklet_struct	cover_tasklet;
> @@ -1157,7 +1158,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	struct mmc_omap_slot *slot = mmc_priv(mmc);
>  	struct mmc_omap_host *host = slot->host;
>  	int i, dsor;
> -	int clk_enabled;
> +	int clk_enabled, init_stream;
>  
>  	mmc_omap_select_slot(slot, 0);
>  
> @@ -1167,6 +1168,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		slot->vdd = ios->vdd;
>  
>  	clk_enabled = 0;
> +	init_stream = 0;
>  	switch (ios->power_mode) {
>  	case MMC_POWER_OFF:
>  		mmc_omap_set_power(slot, 0, ios->vdd);
> @@ -1174,13 +1176,17 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	case MMC_POWER_UP:
>  		/* Cannot touch dsor yet, just power up MMC */
>  		mmc_omap_set_power(slot, 1, ios->vdd);
> +		slot->power_mode = ios->power_mode;
>  		goto exit;
>  	case MMC_POWER_ON:
>  		mmc_omap_fclk_enable(host, 1);
>  		clk_enabled = 1;
>  		dsor |= 1 << 11;
> +		if (slot->power_mode != MMC_POWER_ON)
> +			init_stream = 1;
>  		break;
>  	}
> +	slot->power_mode = ios->power_mode;
>  
>  	if (slot->bus_mode != ios->bus_mode) {
>  		if (slot->pdata->set_bus_mode != NULL)
> @@ -1196,7 +1202,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	for (i = 0; i < 2; i++)
>  		OMAP_MMC_WRITE(host, CON, dsor);
>  	slot->saved_con = dsor;
> -	if (ios->power_mode == MMC_POWER_ON) {
> +	if (init_stream) {
>  		/* worst case at 400kHz, 80 cycles makes 200 microsecs */
>  		int usecs = 250;
>  
> @@ -1234,6 +1240,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
>  	slot->host = host;
>  	slot->mmc = mmc;
>  	slot->id = id;
> +	slot->power_mode = MMC_POWER_UNDEFINED;
>  	slot->pdata = &host->pdata->slots[id];
>  
>  	host->slots[id] = slot;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
