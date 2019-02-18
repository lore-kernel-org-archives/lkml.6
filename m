Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F400CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4E921479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfBRMcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:32:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3771 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728611AbfBRMcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:32:09 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6511738C481F8E94ECC0;
        Mon, 18 Feb 2019 20:32:03 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 20:31:55 +0800
CC:     <liuyu712@hisilicon.com>, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, Yao Chen <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        songxiaowei <songxiaowei@hisilicon.com>,
        xu yiping <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v2 04/10] usb: dwc3: Add two quirks for Hisilicon Kirin
 Soc Platform
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190218112310.17860-1-chenyu56@huawei.com>
 <20190218112310.17860-5-chenyu56@huawei.com>
 <CAHp75VdrSyORjd0OXS11poCL-3PofgsiejzgZ=m56sZegfGyMw@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <d5f8db99-15bf-51a7-553f-c97cf2b70cfd@huawei.com>
Date:   Mon, 18 Feb 2019 20:31:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VdrSyORjd0OXS11poCL-3PofgsiejzgZ=m56sZegfGyMw@mail.gmail.com>
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

On 2019/2/18 20:21, Andy Shevchenko wrote:
> On Mon, Feb 18, 2019 at 1:23 PM Yu Chen <chenyu56@huawei.com> wrote:
>>
>> There are tow quirks for DesignWare USB3 DRD Core of Hisilicon Kirin Soc.
>> 1)SPLIT_BOUNDARY_DISABLE should be set for Host mode
>> 2)A GCTL soft reset should be executed when switch mode
> 
> Thus, it must be two patches, no?
> 
>> +static void dwc3_gctl_core_soft_reset(struct dwc3 *dwc)
>> +{
>> +       u32 reg;
>> +
>> +       reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> 
>> +       reg |= (DWC3_GCTL_CORESOFTRESET);
> 
> Redundant parens.
> 
>> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>> +
>> +       reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> 
>> +       reg &= ~(DWC3_GCTL_CORESOFTRESET);
> 
> Ditto.
> 
>> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>> +}
> 
>> +static void dwc3_complete(struct device *dev)
>> +{
> 
>> +       struct dwc3     *dwc = dev_get_drvdata(dev);
>> +       u32             reg;
> 
> Indentation style is different to the other functions in the same patch.
> Use simple space here.
> 
>> +       if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
>> +                       dwc->dis_split_quirk) {
>> +               dev_dbg(dwc->dev, "set DWC3_GUCTL3_SPLITDISABLE\n");
>> +               reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
>> +               reg |= DWC3_GUCTL3_SPLITDISABLE;
>> +               dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
>> +       }
>> +}
> 
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -269,7 +269,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
>>  {
>>         const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
>>         struct dwc3             *dwc = dep->dwc;
> 
>> -       u32                     timeout = 1000;
>> +       u32                     timeout = 5000;
> 
> I don't see anything about this change in commit message. Moreoever,
> it looks like it must be a separate logical change with its own
> description.
> 
>>         u32                     saved_config = 0;
>>         u32                     reg;
> 
> 

I will separate these changes into different patches. Thanks!

