Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F08C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 01:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCC821581
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 01:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCC821581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeHYE7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 00:59:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726113AbeHYE7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 00:59:14 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8A6A8DFA87CB7;
        Sat, 25 Aug 2018 09:22:08 +0800 (CST)
Received: from [127.0.0.1] (10.63.173.108) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Sat, 25 Aug 2018
 09:22:02 +0800
Subject: Re: [PATCH NET 3/3] net: hns: add configuration constraints for 1000M
 half
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>
References: <1535082143-122281-1-git-send-email-lipeng321@huawei.com>
 <1535082143-122281-4-git-send-email-lipeng321@huawei.com>
 <20180824034119.GA29111@lunn.ch>
 <194ac663-94d8-55e2-0231-a6be53e35f04@huawei.com>
 <20180824132857.GA1999@lunn.ch>
From:   "lipeng (Y)" <lipeng321@huawei.com>
Message-ID: <7c40c758-2ef2-665d-f429-0cc4e63a7a38@huawei.com>
Date:   Sat, 25 Aug 2018 09:21:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180824132857.GA1999@lunn.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.63.173.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/24 21:28, Andrew Lunn wrote:
> On Fri, Aug 24, 2018 at 02:39:36PM +0800, lipeng (Y) wrote:
>>
>> On 2018/8/24 11:41, Andrew Lunn wrote:
>>> On Fri, Aug 24, 2018 at 11:42:23AM +0800, Peng Li wrote:
>>>> Hisilicon hip05 and hip06 board network card do not support
>>>> 1000M half configuration. Driver can not config gmac as
>>>> 1000M half.
>>>>
>>>> Signed-off-by: Peng Li <lipeng321@huawei.com>
>>> Hi Peng
>>>
>>> Does the driver remove SUPPORTED_1000baseT_Half from
>>> phydev->supported?  If you do that, the PHY should never negotiate
>>> this speed.
>>>
>>>     Andrew
>> Hi, Andrew,
>>
>> The driver has removed SUPPORTED_1000baseT_Half from
>>
>> phydev->supported.
>>
>> the code is :
>> #define MAC_GMAC_SUPPORTED \
>> 	(SUPPORTED_10baseT_Half \
>> 	| SUPPORTED_10baseT_Full \
>> 	| SUPPORTED_100baseT_Half \
>> 	| SUPPORTED_100baseT_Full \
>> 	| SUPPORTED_Autoneg)
>>   h->if_support = MAC_GMAC_SUPPORTED;
>>   h->if_support |= SUPPORTED_1000baseT_Full;
>> phydev->supported &= h->if_support;
>>
>> As gmac do not support 1000M half, we add this patch to
>> make sure that no users can set 1000M half in any case.
> Well, not quite. What this patch does is protect the hardware when it
> is asked to change to an unsupported mode. This patch has nothing to
> do with user APIs.
>
> The user API for setting link modes is hns_nic_set_link_ksettings().
>
> What you do have is
>
>                  if (speed == SPEED_1000 && cmd->base.duplex == DUPLEX_HALF)
>                          return -EINVAL;
>
> which should stop somebody setting up a fixed speed link at 1000Half.
>
> But you don't do anything with cmd->link_modes.advertising. However,
> when you call phy_ethtool_ksettings_set(), it gets AND'ed with
> phydev->supported, which you have already removed 1000Half from.
>
> So is this a patch for a theoretical problem? Or have you seen it
> happen? If it did happen, how did the user configure it to cause this
> problem? That user API needs to prevent it.
>
> 	 Andrew
Hi,  Andrew,

HW  do not support 1000M half, and the driver has done the 2 things:
1, remove SUPPORTED_1000baseT_Half from phydev->supported.
2,   add the protect in  hns_nic_set_link_ksettings().

This patch is a  theoretical protect, and the problem does not really  
happen.

I think you really get the point, do you think we need this patch?

Thanks
> .
>


