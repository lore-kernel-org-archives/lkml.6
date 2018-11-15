Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16962C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC214223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC214223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbeKOXGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:06:23 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40123 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbeKOXGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:06:23 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 905D220D73; Thu, 15 Nov 2018 13:58:35 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5F06E20D92;
        Thu, 15 Nov 2018 13:57:32 +0100 (CET)
Date:   Thu, 15 Nov 2018 13:57:31 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <vitor.soares@synopsys.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
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
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Message-ID: <20181115135731.25f60990@bbrezillon>
In-Reply-To: <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
        <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mark Brown for the question about /dev/spidev

Hi Vitor,

On Thu, 15 Nov 2018 12:14:37 +0000
vitor <vitor.soares@synopsys.com> wrote:

> Hi Boris,
> 
> Given the current state of the subsystem I think it might worth start to 
> think how to expose the devices under /dev.

Thanks for starting this discussion. I'm not against the idea in
general, we just need to be careful when doing that.

> My initial thoughts are to do the same think as for i2c, expose the 
> buses or the i3c_devices and use ioctl for private transfers.

Exposing the bus is dangerous IMO, because an I3C bus is not like an
I2C bus:

   * I3C device needs to be discovered through DAA
   * I2C devices need to be declared ahead of time, and LVR is used to
     determine the limitations on the bus at runtime

So you'd anyway be able to interact only with devices that have
previously been discovered.

Note that the virtual I2C bus is already exposed, but any command
targeting an address that is not attached to a registered I2C dev will
get a -ENOENT error.

What we could do though, is expose I3C devices that do not have a
driver in kernel space, like spidev does.

> Some 
> direct CCC commands can be sent through the /sys as you plan for SETNEWDA .

Yes, CCC commands that need to be exposed to userspace should be
exposed through sysfs, or, if we decide to create a /dev/i3cX device
per bus, through ioctls.

> 
> What do you think about this?

I think this request is perfectly valid, we just need to decide how it
should be done, and before we take this decision, I'd like to get
inputs from other maintainers.

Mark, Wolfram, Arnd, Greg, any opinion?

Regards,

Boris
