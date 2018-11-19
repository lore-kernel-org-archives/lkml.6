Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73E6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C2A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C2A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeKTCEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:04:14 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50433 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbeKTCEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:04:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6065320D27; Mon, 19 Nov 2018 16:40:15 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0A91820CFD;
        Mon, 19 Nov 2018 16:40:05 +0100 (CET)
Date:   Mon, 19 Nov 2018 16:40:05 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Andreas Schwab <schwab@suse.de>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/6] net: phy: mscc: migrate to
 phy_select/restore_page functions
Message-ID: <20181119154005.GA8367@piout.net>
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
 <20181008100728.24959-2-quentin.schulz@bootlin.com>
 <mvm8t1pazea.fsf@suse.de>
 <20181119151057.GC26852@lunn.ch>
 <mvm4lcdaynt.fsf@suse.de>
 <20181119152830.GE26852@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119152830.GE26852@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2018 16:28:30+0100, Andrew Lunn wrote:
> On Mon, Nov 19, 2018 at 04:13:10PM +0100, Andreas Schwab wrote:
> > On Nov 19 2018, Andrew Lunn <andrew@lunn.ch> wrote:
> > 
> > > On Mon, Nov 19, 2018 at 03:57:17PM +0100, Andreas Schwab wrote:
> > >> On Okt 08 2018, Quentin Schulz <quentin.schulz@bootlin.com> wrote:
> > >> 
> > >> > The Microsemi PHYs have multiple banks of registers (called pages).
> > >> > Registers can only be accessed from one page, if we need a register from
> > >> > another page, we need to switch the page and the registers of all other
> > >> > pages are not accessible anymore.
> > >> >
> > >> > Basically, to read register 5 from page 0, 1, 2, etc., you do the same
> > >> > phy_read(phydev, 5); but you need to set the desired page beforehand.
> > >> >
> > >> > In order to guarantee that two concurrent functions do not change the
> > >> > page, we need to do some locking per page. This can be achieved with the
> > >> > use of phy_select_page and phy_restore_page functions but phy_write/read
> > >> > calls in-between those two functions shall be replaced by their
> > >> > lock-free alternative __phy_write/read.
> > >> >
> > >> > Let's migrate this driver to those functions.
> > >> 
> > >> This has some serious locking problem.
> > >
> > > Hi Andreas
> > >
> > > Could you be more specific. Are you getting a deadlock? A WARN_ON?
> > 
> > See the stack trace.  That's where it hangs.
> 
> So you never said it hangs. The stacktrace helps, but a description of
> what actually happens also helps. And i expect Quentin has booted this
> code lots of times and not had a hang. So some hits how to reproduce
> it would also help. Maybe your kernel config?
> 
> I'm interested because he is using the core mdio locking
> primitives. If those are broken, i want to know.
> 

My first intuition is that he mac driver quentin is using does
phy_connect when the interface is opened while macb is doing it at probe
time. I didn't investigate but maybe this can help :)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
