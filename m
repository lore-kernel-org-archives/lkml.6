Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8D3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7666821788
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7666821788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeHQJOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 05:14:50 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:40465 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeHQJOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 05:14:50 -0400
Received: from [10.18.59.72] (10.18.59.72) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 17 Aug
 2018 14:12:56 +0800
Subject: Re: [PATCH 2/2] PCI: meson: add the Amlogic Meson PCIe phy driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Yue Wang <yue.wang@amlogic.com>, <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        <shawn.lin@rock-chips.com>
References: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
 <1534227134-151584-3-git-send-email-hanjie.lin@amlogic.com>
 <486e8ab477cc22ff231d2e18d7de22efba2c5abd.camel@baylibre.com>
 <2b87e834-41e3-e418-95f0-c6d695cd8b3f@amlogic.com>
 <e5d9d89e79f8ec37b6337e54912f49a0b0856874.camel@baylibre.com>
From:   Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <91658f21-6934-6085-8deb-b85a1f6b7815@amlogic.com>
Date:   Fri, 17 Aug 2018 14:12:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e5d9d89e79f8ec37b6337e54912f49a0b0856874.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.59.72]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/16 16:33, Jerome Brunet wrote:
> On Thu, 2018-08-16 at 11:05 +0800, Hanjie Lin wrote:
>>
>> On 2018/8/14 18:41, Jerome Brunet wrote:
>>> On Tue, 2018-08-14 at 02:12 -0400, Hanjie Lin wrote:
>>>> From: Yue Wang <yue.wang@amlogic.com>
>>>>
>>>> The Meson-PCIE-PHY controller supports the 5-Gbps data rate
>>>> of the PCI Express Gen 2 specification and is backwardcompatible
>>>> with the 2.5-Gbps Gen 1.1 specification with only
>>>> inferred idle detection supported on AMLOGIC SoCs.
>>>
>>> It looks like the sole purpose of this driver is to provide the reset lines to
>>> pcie driver.
>>>
>>> I wonder why we need this ? Can't the pcie driver claim the reset lines itself.
>>>
>>> Also, an init of this phy will always reset both port. What will happen if the
>>> first port is in use and the 2nd port comes up ?? 
>>>
>>> Looks the the pcie driver should claim 'apb' and 'phy' reset lines as "shared"
>>> reset and the required 'port' as 'exclusive'
>>>
>>
>> Thank you for your response.
>>
>> Yes, 'apb' and 'phy' reset lines are shared, and ‘port' reset line is exclusive.
>> If we handle all reset lines during the first port initial sequence, 
>> and when the second port comes up, we will do nothing about the rest lines, 
>> and don't need a extra API to do ‘port' reset;
> 
> With which other driver are your control shared ?
> 
> Looks it is the answer is none since this phy driver will reset both port
> already, even if one is used.
> 
> In this case the fact that you are using shared control is just abusing the
> framework to reset once.
> 
> As far as I can tell, this driver makes no sense. The appropriate reset lines
> should be given directly to your pcie driver. 
> 
> 
> 
> .
> 

Amlogic AXG SOC includes two pcie controllers and pipes when only one pcie phy: 

                                    (port_a reset)
                      |PCIE_RC_A---->PCIE_PIPE_A------| 
    (apb_reset)       |                               |  (phy reset)
    APB BUS--->       |                               |   PCIE_PHY
                      |                               |
                      |             (port_b_reset)    |
                      |PCIE_RC_B---->PCIE_PIPE_B------|

The phy_reset affect the PCIE_PHY.
The port_a_reset affect the PCIE_PIPE_A, port_b_reset affect the PCIE_PIPE_B. 

As your suggestion we will move the 'port' reset to controller driver,
and keeping the phy driver to process the 'apb' and 'phy' reset or any
more changes of the phy in future.

