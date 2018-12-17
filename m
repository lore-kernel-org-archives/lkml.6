Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C6AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C842145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbeLQKwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:52:36 -0500
Received: from ozlabs.org ([203.11.71.1]:53115 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbeLQKwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:52:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JHzj23Kwz9sBh;
        Mon, 17 Dec 2018 21:52:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     frowand.list@gmail.com, robh+dt@kernel.org,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] of: __of_detach_node() - remove node from phandle cache
In-Reply-To: <1545033396-24485-3-git-send-email-frowand.list@gmail.com>
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com> <1545033396-24485-3-git-send-email-frowand.list@gmail.com>
Date:   Mon, 17 Dec 2018 21:52:28 +1100
Message-ID: <871s6gv30z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

frowand.list@gmail.com writes:
> From: Frank Rowand <frank.rowand@sony.com>
>
> Non-overlay dynamic devicetree node removal may leave the node in
> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
> will incorrectly find the stale entry.  Remove the node from the
> cache.
>
> Add paranoia checks in of_find_node_by_phandle() as a second level
> of defense (do not return cached node if detached, do not add node
> to cache if detached).
>
> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---

Similarly here can we add:

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
Cc: stable@vger.kernel.org # v4.17+


Thanks for doing this series.

Some minor comments below.

> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 6c33d63361b8..ad71864cecf5 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -162,6 +162,27 @@ int of_free_phandle_cache(void)
>  late_initcall_sync(of_free_phandle_cache);
>  #endif
>  
> +/*
> + * Caller must hold devtree_lock.
> + */
> +void __of_free_phandle_cache_entry(phandle handle)
> +{
> +	phandle masked_handle;
> +
> +	if (!handle)
> +		return;

We could fold the phandle_cache check into that if and return early for
both cases couldn't we?

> +	masked_handle = handle & phandle_cache_mask;
> +
> +	if (phandle_cache) {

Meaning this wouldn't be necessary.

> +		if (phandle_cache[masked_handle] &&
> +		    handle == phandle_cache[masked_handle]->phandle) {
> +			of_node_put(phandle_cache[masked_handle]);
> +			phandle_cache[masked_handle] = NULL;
> +		}

A temporary would help the readability here I think, eg:

	struct device_node *np;
        np = phandle_cache[masked_handle];

	if (np && handle == np->phandle) {
		of_node_put(np);
		phandle_cache[masked_handle] = NULL;
	}

> @@ -1209,11 +1230,18 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>  		if (phandle_cache[masked_handle] &&
>  		    handle == phandle_cache[masked_handle]->phandle)
>  			np = phandle_cache[masked_handle];
> +		if (np && of_node_check_flag(np, OF_DETACHED)) {
> +			WARN_ON(1);
> +			of_node_put(np);

Do we really want to do the put here?

We're here because something has gone wrong, possibly even memory
corruption such that np is not even pointing at a device node anymore.
So it seems like it would be safer to just leave the ref count alone,
possibly leak a small amount of memory, and NULL out the reference.


cheers
