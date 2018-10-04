Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD0CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1690F213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1690F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeJDRHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:07:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50845 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeJDRHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:07:42 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g80el-0001Pj-Gt; Thu, 04 Oct 2018 12:14:55 +0200
Message-ID: <1538648094.14153.8.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: Exclusive resets must be dedicated to a
 single hardware block
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Thu, 04 Oct 2018 12:14:54 +0200
In-Reply-To: <20180927180038.24599-1-geert+renesas@glider.be>
References: <20180927180038.24599-1-geert+renesas@glider.be>
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

Hi Geert,

Thank you for the patch. I'd still like to hear the device tree
maintainers' (added to Cc:) opinion on parsing the whole DT for "resets"
phandle properties to find shared resets like this.

On Thu, 2018-09-27 at 20:00 +0200, Geert Uytterhoeven wrote:
> In some SoCs multiple hardware blocks may share a reset control.
> The reset control API for shared resets will only assert such a reset
> when the drivers for all hardware blocks agree.
> The exclusive reset control API still allows to assert such a reset, but
> that impacts all other hardware blocks sharing the reset.
> 
> While the kernel doc comments clearly state that the API for shared
> resets applies to reset controls which are shared between hardware
> blocks, the exact meaning of exclusive resets is not documented.
> Fix the semantic ambiguity with respect to exclusive access vs.
> exclusive reset lines by:
>   1. Clarifying that exclusive resets really are intended for use with
>      reset controls which are dedicated to a single hardware block,
>   2. Ensuring that obtaining an exclusive reset control will fail if the
>      reset is shared by multiple hardware blocks, for both DT-based and
>      lookup-based reset controls.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is v2 of "[RFC] reset: Add support for dedicated reset controls":
>   - Fix wrong variable in __reset_is_dedicated() loop,
>   - Add missing of_node_put() in __of_reset_is_dedicated(),
>   - Document that exclusive reset controls imply they are dedicated to a
>     single hardware block,
>   - Drop new dedicated flag and new API reset_control_get_dedicated(),
>     as exclusive already implies dedicated,
>   - Rename {__of_,}reset_is_dedicated() to {__of_,}reset_is_exclusive(),
>   - Reword description.
> 
> Note: Exclusive lookup-based reset controls were not tested.
> ---
>  drivers/reset/core.c  | 58 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/reset.h |  5 +++-
>  2 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 225e34c56b94a2e3..2f5b61226c7964eb 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -459,6 +459,38 @@ static void __reset_control_put_internal(struct reset_control *rstc)
>  	kref_put(&rstc->refcnt, __reset_control_release);
>  }
>  
> +static bool __of_reset_is_exclusive(const struct device_node *node,
> +				    const struct of_phandle_args args)
> +{
> +	struct of_phandle_args args2;
> +	struct device_node *node2;
> +	int index, ret;
> +	bool eq;

I suppose it is very unlikely to get false positives where an arbitrary
node contains a "resets" property that looks like a proper phandle to an
actual reset-controller node.
Are we allowed though to scan the whole tree for "resets" properties
regardless of the nodes' bindings or compatible properties like this?

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
> +			eq = (args2.np == args.np &&
> +			      args2.args_count == args.args_count &&
> +			      !memcmp(args2.args, args.args,
> +				      args.args_count * sizeof(args.args[0])));
> +			of_node_put(args2.np);
> +			if (eq)

Emitting a loud warning here could be very helpful if it contains
both the reset controller node and the reset index, as well as the
consumer nodes: node and node2.

> +				return false;
> +		}
> +	}
> +	return true;
> +}
> +
>  struct reset_control *__of_reset_control_get(struct device_node *node,
>  				     const char *id, int index, bool shared,
>  				     bool optional)
> @@ -514,6 +546,11 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
>  		return ERR_PTR(rstc_id);
>  	}
>  
> +	if (!shared && !__of_reset_is_exclusive(node, args)) {
> +		mutex_unlock(&reset_list_mutex);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>  	/* reset_list_mutex also protects the rcdev's reset_control list */
>  	rstc = __reset_control_get_internal(rcdev, rstc_id, shared);
>  
> @@ -541,6 +578,22 @@ __reset_controller_by_name(const char *name)
>  	return NULL;
>  }
>  
> +static bool __reset_is_exclusive(const struct reset_control_lookup *lookup)
> +{
> +	const struct reset_control_lookup *lookup2;
> +
> +	list_for_each_entry(lookup2, &reset_lookup_list, list) {
> +		if (lookup2 == lookup)
> +			continue;
> +
> +		if (lookup2->provider == lookup->provider &&
> +		    lookup2->index == lookup->index)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static struct reset_control *
>  __reset_control_get_from_lookup(struct device *dev, const char *con_id,
>  				bool shared, bool optional)
> @@ -562,6 +615,11 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
>  		if ((!con_id && !lookup->con_id) ||
>  		    ((con_id && lookup->con_id) &&
>  		     !strcmp(con_id, lookup->con_id))) {
> +			if (!shared && !__reset_is_exclusive(lookup)) {
> +				mutex_unlock(&reset_lookup_mutex);
> +				return ERR_PTR(-EINVAL);
> +			}
> +
>  			mutex_lock(&reset_list_mutex);
>  			rcdev = __reset_controller_by_name(lookup->provider);
>  			if (!rcdev) {
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 29af6d6b2f4b8103..5881d2594761e48f 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -116,8 +116,11 @@ static inline int device_reset_optional(struct device *dev)
>   * @id: reset line name
>   *
>   * Returns a struct reset_control or IS_ERR() condition containing errno.
> - * If this function is called more than once for the same reset_control it will
> + * If this function is called more than once for the same reset control it will
>   * return -EBUSY.
> + * This function is intended for use with reset controls which are dedicated
> + * to a single hardware block.  If called for a reset control shared among
> + * multiple hardware blocks, it will return -EINVAL.
>   *
>   * See reset_control_get_shared for details on shared references to
>   * reset-controls.

regards
Philipp
