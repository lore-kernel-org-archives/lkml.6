Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D433C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1DA20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PsZ1/yNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1DA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeLLSnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:43:40 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43050 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbeLLSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:43:39 -0500
Received: by mail-yw1-f66.google.com with SMTP id l200so7389209ywe.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhFR6QMOcbaR8IAQTw+MkJki/pA7I5Lieqkhr1OqAb0=;
        b=PsZ1/yNwacfmENYF+OoNvj3N2B9yxHElPTcGTqqTlWORV0Hvi2E0iYqSF0mLgAdmqw
         /unzKg3x+/R+R3hztVo6zE40WEM1jlwTuX0pp7yqZmj85o78ZnZd/0rXowx0xo9RmPor
         Ex9PaN6FeJhCddJ8R5ACiJfPxoiHHVImiLdIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhFR6QMOcbaR8IAQTw+MkJki/pA7I5Lieqkhr1OqAb0=;
        b=HMGtTIMgNaUG2ZSH1oydQr3IR4dGK6Nh9YxUtw1bPRwrxaOfHi6toRfuSL6h7DugYn
         khbfiLnTIecAR16JVmdbIH/UR8buhY8xVXNvgX9nPKDl9tHSMv2r2hCUDNYXvJE6wUVH
         DDYnmGfGZT2bHybdVnOYufyjZ7jeULrzb9r7liek3lB7bJZR2z5J5y0pnr8o2yzXzqzr
         ItiuGs7Yu+kaKRp3dFyOzl2GizK4j0lsHCbE3OH/HDSeBmwz/Wlxww5JyZ3DKoF7Sr+l
         cTzmp4jqFH8tKcmDsFzWPDYbDQciyhVP3KAZkv/ZtoJBJDE0MkEDogKQu+EfL03q2ivL
         WyOw==
X-Gm-Message-State: AA+aEWZohIlPxVHTRHGfjdLf2l/5UnZIAtbDQ3gSvABmJMyzNmdrPgHV
        W1PedOCYovdOZMvG5gEbp4mI72VeKdA=
X-Google-Smtp-Source: AFSGD/X3X32OIJ7F+2hS/kTA6M67KPS57j5mwyG9UK4HCu4YR6F+oHvsP+YXaxn+b0jCFbtTZecSsA==
X-Received: by 2002:a81:5c86:: with SMTP id q128mr20842894ywb.431.1544640218268;
        Wed, 12 Dec 2018 10:43:38 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id a71sm6163520ywe.66.2018.12.12.10.43.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:43:37 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id f9so5101441ybm.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:43:36 -0800 (PST)
X-Received: by 2002:a25:3502:: with SMTP id c2-v6mr21482570yba.410.1544640216461;
 Wed, 12 Dec 2018 10:43:36 -0800 (PST)
MIME-Version: 1.0
References: <1544603038-9373-1-git-send-email-liaoweixiong@allwinnertech.com>
In-Reply-To: <1544603038-9373-1-git-send-email-liaoweixiong@allwinnertech.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Dec 2018 10:43:24 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+nTVoD=AMvOcn2bvA4C0mw=LKDbVnDWhUkL3c6mJye_g@mail.gmail.com>
Message-ID: <CAGXu5j+nTVoD=AMvOcn2bvA4C0mw=LKDbVnDWhUkL3c6mJye_g@mail.gmail.com>
Subject: Re: [PATCH] pstore: fix crypto dependencies of 842/zstd compression
To:     liaoweixiong@allwinnertech.com
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:24 AM liaoweixiong
<liaoweixiong@allwinnertech.com> wrote:
>
> Reference to commit 58eb5b670747 ("pstore: fix crypto dependencies"),
> which fixed crypto dependencies of deflate, lzo, lz4 and lz4hc
> compression, but omitted 842 and newer compression zstd from
> commit 1021bcf44d0e ("pstore: add zstd compression support")
>
> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>

Were you seeing build or config failures without this patch?

-Kees

> ---
>  fs/pstore/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 0d19d19..7068f45 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -44,14 +44,14 @@ config PSTORE_LZ4HC_COMPRESS
>           This option enables LZ4HC (high compression) mode algorithm.
>
>  config PSTORE_842_COMPRESS
> -       bool "842 compression"
> +       tristate "842 compression"
>         depends on PSTORE
>         select CRYPTO_842
>         help
>           This option enables 842 compression algorithm support.
>
>  config PSTORE_ZSTD_COMPRESS
> -       bool "zstd compression"
> +       tristate "zstd compression"
>         depends on PSTORE
>         select CRYPTO_ZSTD
>         help
> --
> 1.9.1
>


-- 
Kees Cook
