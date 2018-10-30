Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E05C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A502081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cxeQWjNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A502081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJaGRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:17:11 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43142 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeJaGRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:17:10 -0400
Received: by mail-yw1-f66.google.com with SMTP id j75-v6so5563772ywj.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A3GtamlUW6fXb7w6Fyunb3q7NAD4+BRgLXRT9qulAng=;
        b=cxeQWjNBpOS0ZubpgiTyMLJ/yj0sQT9pwwaXYhO/t1R1C/GFIqAx0kkSlOQ9/F1/m0
         7reNqthvtQfk76ivAyAaiZXjCk6vNq7S7/+r4z6HuQkq+mvMA2+p8N7lGkeAO5nXsO/A
         osx2fwLU2KYdBlQO7bIk2ezz55bwwVxMQE624=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A3GtamlUW6fXb7w6Fyunb3q7NAD4+BRgLXRT9qulAng=;
        b=mFgewL1QXUPh6nD8id3VfJqQ0Cd15YMb8ttI8epYW3rTYQ8eNvz3uiFTHMDhFkWz65
         oFiCcpZINejEoM7+ffcyZPpitLP5Wf4Np02QGmz4Na/43sWGcXhECB+v82RNZjnvmVz6
         3uJdk55yLv4tbGgOJwVEembKXFk/rybJRLRWPpT8kDk+qzg0+bvPS8FN0eZs5UyW0up1
         MBZiN4ZQG2OXlgI3n/R64VL8X3rIBC8gbayw8/XGihqHk5YMhl4sjmQbXse7AHHa8dc6
         Xg/fnSd6b5Pqko0GS8pp/GrVn/WIEUSVcD+JLAXqZIOesk3serN2dpDDbfGCq+BXnVrO
         fRwg==
X-Gm-Message-State: AGRZ1gKJc6C/kqTp/zWdhirFjm1Uy34SVufn3qZ0q7FrWVvwHTQ6W75G
        +GjcxRBnC+PRgIdITVFM1y+nB9B9hHA=
X-Google-Smtp-Source: AJdET5dpfG8wvf/01OgTTT5dCRO/hux5whtF9Bdar0SVG+4zb0hAkq5DDQZH7XLK22dzkNu4oiPucQ==
X-Received: by 2002:a81:6256:: with SMTP id w83-v6mr406264ywb.501.1540934522425;
        Tue, 30 Oct 2018 14:22:02 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id z11-v6sm7291402ywl.36.2018.10.30.14.22.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 14:22:01 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id k6-v6so1188947ywa.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:22:00 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr420345ywg.47.1540934520178;
 Tue, 30 Oct 2018 14:22:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 14:21:59
 -0700 (PDT)
In-Reply-To: <20181030075234.21137-1-wangpeng15@xiaomi.com>
References: <20181030075234.21137-1-wangpeng15@xiaomi.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Oct 2018 14:21:59 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKKgn4WZWo1Jv3h5DfNFR6ku-eAP1pcOUad5D4rA1Kzqg@mail.gmail.com>
Message-ID: <CAGXu5jKKgn4WZWo1Jv3h5DfNFR6ku-eAP1pcOUad5D4rA1Kzqg@mail.gmail.com>
Subject: Re: [PATCH v4] pstore: Avoid duplicate call of persistent_ram_zap()
To:     Peng Wang <wangpeng15@xiaomi.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, vipwangerxiao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:52 AM, Peng Wang <wangpeng15@xiaomi.com> wrote:
> When initialing prz with invalid data in buffer(no PERSISTENT_RAM_SIG),
> function call path is like this:
>
> ramoops_init_prz ->
> |
> |-> persistent_ram_new -> persistent_ram_post_init -> persistent_ram_zap
> |
> |-> persistent_ram_zap
>
> As we can see, persistent_ram_zap() is called twice.
> We can avoid this by adding an option to persistent_ram_new(), and
> only call persistent_ram_zap() when it is needed.
>
> Signed-off-by: Peng Wang <wangpeng15@xiaomi.com>

Thanks! I've applied this to my devel branch. I'll have it in
linux-next once -rc2 lands.

-Kees

> ---
>  fs/pstore/ram.c            | 4 +---
>  fs/pstore/ram_core.c       | 5 +++--
>  include/linux/pstore_ram.h | 1 +
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ffcff6516e89..b51901f97dc2 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -640,7 +640,7 @@ static int ramoops_init_prz(const char *name,
>
>         label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
>         *prz = persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
> -                                 cxt->memtype, 0, label);
> +                                 cxt->memtype, PRZ_FLAG_ZAP_OLD, label);
>         if (IS_ERR(*prz)) {
>                 int err = PTR_ERR(*prz);
>
> @@ -649,8 +649,6 @@ static int ramoops_init_prz(const char *name,
>                 return err;
>         }
>
> -       persistent_ram_zap(*prz);
> -
>         *paddr += sz;
>
>         return 0;
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index 12e21f789194..2ededd1ea1c2 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -505,15 +505,16 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
>                         pr_debug("found existing buffer, size %zu, start %zu\n",
>                                  buffer_size(prz), buffer_start(prz));
>                         persistent_ram_save_old(prz);
> -                       return 0;
> +                       if (!(prz->flags & PRZ_FLAG_ZAP_OLD))
> +                               return 0;
>                 }
>         } else {
>                 pr_debug("no valid data in buffer (sig = 0x%08x)\n",
>                          prz->buffer->sig);
> +               prz->buffer->sig = sig;
>         }
>
>         /* Rewind missing or invalid memory area. */
> -       prz->buffer->sig = sig;
>         persistent_ram_zap(prz);
>
>         return 0;
> diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
> index 602d64725222..6e94980357d2 100644
> --- a/include/linux/pstore_ram.h
> +++ b/include/linux/pstore_ram.h
> @@ -30,6 +30,7 @@
>   * PRZ_FLAG_NO_LOCK is used. For all other cases, locking is required.
>   */
>  #define PRZ_FLAG_NO_LOCK       BIT(0)
> +#define PRZ_FLAG_ZAP_OLD       BIT(1)
>
>  struct persistent_ram_buffer;
>  struct rs_control;
> --
> 2.19.1
>



-- 
Kees Cook
