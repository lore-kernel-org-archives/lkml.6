Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B15C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3240121857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3240121857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeHQJco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 05:32:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58610 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeHQJcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 05:32:43 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7H6UEur079195;
        Fri, 17 Aug 2018 01:30:14 -0500
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7H6UEaD031508;
        Fri, 17 Aug 2018 01:30:14 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 17
 Aug 2018 01:30:14 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 17 Aug 2018 01:30:14 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7H6UCWv022890;
        Fri, 17 Aug 2018 01:30:12 -0500
Subject: Re: [RFC] dmaengine: Add metadata_ops for dma_async_tx_descriptor
To:     Radhey Shyam Pandey <radheys@xilinx.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
References: <20180815105704.26498-1-peter.ujfalusi@ti.com>
 <CY4PR0201MB36192D111C6EE8AC4E86C173C73E0@CY4PR0201MB3619.namprd02.prod.outlook.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <38aa48ba-5cf9-da12-bef8-b75e22f8b822@ti.com>
Date:   Fri, 17 Aug 2018 09:30:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CY4PR0201MB36192D111C6EE8AC4E86C173C73E0@CY4PR0201MB3619.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radhey,

On 2018-08-16 16:29, Radhey Shyam Pandey wrote:
>> +/**
>> + * enum dma_desc_metadata_mode - per descriptor metadata mode types
>> supported
>> + * @DESC_METADATA_CLIENT - the metadata buffer is allocated/provided by
>> the
>> + *  client driver and it is attached (via the dmaengine_desc_attach_metadata()
>> + *  helper) to the descriptor.
>> + * @DESC_METADATA_EMBEDDED - the metadata buffer is
>> allocated/managed by the DMA
> Just a thought - We can rename it to DESC_METADATA_ENGINE? 
> i.e metadata allocation place - >  dma client/engine.

Sounds good.

> 
>> + *  driver. The client driver can ask for the pointer, maximum size and the
>> + *  currently used size of the metadata and can directly updata or read it.
> /s/updata/update
> 
>> + *  dmaengine_desc_get_metadata_ptr() and
>> dmaengine_desc_set_metadata_len() is
>> + *  provided as helper functions.
> It will be helpful if we add description for both DESC_METADATA_EMBEDDED 
> modes i.e DMA_DEV_TO_MEM and MEM_TO_DEV types. I think in DEV_TO_MEM
> we don't need to set_metadata_len(). Length will provided by DMA engine.

I agree, it is better to extend the explanation on the two modes.

...

>> +static inline int _desc_check_and_set_metadata_mode(
>> +	struct dma_async_tx_descriptor *desc, enum
>> dma_desc_metadata_mode mode)
>> +{
>> +	/* Make sure that the metadata mode is not mixed */
>> +	if (!desc->desc_metadata_mode) {
> Minor nit - we can refactor this code to have failure path early.

I don't think it would help readability, to move the failure case first:

if (desc->desc_metadata_mode &&
    (desc->desc_metadata_mode != mode)) {
	return -EINVAL;
} else if (!desc->desc_metadata_mode) {
	if (dmaengine_is_metadata_mode_supported(desc->chan, mode))
			desc->desc_metadata_mode = mode;
		else
			return -ENOTSUPP;
}

return 0;

> 
>> +		if (dmaengine_is_metadata_mode_supported(desc->chan,
>> mode))
>> +			desc->desc_metadata_mode = mode;
>> +		else
>> +			return -ENOTSUPP;
>> +	} else if (desc->desc_metadata_mode != mode) {
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
