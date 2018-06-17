Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDE0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAB1208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxmcOrpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAB1208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeFQVdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 17:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbeFQVdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 17:33:02 -0400
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com [209.85.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6340C208D5;
        Sun, 17 Jun 2018 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529271181;
        bh=BY84JvCaICcBkLZwN3RFyObVuGWn+y+z24Lvp1Wb4SU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=NxmcOrpjJtoN75XUntS0F8uC8+1dUidsATU/HZ9VcmGkbl0HZAlVb7FVloNXby3EU
         WkTzNBuE9p/RYJ/sJR50pKaP+Z3D7/GlvObqgzqGTFmTSfbjIrOSXARhrwWyd9JRqg
         TCyj2jNu4ndpa8YJG3mlUuG9sB52F0FGO7Ryj22U=
Received: by mail-yb0-f178.google.com with SMTP id s14-v6so2564455ybp.13;
        Sun, 17 Jun 2018 14:33:01 -0700 (PDT)
X-Gm-Message-State: APt69E06JfPlCGiST3mJKHbJ79NRvoWqR3+qgYFnqASMiPY7F7lw2fmU
        mZkLj2dQU/ju0BEPcgJ8AkU16iLasjEpRt4C1LY=
X-Google-Smtp-Source: ADUXVKJqd6Kq7TOhR2PoGTPJth2b023Il1CkeXyxi/aQ0EErtPNxGlcOvveX5rhLx2ZXd2bxc6t726owEwiHv/Tnmzw=
X-Received: by 2002:a25:54c2:: with SMTP id i185-v6mr5129267ybb.62.1529271180528;
 Sun, 17 Jun 2018 14:33:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:bcb:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 14:32:20 -0700 (PDT)
In-Reply-To: <1529251416-14814-1-git-send-email-frowand.list@gmail.com>
References: <1529251416-14814-1-git-send-email-frowand.list@gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Sun, 17 Jun 2018 16:32:20 -0500
X-Gmail-Original-Message-ID: <CANk1AXTh_jpqSp4WpqRc4t4XfTr5Qt18fXUBZyqAHgWnuPeD1w@mail.gmail.com>
Message-ID: <CANk1AXTh_jpqSp4WpqRc4t4XfTr5Qt18fXUBZyqAHgWnuPeD1w@mail.gmail.com>
Subject: Re: [RFC PATCH] of: overlay: update phandle cache on overlay apply
 and remove
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 11:03 AM,  <frowand.list@gmail.com> wrote:

Hi Frank,

> From: Frank Rowand <frank.rowand@sony.com>
>
> A comment in the review of the patch adding the phandle cache said that
> the cache would have to be updated when modules are applied and removed.
> This patch implements the cache updates.
>
> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
> Reported-by: Alan Tull <atull@kernel.org>
> Suggested-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>
> Compiles for one configuration.
> NOT boot tested.
> Not run through my normal process to check for new warnings, etc.
>
> It is late, I'm tired, my brain is fuzzy.  I need to review this more to have
> any confidence in it.  But I wanted to get a version out for Alan to see (and
> test if he wants).

Thanks for the very fast response!  Monday I'll be able to test it and
review it.

Thanks,
Alan

>
>  drivers/of/base.c       |  6 +++---
>  drivers/of/of_private.h |  2 ++
>  drivers/of/overlay.c    | 12 ++++++++++++
>  3 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 848f549164cd..466e3c8582f0 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -102,7 +102,7 @@ static u32 phandle_cache_mask;
>   *   - the phandle lookup overhead reduction provided by the cache
>   *     will likely be less
>   */
> -static void of_populate_phandle_cache(void)
> +void of_populate_phandle_cache(void)
>  {
>         unsigned long flags;
>         u32 cache_entries;
> @@ -134,8 +134,7 @@ static void of_populate_phandle_cache(void)
>         raw_spin_unlock_irqrestore(&devtree_lock, flags);
>  }
>
> -#ifndef CONFIG_MODULES
> -static int __init of_free_phandle_cache(void)
> +int of_free_phandle_cache(void)
>  {
>         unsigned long flags;
>
> @@ -148,6 +147,7 @@ static int __init of_free_phandle_cache(void)
>
>         return 0;
>  }
> +#if !defined(CONFIG_MODULES)
>  late_initcall_sync(of_free_phandle_cache);
>  #endif
>
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 891d780c076a..216175d11d3d 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -79,6 +79,8 @@ int of_resolve_phandles(struct device_node *tree);
>  #if defined(CONFIG_OF_OVERLAY)
>  void of_overlay_mutex_lock(void);
>  void of_overlay_mutex_unlock(void);
> +int of_free_phandle_cache(void);
> +void of_populate_phandle_cache(void);
>  #else
>  static inline void of_overlay_mutex_lock(void) {};
>  static inline void of_overlay_mutex_unlock(void) {};
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 7baa53e5b1d7..3f76e58fbec4 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -804,6 +804,8 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>                 goto err_free_overlay_changeset;
>         }
>
> +       of_populate_phandle_cache();
> +
>         ret = __of_changeset_apply_notify(&ovcs->cset);
>         if (ret)
>                 pr_err("overlay changeset entry notify error %d\n", ret);
> @@ -1046,8 +1048,18 @@ int of_overlay_remove(int *ovcs_id)
>
>         list_del(&ovcs->ovcs_list);
>
> +       /*
> +        * Empty and disable phandle cache.  Must empty here so that
> +        * changeset notifiers do not use stale cache entry for a removed
> +        * phandle.
> +        */
> +       of_free_phandle_cache();
> +
>         ret_apply = 0;
>         ret = __of_changeset_revert_entries(&ovcs->cset, &ret_apply);
> +
> +       of_populate_phandle_cache();
> +
>         if (ret) {
>                 if (ret_apply)
>                         devicetree_state_flags |= DTSF_REVERT_FAIL;
> --
> Frank Rowand <frank.rowand@sony.com>
>
