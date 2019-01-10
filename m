Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F8CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6AB214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lJM9rQC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbfAJLw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:52:28 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45386 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfAJLw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:52:27 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0ABq8XQ051327;
        Thu, 10 Jan 2019 05:52:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547121128;
        bh=kK5OGjM6dqECzPd5ZaNdPEnutiwSDTnoOQrWXRwCKf0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lJM9rQC/1BcOwt6S+6mR1S0IktI4V6AnHZaTtNRAxSZOWjq8gKDkJfsV8eOkHOWgG
         d5YNjcCco/t3bEY0DUNz2JNBlmpuszCxFBw7lWjTibankFmX7Xj9VabDiYYfLWfrwj
         vw4hI7z+442VRXwJaNDRjYgHu3tJRQIE1eSPrjXI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0ABq8xj099778
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 05:52:08 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 05:52:08 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 05:52:08 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0ABq2l1031261;
        Thu, 10 Jan 2019 05:52:03 -0600
Subject: Re: Regression in v4.20 with net phy soft reset changes
To:     Tony Lindgren <tony@atomide.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rex Chang <rchang@ti.com>, Tero Kristo <t-kristo@ti.com>,
        WingMan Kwok <w-kwok2@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
References: <20190109190650.GT5544@atomide.com>
 <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
 <20190109213611.GU5544@atomide.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <79c57d19-837e-4468-f6b4-b3bfa9dde82a@ti.com>
Date:   Thu, 10 Jan 2019 17:22:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109213611.GU5544@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/01/19 3:06 AM, Tony Lindgren wrote:
> Hi,
> 
> * Heiner Kallweit <hkallweit1@gmail.com> [190109 19:28]:
>> On 09.01.2019 20:06, Tony Lindgren wrote:
>>> Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
>>> a regression where suspend resume cycle fails to bring up Ethernet on at
>>> least cpsw on am437x-sk-evm.
>>>
>> What kind of PHY and which PHY driver is used with this board?
>> I found one schematics of am437x where a KSZ9031RN PHY is used.
>> Is it the same on your board?
> 
> Yes that's the phy.
> 
>> As described in the commit message of this commit you would have
>> the option to implement the soft_reset callback in the PHY driver.
>> Can you try to add .soft_reset = genphy_soft_reset to the
>> KSZ9031 driver config in drivers/net/phy/micrel.c and check whether
>> it fixes the issue?
> 
> Yes that seems to work based on a quick test of five suspend
> resume cycles.
> 
> I wonder what all hardware this issue affects though?
> 
> It's probably best that the network folks check what all
> hardare needs patching.
> 
> For TI hardware, Sekhar and TI network folks, can you guys
> please check the various TI SoCs for multiple suspend resume
> cycles with v5.0-rc1 and patch accordingly? See also below

Will do.

> for something else to check, 10 seconds to resume a phy
> seems very long to me :)

On the AM437x GP EVM which uses the same PHY, the link does not even
come up for me after a cable plug unplug. Link is up at boot (I use
NFS). This only happens with v4.20 and v5.0-rc1, not with v4.19.

Adding the genphy_soft_reset hook solves the issue and link comes back
up almost immediately. I checked this with v5.0-rc1.

I don't see the link problem if I shift to 100Mps prior to the
plug/unplug experiment using ethtool. So looks like the problem is
restricted to Gigabit link only. Are you using Gigabit link too?

I think we should patch drivers/net/phy/micrel.c to solve the
regression. Not sure of the root cause though. In the errata pointed to
by Heiner, there is "Module 6" which comes close to what we are seeing,
except it talks of a scenario where auto-negotiation is turned off 100M
link is used and we see the issue even with auto-neg on and in gigabit
mode. "Module 5" is also related to link failure, but is already worked
around in kernel with ksz9031_center_flp_timing().

> 
>>> Keerthy noticed this may not happen on the first resume, but usually
>>> happens after few suspend resume cycles. The most working suspend resume
>>> cycles I've seen with the commit above is three.
> ...
>>> Note that unrelated to the commit above, there may be other issues too
>>> as the cpsw phy LED seems to come on only after about five seconds with
>>> about total of 10 seconds before the Ethernet is up again.

I don't quite see this problem on the AM437x GP EVM. I have seen gigabit
link takes quite some time (sometimes more than 10 seconds) on x15 EVM.
Not sure if the problem you are facing is related to gigabit too. If you
are using gigabit link, can you downgrade to 100MBps to check? Either
using a 100M only switch or by using ethtool on the EVM.

$ ethtool -s eth0 speed 100 duplex full

Thanks,
Sekhar
