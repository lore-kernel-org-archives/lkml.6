Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C2ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23E220880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23E220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbeISUgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:36:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36127 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731739AbeISUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:36:49 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g2dvm-0002oC-W8; Wed, 19 Sep 2018 16:58:18 +0200
Message-ID: <1537369098.6816.6.camel@pengutronix.de>
Subject: Re: [PATCH/RFC v4 1/2] reset: Add support for dedicated reset
 controls
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Sep 2018 16:58:18 +0200
In-Reply-To: <20180917163955.19023-2-geert+renesas@glider.be>
References: <20180917163955.19023-1-geert+renesas@glider.be>
         <20180917163955.19023-2-geert+renesas@glider.be>
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

On Mon, 2018-09-17 at 18:39 +0200, Geert Uytterhoeven wrote:
> In some SoCs multiple hardware blocks may share a reset control.
> The existing reset control API for shared resets will only assert such a
> reset when the drivers for all hardware blocks agree.
> The existing exclusive reset control API still allows to assert such a
> reset, but that impacts all other hardware blocks sharing the reset.

I consider requesting exclusive access to a shared reset line a misuse
of the API. Are there such cases? Can they be fixed?

> Sometimes a driver needs to reset a specific hardware block, and be 100%
> sure it has no impact on other hardware blocks.  This is e.g. the case
> for virtualization with device pass-through, where the host wants to
> reset any exported device before and after exporting it for use by the
> guest, for isolation.
> 
> Hence a new flag for dedicated resets is added to the internal methods,
> with a new public reset_control_get_dedicated() method, to obtain an
> exclusive handle to a reset that is dedicated to one specific hardware
> block.

I'm not sure a new flag is necessary, this is what exclusive resets
should be.
Also I fear there will be confusion about the difference between
exclusive (refering to the reset control) and dedicated (refering to
the reset line) reset controls.

> This supports both DT-based and lookup-based reset controls.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - New.
> 
> Notes:
>   - Dedicated lookup-based reset controls were not tested,
>   - Several internal functions now take 3 boolean flags, and should
>     probably be converted to take a bitmask instead,

In case we have to add more flags, yes.

>   - I think __device_reset() should call __reset_control_get() with
>     dedicated=true.  However, that will impact existing users,

Which ones? And how?

>   - Should a different error than -EINVAL be returned on failure?
> ---
>  drivers/reset/core.c  | 76 ++++++++++++++++++++++++++++++++++++++-----
>  include/linux/reset.h | 60 ++++++++++++++++++++++------------
>  2 files changed, 107 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 225e34c56b94a2e3..5bc4eeca70c0fcc2 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -459,9 +459,38 @@ static void __reset_control_put_internal(struct reset_control *rstc)
>  	kref_put(&rstc->refcnt, __reset_control_release);
>  }
>  
> +static bool __of_reset_is_dedicated(const struct device_node *node,
> +				    const struct of_phandle_args args)
> +{
> +	struct of_phandle_args args2;
> +	struct device_node *node2;
> +	int index, ret;
> +
> +	for_each_node_with_property(node2, "resets") {
> +		if (node == node2)
> +			continue;
> +
> +		for (index = 0; ; index++) {
> +			ret = of_parse_phandle_with_args(node2, "resets",
> +							 "#reset-cells", index,
> +							 &args2);
> +			if (ret)
> +				break;
> +
> +			if (args2.np == args.np &&
> +			    args2.args_count == args.args_count &&
> +			    !memcmp(args2.args, args.args,
> +				    args.args_count * sizeof(args.args[0])))
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}

I want to hear the device tree maintainers' opinion about this.
I'd very much like to have such a check for exclusive resets, but my
understanding is that we are not allowed to make the assumption that
other nodes' "reset" properties follow the common reset signal device
tree bindings.

Maybe this is something that should be checked in a device tree
validation step?

regards
Philipp
