Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFDDC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE332075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE332075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeIFR4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:56:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57118 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbeIFR4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:56:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3B386207AD; Thu,  6 Sep 2018 15:21:07 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7748B20763;
        Thu,  6 Sep 2018 15:20:56 +0200 (CEST)
Date:   Thu, 6 Sep 2018 15:20:55 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Przemyslaw Gaj <pgaj@cadence.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180906152055.5618d235@bbrezillon>
In-Reply-To: <20180906151437.4259d6fc@bbrezillon>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
        <20180719152930.3715-2-boris.brezillon@bootlin.com>
        <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
        <20180824143934.6d6b6487@bbrezillon>
        <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
        <20180824201600.7d80bca9@bbrezillon>
        <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
        <20180828140209.29155d00@bbrezillon>
        <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
        <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com>
        <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
        <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com>
        <25862F03-9823-42B0-87AC-AE36D7E9C780@cadence.com>
        <CAK8P3a3pkddD9VnogYryQKoL9Z_5qVRBXd6yr1z6CqGU692rXg@mail.gmail.com>
        <20180906151437.4259d6fc@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018 15:14:37 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Thu, 6 Sep 2018 14:59:46 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Thu, Sep 6, 2018 at 2:43 PM Przemyslaw Gaj <pgaj@cadence.com> wrote:  
> > >
> > > Hi Boris, Vitor,
> > >
> > > This repository does not contain full kernel sources, but it should be enough to discuss mastership request feature.
> > > https://github.com/przemekgaj/i3c-linux/commit/d54fe68a9d3e573c0c454a2c6f1afafc20142ec5
> > >
> > > Please keep in mind that this is initial version, but mastership works correctly. I added one property to DT to reflect relationship between masters.
> > > It is possible to request mastership on demand (using sysfs. Useful in case when Linux machine is equipped only with secondary master controller) or automatically change operation mode when device driver wants to read/write something from/to device.
> > >
> > > I'm sure I will have to rework something because this was implemented on sources from PATCH v4. I saw that Boris released v7 yesterday :)    
> > 
> > 
> > Can you explain the reason for having a user space interface and DT property?
> > I thought we had concluded earlier that we wouldn't need that, but it's possible
> > that I missed something in the discussion since then.  
> 
> I don't think the sysfs knob is needed, this being said, after thinking
> a bit more about mastership handover and the secondary master case, I
> think we have something important to solve.
> 
> When a master is not in control of the bus, it gets informed of devices
> present on the bus by monitoring DAA or DEFSLVS broadcast events. That
> means the secondary master should populate the bus with I3C/I2C devices
> on such events, but that's not enough, because DEFSLVS/DAA do not
> provide all device info. Some of them (like read/write/ibi limitations)
> require extra CCC commands, and, to send those CCC commands, the
> secondary master must claim the bus. We could add a case where we
> declare devices as partially discovered until the master acquires
> ownership of the bus, but that means part of the data returned by
> i3c_device_get_info() will be inaccurate, which might have an impact on
> some i3c driver ->probe() functions.

Hm, one possible solution would be to register partially discovered
devices to the device model and let i3c_device_get_info() claim the bus
and request missing data when needed. This way, if the driver needs to
call i3c_device_get_info() in its probe path, it should work just fine.
