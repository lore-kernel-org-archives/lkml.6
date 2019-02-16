Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83E0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F6B222D9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391888AbfBPClI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 21:41:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730404AbfBPClI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 21:41:08 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 816DDCD167D31A29F029;
        Sat, 16 Feb 2019 10:41:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Feb 2019
 10:40:58 +0800
Subject: Re: [PATCH net-next] mdio_bus: Fix PTR_ERR() usage after
 initialization to constant
To:     Al Viro <viro@zeniv.linux.org.uk>
References: <20190128132409.17736-1-yuehaibing@huawei.com>
 <20190128143634.GF4765@lunn.ch>
 <eeb532d5-45a7-648f-f835-82448465762a@huawei.com>
 <20190201042411.GM2217@ZenIV.linux.org.uk>
CC:     Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>,
        <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <b70da77c-37d4-1e52-20e6-5cf038e34bcf@huawei.com>
Date:   Sat, 16 Feb 2019 10:40:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190201042411.GM2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/2/1 12:24, Al Viro wrote:
> On Tue, Jan 29, 2019 at 11:30:27AM +0800, YueHaibing wrote:
>>>>  		gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
>>>>  					       "reset-gpios", 0, GPIOD_OUT_LOW,
>>>>  					       "PHY reset");
>>>> -	if (PTR_ERR(gpiod) == -ENOENT ||
>>>> -	    PTR_ERR(gpiod) == -ENOSYS)
>>>> -		gpiod = NULL;
>>>> -	else if (IS_ERR(gpiod))
>>>> -		return PTR_ERR(gpiod);
>>>> +	if (IS_ERR(gpiod)) {
>>>> +		ret = PTR_ERR(gpiod);
>>>> +		if (ret == -ENOENT || ret == -ENOSYS)
>>>> +			gpiod = NULL;
>>>> +		else
>>>> +			return ret;
>>>> +	}
> 
> Rule of the thumb: PTR_ERR(p) == -E... is almost always better off
> as p == ERR_PTR(-E...)

Ok, will fix it.

> 
> .
> 

