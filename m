Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BF7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7988E21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7988E21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeHBMIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:08:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48637 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeHBMIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:08:31 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1flAg7-0003BA-A9; Thu, 02 Aug 2018 12:17:55 +0200
Message-ID: <1533205073.3516.17.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "marex@denx.de" <marex@denx.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Date:   Thu, 02 Aug 2018 12:17:53 +0200
In-Reply-To: <c5e9f521edbca4b1b168e4ee6c8fbd41b1ca2261.camel@nxp.com>
References: <f873c5592e9907beba905ce68358d5ae2f63a4d7.1531824173.git.leonard.crestez@nxp.com>
         <1533038097.3444.13.camel@pengutronix.de>
         <c5e9f521edbca4b1b168e4ee6c8fbd41b1ca2261.camel@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 12:17 +0000, Leonard Crestez wrote:
> On Tue, 2018-07-31 at 13:54 +0200, Philipp Zabel wrote:
> > On Tue, 2018-07-17 at 13:48 +0300, Leonard Crestez wrote:
> > > Adding lcdif nodes to a power domain currently does work, it results in
> > > black/corrupted screens or hangs. While the driver does enable runtime
> > > pm it does not deal correctly with the block being unpowered.
> > > 
> > > Ensure power is on when required by adding pm_runtime_get/put_sync to
> > > mxsfb_pipe_enable/disable.
> > > 
> > > Since power is lost on suspend implement PM_SLEEP_OPS using
> > > drm_mode_config_helper_suspend/resume.
> > > 
> > > The mxsfb_plane_atomic_update function can get called before
> > > mxsfb_pipe_enable while the block is not yet powered. When this happens
> > > the write to LCDIF_NEXT_BUF is lost causing corrupt display on unblank
> > > until a refresh.
> > 
> > Why does this happen?
> 
> I'm not sure what you're asking but register writes to unpowered or
> unclocked blocks are not expected to "just work". Here the write is
> ignored/lost but I think on imx8 it can even cause a bus error.
> 
> The approach here is to only set the framebuffer address as part of
> activating the display.

I wonder why atomic update is called at all while the pipe is not
enabled.

regards
Philipp
