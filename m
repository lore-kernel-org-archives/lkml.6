Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B133BC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0942087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0942087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLDBWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:22:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50896 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbeLDBWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:22:53 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E4CCB52A844CC;
        Tue,  4 Dec 2018 09:22:50 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Tue, 4 Dec 2018
 09:22:44 +0800
CC:     <wangbinghui@hisilicon.com>, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v1 11/12] usb: gadget: Add configfs attribuite for
 controling match_existing_only
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-12-chenyu56@huawei.com>
 <CAHp75VcUQN_PuXDVkeR+jagTsUaOWLtytVt+f_eR+x2iw9B5-A@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <166134c3-22c5-44ce-56af-073bcaa530ec@huawei.com>
Date:   Tue, 4 Dec 2018 09:22:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VcUQN_PuXDVkeR+jagTsUaOWLtytVt+f_eR+x2iw9B5-A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/3 17:25, Andy Shevchenko wrote:
> On Mon, Dec 3, 2018 at 5:47 AM Yu Chen <chenyu56@huawei.com> wrote:
>>
>> Currently the "match_existing_only" of usb_gadget_driver in configfs is
>> set to one which is not flexible.
>> Dwc3 udc will be removed when usb core switch to host mode. This causes
>> failure of writing name of dwc3 udc to configfs's UDC attribuite.
>> To fix this we need to add a way to change the config of
>> "match_existing_only".
>> This patch adds a configfs attribuite for controling match_existing_only
>> which allow user to config "match_existing_only".
> 
>> +static ssize_t gadget_driver_match_existing_only_store(struct config_item *item,
>> +               const char *page, size_t len)
>> +{
> 
>> +       struct usb_gadget_driver *gadget_driver =
>> +               &(to_gadget_info(item)->composite.gadget_driver);
> 
> It would be easier for reader to see two lines with two variables
> instead of this.

OK.
> 
>> +       bool match_existing_only;
>> +       int ret;
>> +
>> +       ret = kstrtobool(page, &match_existing_only);
>> +       if (ret)
>> +               return ret;
>> +
> 
>> +       if (match_existing_only)
>> +               gadget_driver->match_existing_only = 1;
>> +       else
>> +               gadget_driver->match_existing_only = 0;
> 
>           gadget_driver->match_existing_only = match_existing_only;
> But the question rather why is it not direct parameter to kstrtobool?
> 
I wrote the code in this way to avoid type conversion.

>> +
>> +       return len;
>> +}
> 
>> +       struct usb_gadget_driver *gadget_driver =
>> +               &(to_gadget_info(item)->composite.gadget_driver);
> 
> Make it neat.
> 
OK.

