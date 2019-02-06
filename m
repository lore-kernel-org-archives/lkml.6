Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC5CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C889E2080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfBFP47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:56:59 -0500
Received: from muru.com ([72.249.23.125]:37804 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfBFP46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:56:58 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 934AA80D4;
        Wed,  6 Feb 2019 15:57:06 +0000 (UTC)
Date:   Wed, 6 Feb 2019 07:56:54 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux@armlinux.org.uk, khilman@kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Message-ID: <20190206155654.GX5720@atomide.com>
References: <20190202055827.12956-1-andreas@kemnade.info>
 <20190204155604.GH5720@atomide.com>
 <20190204193311.102a60e6@kemnade.info>
 <20190204184317.GO5720@atomide.com>
 <20190206073732.35ad315f@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206073732.35ad315f@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190206 06:38]:
> But wait... twl4030-power.c is to a big part about switching regulators
> on and off. But how does that connect to hwmods going to ret or off
> mode? That is imho slightly another topic.

The pmic wiring is what must be configured for the regulators
to actually get cut off. And the wiring may or may not be done
properly.

The SoC powerdomain bit to attempt off mode is a policy type
decision and should not be configured in the device tree.

> Ok, looking a bit closer, there is the sys_off_mode line
> which needs to be used.
> So we have to derive that from the devicetree.

Yes but that still does not mean it's wired right to the
PMIC :) We do have devices where sys_off_mode and sys_clkreq
lines are swapped for example. So enabling off mode really
should be only allowed if the PMIC is configured right.

And we also support devices that do muxing in the bootloader
like all the Nokia devices do except for dynamic pins.

I guess reading how the sys_clkreq is configured might
work, but not necessarily until the PMIC driver has probed
depending which device handles the muxing. And it won't
work for devices with lines swapped.

> > The PMIC is wired and configured for off mode, and those
> > properties should not be set unless the system is truly capable
> > of entering off mode. If not set, we should not enable off
> > idle by default.
> > 
> > Otherwise the boards should be already using just
> > "ti,twl4030-power" or "ti,twl4030-power-reset".
> > 
> We have also
> ti,twl4030-power-omap3-sdp,
> ti,twl4030-power-omap3-ldp,
> ti,twl4030-power-omap3-evm
> 
> so we have to maintain a list, especially if we want to allow another
> pmic.

Oops so it seems. Those are all early devices with their
own quirks. Anyways, that list is unlikely to change
any longer for twl4030.

> But since it is about connecting the soc to the pmic, we could also add a
> flag in the dtb on the soc side, so we are prepared if someone uses another
> pmic. It feels a bit strange to query something from devicetree for another
> device.

Well if you have something that actually describes the hardware
in mind for the SoC, sure. But let's not start adding any policy
flags to the dts.

Any other pmics would need their own checks to determine if
off mode is configured. It might depend on the firmware on the
pmic for example. But I don't think we need to worry about that
right now since we don't have any such users in the mainline
kernel.

> PS: I hope my omap-gta04.dtsi-related patches have made their way into
> your review queue and are not starving in a generic lkml fallback folder

Yup I should have the thread tagged in my inbox.

Regards,

Tony
