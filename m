Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDA7C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C404D23ED1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C404D23ED1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754299AbeFVINb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:13:31 -0400
Received: from regular1.263xmail.com ([211.150.99.139]:36334 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeFVIN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:13:27 -0400
Received: from david.wu?rock-chips.com (unknown [192.168.167.84])
        by regular1.263xmail.com (Postfix) with ESMTP id 00D4355EE;
        Fri, 22 Jun 2018 16:13:16 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.172] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 1BDC33D7;
        Fri, 22 Jun 2018 16:13:14 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: david.wu@rock-chips.com
X-FST-TO: elaine.zhang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: david.wu@rock-chips.com
X-UNIQUE-TAG: <c3c720331cf91369ddd6fb2019ec5c44>
X-ATTACHMENT-NUM: 0
X-SENDER: wdc@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.172] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 67744R4ZY7;
        Fri, 22 Jun 2018 16:13:17 +0800 (CST)
Subject: Re: [PATCH v2] net: ethernet: stmmac: dwmac-rk: Add GMAC support for
 PX30
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        huangtao@rock-chips.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?5byg5pm0?= <elaine.zhang@rock-chips.com>
References: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com>
 <2582999.2hZx6CH9S6@diego>
 <157ecfc9-d0e6-7782-1cbc-d0fb76c81edb@rock-chips.com>
 <18221590.FEDROxemCD@phil>
From:   David Wu <david.wu@rock-chips.com>
Message-ID: <7baeda9c-d7c4-e491-e18d-30afefa98c96@rock-chips.com>
Date:   Fri, 22 Jun 2018 16:13:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <18221590.FEDROxemCD@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

在 2018年06月22日 15:30, Heiko Stuebner 写道:
> Hi David,
> 
> Am Mittwoch, 20. Juni 2018, 04:40:35 CEST schrieb David Wu:
>> 在 2018年06月14日 16:30, Heiko Stübner 写道:
>>> Am Donnerstag, 14. Juni 2018, 10:14:31 CEST schrieb David Wu:
>>>> Hi Heiko,
>>>>
>>>> 在 2018年06月14日 15:54, Heiko Stübner 写道:
>>>>> I don't see that new clock documented in the dt-binding.
>>>>> Also, which clock from the clock-controller does this connect to?
>>>>
>>>> The clock is the "SCLK_GMAC_RMII" at the clock-controller, which could
>>>> be set rate by the link speed.
>>>
>>> Hmm, while these huge number of clocks are somewhat strange,
>>> shouldn't it be named something with _rmii instead of _speed then?
>>
>> Okay, it is better to be named _speed.
>>
>>>
>>> Also, I don't see any clk_enable action for that new clock, so you could
>>> end up with being off?
>>
>> The new speed is the parent of the clk_tx_rx, to enable/disable
>> clk_tx_rx, the new clock would be also enabled/disabled.
> 
> Still it is nicer to really enable it, so that the clock-framework can keep
> track of usage counts.
> 
> Because also no-one hinders the chip-designer from putting a gate in
> between in one of the next socs ;-)
> 

Okay, i will add the enable/disable for clk_mac_speed.
  ;-)

> 
> Heiko
> 
> 
> 
> 
> 

