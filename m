Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeC0O3O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:29:14 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:22530 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeC0O3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:29:12 -0400
Subject: Re: [net-next PATCH 2/5] soc: ti: K2G: provide APIs to support driver
 probe deferral
To: Andrew Lunn <andrew@lunn.ch>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
References: <1522095312-23249-1-git-send-email-m-karicheri2@ti.com>
 <1522095312-23249-3-git-send-email-m-karicheri2@ti.com>
 <20180326204802.GC5862@lunn.ch> <4aeeda56-c68b-cb64-1314-a669f721ff20@ti.com>
 <20180327140310.GK5862@lunn.ch>
From: Murali Karicheri <m-karicheri2@ti.com>
Organization: Texas Instruments
Message-ID: <cbc1b848-2b11-6953-3a2c-1650af0d99f7@ti.com>
Date: Tue, 27 Mar 2018 10:31:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180327140310.GK5862@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On 03/27/2018 10:03 AM, Andrew Lunn wrote:
>> Could you please elaborate? These knav dma and qmss drivers are
>> introduced to support packet DMA hardware available in Keystone
>> NetCP which couldn't be implemented using the DMA APIs available
>> at the time this driver was introduced. Another reason was that
>> the performance was really bad. We had an internal implementation
>> based on DMA API before which couldn't be upstreamed at that time
>> due to the reason that we were mis-using the API for this driver.
>> So we introduced these knav_dma driver to support NetCP. We don't
>> have any plan to re-write the driver at this time.
>>
>> If your question is about EPROBE_DEFER being returned from an
>> existing knav_dma API and using the return code to achieve probe
>> defer instead of introducing these APIs, I can take a look into
>> that and respond. So please clarify.
>  
> Hi Murali
> 
> So if i understood you right, at the time these drivers were written,
> the linux DMA API did not do what you wanted. You could hack something
> together by using the API wrongly, but that could not be mainlined. So
> rather than fixing the DMA API to make it work for this hardware, you
> ignored it, and made up your own API? This API now has its own
> problems, it does not correctly handle ordering? So you are hacking
> your own API further.
> 
> Does the Linux DMA API correctly handle probing order issues? Has the
> Linux DMA API evolved so that it now does do what is needed by your
> hardware?
> 

Thanks once again for your review and response!

I don't think dma API was meant to support hardware like pkt dma and was the
reason quoted when this driver was introduced and the same is valid even
today. AFAIK, Without hacking the API, we will not be able to support our
driver even today. Besides Keystone itself is an old platform that is
matured and have been there for long. K2G SoC was also introduced almost
3 years ago and we were late to port it to upstream due to various reasons.
We now have the SoC and most of the drivers upstreamed and this is a
missing driver to support networking. Given that we don't have any other
new devices planned from this SoC familty in the future, and the platform
itself is old and matured, I don't think the extra effort needed to
explore DMA API usage and re-write the driver is justified. 

knav dma API is a TI SoC specific driver API and IMO, it should be fine\
to extend it to support probe deferral. I have also looked at the driver
and I don't see any other way to handle this since the channels are
allocated and used in ndo_open() and EPROBE_DEFER is not useful here.

Btw, I will re-write patch 3/5 as you have suggested as there is scope
for adding one more patch besides what I have mentioned in my response.
I will be sending v2 of the series soon with your comment on 3/5 addressed.

Regards,

Murali
> If this was an old hardware which is slowly going away, it would not
> be an issue. But it seems like there are new variants of the hardware
> being released. So maybe you should go back and re-write the DMA
> driver, rather than paper over the cracks?
> 
> 	Andrew
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
