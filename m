Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7FCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825D4218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t9yUsQlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732875AbfAaM3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:29:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46600 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:29:01 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0VCSsUt007670;
        Thu, 31 Jan 2019 06:28:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548937734;
        bh=XGvTSiJVE2NrDfBue8YEIy9vouljmzIY6F3BynwSat0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t9yUsQlF1bMSn59PpWCqBhYFMIjhwmN9x/GnWndV697JNoFMPrKgacbLai6zKPcd+
         imfuF//M/Ed31tgV1k6XEE0Aw5nuEFLSJ0vT5jdnm7N3IrRUvWDKuy+XXsL0vA7DTu
         HCMvtUip3sd+RJbjuNvfu/5t3gltUj1uBSAYjgjc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0VCSsoX102352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 06:28:54 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 31
 Jan 2019 06:28:54 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 31 Jan 2019 06:28:54 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0VCSp5c022847;
        Thu, 31 Jan 2019 06:28:51 -0600
Subject: Re: [PATCH 1/7] mmc: sdhci: add support for using external DMA
 devices
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <CAG2=9p_mUyY=hKLN4E-ZUaJNueE-h5hHKDnJV5cG5kjtLsEgPA@mail.gmail.com>
 <20190130110548.19151-1-zhang.chunyan@linaro.org>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <708d8bb6-6c64-b63d-398f-19c7f784020c@ti.com>
Date:   Thu, 31 Jan 2019 18:02:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130110548.19151-1-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chunyan,

On 30/01/19 4:35 PM, Chunyan Zhang wrote:
> Some standard SD host controllers can support both external dma
> controllers as well as ADMA/SDMA in which the SD host controller
> acts as DMA master. TI's omap controller is the case as an example.
> 
> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> the host controller but does not have any support for external DMA
> controllers implemented using dmaengine, meaning that custom code is
> needed for any systems that use an external DMA controller with SDHCI.
> 
> Fixes by Faiz Abbas <faiz_abbas@ti.com>:
> 1. Map scatterlists before dmaengine_prep_slave_sg()
> 2. Use dma_async() functions inside of the send_command() path and
> synchronize once at the start of each request.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
> Changes from the last version:
> * Moved sdhci_set_timeout() from _prepare_data() to its caller -
>   sdhci_send_command();
> * Factor out a new function sdhci_reset_data() which deal with sanity
>   checks for mmc_data and reset for host->data, these processes were
>   in _prepare_data();
> * Factor out a new function sdhci_set_block_info() for configuring data
>   blocks which were processing at bottom of _prepare_data();
> * Added a new tasklet and functions for handling external dma  error case;
> * Removed sdhci_external_dma_cleanup() which is not used;
> * Added an empty sdhci_external_dma_channel definition for
>   !IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA);
> * Addressed some other comments from Adrian:
> - Removed check for MMC_SET_BLOCK_COUNT, left checking !cmd->data only
>   which is enough.

There should have been a v2 in the patch description. It lets reviewers
know that they have seen this patch before and its not the same thing. I
would have preferred you had me test this before posting it to the
mailing list. Otherwise there should be a "not tested" in the description.

> ---
>  drivers/mmc/host/Kconfig |   3 +
>  drivers/mmc/host/sdhci.c | 333 +++++++++++++++++++++++++++++++++++----
>  drivers/mmc/host/sdhci.h |  10 ++
>  3 files changed, 317 insertions(+), 29 deletions
[snip]

> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +	struct dma_chan *chan = sdhci_external_dma_channel(host, data);
chan is not being used in this function.
> +
> +	if (!sdhci_external_dma_setup(host, cmd)) {
> +		__sdhci_external_dma_prepare_data(host, cmd);
>  	} else {
> -		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> +		sdhci_external_dma_release(host);
> +		pr_err("%s: Cannot use external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
> +		       mmc_hostname(host->mmc));
> +		sdhci_prepare_data(host, cmd);
> +	}
> +}
> +
> +static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	struct dma_chan *chan;

I think you wanted to initialize this one.

> +
> +	if (!cmd->data)
> +		return;
> +
> +	chan = sdhci_external_dma_channel(host, cmd->data);
> +	if (chan)
> +		dma_async_issue_pending(chan);
> +}
> +
> +static bool sdhci_external_dma_request_done(struct sdhci_host *host)
> +{
> +	struct mmc_request *mrq;
> +	struct dma_chan *chan;
> +	int i;
> +
> +	spin_lock_irqsave(&host->lock, flags);

flags is not declared.

> +
> +	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> +		mrq = host->mrqs_done[i];
> +		if (mrq)
> +			break;
>  	}
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	if (!mrq)
> +		return true;
> +
> +	sdhci_tasklet_finish(host);

This doesn't even build. sdhci_tasklet_finish is declared below this. In
the future, if you don't have a platform to test things on, at least
build and use checkpatch before posting it to the mailing list.

Should we even be calling a tasklet callback function directly?
Shouldn't we do a tasklet_schedule()?

Thanks,
Faiz
