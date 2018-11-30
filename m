Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8128CC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCB220868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCB220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeLABvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:51:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:44118 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbeLABvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:51:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 06:41:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,298,1539673200"; 
   d="scan'208";a="96315664"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2018 06:41:40 -0800
Subject: Re: [PATCH] sdhci: fix the fake timeout bug
To:     "Du, Alek" <alek.du@intel.com>
Cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org
References: <20181130150028.732896d8@xdu1-mobl>
 <81ba3745-8277-d16e-3aad-48324f51dc8a@intel.com>
 <20181130221300.4ef2956c@xdu1-mobl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c580be57-8a49-59f3-791e-c605d892266b@intel.com>
Date:   Fri, 30 Nov 2018 16:40:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181130221300.4ef2956c@xdu1-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/18 4:13 PM, Du, Alek wrote:
> On Fri, 30 Nov 2018 11:19:03 +0200
> Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Commands and resets are under spin lock, so no possibility for
>> preemption, and certainly a few microseconds isn't going to make any
>> difference to these timeouts, so I don't see how this patch could
>> help.
> 
> Thanks for your review.
> 
> I believe my case the scheduling out delay sometime can reach 10~20
> milliseconds... This may be due to the hypervisor...

So you are saying this only happens under virtualization?

> 
> Please look at the sdhci_enable_clk() below, there is a window in clock
> stabilization check. The first check is to check status register, the
> second check is to check if time passed. That's why I can capture a
> case that after time passed, the actually clock control register
> indicated that clock is stable. So the error handling is wrong...

Sure, but "Internal clock never stabilised." is not one of the  errors you
listed.

> 
> Also the sdhci_send_command commands is not in spin lock There is a
> windows between mod_timer and real command send...

What code path does not have a spin lock?

> 
> Thanks,
> Alek
> 
>>
>> I recently sent a patch for GLK laptops that had BIOS issues:
>>
>> 	https://marc.info/?l=linux-mmc&m=154270005901609
>>
>> And also some improvements to error handling:
>>
>> 	https://marc.info/?l=linux-mmc&m=154229013900437
>>
>> If those don't help, please share more details of the actual problem.
> 
> Sorry, I can't see how this patches could fix my problem.
> 
> 
> 
>>
>>>
>>> Signed-off-by: Alek Du <alek.du@intel.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 19 ++++++++++++++++---
>>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 99bdae53fa2e..f88c49fc574e 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -218,12 +218,17 @@ void sdhci_reset(struct sdhci_host *host, u8
>>> mask) /* hw clears the bit when it's done */
>>>  	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
>>>  		if (ktime_after(ktime_get(), timeout)) {
>>> +			/* check it again, since there is a window
>>> between
>>> +			   bit check and time check */
>>> +			if (!(sdhci_readb(host,
>>> SDHCI_SOFTWARE_RESET) & mask))
>>> +				break;
>>>  			pr_err("%s: Reset 0x%x never completed.\n",
>>>  				mmc_hostname(host->mmc),
>>> (int)mask); sdhci_dumpregs(host);
>>>  			return;
>>> +		} else {
>>> +			udelay(10);
>>>  		}
>>> -		udelay(10);
>>>  	}
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_reset);
>>> @@ -1395,9 +1400,10 @@ void sdhci_send_command(struct sdhci_host
>>> *host, struct mmc_command *cmd) timeout +=
>>> DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ; else
>>>  		timeout += 10 * HZ;
>>> -	sdhci_mod_timer(host, cmd->mrq, timeout);
>>>  
>>>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags),
>>> SDHCI_COMMAND);
>>> +	/* setup timer after command to avoid fake timeout */
>>> +	sdhci_mod_timer(host, cmd->mrq, timeout);
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_send_command);
>>>  
>>> @@ -1611,12 +1617,19 @@ void sdhci_enable_clk(struct sdhci_host
>>> *host, u16 clk) while (!((clk = sdhci_readw(host,
>>> SDHCI_CLOCK_CONTROL)) & SDHCI_CLOCK_INT_STABLE)) {
>>>  		if (ktime_after(ktime_get(), timeout)) {
>>> +			/* check it again since there is a window
>>> between
>>> +			   status check and time check */
>>> +			if ((clk = sdhci_readw(host,
>>> SDHCI_CLOCK_CONTROL))
>>> +					& SDHCI_CLOCK_INT_STABLE)
>>> +				break;
>>>  			pr_err("%s: Internal clock never
>>> stabilised.\n", mmc_hostname(host->mmc));
>>>  			sdhci_dumpregs(host);
>>>  			return;
>>>  		}
>>> -		udelay(10);
>>> +		else {
>>> +			udelay(10);
>>> +		}
>>>  	}
>>>  
>>>  	clk |= SDHCI_CLOCK_CARD_EN;
>>>   
>>
> 
> 

