Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03005214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CkncJYsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfA2Jeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:34:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54566 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfA2Jeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:34:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so17000893wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1Zjq2WctcVH0NKa5Tr4dSEzjz+ChEkhVWBArMb0P8po=;
        b=CkncJYsMm+JGbzg82cfofdGvTqxmkWgqW0bDLaHeuQeZBMHhfu25PBVX/30yj3zpoG
         qF+SmOo3PRaadhhiBZ+I6oCiM4zd9T2cAfmzlLWaL3pwJbErpXNSx3OJRKG9sL7qsRZb
         jr3WRFFgBcf+/WfUQEFK5pOP5irQD4d2LjSBMxHIWSEZFwBQGRmcYdUMX/ocbfwOcWXS
         2U0fAZ2q2bn9YwYE7mrnwsHwSvQH2gRJyBGLpPqGMo1cE9/hm/vls8mkfDCl/3ulfj4D
         5t9+M+Q9O+Yr1Ps9jrTfppIPevx+JFbzKyHl/kH3hcozlUO8+shGPn+B+LGhgQrJongz
         RwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1Zjq2WctcVH0NKa5Tr4dSEzjz+ChEkhVWBArMb0P8po=;
        b=gaUZpNyk4ISkif31i+zBeEl8N9AQULqPb7gUX1MV4pT9WURlVMH7n3hud825Trgqzf
         6jt4tO8U94sWKTR+fT55RAsxWM/D1q1bO/Dq1DN2saJ7t9F+FQHneAd7RNn3X1/zU+Uq
         jBNyqt3VTshzQg9Odw2okf6c0FcxjqfPlVusN3dGU9oCtfhJts9LyxZKhbXdFROer5h0
         chf1VvWVDVPIHrwf299oaytw2Tkvv58cW86kJ9FI5O8KUBPIHNBgYuR0bd9kDtlcnnAH
         guxRDeTQHFJpsLf7dIwV9/DwrlQ23FHuo+sKZHeXeao1ge4zukqpBFoDTRb/jB/ilRm+
         gZgw==
X-Gm-Message-State: AJcUukf++5aNfI0+1JWKEA7Dy4SqF5Z3APRl7zf6mPFbTcxqYFjSbOCE
        CKFUO7zGe7YaLGEOMxXdpcY/TQ==
X-Google-Smtp-Source: ALg8bN7+dLDfuO2x1tDJ5n9rPOD1Z6B27kcoSuha61cgb9aAwBTkiDtgKJSYlL92cLyzuMZpNI3F4A==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr20397996wmf.3.1548754481215;
        Tue, 29 Jan 2019 01:34:41 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id f187sm1568856wma.4.2019.01.29.01.34.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 29 Jan 2019 01:34:40 -0800 (PST)
Message-ID: <e303573aefeaf6a7e3a4b1d820e801354ff900b4.camel@baylibre.com>
Subject: Re: [PATCH 2/9] clk: Introduce get_parent_hw clk op
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Date:   Tue, 29 Jan 2019 10:34:38 +0100
In-Reply-To: <20190129061021.94775-3-sboyd@kernel.org>
References: <20190129061021.94775-1-sboyd@kernel.org>
         <20190129061021.94775-3-sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-28 at 22:10 -0800, Stephen Boyd wrote:
> The clk_ops::get_parent function is limited in ability to return errors
> because it returns a u8. A "workaround" to return an error is to return
> a number >= the number of parents of a clk. This will in turn cause the
> framework to "orphan" the clk and make the parent of the clk NULL. This
> isn't really correct, because if an error occurs while reading the
> parents of a clk we should fail the clk registration, instead of
> orphaning the clk and waiting for the clk to appear later.
> 
> We really need to have three different return values from the get_parent
> clk op. Something valid for a clk that exists, something invalid for a
> clk that doesn't exist and never will exist or can't be determined
> because the register operation to read the parent failed, and something
> for a clk that doesn't exist because the framework doesn't know about
> what it is. Introduce a new clk_op that can express all of this by
> returning a pointer to the clk_hw of the parent. It's expected that clk
> provider drivers will return a valid pointer when the parent is
> findable, an error pointer like EPROBE_DEFER if their parent provider
> hasn't probed yet but is valid, a NULL pointer if they can't find the
> clk but index is valid, and an error pointer with an appropriate error
> code otherwise.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c            | 117 ++++++++++++++++++++++++++---------
>  include/linux/clk-provider.h |   9 +++
>  2 files changed, 96 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 01b36f0851bd..5d82cf25bb29 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2242,14 +2242,84 @@ struct clk *clk_get_parent(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_get_parent);
>  
> -static struct clk_core *__clk_init_parent(struct clk_core *core)
> +static struct clk_core *
> +__clk_init_parent(struct clk_core *core, bool update_orphan)
>  {
>  	u8 index = 0;
> +	struct clk_hw *parent_hw = NULL;
>  
> -	if (core->num_parents > 1 && core->ops->get_parent)
> -		index = core->ops->get_parent(core->hw);
> +	if (core->ops->get_parent_hw) {
> +		parent_hw = core->ops->get_parent_hw(core->hw);
> +		/*
> +		 * The provider driver doesn't know what the parent is,
> +		 * but it's at least something valid, so it's not an
> +		 * orphan, just a clk with some unknown parent.
> +		 */

I suppose this is the answer the discussion we had last year. I'm not sure it
answer the problem. In the case I presented, we have no idea wether the
setting is valid or not.

We can't assume it is `at least something valid`, the value in the mux is just
something we can't map.

Aslo, could you provide an example of what such callback would be, with clk-
mux maybe ?

I don't get how a clock driver will keep track of the clk_hw pointers it is
connected to. Is there an API for this ? clk-mux must access to clk_core to
explore his own parent ... which already does not scale well, expect if we
plan to expose clk_core at some point ?

> +		if (!parent_hw && update_orphan)
> +			core->orphan = false;
> +	} else {
> +		if (core->num_parents > 1 && core->ops->get_parent)

I still get why, when num_parents == 1, it is OK to call get_parent_hw() and
no get_parent(). It does not seems coherent.

> +			index = core->ops->get_parent(core->hw);
> +
> +		parent_hw = clk_hw_get_parent_by_index(core->hw, index);
> +	}
> +
> +	if (IS_ERR(parent_hw)) {
> +		/* Parent clk provider hasn't probed yet, orphan it */
> +		if (PTR_ERR(parent_hw) == -EPROBE_DEFER) {
> +			if (update_orphan)
> +				core->orphan = true;
> +
> +			return NULL;
> +		}
> +
> +		return ERR_CAST(parent_hw);
> +	}
> +
> +	if (!parent_hw)
> +		return NULL;
> +
> +	return parent_hw->core;
> +}
> +
> +static int clk_init_parent(struct clk_core *core)
> +{
> +	core->parent = __clk_init_parent(core, true);
> +	if (IS_ERR(core->parent))
> +		return PTR_ERR(core->parent);
> +
> +	/*
> +	 * Populate core->parent if parent has already been clk_core_init'd.
> If
> +	 * parent has not yet been clk_core_init'd then place clk in the
> orphan
> +	 * list.  If clk doesn't have any parents then place it in the root
> +	 * clk list.
> +	 *
> +	 * Every time a new clk is clk_init'd then we walk the list of orphan
> +	 * clocks and re-parent any that are children of the clock currently
> +	 * being clk_init'd.
> +	 */
> +	if (core->parent) {
> +		hlist_add_head(&core->child_node,
> +				&core->parent->children);
> +		core->orphan = core->parent->orphan;
> +	} else if (!core->num_parents) {
> +		hlist_add_head(&core->child_node, &clk_root_list);
> +		core->orphan = false;
> +	} else {
> +		hlist_add_head(&core->child_node, &clk_orphan_list);
> +	}
> +
> +	return 0;
> +}
>  
> -	return clk_core_get_parent_by_index(core, index);
> +static struct clk_core *clk_find_parent(struct clk_core *core)
> +{
> +	return __clk_init_parent(core, false);
> +}
> +
> +static bool clk_has_parent_op(const struct clk_ops *ops)
> +{
> +	return ops->get_parent || ops->get_parent_hw;
>  }
>  
>  static void clk_core_reparent(struct clk_core *core,
> @@ -3045,14 +3115,14 @@ static int __clk_core_init(struct clk_core *core)
>  		goto out;
>  	}
>  
> -	if (core->ops->set_parent && !core->ops->get_parent) {
> +	if (core->ops->set_parent && !clk_has_parent_op(core->ops)) {
>  		pr_err("%s: %s must implement .get_parent & .set_parent\n",
>  		       __func__, core->name);
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	if (core->num_parents > 1 && !core->ops->get_parent) {
> +	if (core->num_parents > 1 && !clk_has_parent_op(core->ops)) {
>  		pr_err("%s: %s must implement .get_parent as it has multi
> parents\n",
>  		       __func__, core->name);
>  		ret = -EINVAL;
> @@ -3073,29 +3143,9 @@ static int __clk_core_init(struct clk_core *core)
>  				"%s: invalid NULL in %s's .parent_names\n",
>  				__func__, core->name);
>  
> -	core->parent = __clk_init_parent(core);
> -
> -	/*
> -	 * Populate core->parent if parent has already been clk_core_init'd.
> If
> -	 * parent has not yet been clk_core_init'd then place clk in the
> orphan
> -	 * list.  If clk doesn't have any parents then place it in the root
> -	 * clk list.
> -	 *
> -	 * Every time a new clk is clk_init'd then we walk the list of orphan
> -	 * clocks and re-parent any that are children of the clock currently
> -	 * being clk_init'd.
> -	 */
> -	if (core->parent) {
> -		hlist_add_head(&core->child_node,
> -				&core->parent->children);
> -		core->orphan = core->parent->orphan;
> -	} else if (!core->num_parents) {
> -		hlist_add_head(&core->child_node, &clk_root_list);
> -		core->orphan = false;
> -	} else {
> -		hlist_add_head(&core->child_node, &clk_orphan_list);
> -		core->orphan = true;
> -	}
> +	ret = clk_init_parent(core);
> +	if (ret)
> +		goto out;
>  
>  	/*
>  	 * optional platform-specific magic
> @@ -3173,7 +3223,14 @@ static int __clk_core_init(struct clk_core *core)
>  	 * parent.
>  	 */
>  	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node)
> {
> -		struct clk_core *parent = __clk_init_parent(orphan);
> +		struct clk_core *parent = clk_find_parent(orphan);
> +
> +		/*
> +		 * Error parent should have been caught before and returned
> +		 * as an error during registration.
> +		 */
> +		if (WARN_ON_ONCE(IS_ERR(parent)))
> +			continue;
>  
>  		/*
>  		 * We need to use __clk_set_parent_before() and _after() to
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 60c51871b04b..8b84dee942bf 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -155,6 +155,14 @@ struct clk_duty {
>   *		multiple parents.  It is optional (and unnecessary) for clocks
>   *		with 0 or 1 parents.
>   *
> + * @get_parent_hw: Queries the hardware to determine the parent of a
> clock.  The
> + *		return value is a clk_hw pointer corresponding to
> + *		the parent clock. In short, this function translates the
> parent
> + *		value read from hardware into a pointer to the clk_hw for that
> clk.
> + *		Currently only called when the clock is initialized by
> + *		__clk_init.  This callback is mandatory for clocks with
> + *		multiple parents.  It is optional for clocks with 0 or 1
> parents.
> + *

The comments above could imply that get_parent() and get_parent_hw() are both
mandatory if num_parent > 1. (I don't think so but) Is this your intent ?

>   * @set_rate:	Change the rate of this clock. The requested rate is
> specified
>   *		by the second argument, which should typically be the return
>   *		of .round_rate call.  The third argument gives the parent rate
> @@ -238,6 +246,7 @@ struct clk_ops {
>  					  struct clk_rate_request *req);
>  	int		(*set_parent)(struct clk_hw *hw, u8 index);
>  	u8		(*get_parent)(struct clk_hw *hw);
> +	struct clk_hw * (*get_parent_hw)(struct clk_hw *hw);
>  	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
>  				    unsigned long parent_rate);
>  	int		(*set_rate_and_parent)(struct clk_hw *hw,


