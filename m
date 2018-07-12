Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581F820BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581F820BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeGLGgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:36:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeGLGgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:36:06 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5926249B;
        Thu, 12 Jul 2018 06:27:59 +0000 (UTC)
Date:   Thu, 12 Jul 2018 08:27:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Rue <dan.rue@linaro.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        chris.ruehl@gtsys.com.hk, Lars Persson <lars.persson@axis.com>
Subject: Re: [PATCH 4.9 181/310] net: phy: micrel: Restore led_mode and
 clk_sel on resume
Message-ID: <20180712062756.GJ20905@kroah.com>
References: <20180411183622.305902791@linuxfoundation.org>
 <20180411183630.390575424@linuxfoundation.org>
 <CA+G9fYtR_3AXKvhrkE3WEZhVOX6XwJ1r38PLav1XKkz4L4eQZQ@mail.gmail.com>
 <1524154267.17017.15.camel@nxp.com>
 <CA+G9fYs00cOVxuWYkfUxkdYZX5NGeTgBpwimCJ7tJbANbZwGEA@mail.gmail.com>
 <223ffd4d-567e-6c5c-9581-5304494dd0b3@gmail.com>
 <1524164724.17017.35.camel@nxp.com>
 <20180711201548.3rvad25yhcnr5h4e@linode.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180711201548.3rvad25yhcnr5h4e@linode.therub.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:15:48PM +0000, Dan Rue wrote:
> On Thu, Apr 19, 2018 at 10:05:24PM +0300, Leonard Crestez wrote:
> > On Thu, 2018-04-19 at 11:32 -0700, Florian Fainelli wrote:
> > > +Others who reported the same problem
> > > On 04/19/2018 11:24 AM, Naresh Kamboju wrote:
> > > > On 19 April 2018 at 21:41, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > > > > 
> > > > > Looking at this dump I'm guessing that phydev->priv is NULL at the
> > > > > start of kszphy_config_reset and this really shouldn't be happening.
> > > > > 
> > > > > The phydev->priv field is initialized by kszphy_probe but your
> > > > > particular phy (KSZ9031) in linux-4.9.y does not seem to have .probe =
> > > > > kszphy_probe assigned in the struct phy_driver ksphy_driver array.
> > > > > 
> > > > > In upstream this was added by commit bfe72442578b ("net: phy: micrel:
> > > > > fix crash when statistic requested for KSZ9031 phy"). The message for
> > > > > that patch claims to fix a kernel crash on this command:
> > > > > 
> > > > >     ethtool --phy-statistics eth0
> > > > > 
> > > > > Looking at the code this issue should affect linux-4.9.y on your board.
> > > > > Naresh: can you please check?
> > > > After reverting the patch i have run this command and kernel oops
> > > > showed up.
> > > > ethtool --phy-statistics eth0
> > > > 
> > > > PC is at kszphy_get_stats+0x74/0xa8
> > > > 
> > > > ethtool --phy-statistics eth0 crashed on x15
> > > > 
> > > Chris proposed the following patch, which has not been formally
> > > submitted yet:
> > > 
> > > Meanwhile, Greg seems to have reverted the offending patch, so we should
> > > be good with 4.9.95.
> > 
> > I don't object to reverting my patch from linux-4.14.y but it seems all
> > the affected hardware would also be affected by the crash from ethtool
> > --phy-statistics eth0. Adding bfe72442578b to stable would be great
> > because it fixes more than the patch in the title.
> > 
> > In the other thread there is a mention that "Micrel KSZ8795",
> > "Micrel KSZ886X Switch", "Micrel KSZ8061", and "Micrel KS8737" might
> > still have problems after bfe72442578b. Is this because they have
> > kszphy_config_init but not kszphy_probe? All versions of
> > kszphy_config_init seem to check for a NULL priv.
> 
> To conclude this thread, bfe72442578b has been backported as of 4.9.112
> and 'ethtool --phy-statistics eth0' no longer causes a NULL pointer
> error.

Wonderful, thanks for confirming this.

greg k-h
