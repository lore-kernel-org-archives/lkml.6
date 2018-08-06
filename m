Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1099CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1E221A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1E221A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbeHFM4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:56:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:29657 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbeHFM4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:56:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 03:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="73988427"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga002.fm.intel.com with ESMTP; 06 Aug 2018 03:47:39 -0700
Subject: Re: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <b819a5fc-82aa-dc9c-4272-fecdacbd5880@intel.com>
 <MWHPR02MB281619CD8CFDA93B9ADB3D89A7510@MWHPR02MB2816.namprd02.prod.outlook.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <51566ca4-1002-5c62-71d0-9da610bff368@linux.intel.com>
Date:   Mon, 6 Aug 2018 13:50:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <MWHPR02MB281619CD8CFDA93B9ADB3D89A7510@MWHPR02MB2816.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Back from vacation

On 20.07.2018 18:39, Anurag Kumar Vulisha wrote:
> 
> Hi Mathias,
> 
> Thanks for providing your comments, please find my comments inline
> 
>>>
>>> -	if (device_property_read_bool(sysdev, "usb2-lpm-disable"))
>>> -		xhci->quirks |= XHCI_HW_LPM_DISABLE;
>>> +	/* Iterate over all parent nodes for finding quirks */
>>> +	for (tmpdev = &pdev->dev; tmpdev; tmpdev = tmpdev->parent) {
>>
>> Isn't sysdev at this point the topmost device that can have any of those device
>> properties set?
>> We could loop from &pdev->dev up to and including sysdev.
>>
>> It doesn't matter much but maybe avoid walking some extra parents.
>>> 
> I have seen some drivers ( like dwc3 host.c) which create a child dev, which is
> the pdev that is being passed to xhci_plat_probe(). So, sysdev may not be the
> topmost parent. There could be some properties which may be present in parent
> and may not be populated in the child. So, I made this change to search on all
> available parents for finding a valid property

Ok, lets keep it like you wrote it

> 
>>>
>>> -	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
>>> -		xhci->quirks |= XHCI_LPM_SUPPORT;
>>> +		if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
>>> +			xhci->quirks |= XHCI_HW_LPM_DISABLE;
>>>
>>> -	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
>>> -		xhci->quirks |= XHCI_BROKEN_PORT_PED;
>>> +		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
>>> +			xhci->quirks |= XHCI_LPM_SUPPORT;
>>>
>>> -	/* imod_interval is the interrupt moderation value in nanoseconds. */
>>> -	xhci->imod_interval = 40000;
>>
>> Setting the default imod_interval could be moved before the for() loop
>>
> 
> I thought it would be better if everything related to imod_interval is in one place,
> so kept it as is. I can fix this in v2 if you suggest.

Default imod_interval needs to be set before the for loop to avoid overwriting a value
got from device property

So a v2 is needed

-Mathias
