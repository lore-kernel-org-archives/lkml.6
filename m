Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54FBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E222087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E222087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390043AbeKQCOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:14:35 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56059 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKQCOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:14:35 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gNgYk-0002H4-Jt; Fri, 16 Nov 2018 17:01:30 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gNgYj-0001iK-1p; Fri, 16 Nov 2018 17:01:29 +0100
Date:   Fri, 16 Nov 2018 17:01:28 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/6] clk: Add of_clk_get_by_name_optional() function
Message-ID: <20181116160128.pkuya6rwqm4schdn@pengutronix.de>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-2-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181116145937.27660-2-phil.edworthy@renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 02:59:32PM +0000, Phil Edworthy wrote:
> Quite a few drivers get an optional clock, e.g. a clock required to
> access a peripheral's registers that is always enabled on some devices.
> This adds the of_clk_get_by_name_optional() function for this purpose.
> 
> This function behaves the same as of_clk_get_by_name() except that it
> will return NULL instead of -ENOENT. This allows for simpler error
> handling in the callers.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> *Warning*
> This changes the return values for of_clk_get_by_name() in some cases.
> If the name arg is non-NULL, and the "clock-names" OF property can't be
> found or the name is not in that prop, the code used to return -EINVAL,
> but will now return -ENOENT.
> Note that before and after this patch, if name=NULL and no "clocks" OF
> property has been found, of_clk_get_by_name() returns -ENOENT.
> 
> I believe the new behaviour is correct. I cannot find any callers to
> of_clk_get_by_name() that explicitly check for -EINVAL or -ENOENT, but
> there is the possibility that something will break at runtime with this
> change.
> 
> v6:
>  - Rework the __of_clk_get_by_name() logic so as to avoid duplicate tests.
> v5:
>  - Simplified the code by handling all the error conditions on exit
> v4:
>  - For optional named clocks of_property_match_string() will return
>    -EINVAL if the "clock-names" property is missing, or -ENODATA if
>    the specified clock name in the "clock-names" property is missing.
>    If we then call __of_clk_get() with these errors as the index, we
>    get clk = -EINVAL. This is then filtered later on so users don't
>    see it. However, if the clock is not named, __of_clk_get() will
>    return -ENOENT is the clock provide is not there.
>    So for optional named clocks, use index to determine if the clock
>    provider is there or not, and for unnamed clocks, simply check if
>    __of_clk_get() returns -ENOENT.
> 
> v3:
>  - Fix check for clock not present. __of_clk_get() returns -EINVAL
>    if it's not there. Cover case of when there is no clock name.
>  - of_clk_get_by_name_optional() should return NULL if !np.
>  - Add dummy version of of_clk_get_by_name_optional() for the
>    !OF || !COMMON_CLK case.
> ---
>  drivers/clk/clkdev.c | 76 ++++++++++++++++++++++++++++++++++++--------
>  include/linux/clk.h  |  6 ++++
>  2 files changed, 69 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 9ab3db8b3988..0c655d1ba1d9 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -52,9 +52,19 @@ struct clk *of_clk_get(struct device_node *np, int index)
>  }
>  EXPORT_SYMBOL(of_clk_get);
>  
> +/*
> + * This function tries to find a clock provider.
> + * If a name is provided, the function looks for a clock with that name in the
> + * OF node's "clock-names" property. If not found, the function will try the
> + * parent node and so on until a matching property is found or we reach the
> + * top of the tree.

I think the comment here could be improved. I think if you replace the
last sentence by:

	If not found (i.e. either there is no "clock-names" property or
	the "clock-names" property doesn't include the name to look up),
	the function will try the parent node and so on until ...

Other than that I think the patch is fine, but maybe it would be easier
to review if you split it in two patches. The first patch to implement
the changed behaviour you mention in the warning above and only then the
addition of the optional handling.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
