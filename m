Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36221C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3CD20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3CD20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504353AbeKWXeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:34:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59149 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388147AbeKWXeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:34:12 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9C8FB207BB; Fri, 23 Nov 2018 13:50:05 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id EA9DD207AB;
        Fri, 23 Nov 2018 13:50:04 +0100 (CET)
Date:   Fri, 23 Nov 2018 13:50:04 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <vitor.soares@synopsys.com>
Cc:     <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <psroka@cadence.com>, <agolec@cadence.com>,
        <adouglas@cadence.com>, <bfolta@cadence.com>, <dkos@cadence.com>,
        <alicja@cadence.com>, <cwronka@cadence.com>, <sureshp@cadence.com>,
        <rafalc@cadence.com>, <thomas.petazzoni@bootlin.com>, <nm@ti.com>,
        <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <geert@linux-m68k.org>, <linus.walleij@linaro.org>,
        <Xiang.Lin@synaptics.com>, <linux-gpio@vger.kernel.org>,
        <nsekhar@ti.com>, <pgaj@cadence.com>, <peda@axentia.se>,
        <mshettel@codeaurora.org>, <swboyd@chromium.org>,
        <joao.pinto@synopsys.com>
Subject: Re: [PATCH] i3c: master: dw: split dw-i3c-master.c into master and
 bus specific parts
Message-ID: <20181123135004.7fd1cd58@bbrezillon>
In-Reply-To: <6d513e04-3a57-1989-429c-64631101c5a2@synopsys.com>
References: <ade2c1a8d1eb48681b01ccdc9bed22caf5e96c4b.1542904564.git.soares@synopsys.com>
        <20181122210202.6af50fcc@bbrezillon>
        <6d513e04-3a57-1989-429c-64631101c5a2@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 12:39:31 +0000
vitor <vitor.soares@synopsys.com> wrote:

> Hi Boris,
> 
> 
> On 22/11/18 20:02, Boris Brezillon wrote:
> > On Thu, 22 Nov 2018 17:54:54 +0000
> > Vitor Soares <vitor.soares@synopsys.com> wrote:
> >  
> >> From: Vitor Soares <soares@synopsys.com>
> >>
> >> This patch slipts dw-i3c-master.c into three pieces:
> >> 	dw-i3c-master.c - contains the code that interacts directly with the
> >> 	core in master mode.
> >>
> >> 	dw-i3c-platdrv.c - contains the code specific to the platform driver.
> >>
> >> 	dw-i3c-core.h - contains the definitions and declarations shared by
> >> 	dw-i3c-master and dw-i3c-platdrv
> >>
> >> This patch will allow SOC integrators to add their code specific to
> >> DesignWare I3C IP.  
> > Isn't it too early to do this change? Can't we wait until we have a SoC
> > that actually embeds this IP?  
> 
> 
> I'm trying to turn it more flexible so the other can reuse the code.

Looking at the separation you've done here, I don't see why you need
it. All the resources you request are generic, so why not just adding a
new compat in the of_match_table?

> 
> 
> >  
> >> Signed-off-by: Vitor Soares <soares@synopsys.com>
> >> ---
> >>   drivers/i3c/master/Kconfig          |   9 +-
> >>   drivers/i3c/master/Makefile         |   5 +-
> >>   drivers/i3c/master/dw-i3c-core.h    | 214 ++++++++++++++++++++++++++
> >>   drivers/i3c/master/dw-i3c-master.c  | 299 ++----------------------------------
> >>   drivers/i3c/master/dw-i3c-platdrv.c | 112 ++++++++++++++

Just realized the driver is named dw-i3c-master, while the cadence
driver is named i3c-master-cdns.c. I'll send a patch to make that
consistent and follow the initial naming scheme: i3c-master-<ipname>.c.
