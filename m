Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690FDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F60214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfA1L0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:26:52 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37657 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1L0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:26:52 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1go53w-0004ZZ-ET; Mon, 28 Jan 2019 12:26:48 +0100
Message-ID: <1548674808.6421.3.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Don't WARN if trying to get a used reset control
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 28 Jan 2019 12:26:48 +0100
In-Reply-To: <20190125101554.5947-1-thierry.reding@gmail.com>
References: <20190125101554.5947-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Fri, 2019-01-25 at 11:15 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> When requesting a reset control for exclusive use that's already in use,
> an -EBUSY error code is returned. Users can react accordingly when they
> receive that error code, so there is no need to loudly complain.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/reset/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 9582efb70025..6b452f010b66 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -416,7 +416,7 @@ static struct reset_control *__reset_control_get_internal(
>  
>  	list_for_each_entry(rstc, &rcdev->reset_control_head, list) {
>  		if (rstc->id == index) {
> -			if (WARN_ON(!rstc->shared || !shared))
> +			if (!rstc->shared || !shared)
>  				return ERR_PTR(-EBUSY);
>  
>  			kref_get(&rstc->refcnt);

Are you actually running into this somewhere?

My reason for adding these warnings was that these point to either a DT
misconfiguration or a driver bug, and the verbose warning helps to
quickly identify the actual issue. This is not an error condition that
I would expect on a correctly configured system.

I don't expect most drivers give a proper error message that contains
the -EBUSY return value. Usually it's just along the lines of "failed to
get reset control" without any further indication.

regards
Philipp
