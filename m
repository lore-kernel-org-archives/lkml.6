Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21971C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B79216FC
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FzFPjWtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B79216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeJUEoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 00:44:25 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39061 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbeJUEoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 00:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=BxLea/evN+XC098VCgL7By3veNZat0HjlnOT/U0p37w=;
        b=FzFPjWtJdEMlQC8lGgcKPNSG45wVGHdO6ElfqAoaUGFlGSRORWf7qbvrIMp44duBZK81Owo0r5YA9lbxT7UJ+5eGqaYmkI6F1eI7S3BeMVv7JdQoABRPd9dUtkxDvuU0/0I5zVgfUmgZiPs7n2oPQ+WJ21u8uYxzbaXItGY5AhM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gDxvN-0003g3-3V; Sat, 20 Oct 2018 22:32:41 +0200
Date:   Sat, 20 Oct 2018 22:32:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        fugang.duan@nxp.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
Message-ID: <20181020203241.GC6615@lunn.ch>
References: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
 <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com>
 <20181018184715.GA31736@Red>
 <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com>
 <20181018191612.GB31736@Red>
 <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com>
 <20181018195909.GA11317@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018195909.GA11317@Red>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 09:59:09PM +0200, LABBE Corentin wrote:
> On Thu, Oct 18, 2018 at 12:38:32PM -0700, Florian Fainelli wrote:
> > On 10/18/2018 12:16 PM, LABBE Corentin wrote:
> > > On Thu, Oct 18, 2018 at 11:55:49AM -0700, Florian Fainelli wrote:
> > >> On 10/18/2018 11:47 AM, LABBE Corentin wrote:
> > >>> On Thu, Oct 18, 2018 at 11:39:24AM -0700, Florian Fainelli wrote:
> > >>>> On 10/18/2018 08:05 AM, Corentin Labbe wrote:
> > >>>>> Since commit 58056c1e1b0e ("net: ethernet: Use phy_set_max_speed() to limit advertised speed"), the fec driver is unable to get any link.
> > >>>>> This is due to missing SPEED_.
> > >>>>
> > >>>> But SPEED_1000 is defined in include/uapi/linux/ethtool.h as 1000, so
> > >>>> surely this would amount to the same code paths being taken or am I
> > >>>> missing something here?
> > >>>
> > >>> The bisect session pointed your patch, reverting it fix the issue.
> > >>> BUT since the fix seemed trivial I sent the patch without more test then compile it.
> > >>> Sorry, I have just found some minutes ago that it didnt fix the issue.
> > >>>
> > >>> But your patch is still the cause for sure.
> > >>>
> > >>
> > >> What you are writing is really lowering the confidence level, first
> > >> Andrew is the author of that patch, and second "just compiling" and
> > >> pretending this fixes a problem when it does not is not quite what I
> > >> would expect.
> > >>
> > >> I don't have a problem helping you find the solution or the right fix
> > >> though, even if it is not my patch, but please get the author and actual
> > >> problem right so we can move forward in confidence, thanks!
> > > 
> > > Sorry again, I wanted to acknoledge my error but I did it too fast and late.
> > > And sorry to have confound you with Andrew.
> > 
> > No worries, here to help, let us know what your bisection points to. THanks
> 
> I have added printing of phydev->supported
> My working kernel (on top of 58056c1e1b0e + revert patch) got:
> [    5.550838] fec_enet_mii_probe 2ff (gbit features)
> [    5.555848] fec_enet_mii_probe 2ef (without 1000baseT_Half)
> [    5.561620] fec_enet_mii_probe 22ef final (after pause)
> [    5.566914] Micrel KSZ9021 Gigabit PHY 2188000.ethernet-1:06: attached PHY driver [Micrel KSZ9021 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet-1:06, irq=POLL)

I just looked at the datasheet for the KSZ9021. It supports Pause and
ASym Pause. So i would expect these bits to be set. However, the FEC
MAC is unable to support Asym pause, it only supports Pause. So it is
the MAC drivers responsibility to clear Asym Pause.

        /* mask with MAC supported features */
	if (fep->quirks & FEC_QUIRK_HAS_GBIT) {
                phy_set_max_speed(phy_dev, 1000);
                phy_remove_link_mode(phy_dev,
                                     ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
#if !defined(CONFIG_M5272)
	phy_support_sym_pause(phy_dev);
#endif
        }
        else
                phy_set_max_speed(phy_dev, 100);

I think we just need to take this #if !defined out, so always
indicating that sym_pause is supported. And we want
phy_support_sym_pause() to clear the asym_pause bit, if set.

	Andrew
