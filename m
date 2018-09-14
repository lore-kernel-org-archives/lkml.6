Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273D6FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D137C20671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZOfwqaBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D137C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeINSof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:44:35 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34635 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbeINSof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=1l9ugV6Aa6CqRnG98Lun2VDfwNOh2p50okizB/MSpnA=;
        b=ZOfwqaBFSkRK4/puWDptzIRwt3cFPRpHsp5H5PsYfQxOeDjEM45DfPe8MENCgLqD+jCNdtLh6xiw5LkzhyP9j8zHR7jUff1EW64a3nEPcj2eidNmIuTNbNi4IMlpnn6b/TOFPGE8mkrDxz/onkyWPZbsHerqQSRkUhE9sNI2vpc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g0oAZ-0004V0-Oi; Fri, 14 Sep 2018 15:29:59 +0200
Date:   Fri, 14 Sep 2018 15:29:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
Subject: Re: [PATCH net-next 1/5] net: phy: mscc: add ethtool statistics
 counters
Message-ID: <20180914132959.GH14865@lunn.ch>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <e220fe75053e200f91554b752905d84b14b76eb6.1536913944.git-series.quentin.schulz@bootlin.com>
 <20180914130156.GB14865@lunn.ch>
 <20180914131645.64k4w4h7ir3u5yuk@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914131645.64k4w4h7ir3u5yuk@qschulz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When you change a page, you basically can access only the registers in
> this page so if there are two functions requesting different pages at
> the same time or registers of different pages, it won't work well
> indeed.
> 
> > phy_read_page() and phy_write_page() will do the needed locking if
> > this is an issue.
> > 
> 
> That's awesome! Didn't know it existed. Thanks a ton!
> 
> Well, that means I should migrate the whole driver to use
> phy_read/write_paged instead of the phy_read/write that is currently in
> use.
> 
> That's impacting performance though as per phy_read/write_paged we read
> the current page, set the desired page, read/write the register, set the
> old page back. That's 4 times more operations.

You can use the lower level locking primatives. See m88e1318_set_wol()
for example.

> Couldn't we use the
> phy_device mutex instead (as it's currently done in the whole driver)?
> Or is it worse/comparable in performance to the suggested solution?

Russell King found a race condition where this breaks. You cannot hold
the phy_device mutex everywhere.

    Andrew
