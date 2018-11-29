Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65A3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D4A20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D4A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeK2VqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:46:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:9113 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbeK2VqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:46:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 02:41:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="95703319"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2018 02:41:20 -0800
Subject: Re: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA
 devices
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, faiz_abbas@ti.com,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        kishon@ti.com, nsekhar@ti.com
References: <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <1543471664-22856-1-git-send-email-zhang.chunyan@linaro.org>
 <cb2cdfb9-f3e6-72cd-2d55-734b08ea3e15@intel.com>
 <CAAfSe-tw-pEdFBTjeGBQD03QdNMkdnHdf8=2J01Qczf54yJ9CA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9cbb0593-f817-5388-e379-0f7d33cb66b3@intel.com>
Date:   Thu, 29 Nov 2018 12:39:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAAfSe-tw-pEdFBTjeGBQD03QdNMkdnHdf8=2J01Qczf54yJ9CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/18 11:44 AM, Chunyan Zhang wrote:
> On Thu, 29 Nov 2018 at 17:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 29/11/18 8:07 AM, Chunyan Zhang wrote:
>>> Some standard SD host controllers can support both external dma
>>> controllers as well as ADMA/SDMA in which the SD host controller
>>> acts as DMA master. TI's omap controller is the case as an example.
>>>
>>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
>>> the host controller but does not have any support for external DMA
>>> controllers implemented using dmaengine, meaning that custom code is
>>> needed for any systems that use an external DMA controller with SDHCI.
>>>
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>> ---
>>>  drivers/mmc/host/Kconfig |  14 ++++
>>>  drivers/mmc/host/sdhci.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++-
>>>  drivers/mmc/host/sdhci.h |   8 ++
>>>  3 files changed, 206 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index 1b58739..4183f43 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -969,6 +969,7 @@ config MMC_SDHCI_XENON
>>>  config MMC_SDHCI_OMAP
>>>       tristate "TI SDHCI Controller Support"
>>>       depends on MMC_SDHCI_PLTFM && OF
>>> +     select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE
>>>       help
>>>         This selects the Secure Digital Host Controller Interface (SDHCI)
>>>         support present in TI's DRA7 SOCs. The controller supports
>>> @@ -977,3 +978,16 @@ config MMC_SDHCI_OMAP
>>>         If you have a controller with this interface, say Y or M here.
>>>
>>>         If unsure, say N.
>>> +
>>> +config MMC_SDHCI_EXTERNAL_DMA
>>> +        bool "Support external DMA in standard SD host controller"
>>> +     depends on MMC_SDHCI
>>> +     depends on DMA_ENGINE
>>> +     help
>>> +       This is an option for using external DMA device via dmaengine
>>> +       framework.
>>> +
>>> +       If you have a controller which support using external DMA device
>>> +       for data transfer, can say Y.
>>> +
>>> +       If unsure, say N.
>>
>> So if you are going to select this, then you don't need the prompt or help
>> anymore i.e.
>>
>> config MMC_SDHCI_EXTERNAL_DMA
>>         bool
>>
>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 99bdae5..ad7cc80 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -14,6 +14,7 @@
>>>   */
>>>
>>>  #include <linux/delay.h>
>>> +#include <linux/dmaengine.h>
>>>  #include <linux/ktime.h>
>>>  #include <linux/highmem.h>
>>>  #include <linux/io.h>
>>> @@ -1309,6 +1310,162 @@ static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
>>>               del_timer(&host->timer);
>>>  }
>>>
>>> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
>>> +static int sdhci_external_dma_init(struct sdhci_host *host)
>>> +{
>>> +     int ret = 0;
>>> +     struct mmc_host *mmc = host->mmc;
>>> +
>>> +     host->tx_chan = dma_request_chan(mmc->parent, "tx");
>>> +     if (IS_ERR(host->tx_chan)) {
>>> +             ret = PTR_ERR(host->tx_chan);
>>> +             if (ret != -EPROBE_DEFER)
>>> +                     pr_warn("Failed to request TX DMA channel.\n");
>>> +             host->tx_chan = NULL;
>>> +             return ret;
>>> +     }
>>> +
>>> +     host->rx_chan = dma_request_chan(mmc->parent, "rx");
>>> +     if (IS_ERR(host->rx_chan)) {
>>> +             if (host->tx_chan) {
>>> +                     dma_release_channel(host->tx_chan);
>>> +                     host->tx_chan = NULL;
>>> +             }
>>> +
>>> +             ret = PTR_ERR(host->rx_chan);
>>> +             if (ret != -EPROBE_DEFER)
>>> +                     pr_warn("Failed to request RX DMA channel.\n");
>>> +             host->rx_chan = NULL;
>>> +     }
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static inline struct dma_chan *
>>> +sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data)
>>> +{
>>> +     return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
>>> +}
>>> +
>>> +static int sdhci_external_dma_setup(struct sdhci_host *host,
>>> +                                 struct mmc_command *cmd)
>>> +{
>>> +     int ret, i;
>>> +     struct dma_async_tx_descriptor *desc;
>>> +     struct mmc_data *data = cmd->data;
>>> +     struct dma_chan *chan;
>>> +     struct dma_slave_config cfg;
>>> +     dma_cookie_t cookie;
>>> +
>>> +     if (!host->mapbase)
>>> +             return -EINVAL;
>>> +
>>> +     if (!data)
>>> +             return 0;
>>
>> It would read better if the above 2 if-statements were the other way around i.e.
>>
>>         if (!data)
>>                 return 0;
>>
>>         if (!host->mapbase)
>>                 return -EINVAL;
>>
> 
> Ok.
> 
>>> +
>>> +     cfg.src_addr = host->mapbase + SDHCI_BUFFER;
>>> +     cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
>>> +     cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>> +     cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>> +     cfg.src_maxburst = data->blksz / 4;
>>> +     cfg.dst_maxburst = data->blksz / 4;
>>> +
>>> +     /* Sanity check: all the SG entries must be aligned by block size. */
>>> +     for (i = 0; i < data->sg_len; i++) {
>>> +             if ((data->sg + i)->length % data->blksz)
>>> +                     return -EINVAL;
>>> +     }
>>> +
>>> +     chan = sdhci_external_dma_channel(host, data);
>>> +
>>> +     ret = dmaengine_slave_config(chan, &cfg);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
>>> +                                    mmc_get_dma_dir(data),
>>> +                                    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>>> +     if (!desc)
>>> +             return -EINVAL;
>>> +
>>> +     desc->callback = NULL;
>>> +     desc->callback_param = NULL;
>>> +
>>> +     cookie = dmaengine_submit(desc);
>>> +     if (cookie < 0)
>>> +             ret = cookie;
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static void sdhci_external_dma_release(struct sdhci_host *host)
>>> +{
>>> +     if (host->tx_chan) {
>>> +             dma_release_channel(host->tx_chan);
>>> +             host->tx_chan = NULL;
>>> +     }
>>> +
>>> +     if (host->rx_chan) {
>>> +             dma_release_channel(host->rx_chan);
>>> +             host->rx_chan = NULL;
>>> +     }
>>> +
>>> +     sdhci_switch_external_dma(host, false);
>>> +}
>>> +
>>> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
>>> +                                         struct mmc_command *cmd)
>>> +{
>>> +     if (sdhci_external_dma_setup(host, cmd)) {
>>> +             sdhci_external_dma_release(host);
>>> +             pr_err("%s: Failed to setup external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
>>> +                    mmc_hostname(host->mmc));
>>> +     } else {
>>> +             /* Prepare for using external dma */
>>> +             host->flags |= SDHCI_REQ_USE_DMA;
>>> +     }
>>> +
>>> +     sdhci_prepare_data(host, cmd);
>>> +}
>>> +
>>> +static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
>>> +                                         struct mmc_command *cmd)
>>> +{
>>> +     struct dma_chan *chan;
>>> +
>>> +     if (cmd->opcode != MMC_SET_BLOCK_COUNT && cmd->data) {
>>
>> MMC_SET_BLOCK_COUNT doesn't have data so that part is not needed
> 
> Didn't get you here.
> This is for other packets except MMC_SET_BLOCK_COUNT.
> 

MMC_SET_BLOCK_COUNT is not a data transfer command, so cmd->data == NULL anyway.
