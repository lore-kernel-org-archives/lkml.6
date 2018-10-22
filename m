Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E161CC7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D40205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D40205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeJWALm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:11:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54009 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbeJWALm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:11:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 80CA220DE6; Mon, 22 Oct 2018 17:52:35 +0200 (CEST)
Received: from localhost (unknown [185.7.230.214])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3FBCA208B5;
        Mon, 22 Oct 2018 17:52:25 +0200 (CEST)
Date:   Mon, 22 Oct 2018 17:52:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Soeren Moch <smoch@web.de>
Cc:     stable@vger.kernel.org, Andrea Greco <a.greco@4sigma.it>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1307: fix ds1339 wakealarm support
Message-ID: <20181022155224.GS17341@piout.net>
References: <20181022123812.5782-1-smoch@web.de>
 <20181022135757.GQ17341@piout.net>
 <3a6041a9-6fef-c113-5962-caa0a24aca49@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6041a9-6fef-c113-5962-caa0a24aca49@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2018 16:18:13+0200, Soeren Moch wrote:
> Hi,
> 
> Am 22.10.2018 um 15:57 schrieb Alexandre Belloni:
> > Hello,
> >
> > On 22/10/2018 14:38:12+0200, Soeren Moch wrote:
> >> Commit 51ed73eb998a1c79a2b0e9bed68f75a8a2c93b9b ("rtc: ds1340: Add support
> >> for trickle charger.") breaks ds1339 wakealarm support by limiting
> >> accessible registers. Fix this.
> >>
> >> Fixes: 51ed73eb998a ("rtc: ds1340: Add support for trickle charger.")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Soeren Moch <smoch@web.de>
> >> --
> >> Cc: Andrea Greco <a.greco@4sigma.it>
> >> Cc: Alessandro Zummo <a.zummo@towertech.it>
> >> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >> Cc: linux-rtc@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> ---
> >>  drivers/rtc/rtc-ds1307.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> >> index 4b2b4627daeb..71396b62dc52 100644
> >> --- a/drivers/rtc/rtc-ds1307.c
> >> +++ b/drivers/rtc/rtc-ds1307.c
> >> @@ -1384,7 +1384,6 @@ static void ds1307_clks_register(struct ds1307 *ds1307)
> >>  static const struct regmap_config regmap_config = {
> >>  	.reg_bits = 8,
> >>  	.val_bits = 8,
> >> -	.max_register = 0x9,
> > I would prefer having a different regmap_config for chips that have more
> > registers. I guess you could put a pointer to a regmap_config in chip_desc.
> >
> What looks strange to me, the original patch (according to its
> description) enabled trickle charger functionality for a single chip.
> This is something totally different than limiting the register space for
> all chips that are supported by this driver. So this seems to be an
> accident to me. And this causes an regression for ds1339, which was
> supported for years.
> 
> Are there any advantages for limiting the address space of i2c devices?

I would think it was done as a facility to debug the feature because
when max_register is set, regmap will allow you to dump the register
space.

> If we really need this, can we apply this partial revert as regression
> fix (also for stable) and implement the address space limitation separately?
> 

Fine, I'm applying this patch right now.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
