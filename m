Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58172C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 10:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17E824B53
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 10:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17E824B53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeFWKRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 06:17:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43315 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbeFWKRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 06:17:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 42EBA20720; Sat, 23 Jun 2018 12:17:06 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8001C203B0;
        Sat, 23 Jun 2018 12:17:05 +0200 (CEST)
Date:   Sat, 23 Jun 2018 12:17:05 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v5 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180623121705.1d618c5d@bbrezillon>
In-Reply-To: <ed1add9b-ba21-d3d3-64c4-44d18af3d133@axentia.se>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-2-boris.brezillon@bootlin.com>
        <ed1add9b-ba21-d3d3-64c4-44d18af3d133@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, 22 Jun 2018 23:35:34 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-06-22 12:49, Boris Brezillon wrote:
> > Add core infrastructure to support I3C in Linux and document it.
> > 
> > This infrastructure is not complete yet and will be extended over
> > time.
> > 
> > There are a few design choices that are worth mentioning because they
> > impact the way I3C device drivers can interact with their devices:
> > 
> > - all functions used to send I3C/I2C frames must be called in
> >   non-atomic context. Mainly done this way to ease implementation, but
> >   this is still open to discussion. Please let me know if you think
> >   it's worth considering an asynchronous model here
> > - the bus element is a separate object and is not implicitly described
> >   by the master (as done in I2C). The reason is that I want to be able
> >   to handle multiple master connected to the same bus and visible to
> >   Linux.
> >   In this situation, we should only have one instance of the device and
> >   not one per master, and sharing the bus object would be part of the
> >   solution to gracefully handle this case.
> >   I'm not sure we will ever need to deal with multiple masters
> >   controlling the same bus and exposed under Linux, but separating the
> >   bus and master concept is pretty easy, hence the decision to do it
> >   like that.
> >   The other benefit of separating the bus and master concepts is that
> >   master devices appear under the bus directory in sysfs.  
> 
> Are bus multiplexers relevant to I3C?

Not yet, but who knows.

> The locking needed for handling
> muxes for I2C is, well, convoluted...

Do you remember what was the problem?

Anyway, I'd really like to have basic support upstreamed before we
start considering advanced use cases that do not exist yet. Don't get
me wrong, I'm not against having the multiplexer/locking discussion,
but it should not block inclusion of the I3C subsystem.

Regards,

Boris
