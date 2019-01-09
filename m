Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27CCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EAC20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfAIVgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:36:17 -0500
Received: from muru.com ([72.249.23.125]:32884 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfAIVgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:36:17 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1CB7180C5;
        Wed,  9 Jan 2019 21:36:21 +0000 (UTC)
Date:   Wed, 9 Jan 2019 13:36:11 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rex Chang <rchang@ti.com>, Tero Kristo <t-kristo@ti.com>,
        WingMan Kwok <w-kwok2@ti.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Re: Regression in v4.20 with net phy soft reset changes
Message-ID: <20190109213611.GU5544@atomide.com>
References: <20190109190650.GT5544@atomide.com>
 <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Heiner Kallweit <hkallweit1@gmail.com> [190109 19:28]:
> On 09.01.2019 20:06, Tony Lindgren wrote:
> > Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
> > a regression where suspend resume cycle fails to bring up Ethernet on at
> > least cpsw on am437x-sk-evm.
> > 
> What kind of PHY and which PHY driver is used with this board?
> I found one schematics of am437x where a KSZ9031RN PHY is used.
> Is it the same on your board?

Yes that's the phy.

> As described in the commit message of this commit you would have
> the option to implement the soft_reset callback in the PHY driver.
> Can you try to add .soft_reset = genphy_soft_reset to the
> KSZ9031 driver config in drivers/net/phy/micrel.c and check whether
> it fixes the issue?

Yes that seems to work based on a quick test of five suspend
resume cycles.

I wonder what all hardware this issue affects though?

It's probably best that the network folks check what all
hardare needs patching.

For TI hardware, Sekhar and TI network folks, can you guys
please check the various TI SoCs for multiple suspend resume
cycles with v5.0-rc1 and patch accordingly? See also below
for something else to check, 10 seconds to resume a phy
seems very long to me :)

> > Keerthy noticed this may not happen on the first resume, but usually
> > happens after few suspend resume cycles. The most working suspend resume
> > cycles I've seen with the commit above is three.
...
> > Note that unrelated to the commit above, there may be other issues too
> > as the cpsw phy LED seems to come on only after about five seconds with
> > about total of 10 seconds before the Ethernet is up again.

Regards,

Tony
