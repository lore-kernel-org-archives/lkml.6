Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BABBECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0687520C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0687520C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbeGQNyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:54:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56025 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbeGQNyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:54:05 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ffPur-0004W1-Dy; Tue, 17 Jul 2018 15:21:21 +0200
Message-ID: <1531833680.3468.8.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx: Remove unused field imx_drm_device.pipes
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Liu Ying <gnuiyl@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Date:   Tue, 17 Jul 2018 15:21:20 +0200
In-Reply-To: <69a927983d003e7ebfbd19cbc940c5e2a13b9473.1531828221.git.leonard.crestez@nxp.com>
References: <69a927983d003e7ebfbd19cbc940c5e2a13b9473.1531828221.git.leonard.crestez@nxp.com>
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

On Tue, 2018-07-17 at 15:11 +0300, Leonard Crestez wrote:
> This has been unused since commit 44b460cfe554 ("drm: imx: remove struct
> imx_drm_crtc and imx_drm_crtc_helper_funcs")
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied to imx-drm/next, thank you.

> ---
>  drivers/gpu/drm/imx/imx-drm-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> Looking at the imx_drm_device struct it is only used to save the
> drm_atomic_helper_suspend state. It seems like this could be replaced
> with drm_mode_config_helper_suspend/resume and the entire struct
> removed.
> 
> The only difference between imx_drm_suspend/resume and
> drm_mode_config_helper_suspend/resume is that the latter also suspends
> the fb_helper. This would be an improvement, right?

This looks about right to me. We currently don't call the
fbdev suspend/resume notifiers at all. The correct call
would be drm_fbdev_cma_set_suspend_unlocked instead of
drm_fb_helper_set_suspend_unlocked, though.

Since drm_fb_cma_fbdev_init registers its fb_helper with the
drm_device via drm_fb_helper_init, both (currently) do exactly
the same thing.

regards
Philipp
