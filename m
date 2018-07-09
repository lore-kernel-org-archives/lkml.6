Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0032C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BAC20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BAC20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932855AbeGIJaJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:30:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45473 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932411AbeGIJaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:30:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 38E4420893; Mon,  9 Jul 2018 11:30:03 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0F5E3203D9;
        Mon,  9 Jul 2018 11:29:53 +0200 (CEST)
Date:   Mon, 9 Jul 2018 11:29:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, a.zummo@towertech.it, t-kristo@ti.com,
        linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc: OMAP: Add support for rtc-only mode
Message-ID: <20180709092952.GF16084@piout.net>
References: <1531116709-20135-1-git-send-email-j-keerthy@ti.com>
 <20180709075553.GA3633@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709075553.GA3633@localhost>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 09:55:53+0200, Johan Hovold wrote:
> On Mon, Jul 09, 2018 at 11:41:49AM +0530, Keerthy wrote:
> > Prepare rtc driver for rtc-only with DDR in self-refresh mode.
> > omap_rtc_power_off now should cater to two features:
> > 
> > 1) RTC plus DDR in self-refresh is power a saving mode where in the
> > entire system including the different voltage rails from PMIC are
> > shutdown except the ones feeding on to RTC and DDR. DDR is kept in
> > self-refresh hence the contents are preserved. RTC ALARM2 is connected
> > to PMIC_EN line once we the ALARM2 is triggered we enter the mode with
> > DDR in self-refresh and RTC Ticking. After a predetermined time an RTC
> > ALARM1 triggers waking up the system[1]. The control goes to bootloader.
> > The bootloader then checks RTC scratchpad registers to confirm it was an
> > rtc_only wakeup and follows a different path, configure bare minimal
> > clocks for ddr and then jumps to the resume address in another RTC
> > scratchpad registers and transfers the control to Kernel. Kernel then
> > restores the saved context. omap_rtc_power_off_program does the ALARM2
> > programming part.
> > 
> >      [1] http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884
> > 
> > 2) Power-off: This is usual poweroff mode. omap_rtc_power_off calls the
> > above omap_rtc_power_off_program function and in addition to that
> > programs the OMAP_RTC_PMIC_REG for any external wake ups for PMIC like
> > the pushbutton and shuts off the PMIC.
> > 
> > Hence the split in omap_rtc_power_off.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> > 
> > Changes in v2:
> > 
> >   * Add details in the commit log.
> >   * Use of_device_is_system_power_controller to check if rtc node is
> >     indeed the system power control instead of manually reading property.
> > 
> >  drivers/rtc/interface.c |  12 ++++
> >  drivers/rtc/rtc-omap.c  | 167 +++++++++++++++++++++++++++++++++---------------
> >  include/linux/rtc.h     |   2 +
> >  3 files changed, 131 insertions(+), 50 deletions(-)
> > 
> > diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> > index 6d4012d..d8b70f0 100644
> > --- a/drivers/rtc/interface.c
> > +++ b/drivers/rtc/interface.c
> > @@ -1139,3 +1139,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
> >  	trace_rtc_set_offset(offset, ret);
> >  	return ret;
> >  }
> > +
> > +/**
> > + * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
> > + * line and can be used to power off the SoC.
> > + *
> > + * Kernel interface to program rtc to power off
> > + */
> > +void rtc_power_off_program(struct rtc_device *rtc)
> > +{
> > +	rtc->ops->power_off_program(rtc->dev.parent);
> > +}
> > +EXPORT_SYMBOL_GPL(rtc_power_off_program);
> 
> We typically do not add new interfaces without any users, so this will
> probably have to go in along with the corresponding omap changes for
> rtc-only mode.
> 

I'm probably not smart enough but I still don't get why you need to add
an interface at all, especially one that will result in a NULL pointer
dereference on 99.6% of the drivers.

This is so specific to your use case that this has zero chance to be
reused by another driver.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
