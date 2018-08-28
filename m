Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E964DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A142087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A142087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeH1Pxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:53:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42430 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbeH1Pxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:53:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 213DE2079D; Tue, 28 Aug 2018 14:02:11 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 67AB1206A6;
        Tue, 28 Aug 2018 14:02:10 +0200 (CEST)
Date:   Tue, 28 Aug 2018 14:02:09 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <Vitor.Soares@synopsys.com>
Cc:     <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        "Cyprian Wronka" <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "Rafal Ciepiela" <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180828140209.29155d00@bbrezillon>
In-Reply-To: <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
        <20180719152930.3715-2-boris.brezillon@bootlin.com>
        <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
        <20180824143934.6d6b6487@bbrezillon>
        <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
        <20180824201600.7d80bca9@bbrezillon>
        <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitor,

On Tue, 28 Aug 2018 12:50:12 +0100
vitor <Vitor.Soares@synopsys.com> wrote:

> Hi Boris,
> 
> The DT Bindings say "The node describing an I3C bus should be named 
> i3c-master.". Do you have a field for secondary master?
> 
> On 24-08-2018 19:16, Boris Brezillon wrote:
> > Well, before even considering supporting secondary master registration,
> > we need to handle mastership handover. As for the DAA operation, it's
> > likely to be host specific, so we'll have to add a new hook to the
> > i3c_master_controller_ops struct.  
> Do you mean when master try to delegate the bus ownership through 
> GETACCMST? or to get the bus ownership with IBI-MR?

I think we need to support both.

> 
> I think that could be useful to pass the ibi type on request_ibi(), 
> there is some case where the master doesn't support IBI-MR.

Actually, I was planning on making it completely separate from
regular slave IBIs. That is, the master controller driver would demux
the slave, MR and Hot Join IBIs, and if there's an MR request, queue a
mastership handover work to the workqueue (pretty much what we do for
Hot-Join already). Mastership handover is anyway likely to be IP
specific, so I don't think there's a need to make it look like a
regular IBI.

Regarding whether IBI-MR support should be exposed to the I3C framework
or not depends on how much will be automated on the framework side. I
don't the answer yet, but that's probably something will figure out
along the road.

Regards,

Boris
