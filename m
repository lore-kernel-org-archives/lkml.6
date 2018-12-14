Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1862FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AE2206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544808018;
	bh=17sy1cCSStd8lhmEga2NxAz/c3m4ocZS/i17ebqa7EI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IzzNwoxH2wkgdUNuFLFA5W9X0OErYOmem5d23yX4/lcHewE/7Op2bFkc9hkqZp/CN
	 YdE4xVwJOTgvcAp8hK60zLs2CsFLhmEHRhc96AmvU/cBvFZsMvNbU9iWF1y1Q4gmTw
	 z39s8hbV/sXDmKOtdFWB8Sy8Yyxd3vNIywsOqo9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbeLNRUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbeLNRUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:20:15 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62DF12070B;
        Fri, 14 Dec 2018 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544808015;
        bh=17sy1cCSStd8lhmEga2NxAz/c3m4ocZS/i17ebqa7EI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jk6cGvAJQfQI+e/4LlEK4od6zBgkjqbm5UFGv0N5bvovzk+KTl4Dj4GBs52uekfWe
         soGUWcGiXcYUDyDQ/LNnBkBzLhWjVs5HiiULZYln89R1KkmMBRJYTc3wMhqlLsx04Y
         psPtTrPdXUTwrFuKL8ouAPkCE1gvMRWUlb0gWk7I=
Received: by mail-qt1-f178.google.com with SMTP id e5so6955240qtr.12;
        Fri, 14 Dec 2018 09:20:14 -0800 (PST)
X-Gm-Message-State: AA+aEWaYfpkQetHgHO+W/VrNTOmADpe/+YQUnXQRjN139RcTZ76Dy47R
        IQVfSyBhfXZvBG8uRe3GalhoqE4/oOZsUXPjjg==
X-Google-Smtp-Source: AFSGD/XcBa+uXBQytzMAAiU37puwUAWqVcy0X6GwO7dnsYCY+S7wER+oum3HKdq97bkWJJPzKOLXlrWGxM0gOJFFvVE=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr3646677qve.246.1544808013572;
 Fri, 14 Dec 2018 09:20:13 -0800 (PST)
MIME-Version: 1.0
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com> <1544769771-5468-3-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1544769771-5468-3-git-send-email-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 14 Dec 2018 11:20:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJN69kbLX=Fn-hYh1FwWoU-S+sB7wHjG-9H5=ihbo3hcg@mail.gmail.com>
Message-ID: <CAL_JsqJN69kbLX=Fn-hYh1FwWoU-S+sB7wHjG-9H5=ihbo3hcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: __of_detach_node() - remove node from phandle cache
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     mwb@linux.vnet.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        tlfalcon@linux.vnet.ibm.com, minkim@us.ibm.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:43 AM <frowand.list@gmail.com> wrote:
>
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
>  drivers/of/base.c       | 29 ++++++++++++++++++++++++++++-
>  drivers/of/dynamic.c    |  3 +++
>  drivers/of/of_private.h |  4 ++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index d599367cb92a..34a5125713c8 100644
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
> +       phandle masked_handle;
> +
> +       if (!handle)
> +               return;
> +
> +       masked_handle = handle & phandle_cache_mask;
> +
> +       if (phandle_cache) {
> +               if (phandle_cache[masked_handle] &&
> +                   handle == phandle_cache[masked_handle]->phandle) {
> +                       of_node_put(phandle_cache[masked_handle]);
> +                       phandle_cache[masked_handle] = NULL;
> +               }
> +       }
> +}
> +
>  void of_populate_phandle_cache(void)
>  {
>         unsigned long flags;
> @@ -1209,11 +1230,17 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>                 if (phandle_cache[masked_handle] &&
>                     handle == phandle_cache[masked_handle]->phandle)
>                         np = phandle_cache[masked_handle];
> +               if (np && of_node_check_flag(np, OF_DETACHED)) {
> +                       of_node_put(np);
> +                       phandle_cache[masked_handle] = NULL;

This should never happen, right? Any time we set OF_DETACHED, the
entry should get removed from the cache. I think we want a WARN here
in case we're in an unexpected state.

Rob
