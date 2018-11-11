Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0758C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B262148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B262148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbeKLD7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:59:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50438 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbeKLD7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:59:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A63F9207B8; Sun, 11 Nov 2018 19:10:18 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D1635206A7;
        Sun, 11 Nov 2018 19:10:17 +0100 (CET)
Date:   Sun, 11 Nov 2018 19:10:17 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
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
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Message-ID: <20181111191017.7b2efdf1@bbrezillon>
In-Reply-To: <20181111173932.GA12254@kroah.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
        <20181111173932.GA12254@kroah.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, 11 Nov 2018 09:39:32 -0800
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Oct 26, 2018 at 04:43:24PM +0200, Boris Brezillon wrote:
> > Hi Greg,
> > 
> > I think we've reached a point where we can eventually consider the I3C
> > framework for inclusion in 4.20 (5.0?). A few more issues were reported
> > on v9 and fixed in v10. I can't guarantee that the implementation is
> > free of bugs but I still think it's worth merging it in v4.20: it's a
> > new subsystem, so we don't risk regressions, and the only way we can
> > detect other issues is by having other people experiment with this
> > implementation.
> > 
> > The only remaining concern raised by Arnd is the fact that both hosts
> > and slaves share the same bus type and are differentiated thanks to
> > their device_type, which IMHO is fine since this is what other
> > subsystems do (plus I don't see other solutions to have both I3C
> > devices and I3C buses represented under /sys/bus/i3c/).  
> 
> Yeah, it's not the nicest, but it will work, we did it also for USB and
> greybus and it solves the issue.
> 
> This all looks good to me, so I've queued it up.  Let's see if
> linux-next has any problems with it.

I recently asked Stephen to add the linux-i3c tree to linux-next, so
I'm expecting conflicts :-/. Sorry, I didn't know you were planning to
take these patches through your tree.

BTW, I also fixed a couple of things when rebasing on top of 4.20-rc1:

- KernelVersion in the sysfs ABI doc has been updated to 5.0
- Fixed i3c_master_getmxds_locked() (bug reported/fixed by Colin here
  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1799850.html)
- Removed a blank line at the end of master-driver-api.rst

For the record, the i3c/next branch pulled by Stephen is available here
[1].

> Thanks for sticking with it, nice work!

Thanks for reviewing it! Greg, Stephen, let me know if you want me to
reset i3c/next to v4.20-rc1 to avoid conflicts in linux-next.

Regards,

Boris

[1]https://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git/log/?h=i3c/next
