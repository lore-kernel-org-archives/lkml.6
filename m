Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B41C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9EE20684
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9EE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeKSSJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:09:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:58654 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbeKSSJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:09:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2018 23:46:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,251,1539673200"; 
   d="scan'208";a="107430677"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by fmsmga004.fm.intel.com with ESMTP; 18 Nov 2018 23:46:55 -0800
Subject: Re: [PATCH v2 3/3] mmc: sdhci-pci: only install voltage switch method
 when useful
To:     Anisse Astier <anisse@astier.eu>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181022134026.GB18413@jaya>
 <20181023100729.28864-4-anisse@astier.eu> <20181116165850.GB5894@jaya>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <94fa0484-c532-683f-3a3f-fd9f4b263d16@intel.com>
Date:   Mon, 19 Nov 2018 09:45:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116165850.GB5894@jaya>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/18 6:58 PM, Anisse Astier wrote:
> Hi Adrian,
> 
> On Tue, Oct 23, 2018 at 12:07:29PM +0200, Anisse Astier wrote:
>> If there's no ACPI DSM for voltage switch, it will just cause a lot of
>> debug info down the line, we only need one at startup.
>>
>> Signed-off-by: Anisse Astier <anisse@astier.eu>
>> ---
>>  drivers/mmc/host/sdhci-pci-core.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index f2c1fb339d66..95fdbb883c7e 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -723,6 +723,7 @@ static const struct dmi_system_id board_no_1_8v[] = {
>>  static void byt_probe_slot(struct sdhci_pci_slot *slot)
>>  {
>>  	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
>> +	struct intel_host *intel_host = sdhci_pci_priv(slot);
>>  
>>  	byt_read_dsm(slot);
>>  
>> @@ -733,6 +734,16 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
>>  				mmc_hostname(slot->host->mmc));
>>  		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>  	}
>> +	/* Check if we have the appropriate voltage switch DSM methods */
>> +	if (!(intel_host->dsm_fns & (1 << INTEL_DSM_V18_SWITCH)) &&
>> +	    !(intel_host->dsm_fns & (1 << INTEL_DSM_V33_SWITCH))) {
>> +		/* No voltage switching supported at all, there's no
>> +		 * point in installing the callback: return.
>> +		 */
>> +		pr_debug("%s: No voltage switching ACPI DSM helper\n",
>> +				mmc_hostname(slot->host->mmc));
>> +		return;
>> +	}
>>  	ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
>>  }
>>  
>> -- 
>> 2.17.2
>>
> 
> What do you think of picking this last patch ? Or maybe you had
> different cleanups in mind when you said you wanted to rework this ?

Voltage switches are relatively rare, and dynamic debug allows control over
exactly which debug messages display, so I am not sure this patch is needed.
