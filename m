Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6D7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE12B222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kPeojznO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfBLUUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:20:37 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39553 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfBLUUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:20:36 -0500
Received: by mail-vk1-f193.google.com with SMTP id f206so931772vke.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viBxAF7PP0eunUz/9xypEOMArai5yFpDCyBtqzWyPqg=;
        b=kPeojznO8+uAD/UDYWlEalXfU59kkGoS+xyT5GXj7EzLmrIqKpOiOujDaiZC6jQjDH
         o+OILy2EIr8l2j4E4qP6Ali1DXT+FHHTdnDM1rZgHysLkzCtWC0sLuzuFdvSiafbZ6Bw
         Lo3s4fcJwRVyFLuYnUP2QraPa1Rt25/AxuS0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viBxAF7PP0eunUz/9xypEOMArai5yFpDCyBtqzWyPqg=;
        b=ponr51btiiSNtvOu3UO7Z9qC0wBmLv+A+VwN7i0GtYStnz3riJTP31qiNBPYRSV1Xy
         xbCoSRcGGEFQOQWO3T8uENKSQV2tkJJMjAVyg/JQ/oKryKIT/zWwCV0UpomvDcdH5PDw
         eYVxZ12P9BbBK9+/pMLpFZSTOmlAUPjhfV/lmnk2IXtBsE5Rn19XRovnpgvL4Y+5abf6
         9kgBWRAnAic1mqpgcDZUh4bwD4MGtVKMPC2gIhLtUOr7AUEXQ3Cwo/eDZYzQxHYp9+G1
         ti4BCf0fbdGXePoSlz4x/ylYAFkVFcxZFZ1Fp5fvtyurvgMVyUD7j0sr5U94z46b5BM5
         XuqA==
X-Gm-Message-State: AHQUAubR69cWPiTehuTKntBm1dU015VRoU+i1b5hOnkhw6V+NhpJGfi9
        ix6XPRQaCLktBoEnvl8HbQ0f5dYsOHM=
X-Google-Smtp-Source: AHgI3IapClnzIUaCzqCHaoMt1X782LFqKmAiXHS8IAGjPKPSgxTlH9aDZiSUcoeActeyjDzZfshFAw==
X-Received: by 2002:a1f:de82:: with SMTP id v124mr1696272vkg.26.1550002835091;
        Tue, 12 Feb 2019 12:20:35 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id y20sm3595476vsq.16.2019.02.12.12.20.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:20:34 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id s16so2429863vsk.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:20:34 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr2425743vsc.48.1550002833600;
 Tue, 12 Feb 2019 12:20:33 -0800 (PST)
MIME-Version: 1.0
References: <5c46fa15.1c69fb81.5733e.9104SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5c46fa15.1c69fb81.5733e.9104SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 12:20:22 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJsw45gBkj8KJoKmT9PJKsFK-kTMy1tGTKf3jPKnhzzDw@mail.gmail.com>
Message-ID: <CAGXu5jJsw45gBkj8KJoKmT9PJKsFK-kTMy1tGTKf3jPKnhzzDw@mail.gmail.com>
Subject: Re: [PATCH] pstore: Fix some style warnings and errors
To:     Yue Hu <huyue2@yulong.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 3:10 AM Yue Hu <huyue2@yulong.com> wrote:
>
> From 7123b8bfaede56796fb21767cc8c13496d9c44e6 Mon Sep 17 00:00:00 2001
> From: Yue Hu <huyue2@yulong.com>
> Date: Tue, 22 Jan 2019 18:51:48 +0800
> Subject: [PATCH] pstore: Fix some style warnings and errors
>
> WARNING: line over 80 characters
> +#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
>
> WARNING: line over 80 characters
> +#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
>
> ERROR: "foo __init      bar" should be "foo __init bar"
> +int __init     pstore_init_fs(void);
>
> ERROR: "foo __exit      bar" should be "foo __exit bar"
> +void __exit    pstore_exit_fs(void);
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/pstore/internal.h | 4 ++--
>  fs/pstore/platform.c | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
> index 7062ea4..6b4fad0 100644
> --- a/fs/pstore/internal.h
> +++ b/fs/pstore/internal.h
> @@ -38,7 +38,7 @@ extern void   pstore_record_init(struct pstore_record *record,
>                                    struct pstore_info *psi);
>
>  /* Called during pstore init/exit. */
> -int __init     pstore_init_fs(void);
> -void __exit    pstore_exit_fs(void);
> +int __init pstore_init_fs(void);
> +void __exit pstore_exit_fs(void);

These are intentionally indented to match the function declarations above them.

>
>  #endif
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 2d1066e..0ca7657 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -31,7 +31,8 @@
>  #if IS_ENABLED(CONFIG_PSTORE_LZO_COMPRESS)
>  #include <linux/lzo.h>
>  #endif
> -#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
> +#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || \
> +       IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
>  #include <linux/lz4.h>
>  #endif
>  #if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
> @@ -219,7 +220,8 @@ static int zbufsize_lzo(size_t size)
>  }
>  #endif
>
> -#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
> +#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || \
> +       IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
>  static int zbufsize_lz4(size_t size)
>  {
>         return LZ4_compressBound(size);

My hope is to remove the per-compression logic in the near future once
the general compression API gains the "size" API, so I'd like to avoid
churn here for the moment.

-Kees

-- 
Kees Cook
