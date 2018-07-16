Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1A9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D393208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D393208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeGPNwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:52:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:18246 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbeGPNwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:52:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 06:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,361,1526367600"; 
   d="scan'208";a="240666744"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga005.jf.intel.com with ESMTP; 16 Jul 2018 06:25:11 -0700
Subject: Re: [PATCH V3 2/7] mmc: sdhci: made changes for System Address
 register of SDMA
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
 <1531106398-14062-3-git-send-email-zhang.chunyan@linaro.org>
 <1653583c-8d5b-6781-e923-9dcfd1e96403@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ff9c22dc-b462-98d9-fb74-930107a3d66f@intel.com>
Date:   Mon, 16 Jul 2018 16:23:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1653583c-8d5b-6781-e923-9dcfd1e96403@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/18 16:03, Adrian Hunter wrote:
> On 09/07/18 06:19, Chunyan Zhang wrote:
>> According to the SD host controller specification version 4.10, when
>> Host Version 4 is enabled, SDMA uses ADMA System Address register
>> (05Fh-058h) instead of using SDMA System Address register to
>> support both 32-bit and 64-bit addressing.
> 
> The commit message is good but the subject is not so good.  What about
> "Change SDMA address register for V4 mode"
> 
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 525862f..c7de6a5 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -701,7 +701,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>>  	}
>>  }
>>  
>> -static u32 sdhci_sdma_address(struct sdhci_host *host)
>> +static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>>  {
>>  	if (host->bounce_buffer)
>>  		return host->bounce_addr;
>> @@ -709,6 +709,18 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
>>  		return sg_dma_address(host->data->sg);
>>  }
>>  
>> +static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
>> +{
>> +	if (host->v4_mode) {
>> +		sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
>> +		if (host->flags & SDHCI_USE_64_BIT_DMA)
>> +			sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);

Also need to adjust the initialization in sdhci_setup_host() which prevents
SDMA with 64-bit DMA i.e.

	/* SDMA does not support 64-bit DMA */
	if (host->flags & SDHCI_USE_64_BIT_DMA)
		host->flags &= ~SDHCI_USE_SDMA;


>> +	} else {
>> +		sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
>> +	}
>> +
>> +}
>> +
>>  static unsigned int sdhci_target_timeout(struct sdhci_host *host,
>>  					 struct mmc_command *cmd,
>>  					 struct mmc_data *data)
>> @@ -968,8 +980,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>  					     SDHCI_ADMA_ADDRESS_HI);
>>  		} else {
>>  			WARN_ON(sg_cnt != 1);
>> -			sdhci_writel(host, sdhci_sdma_address(host),
>> -				     SDHCI_DMA_ADDRESS);
>> +			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
>>  		}
>>  	}
>>  
>> @@ -2796,7 +2807,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>  		 * some controllers are faulty, don't trust them.
>>  		 */
>>  		if (intmask & SDHCI_INT_DMA_END) {
>> -			u32 dmastart, dmanow;
>> +			dma_addr_t dmastart, dmanow;
>>  
>>  			dmastart = sdhci_sdma_address(host);
>>  			dmanow = dmastart + host->data->bytes_xfered;
>> @@ -2807,9 +2818,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>  				~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
> 
> That isn't going to work with 64-bit addresses.  Need to cast
> SDHCI_DEFAULT_BOUNDARY_SIZE to dma_addr_t
> 
>>  				SDHCI_DEFAULT_BOUNDARY_SIZE;
>>  			host->data->bytes_xfered = dmanow - dmastart;
>> -			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
>> -			    dmastart, host->data->bytes_xfered, dmanow);
>> -			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
>> +			DBG("DMA base 0x%016llx, transferred 0x%06x bytes, next 0x%016llx\n",
> 
> Can you use %pad for dma_addr_t
> 
>> +			    (u64)dmastart, host->data->bytes_xfered, (u64)dmanow);
>> +			sdhci_set_sdma_addr(host, dmanow);
>>  		}
>>  
>>  		if (intmask & SDHCI_INT_DATA_END) {
>>
> 
> 

