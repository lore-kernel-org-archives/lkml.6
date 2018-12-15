Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02929C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6692084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HRs3yuhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbeLOKhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 05:37:53 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49462 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbeLOKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 05:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9qVWMEg1FqMy2cTe0P4YBNSrLkIr3U7RdOd7f04YqHE=; b=HRs3yuhgaoPAsF3dIucTFT1fR
        80NFSwMbjwE2IHjpFiaGsbvbpKi5w7c9zBYRTz4y2+v4HBzANxjcc/Y+Ay9MLwAv0nMgKBHkgrYqW
        W5Iaxv0uvzVUvPtLk37TmtYgETKzhp8tbcxlP/B3j3zY+I7l72lZFPghlv7/blH+TqpNo=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:50975)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gY7KG-0004tw-U7; Sat, 15 Dec 2018 10:37:41 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gY7KE-0006wm-4T; Sat, 15 Dec 2018 10:37:38 +0000
Date:   Sat, 15 Dec 2018 10:37:36 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Weiwei Deng <dengweiwei@huawei.com>,
        "Yisen.Zhuang@huawei.com" <Yisen.Zhuang@huawei.com>,
        "huangdaode@hisilicon.com" <huangdaode@hisilicon.com>,
        "lipeng321@huawei.com" <lipeng321@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        lijianhua 00216010 <lijianhua@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: pause mode disabled for marvell 88e151x phy
Message-ID: <20181215103736.GG26090@n2100.armlinux.org.uk>
References: <04b323d7-2a30-eaa5-8268-a7d3f30d989c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b323d7-2a30-eaa5-8268-a7d3f30d989c@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 04:07:42PM +0800, Yunsheng Lin wrote:
> There seems to be some problem with pause subsequent negotiation.
> We reverted the above patch and tried to reproduce the above problem
> by triggering another negotiation by reconnection of the cable, using
> ethtool -a cmd shows both still have tx and rx pause enable.

That's where the problem is - as far as the network device and Linux
is concerned, pause was successfully negotiated.  However, as the
advertisment register has ended up with the pause mode bits cleared,
Linux doesn't realise that what we conveyed to the partner was an
advertisment containing no pause mode bits.

ethtool doesn't read the PHY advertisment register when displaying
what we advertised, it returns what's in phydev->advertising - it
gives you the cached value not the this-is-what-the-hardware-is-doing
value.

> 1. Does all the 88e151x supporting SGMII-to-Copper have the above problem?

Unknown.

> 2. If not, can we use revision id field in phydev->phy_id to only disable
>    the pause support for specific 88e151x phy? We can not find some useful
>    revision info in datasheet, and by printing the phy id when phy init, we
>    are able to find that the phy we are using has a phy id as 0x1d10dd1,
>    which has revision id as 0x1.

0x01d10dd1 doesn't look to be a Marvell part - Marvell parts generally
start with 0x0141....  Is your 0x1d1 a typo?  My device is 0x01410dd1.

> 3. Does this problem only happen marvel 88e1512 phy with some specific partner
>    phy? We are unable to reproduce this problem, so any suggestion to reproduce
>    this would be very helpful to us too.

I don't think you've proven that you do not have a problem (see below
for how to do this.)

> 4. Also the commit disables the pause support completely, if using revision id
>    can not aviod this problem, can we only disable pause support when negotiation
>    by only clearing pause support in phydev->advertising, but not phydev->supported?

No comment at present.


I think you first need to ensure that your observations are correct.
You are basing your assumptions on ethtool -a's output, which is
definitely wrong as I've mentioned above.

You need to read directly from the hardware using mii-diag -v ethN
and manually decode the advertisment register (register 4) checking
bits 11 and 10 (the pause mode bits).  My observation is that Linux
can set these bits, but then both bits clear during the negotiation
process.

If you then find that these bits do not clear, then we need further
research to work out why there's a different behaviour between the
device I've tested here and the device that you are testing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
