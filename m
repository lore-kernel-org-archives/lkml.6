Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2E7DAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2BE20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eFgUCwC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2BE20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755939AbeFOHyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:54:43 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33815 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755757AbeFOHyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=/hmueo3c4f0GNNHYmi4RVdqxd//FvNgHT1kS3ySeuug=;
        b=eFgUCwC12W2vVOQcwo0mnC59FfR7mERmZqqN6kiUhENX8dwV1d12QgqsrV5ZIVosYWaL+MEmc+18WQRYJB0Bc9AL72pLTeqmEOodOoPG1zqRae4xGN716GmjN14nKZ2z5wzLDnGJz7NgNa1QXNymeZenCMZHF3CJUKQovgqI3a8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fTjYn-0007aA-8n; Fri, 15 Jun 2018 09:54:17 +0200
Date:   Fri, 15 Jun 2018 09:54:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Don Bollinger <don@thebollingers.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, brandon_chuang@edge-core.com,
        wally_wang@accton.com, roy_lee@edge-core.com,
        rick_burchett@edge-core.com, quentin.chang@quantatw.com,
        steven.noble@bigswitch.com, jeffrey.townsend@bigswitch.com,
        scotte@cumulusnetworks.com, roopa@cumulusnetworks.com,
        David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
Message-ID: <20180615075417.GA28730@lunn.ch>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <496e06b9-9f02-c4ae-4156-ab6221ba23fd@amd.com>
 <20180612181109.GD12251@lunn.ch>
 <20180615022652.t6oqpnwwvdmbooab@thebollingers.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615022652.t6oqpnwwvdmbooab@thebollingers.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually this is better described by a third use case.  The target
> switches are PHY-less (see various designs at
> www.compute.org/wiki/Networking/SpecsAndDesigns). The AS5712 for example
> says "The AS5712-54X is a PHY-Less design with the SFP+ and QSFP+
> connections directly attaching to the Serdes interfaces of the Broadcom
> BCM56854 720G Trident 2 switching silicon..."

We consider the SFP+ and QSFP+ as being the PHY. You need something to
control that PHY. Either it is firmware running in the switch, or it
is the Linux kernel, via PHYLINK.

> The i2c bus is muxed from the CPU to all of the {Q}SFP devices, which
> are set up as standard linux i2c devices
> (/sys/bus/i2c/devices/i2c-xxxx).

Having a standard i2c bus driver is correct. This is what PHYLINK
assumes. It knows about the different addresses the SFP uses on the
i2c bus.

> There is no MDIO bus between the CPU and the {Q}SFP devices.

There is no physical MDIO bus for SFP devices. If the SFP module
implements copper 1G, there is often MDIO tunnelled over i2c. PHYLINK
knows how to do this, and will instantiate a normal Linux MDIO bus
driver, and then you can use the Linux kernel copper PHY state
machines as normal.

> And, there isn't actually 'a wish to expose' the EEPROM data to linux
> (the kernel).  It turns out that none of the NOS partners I'm working
> with use that data *in the kernel*.  It is all managed from user space.

Ah. O.K. We can stop here then.

If you are using Linux as a boot loader, i doubt you will find any
network kernel developers who are willing to consider this driver. The
kernel community as decided switchdev is how the Linux kernel supports
switches. We are unlikely to add drivers for supporting user space
drivers of switches.

NACK.

	Andrew
