Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDC3C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC9C20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfAUIg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:36:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40416 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728056AbfAUIg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:36:26 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AA9B81B2C74ACCAB6420;
        Mon, 21 Jan 2019 16:36:23 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Mon, 21 Jan 2019
 16:36:15 +0800
CC:     <liuyu712@hisilicon.com>, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "John Stultz" <john.stultz@linaro.org>
Subject: Re: [PATCH v1 07/12] usb: roles: Find the usb role switch by also
 matching against the device node
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-8-chenyu56@huawei.com>
 <CAHp75VfUKAQ+Q0cQz-4-=i2JL9uACBX1bVvCeNjZLL1HStDGKQ@mail.gmail.com>
 <20181203122534.GD24338@kuha.fi.intel.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <e9a8f745-6211-d6d2-24f0-ac86f82924f0@huawei.com>
Date:   Mon, 21 Jan 2019 16:36:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181203122534.GD24338@kuha.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On 2018/12/3 20:25, Heikki Krogerus wrote:
> Hi,
> 
> On Mon, Dec 03, 2018 at 10:17:20AM +0200, Andy Shevchenko wrote:
>> On Mon, Dec 3, 2018 at 5:45 AM Yu Chen <chenyu56@huawei.com> wrote:
>>>
>>> This patch adds code for supporting find usb role switch by matching against
>>> the device node described using of_graph.
>>
>>>  #include <linux/module.h>
>>>  #include <linux/mutex.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_graph.h>
>>
>> Keep it ordered.
>>
>>> +static int __switch_match_by_of_node(struct device *dev, const void *name)
>>> +{
>>> +       if (!dev->parent || !dev->parent->of_node)
>>> +               return 0;
>>> +
>>> +       return of_node_name_eq(dev->parent->of_node, (const char *)name);
>>> +}
>>
>> I think Heikki has introduced some more generic function for this.
> 
> Yes, for this I'm proposing a new function fwnode_get_name() that
> should allow us to support ACPI as well as OF platforms:
> https://lkml.org/lkml/2018/11/28/784
> 
>>>         sw = device_connection_find_match(dev, "usb-role-switch", NULL,
>>>                                           usb_role_switch_match);
>>
>>> +       sw = of_graph_find_match_by_type(dev, "usb-role-switch");
>>
>> Why this is here?! device_connection_find_match() should take care for OF case.
> 
> Exactly. device_connection_find_match() needs to parse the graph (OF
> and ACPI), and I already made proposal (RFC) for that:
> https://lkml.org/lkml/2018/10/24/619
> 
> I have prepared a more finalized version of those patches. I've been
> waiting for that fwnode_get_name() to be accepted before sending it
> out since we are going to need that function, but I'll send a new RFC
> if nothing happens soon with that fwnode_get_name() series.
> 
> 
> Br,
> 

Have the fwnode_get_name() patches been accepted?
And I will be grateful if you can tell me your plan about the
https://lkml.org/lkml/2018/10/24/619 patches.

thanks
- Yu Chen

