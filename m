Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430DBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53D22151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53D22151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbeKVD4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:56:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:49713 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbeKVD4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:56:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 09:21:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="110062857"
Received: from vrgaurav-mobl1.amr.corp.intel.com (HELO [10.252.133.91]) ([10.252.133.91])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2018 09:20:59 -0800
Subject: Re: [RFC PATCH 2/6] ASoC: Intel: Skylake: stop init/probe if DSP is
 not present
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, liam.r.girdwood@linux.intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-3-pierre-louis.bossart@linux.intel.com>
 <20181121142925.GP10650@smile.fi.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1d06c878-c69b-a627-b7e6-e9d92be3b08a@linux.intel.com>
Date:   Wed, 21 Nov 2018 10:48:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121142925.GP10650@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/21/18 8:29 AM, Andy Shevchenko wrote:
> On Tue, Nov 20, 2018 at 03:36:40PM -0600, Pierre-Louis Bossart wrote:
>> Check immediately if the DSP can be found, bail and avoid doing inits
>> to enable legacy fallback without delay.
> It does slightly more than described. Please do either remove unrelated changes, or fill the gap in the commit message. In the latter case it may require to split patch to two.
ok, maybe I should change the commit message since there are really two 
test conditions: DSP can be found and DSP streams found. The code really 
does just that, nothing else.
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/intel/skylake/skl.c | 26 +++++++++++++++++---------
>>   1 file changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
>> index df36b8fe6d5e..1d7146773d19 100644
>> --- a/sound/soc/intel/skylake/skl.c
>> +++ b/sound/soc/intel/skylake/skl.c
>> @@ -931,6 +931,12 @@ static int skl_first_init(struct hdac_bus *bus)
>>   
>>   	snd_hdac_bus_parse_capabilities(bus);
>>   
>> +	/* check if dsp is there */
>> +	if (!bus->ppcap) {
>> +		dev_err(bus->dev, "bus ppcap not set, DSP not present?\n");
>> +		return -ENODEV;
>> +	}
>> +
>>   	if (skl_acquire_irq(bus, 0) < 0)
>>   		return -EBUSY;
>>   
>> @@ -940,23 +946,25 @@ static int skl_first_init(struct hdac_bus *bus)
>>   	gcap = snd_hdac_chip_readw(bus, GCAP);
>>   	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
>>   
>> -	/* allow 64bit DMA address if supported by H/W */
>> -	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64))) {
>> -		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
>> -	} else {
>> -		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
>> -		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
>> -	}
>> -
>>   	/* read number of streams from GCAP register */
>>   	cp_streams = (gcap >> 8) & 0x0f;
>>   	pb_streams = (gcap >> 12) & 0x0f;
>>   
>> -	if (!pb_streams && !cp_streams)
>> +	if (!pb_streams && !cp_streams) {
>> +		dev_err(bus->dev, "no streams found in GCAP definitions?\n");
>>   		return -EIO;
>> +	}
>>   
>>   	bus->num_streams = cp_streams + pb_streams;
>>   
>> +	/* allow 64bit DMA address if supported by H/W */
>> +	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64))) {
>> +		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
>> +	} else {
>> +		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
>> +		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
>> +	}
>> +
>>   	/* initialize streams */
>>   	snd_hdac_ext_stream_init_all
>>   		(bus, 0, cp_streams, SNDRV_PCM_STREAM_CAPTURE);
>> -- 
>> 2.17.1
>>
