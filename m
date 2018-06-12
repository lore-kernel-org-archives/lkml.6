Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 43E35C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB670208BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HoR9jOhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB670208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933850AbeFLSLn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:11:43 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59850 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754209AbeFLSLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=9WpHl8Q4wdCTmzJvtyuJJnxHMb0s/WHit2GsXdnN4L8=;
        b=HoR9jOhwBTHLVGUTJJWvrUiz+A3eNKcE4112yL5wDyFFE83lDSYp5A4GSVr82aNje0zecSOJyKCZR2qQHVUunoFeSkPv5ltaOSSQf0ngu17UunUEP0jNxxQF4aZK5Tr7TkJuVeyHodCBuFuWvhrZmXFaer0g34ngRYU7V2L4u28=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fSnl7-00043d-8k; Tue, 12 Jun 2018 20:11:09 +0200
Date:   Tue, 12 Jun 2018 20:11:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Don Bollinger <don@thebollingers.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, brandon_chuang@edge-core.com,
        wally_wang@accton.com, roy_lee@edge-core.com,
        rick_burchett@edge-core.com, quentin.chang@quantatw.com,
        jeffrey.townsend@bitswitch.com, scotte@cumulusnetworks.com,
        roopa@cumulusnetworks.com, David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
Message-ID: <20180612181109.GD12251@lunn.ch>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <496e06b9-9f02-c4ae-4156-ab6221ba23fd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496e06b9-9f02-c4ae-4156-ab6221ba23fd@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There's an SFP driver under drivers/net/phy.  Can that driver be extended
> to provide this support?  Adding Russel King who developed sfp.c, as well
> at the netdev mailing list.

I agree, the current SFP code should be used.

My observations seem to be there are two different ways {Q}SFP are used:

1) The Linux kernel has full control, as assumed by the devlink/SFP
frame work. We parse the SFP data to find the capabilities of the SFP
and use it to program the MAC to use the correct mode. The MAC can be
a NIC, but it can also be a switch. DSA is gaining support for
PHYLINK, so SFP modules should just work with most switches which DSA
support.  And there is no reason a plain switchdev switch can not use
PHYLINK.

2) Firmware is in control of the PHY layer, but there is a wish to
expose some of the data which is available via i2c from the {Q}SFP to
linux.

It appears this optoe supports this second case. It does not appear to
support any in kernel API to actually make use of the SFP data in the
kernel.

We should not be duplicating code. We should share the SFP code for
both use cases above. There is also a Linux standard API for getting
access to this information. ethtool -m/--module-info. Anything which
is exporting {Q}SFP data needs to use this API.

   Andrew
