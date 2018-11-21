Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2A5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA98C214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA98C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbeKVD4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:56:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:49713 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbeKVD4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:56:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 09:21:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="110062858"
Received: from vrgaurav-mobl1.amr.corp.intel.com (HELO [10.252.133.91]) ([10.252.133.91])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2018 09:21:00 -0800
Subject: Re: [RFC PATCH 1/6] ASoC: Intel: Skylake: Add CFL-S support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, liam.r.girdwood@linux.intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
 <20181121142721.GO10650@smile.fi.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <414b4c3a-7e04-2775-7d87-16a236b5b4e8@linux.intel.com>
Date:   Wed, 21 Nov 2018 11:16:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121142721.GO10650@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/21/18 8:27 AM, Andy Shevchenko wrote:
> On Tue, Nov 20, 2018 at 03:36:39PM -0600, Pierre-Louis Bossart wrote:
>> From: Takashi Iwai <tiwai@suse.de>
>>
>> It's with CNP, supposed to be equivalent with CNL entry.
>>
> May you consider to switch to PCI_DEVICE_DATA() first?

Is this really the recommended path?

The macro generates PCI_DEVICE_ID_##vend##_##dev, and I don't have a 
turn key #define PCI_DEVICE_ID_INTEL_AUDIO_CFL 0xa348 I can use. In a 
number of cases we have multiple variants of the same hardware, and it 
starts being painful to use a 20-letter macro to differentiate between 
INTEL_AUDIO_CFL_Y and INTEL_AUDIO_CFL_H. The explicit code and a short 
comment are more readable really.

git grep PCI_DEVICE_ID_INTEL gives me hundreds of definitions, some 
global, some local to specific drivers, doesn't seem like there is a 
well-agreed usage of this macro, is there? I don't mind making the 
change but I don't sense an strong argument for it?

>
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/intel/skylake/skl-messages.c | 8 ++++++++
>>   sound/soc/intel/skylake/skl.c          | 3 +++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
>> index 8bfb8b0fa3d5..b0e6fb93eaf8 100644
>> --- a/sound/soc/intel/skylake/skl-messages.c
>> +++ b/sound/soc/intel/skylake/skl-messages.c
>> @@ -247,6 +247,14 @@ static const struct skl_dsp_ops dsp_ops[] = {
>>   		.init_fw = cnl_sst_init_fw,
>>   		.cleanup = cnl_sst_dsp_cleanup
>>   	},
>> +	{
>> +		.id = 0xa348,
>> +		.num_cores = 4,
>> +		.loader_ops = bxt_get_loader_ops,
>> +		.init = cnl_sst_dsp_init,
>> +		.init_fw = cnl_sst_init_fw,
>> +		.cleanup = cnl_sst_dsp_cleanup
>> +	},
>>   };
>>   
>>   const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
>> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
>> index 3f0ac1312982..df36b8fe6d5e 100644
>> --- a/sound/soc/intel/skylake/skl.c
>> +++ b/sound/soc/intel/skylake/skl.c
>> @@ -1121,6 +1121,9 @@ static const struct pci_device_id skl_ids[] = {
>>   	/* CNL */
>>   	{ PCI_DEVICE(0x8086, 0x9dc8),
>>   		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
>> +	/* CFL */
>> +	{ PCI_DEVICE(0x8086, 0xa348),
>> +		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
>>   	{ 0, }
>>   };
>>   MODULE_DEVICE_TABLE(pci, skl_ids);
>> -- 
>> 2.17.1
>>
