Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933743AbeCEJiw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:38:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:27101 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752556AbeCEJit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:38:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="208868379"
Subject: Re: [PATCH v2 09/16] mmc: sdhci: Add quirk to disable HW timeout
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-10-kishon@ti.com>
 <cda22332-ed17-9309-4989-19765744879b@intel.com>
 <a7ba98cd-7a3c-00f9-bfaa-a982126c9185@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <18a7cff5-5cc5-4eb1-17c8-033bd5ddf6c1@intel.com>
Date: Mon, 5 Mar 2018 11:38:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a7ba98cd-7a3c-00f9-bfaa-a982126c9185@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/18 11:30, Kishon Vijay Abraham I wrote:
> Hi Adrian,
> 
> On Monday 19 February 2018 02:21 PM, Adrian Hunter wrote:
>> On 05/02/18 14:50, Kishon Vijay Abraham I wrote:
>>> Add quirk to disable HW timeout if the requested timeout is more than
>>> the maximum obtainable timeout.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 12 ++++++++++++
>>>  drivers/mmc/host/sdhci.h |  7 +++++++
>>>  2 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 070aff9c108f..1aa74b4682f3 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -735,6 +735,12 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>>  		DBG("Too large timeout 0x%x requested for CMD%d!\n",
>>>  		    count, cmd->opcode);
>>>  		count = 0xE;
>>> +		if (host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
>>> +			host->ier &= ~SDHCI_INT_DATA_TIMEOUT;
>>> +			sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>>> +			sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>>> +			host->hw_timeout_disabled = true;
>>> +		}
>>
>> sdhci_calc_timeout() is really for calculations so please do this in
>> sdhci_set_timeout() instead (i.e. change sdhci_calc_timeout() to return
>> whether the timeout is too big).  Note that you need to cater for the "/*
>> Unspecified timeout, assume max */" case and the
>> SDHCI_QUIRK_BROKEN_TIMEOUT_VAL case.
>>
>> Also if SDHCI_INT_DATA_TIMEOUT is not being disabled, check here to
>> re-enable it and leave sdhci_request_done() alone. i.e.
>>
>> 	else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
>> 		host->ier |= SDHCI_INT_DATA_TIMEOUT;
>> 		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>> 		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>> 	}
>>
>> Maybe make a separate subroutine for the update:
>>
>> void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
>> {
>> 	if (enable)
>> 		host->ier |= SDHCI_INT_DATA_TIMEOUT;
>> 	else
>> 		host->ier &= ~SDHCI_INT_DATA_TIMEOUT;
>> 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>> 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>> }
>>
>>
>>>  	}
>>>  
>>>  	return count;
>>> @@ -2349,6 +2355,12 @@ static bool sdhci_request_done(struct sdhci_host *host)
>>>  	}
>>>  
>>>  	sdhci_del_timer(host, mrq);
>>> +	if (sdhci_data_line_cmd(mrq->cmd) && host->hw_timeout_disabled) {
>>> +		host->ier |= SDHCI_INT_DATA_TIMEOUT;
>>> +		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>>> +		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>>> +		host->hw_timeout_disabled = false;
>>> +	}
>>>  
>>>  	/*
>>>  	 * Always unmap the data buffers if they were mapped by
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index afab26fd70e6..3a967a56fcc3 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -437,6 +437,11 @@ struct sdhci_host {
>>>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
>>>  /* Controller has CRC in 136 bit Command Response */
>>>  #define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
>>> +/*
>>> + * Disable HW timeout if the requested timeout is more than the maximum
>>> + * obtainable timeout
>>> + */
>>> +#define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
> 
> Are you okay with the definition of this quirk? i.e this quirk is applied only
> when the requested timeout is "more" than the maximum obtainable timeout.
> 
> By this way platforms can continue to use hardware timeout for smaller timeout
> value.

It is fine to me.
