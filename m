Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE76C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790812183E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfBSDhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:37:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfBSDhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:37:47 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 692623ED6A6C00D1E62B;
        Tue, 19 Feb 2019 11:37:45 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 11:37:35 +0800
CC:     <liuyu712@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        <songxiaowei@hisilicon.com>, <xuyiping@hisilicon.com>,
        <xuyoujun4@huawei.com>, <yudongbin@hisilicon.com>,
        <zangleigang@hisilicon.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Li Jun <jun.li@nxp.com>
Subject: Re: [PATCH v2 07/10] usb: dwc3: Registering a role switch in the DRD
 code.
To:     Jun Li <lijun.kernel@gmail.com>
References: <20190218112310.17860-1-chenyu56@huawei.com>
 <20190218112310.17860-8-chenyu56@huawei.com>
 <CAKgpwJXgiJYkpTxddwLFJRSvadcCw7fMbd=d510NFkyRSKaswA@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <39e822a2-54fb-f4ac-4471-ed8312acf53e@huawei.com>
Date:   Tue, 19 Feb 2019 11:37:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAKgpwJXgiJYkpTxddwLFJRSvadcCw7fMbd=d510NFkyRSKaswA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/2/19 10:57, Jun Li wrote:
>>
>> +static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
>> +{
>> +       u32 mode;
>> +
>> +       switch (role) {
>> +       case USB_ROLE_HOST:
>> +               mode = DWC3_GCTL_PRTCAP_HOST;
>> +               break;
>> +       case USB_ROLE_DEVICE:
>> +               mode = DWC3_GCTL_PRTCAP_DEVICE;
>> +               break;
>> +       default:
>> +               mode = DWC3_GCTL_PRTCAP_HOST;
> 
> I'd propose let dwc3 stay at device mode at default case.
> 
Setting mode to DWC3_GCTL_PRTCAP_HOST at default case due to the
requirement of Hikey960 board. When there is no cable connected to
type-C port, dwc3 should be set to HOST mode and the hub on the
Hikey960 will be power on.
Here is the details of the Hikey960:
	https://www.96boards.org/documentation/consumer/hikey/hikey960/hardware-docs/hardware-user-manual.md.html

But I will check the code to see if it is possible to make dwc3
set to device mode at default case.

>> +               break;
>> +       };
>> +
>> +       dwc3_set_mode(dev_get_drvdata(dev), mode);
>> +       return 0;
>> +}
>> +
>> +static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
>> +{
>> +       struct dwc3 *dwc = dev_get_drvdata(dev);
>> +       unsigned long flags;
>> +       enum usb_role role;
>> +
>> +       spin_lock_irqsave(&dwc->lock, flags);
>> +       role = dwc->current_otg_role;
>> +       spin_unlock_irqrestore(&dwc->lock, flags);
>> +
>> +       return role;
>> +}
>> +
>>  int dwc3_drd_init(struct dwc3 *dwc)
>>  {
>> +       struct usb_role_switch_desc dwc3_role_switch = {0};
>>         int ret, irq;
>>
>>         dwc->edev = dwc3_get_extcon(dwc);
>> @@ -522,6 +556,15 @@ int dwc3_drd_init(struct dwc3 *dwc)
>>                 dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>>         }
>>
>> +       dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
>> +       dwc3_role_switch.set = dwc3_usb_role_switch_set;
>> +       dwc3_role_switch.get = dwc3_usb_role_switch_get;
>> +       dwc->role_sw = usb_role_switch_register(dwc->dev, &dwc3_role_switch);
>> +       if (ret) {
>> +               dwc3_drd_exit(dwc);
>> +               return PTR_ERR(dwc->role_sw);
>> +       }
>> +
> 
> My understanding is, if you use usb role switch, you don't need either edev or
> OTG block event, so this should be like:
> 
> if (device_property_read_bool(dwc->dev, "usb-role-switch")) {
>            usb role switch register;
> } else if (edev) {
> ...
> } else {
> ...
> }
Yes. Thanks!

> 
> Jun
>>         return 0;
>>  }
>>
>> @@ -557,4 +600,6 @@ void dwc3_drd_exit(struct dwc3 *dwc)
>>
>>         if (!dwc->edev)
>>                 free_irq(dwc->otg_irq, dwc);
>> +
>> +       usb_role_switch_unregister(dwc->role_sw);
>>  }
>> --
>> 2.15.0-rc2
>>
> 
> .
> 

Thanks
Yu Chen

