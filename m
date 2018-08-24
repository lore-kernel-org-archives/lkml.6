Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870C6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDE421570
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNcaLagw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDE421570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeHXGcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:32:33 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33858 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeHXGc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:32:29 -0400
Received: by mail-yw1-f65.google.com with SMTP id y134-v6so2608780ywg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 19:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W+40nW/kGC407FbZbaA8m0FyhoNg5ILSGFdbeembEdc=;
        b=XNcaLagw56A1mHXnrepMoHuIY6eQ85xdRB1QIx8oenaTWTzse+n/biry7Yu4m+da5u
         PRgX69V9WUYiLtedCjzBs5WJK+OOiYcTJKVpsE43YUCQEtTVG5w+Ew0ZI+ow2YdkvoGT
         2U2kxmzGZTRmEtUd0eWcE/JcIPq2cTY7i+teQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W+40nW/kGC407FbZbaA8m0FyhoNg5ILSGFdbeembEdc=;
        b=CDCduTKjOD5xg9edCyryCNbK1HVVu9gN6oY7YVsW9aFWPOl+vdS6bRot2jepiQhup0
         1xOM1VSAjTJqGkjUU1Bb0WuaQe5KhgFgr6DfaN5iayX4YoXAivDFT6JrpmIXk8uGK5B4
         5okIktip6AK0ilh7xwIalbl0zmN4eORH9t4O3Ec4nIBb4eoPcqivnPMWH17GEg3MfJGA
         JQqu6QV+ld6EmwBw3QdjarF4b87Wj6H6bx4qRDeFK6vlaYN5nfYxzh+DDNM9zpg+/2Ay
         qu10WGJ3hMI4jkDla+MRCGkeY6ajvYdnWm30xn+JW2c1Fz8iH/3TTys5PIb8UjD0iESe
         /FWQ==
X-Gm-Message-State: APzg51Bup1caOtFkh+hK88J+b3wqD2LGKigqdtzTSGDuC9Rj83Nh5Bce
        0GIGF2VNoK1SAnubZu6uYiVdsJV71m4=
X-Google-Smtp-Source: ANB0Vdb/sXXsOVYWIo05fYKfn7opfImBufE79Zuei0qGyjkG0e/MkDnHLNBGIa4cOFqdcrMhJpe7vw==
X-Received: by 2002:a0d:e251:: with SMTP id l78-v6mr4615052ywe.218.1535079594099;
        Thu, 23 Aug 2018 19:59:54 -0700 (PDT)
Received: from mail-yb0-f177.google.com (mail-yb0-f177.google.com. [209.85.213.177])
        by smtp.gmail.com with ESMTPSA id d6-v6sm2415609ywa.85.2018.08.23.19.59.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 19:59:53 -0700 (PDT)
Received: by mail-yb0-f177.google.com with SMTP id z3-v6so2989477ybm.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 19:59:52 -0700 (PDT)
X-Received: by 2002:a25:f606:: with SMTP id t6-v6mr21509244ybd.141.1535079592382;
 Thu, 23 Aug 2018 19:59:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 19:59:51
 -0700 (PDT)
In-Reply-To: <20180824011247.GA25648@embeddedor.com>
References: <20180824011247.GA25648@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 19:59:51 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+TkaLoXaGi0mc4-xZSnDdM=z=J9n-h5GOaoOTM5MgBLQ@mail.gmail.com>
Message-ID: <CAGXu5j+TkaLoXaGi0mc4-xZSnDdM=z=J9n-h5GOaoOTM5MgBLQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: use struct_size() in kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 6:12 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>         int stuff;
>         void *entry[];
> };
>
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/wireless/ath/ath10k/ce.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
> index 18c709c..d0381aa 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.c
> +++ b/drivers/net/wireless/ath/ath10k/ce.c
> @@ -1416,10 +1416,8 @@ ath10k_ce_alloc_src_ring(struct ath10k *ar, unsigned int ce_id,
>
>         nentries = roundup_pow_of_two(nentries);
>
> -       src_ring = kzalloc(sizeof(*src_ring) +
> -                          (nentries *
> -                           sizeof(*src_ring->per_transfer_context)),
> -                          GFP_KERNEL);
> +       src_ring = kzalloc(struct_size(src_ring, per_transfer_context,
> +                                      nentries), GFP_KERNEL);
>         if (src_ring == NULL)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -1476,10 +1474,8 @@ ath10k_ce_alloc_src_ring_64(struct ath10k *ar, unsigned int ce_id,
>
>         nentries = roundup_pow_of_two(nentries);
>
> -       src_ring = kzalloc(sizeof(*src_ring) +
> -                          (nentries *
> -                           sizeof(*src_ring->per_transfer_context)),
> -                          GFP_KERNEL);
> +       src_ring = kzalloc(struct_size(src_ring, per_transfer_context,
> +                                      nentries), GFP_KERNEL);
>         if (!src_ring)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -1534,10 +1530,8 @@ ath10k_ce_alloc_dest_ring(struct ath10k *ar, unsigned int ce_id,
>
>         nentries = roundup_pow_of_two(attr->dest_nentries);
>
> -       dest_ring = kzalloc(sizeof(*dest_ring) +
> -                           (nentries *
> -                            sizeof(*dest_ring->per_transfer_context)),
> -                           GFP_KERNEL);
> +       dest_ring = kzalloc(struct_size(dest_ring, per_transfer_context,
> +                                       nentries), GFP_KERNEL);
>         if (dest_ring == NULL)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -1580,10 +1574,8 @@ ath10k_ce_alloc_dest_ring_64(struct ath10k *ar, unsigned int ce_id,
>
>         nentries = roundup_pow_of_two(attr->dest_nentries);
>
> -       dest_ring = kzalloc(sizeof(*dest_ring) +
> -                           (nentries *
> -                            sizeof(*dest_ring->per_transfer_context)),
> -                           GFP_KERNEL);
> +       dest_ring = kzalloc(struct_size(dest_ring, per_transfer_context,
> +                                       nentries), GFP_KERNEL);
>         if (!dest_ring)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
