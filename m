Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D1DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3224120857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfBHMan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:30:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:11339 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfBHMam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:30:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 04:30:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="scan'208";a="114668738"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2019 04:30:39 -0800
Subject: Re: [PATCH 2/2] drivers: xhci: Add quirk to reset xHCI port PHY
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
 <1549347534-11320-3-git-send-email-srinath.mannam@broadcom.com>
 <6392f206-9db2-5506-9e5d-cdf2b784d32e@linux.intel.com>
 <CABe79T4wLea8hBML4Xejv3YH3eAFfXqgnB8+udr-Xo_ZdTn0xA@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <d176e6bf-10b8-374c-1739-47bc98d12f09@linux.intel.com>
Date:   Fri, 8 Feb 2019 14:35:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABe79T4wLea8hBML4Xejv3YH3eAFfXqgnB8+udr-Xo_ZdTn0xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.2019 17:17, Srinath Mannam wrote:
> Hi Mathias,
> 
> Thanks for review, please see my comments below inline.
> 
> On Thu, Feb 7, 2019 at 8:32 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>>
>> On 05.02.2019 08:18, Srinath Mannam wrote:
>>> Add a quirk to reset xHCI port PHY on port disconnect event.
>>> Stingray USB HS PHY has an issue, that USB High Speed device detected
>>> at Full Speed after the same port has connected to Full speed device.
>>> This problem can be resolved with that port PHY reset on disconnect.
>>>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> ---
>>>    drivers/usb/core/hcd.c       |  6 ++++++
>>>    drivers/usb/core/phy.c       | 21 +++++++++++++++++++++
>>>    drivers/usb/core/phy.h       |  1 +
>>>    drivers/usb/host/xhci-plat.c |  3 +++
>>>    drivers/usb/host/xhci-ring.c |  9 ++++++---
>>>    drivers/usb/host/xhci.h      |  1 +
>>>    include/linux/usb/hcd.h      |  1 +
>>>    7 files changed, 39 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>>> index 015b126..e2b87a6 100644
>>> --- a/drivers/usb/core/hcd.c
>>> +++ b/drivers/usb/core/hcd.c
>>> @@ -2663,6 +2663,12 @@ int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1)
>>>        return hcd->driver->find_raw_port_number(hcd, port1);
>>>    }
>>>
>>> +int usb_hcd_phy_port_reset(struct usb_hcd *hcd, int port)
>>> +{
>>> +     return usb_phy_roothub_port_reset(hcd->phy_roothub, port);
>>> +}
>>> +EXPORT_SYMBOL_GPL(usb_hcd_phy_port_reset);
>>> +
>>>    static int usb_hcd_request_irqs(struct usb_hcd *hcd,
>>>                unsigned int irqnum, unsigned long irqflags)
>>>    {
>>> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
>>> index 38b2c77..c64767d 100644
>>> --- a/drivers/usb/core/phy.c
>>> +++ b/drivers/usb/core/phy.c
>>> @@ -162,6 +162,27 @@ void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub)
>>>    }
>>>    EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);
>>>
>>> +int usb_phy_roothub_port_reset(struct usb_phy_roothub *phy_roothub, int port)
>>> +{
>>> +     struct usb_phy_roothub *roothub_entry;
>>> +     struct list_head *head;
>>> +     int i = 0;
>>> +
>>> +     if (!phy_roothub)
>>> +             return -EINVAL;
>>> +
>>> +     head = &phy_roothub->list;
>>> +
>>> +     list_for_each_entry(roothub_entry, head, list) {
>>> +             if (i == port)
>>> +                     return phy_reset(roothub_entry->phy);
>>> +             i++;
>>> +     }
>>
>> I'm not that familiar with SoC's that have several PHYs per controller,
>> but this looks odd.
>>
>> For the above code to work wouldn't it require that each port has their own PHY,
>> and the PHYs are added to the list of usb_phy_roothub is in the same order as usb ports?
>>
>> Or is there something I don't understand here?
>>
> In our SOC (Stingray), xHCI controller has three ports and each port
> connected to separate PHY.
> Stingray xHCI controller supports both SS and HS ports and connected
> separate PHYs.
> We passed PHY phandlers in xHCI DT node in the order of port numbers.
> as shown below xHCI DT node.
> So that all PHYs added to usb_phy_roothub are in order of port numbers.
>   xhci1: usb@11000 {
>                          compatible = "generic-xhci";
>                          reg = <0x00011000 0x1000>;
>                          interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
>                          phys = <&usb1_phy1>, <&usbphy2>, <&usb1_phy0>;
>                          phy-names = "phy0", "phy1", "phy2";
>                          dma-coherent;
>                          status = "disabled";
> };
> But we have issue with HS PHYs, so that those PHYs are required to reset.

This is very specific to your SOC.
A quick grep shows most xhci controllers have one or two PHYs in total.

The suggested usb_phy_roothub_port_reset() above will only work for your SOC.
I think it would be better to have a stingray specific quirk/workaround where you
can find the right PHY to reset based on somthing like port number and PHY name.

For a generic solution we would need a better way to map usb ports to the PHY it uses.

-Mathias
