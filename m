Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4357BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC1021547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC1021547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389808AbeIUS0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:26:48 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:64630 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeIUS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:26:47 -0400
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="20383203"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Sep 2018 05:38:05 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Fri, 21 Sep 2018
 05:38:04 -0700
Subject: Re: [PATCH] net: macb: Clean 64b dma addresses if they are not
 detected
To:     Michal Simek <michal.simek@xilinx.com>,
        "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        "Edgar E. Iglesias" <edgari@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <u-boot@lists.denx.de>, Joe Hershberger <joe.hershberger@ni.com>
References: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
 <20180919180806.3tps6yukhm3ry43i@toto>
 <7e641346-dd4c-4e2a-637f-1b666f13485c@xilinx.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <20eb98a9-edbd-c613-1f76-eccd7e06e052@microchip.com>
Date:   Fri, 21 Sep 2018 14:38:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7e641346-dd4c-4e2a-637f-1b666f13485c@xilinx.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal,

On 20/09/2018 at 08:23, Michal Simek wrote:
> On 19.9.2018 20:08, Edgar E. Iglesias wrote:
>> On Wed, Sep 19, 2018 at 06:08:18PM +0200, Michal Simek wrote:
>>> Clear ADDR64 dma bit in DMACFG register in case that HW_DMA_CAP_64B
>>> is not detected on 64bit system.
>>> The issue was observed when bootloader(u-boot) does not check macb
>>> feature at DCFG6 register (DAW64_OFFSET) and enabling 64bit dma support
>>> by default. Then macb driver is reading DMACFG register back and only
>>> adding 64bit dma configuration but not cleaning it out.
>>>
>>> This is also align with other features which are also cleared if they are not
>>> present.
>>
>> Hi Michal,
>>
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>
>>>   drivers/net/ethernet/cadence/macb_main.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>>> index 16e4ef7d7185..79707dff3f13 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> @@ -2163,6 +2163,8 @@ static void macb_configure_dma(struct macb *bp)
>>>   #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>>   		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>>>   			dmacfg |= GEM_BIT(ADDR64);
>>> +		else
>>> +			dmacfg &= ~GEM_BIT(ADDR64);
>>>   #endif
>>
>> I think you might want to do this clearing outside of the #ifdef.
>> If CONFIG_ARCH_DMA_ADDR_T_64BIT is not defined, we'd want to make
>> sure the ADDR64 is cleared. E.g something like:
>>
>>               dmacfg &= ~GEM_BIT(ADDR64);
>> #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>               if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>>                       dmacfg |= GEM_BIT(ADDR64);
>> #endif
>>
>>
>> Same thing for the USE_HWSTAMP/PTP flags below.
> 
> Origin patch, which introduce this read with mask,
> macfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
> was done in 2011 and from that time this function was extended a little
> bit. I am even not quite sure if make sense to read this reg and apply
> setting on the top of it.
> 
> Nicolas: Isn't it better simply compose that reg from scratch?

I have several arguments against composing this register from scratch:

1/ the reset value of this register is non-null for both of our 
platforms and it could be meaningful to keep some of these values.

2/ one bitfield could use different values between Zynq and AT91: RXBMS 
(1kB to 8kB for Zynq and 512 to 4KB for AT91), with same encoding.

3/ and well, this is the type of register with multiple bits that are 
marked as "reserved" and that experience tells that they might be 
connected to something...

So, I'm all for correcting the code like what Edgar suggests.

Best regards,
-- 
Nicolas Ferre
