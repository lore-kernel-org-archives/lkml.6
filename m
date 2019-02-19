Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA277C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B164821773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbfBSBlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:41:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732885AbfBSBlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:41:06 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 392784F5C1F6EE46A44C;
        Tue, 19 Feb 2019 09:41:04 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 09:40:58 +0800
CC:     <liuyu712@hisilicon.com>, <john.stultz@linaro.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 07/10] usb: dwc3: Registering a role switch in the DRD
 code.
To:     Valentin Schneider <valentin.schneider@arm.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190218112310.17860-1-chenyu56@huawei.com>
 <20190218112310.17860-8-chenyu56@huawei.com>
 <8162929c-0d1b-1081-4be0-d40ed6f752d6@arm.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <f0c4060c-87e0-dcc7-16a9-85be32a05724@huawei.com>
Date:   Tue, 19 Feb 2019 09:40:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <8162929c-0d1b-1081-4be0-d40ed6f752d6@arm.com>
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

On 2019/2/19 1:30, Valentin Schneider wrote:
> Hi,
> 
> On 18/02/2019 11:23, Yu Chen wrote:
> [...]
>> @@ -522,6 +556,15 @@ int dwc3_drd_init(struct dwc3 *dwc)
>>  		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>>  	}
>>  
>> +	dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
>> +	dwc3_role_switch.set = dwc3_usb_role_switch_set;
>> +	dwc3_role_switch.get = dwc3_usb_role_switch_get;
>> +	dwc->role_sw = usb_role_switch_register(dwc->dev, &dwc3_role_switch);
> 
> Building arm64 defconfig gives me this:
> 
> drivers/usb/dwc3/drd.o: In function `dwc3_drd_exit':
> /home/valsch01/Work/kernel/drivers/usb/dwc3/drd.c:604: undefined reference to `usb_role_switch_unregister'
> /home/valsch01/Work/kernel/drivers/usb/dwc3/drd.c:604:(.text+0x814): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_role_switch_unregister'
> /home/valsch01/Work/kernel/drivers/usb/dwc3/drd.c:604: undefined reference to `usb_role_switch_unregister'
> /home/valsch01/Work/kernel/drivers/usb/dwc3/drd.c:604:(.text+0x844): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_role_switch_unregister'
> drivers/usb/dwc3/drd.o: In function `dwc3_drd_init':
> /home/valsch01/Work/kernel/drivers/usb/dwc3/drd.c:562: undefined reference to `usb_role_switch_register'
> /home/valsch01/Work/kernel/drivers/usb/dwc3/drd.c:562:(.text+0xa20): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_role_switch_register'
> /home/valsch01/Work/kernel/drivers/usb/dwc3/drd.c:562: undefined reference to `usb_role_switch_register'
> /home/valsch01/Work/kernel/drivers/usb/dwc3/drd.c:562:(.text+0xb4c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_role_switch_register'
> Makefile:1024: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
> 
> This has CONFIG_USB_ROLE_SWITCH=m, setting it as a built-in makes the thing
> linkable.
> 
> I suppose that's because defconfig gives us
> 
>   CONFIG_USB_DWC3_DUAL_ROLE=y
> 
> but then that should probably force a CONFIG_USB_ROLE_SWITCH=y. My
> immediate reaction to this would be to add:
> 
> ---
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 2b1494460d0c..661b1d2efc8b 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -44,6 +44,7 @@ config USB_DWC3_DUAL_ROLE
>  	bool "Dual Role mode"
>  	depends on ((USB=y || USB=USB_DWC3) && (USB_GADGET=y || USB_GADGET=USB_DWC3))
>  	depends on (EXTCON=y || EXTCON=USB_DWC3)
> +	select USB_ROLE_SWITCH
>  	help
>  	  This is the default mode of working of DWC3 controller where
>  	  both host and gadget features are enabled.
> ---
>   
> Not sure how acceptable that is though.
> 
Thanks for your notice! I will add this in next version.

> 
>> +	if (ret) {
>> +		dwc3_drd_exit(dwc);
>> +		return PTR_ERR(dwc->role_sw);
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> @@ -557,4 +600,6 @@ void dwc3_drd_exit(struct dwc3 *dwc)
>>  
>>  	if (!dwc->edev)
>>  		free_irq(dwc->otg_irq, dwc);
>> +
>> +	usb_role_switch_unregister(dwc->role_sw);
>>  }
>>
> 
> .
> 

Thanks
Yu Chen

