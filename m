Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D33DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F2020865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F2020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeK0HCi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:02:38 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41826 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeK0HCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:02:36 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BC1DC20D2E; Mon, 26 Nov 2018 21:07:20 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D4A6C206A1;
        Mon, 26 Nov 2018 21:06:38 +0100 (CET)
Date:   Mon, 26 Nov 2018 21:06:38 +0100
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
Message-ID: <20181126210638.0b8c4ee8@bbrezillon>
In-Reply-To: <b7f59793-aaaa-95ff-fe7d-943e558f65b5@synopsys.com>
References: <ade2c1a8d1eb48681b01ccdc9bed22caf5e96c4b.1542904564.git.soares@synopsys.com>
        <20181122210202.6af50fcc@bbrezillon>
        <6d513e04-3a57-1989-429c-64631101c5a2@synopsys.com>
        <20181123135004.7fd1cd58@bbrezillon>
        <83115f47-1326-cb33-a7dc-4bc8ff95befa@synopsys.com>
        <20181126133550.51469816@bbrezillon>
        <4e9c0461-02a3-80b2-c9b7-2e9ea9b38f8b@synopsys.com>
        <20181126195618.352eafb1@bbrezillon>
        <20181126200855.0caa45b0@bbrezillon>
        <b7f59793-aaaa-95ff-fe7d-943e558f65b5@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 19:28:02 +0000
vitor <vitor.soares@synopsys.com> wrote:

> On 26/11/18 19:08, Boris Brezillon wrote:
> > On Mon, 26 Nov 2018 19:56:18 +0100
> > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> >     
> >>>       - for the others it will easy the SoC integration avoiding
> >>> duplicated work and doing things from scratch.  
> >> What would be duplicated? You want to support a new SoC, just add a new
> >> entry in the of_match_table and you're done. When you need to add
> >> SoC/integration specific stuff, create a struct and attach a different
> >> instance per-compatible so that each SoC can have its own configuration
> >> (or even init sequence if needed). That's how we do for pretty much all
> >> IPs out there, why should designware ones be different?  
> > To be more specific, I'd like a real example that shows why the
> > separation is needed.  
> 
> Ok no problem. We can delay this for PCI and other rules support.

I finally understand what this separation is all about: supporting both
PCI and platform devices. I guess I've been distracted by this sentence:

"
This patch will allow SOC integrators to add their code specific to
DesignWare I3C IP.
"

which for me meant each SoC would have its own platform_driver.

In any case, I think this is a bit premature do this separation, unless
you already know about one integrator planning to expose this IP over
PCI.
