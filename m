Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6076C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6E8217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tq5Maxpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfAVNUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:20:13 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51529 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbfAVNUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=O+u0odsrSBsihdyWpnauKMfnZl0ym9tcZpZN6vfZhCw=;
        b=tq5MaxpzUVnaqWGPJYGhN8rHzM0H448KVyCWRUCJWrkwsjZm8iRiEPBtxOA0bBM/gunW12QztgkilRHNMBNOgk8PMZQh4joAv1pY+FMc2awYhstkGHzbsAge49NQDq4+2KOz45CLvuj/nwDg+w71R7OlKLBrhxUmznkoTtMWQW8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1glvyH-0001A2-MB; Tue, 22 Jan 2019 14:20:05 +0100
Date:   Tue, 22 Jan 2019 14:20:05 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add suspend/resume
 callbacks
Message-ID: <20190122132005.GA3634@lunn.ch>
References: <20190116153419.3208-1-miquel.raynal@bootlin.com>
 <20190116155651.GC29244@lunn.ch>
 <e9ac5203-87ba-c14f-8140-5b100808a8a4@gmail.com>
 <20190116222329.GP29244@lunn.ch>
 <20190117104641.GD13242@t480s.localdomain>
 <20190117165052.6d1f1a58@xps13>
 <b804e77a-5eb5-6d18-cb79-f8176e370775@gmail.com>
 <20190122110435.5eaab82a@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190122110435.5eaab82a@xps13>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not sure to understand what is lost. On my setup ethtool shows
> that everything is fine after resume but maybe I fall into a "default"
> working case.

Hi Miquèl

Is the power removed from the switch? If so, you need to restore the
full switch configuration. The current code might be sufficient for
runtime suspend, where the switch is put into a low power mode, but it
is kept powered. It is not sufficient for a full power cycle.

> When I compare with the two drivers pointed out by Andrew:
> * qca8k resume callback:
> 	* enable ports,
> 	* call dsa_switch_resume().
> * bcm_sf2 resume callback:
> 	* call dsa_switch_resume(),
> 	* reset the switch,
> 	* refresh rules (Not applicable?),
> 	* enable the PHYs,
> 	* setup the ports,
> 	* configure vlan (Not applicable?),
> * mv88e6xxx resume callback:
> 	* reset the switch,
> 	* enable the PHYs,
> 	* setup the ports,
> 	* enable IRQs,
> 	* call dsa_switch_resume().
 
Here are some commands to try before you suspend:

ip link add name br0 type bridge
ip link set br0 up
ip link set lan1 up
ip link set lan1 master br0
ip link set lan2 up
ip link set lan2 master br0

At this point, you should be able to pass traffic between lan1 and
lan2.

bridge fdb add 00:42:42:42:42:42 lan1
bridge fdb add 00:24:24:24:24:24 lan2

That adds two static forwarding database entries. You can show these using

bridge fdb show

There are likely to be additional dynamic FDB entries. It is O.K. to
loose the dynamic entries over a suspend/resume cycle, but the static
ones must remain.

> This looks pretty similar. Maybe the ports setup are set to default
> values while I should save some parameters at suspend? I changed a
> few parameters (like the MTU or the queue length) but they seem to be
> correct across suspend cycles.

MTU and queue length have nothing to do with the actual switch. Your
tests need to actually program the hardware.

    Andrew
