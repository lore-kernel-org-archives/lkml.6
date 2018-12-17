Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5655CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137E520675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbeLQJmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:42:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726789AbeLQJma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:42:30 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BFF1FC5A084F6;
        Mon, 17 Dec 2018 17:42:25 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 17:42:20 +0800
Subject: Re: Question: pause mode disabled for marvell 88e151x phy
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     Andrew Lunn <andrew@lunn.ch>,
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
References: <04b323d7-2a30-eaa5-8268-a7d3f30d989c@huawei.com>
 <20181215103736.GG26090@n2100.armlinux.org.uk>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <1b4d7886-06c4-9d15-ef72-83318419b30e@huawei.com>
Date:   Mon, 17 Dec 2018 17:42:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181215103736.GG26090@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/15 18:37, Russell King - ARM Linux wrote:
> On Sat, Dec 15, 2018 at 04:07:42PM +0800, Yunsheng Lin wrote:
>> There seems to be some problem with pause subsequent negotiation.
>> We reverted the above patch and tried to reproduce the above problem
>> by triggering another negotiation by reconnection of the cable, using
>> ethtool -a cmd shows both still have tx and rx pause enable.
> 
> That's where the problem is - as far as the network device and Linux
> is concerned, pause was successfully negotiated.  However, as the
> advertisment register has ended up with the pause mode bits cleared,
> Linux doesn't realise that what we conveyed to the partner was an
> advertisment containing no pause mode bits.
> 
> ethtool doesn't read the PHY advertisment register when displaying
> what we advertised, it returns what's in phydev->advertising - it
> gives you the cached value not the this-is-what-the-hardware-is-doing
> value.
> 
>> 1. Does all the 88e151x supporting SGMII-to-Copper have the above problem?
> 
> Unknown.
> 
>> 2. If not, can we use revision id field in phydev->phy_id to only disable
>>    the pause support for specific 88e151x phy? We can not find some useful
>>    revision info in datasheet, and by printing the phy id when phy init, we
>>    are able to find that the phy we are using has a phy id as 0x1d10dd1,
>>    which has revision id as 0x1.
> 
> 0x01d10dd1 doesn't look to be a Marvell part - Marvell parts generally
> start with 0x0141....  Is your 0x1d1 a typo?  My device is 0x01410dd1.

Sorry, 0x1d1 is a typo.
My device is also 0x01410dd1.

> 
>> 3. Does this problem only happen marvel 88e1512 phy with some specific partner
>>    phy? We are unable to reproduce this problem, so any suggestion to reproduce
>>    this would be very helpful to us too.
> 
> I don't think you've proven that you do not have a problem (see below
> for how to do this.)
> 
>> 4. Also the commit disables the pause support completely, if using revision id
>>    can not aviod this problem, can we only disable pause support when negotiation
>>    by only clearing pause support in phydev->advertising, but not phydev->supported?
> 
> No comment at present.
> 
> 
> I think you first need to ensure that your observations are correct.
> You are basing your assumptions on ethtool -a's output, which is
> definitely wrong as I've mentioned above.
> 
> You need to read directly from the hardware using mii-diag -v ethN
> and manually decode the advertisment register (register 4) checking
> bits 11 and 10 (the pause mode bits).  My observation is that Linux
> can set these bits, but then both bits clear during the negotiation
> process.

Thanks for the info.

Using arm64 with marvel 88e1512 phy connected to a X86 with intel phy,
The 88e1512 phy' advertisment register did change after negotiation:

arm64 with marvel 88e1512 phy:
 MII PHY #1 transceiver registers:
   3100 796d 0141 0dd1 05e1 cde1 000d 2001
   4006 0200 3800 0000 0000 0003 0000 3000
   3060 af08 0000 0000 0020 0000 0000 0000
   0000 0000 0040 0000 0000 0000 0000 0000

X86 with intel phy:
   1140 796d 0154 03b1 0de1 c5e1 000d 2001
   6801 0600 7800 0000 0000 0000 0000 3000
   0000 000a 840a 1075 0000 000c ff08 3048
   0000 816c 1ac6 0003 210a 1f55 0000 c064

But ethtool -a on both arm64 and X86 shows that tx and rx pause are
both enabled.

It seems ADVERTISE_PAUSE_ASYM is cleared on arm64 with marvel 88e1512 phy.
Does your device with marvel 88e1512 phy have the smiliar output as above?

And in include/linux/mii.h, we have:
/**
 * mii_resolve_flowctrl_fdx
 * @lcladv: value of MII ADVERTISE register
 * @rmtadv: value of MII LPA register
 *
 * Resolve full duplex flow control as per IEEE 802.3-2005 table 28B-3
 */
static inline u8 mii_resolve_flowctrl_fdx(u16 lcladv, u16 rmtadv)
{
	u8 cap = 0;

	if (lcladv & rmtadv & ADVERTISE_PAUSE_CAP) {
		cap = FLOW_CTRL_TX | FLOW_CTRL_RX;
	} else if (lcladv & rmtadv & ADVERTISE_PAUSE_ASYM) {
		if (lcladv & ADVERTISE_PAUSE_CAP)
			cap = FLOW_CTRL_RX;
		else if (rmtadv & ADVERTISE_PAUSE_CAP)
			cap = FLOW_CTRL_TX;
	}

	return cap;
}

As the comment has pointed to IEEE 802.3-2005 table 28B-3:
http://www.ismlab.usf.edu/dcom/Ch3_802.3-2005_section2.pdf

ADVERTISE_PAUSE_ASYM on local and remote is a "Don’t care"
bit when they both support ADVERTISE_PAUSE_CAP, so maybe it is ok
that marvel phy clears the ADVERTISE_PAUSE_ASYM bit.

Any thought?


> 
> If you then find that these bits do not clear, then we need further
> research to work out why there's a different behaviour between the
> device I've tested here and the device that you are testing.
> 

