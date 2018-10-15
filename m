Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16519C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38802098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kAq+E59G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38802098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJPFRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:17:37 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33201 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeJPFRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:17:37 -0400
Received: by mail-yb1-f196.google.com with SMTP id u88-v6so8094245ybi.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6UE4dj/X0Qt7JsnD4bc2W7fC/UsXyQ64OUuERWk0meA=;
        b=kAq+E59GcgwmX0fdLI7OQdNmA4SLQlwmT8arhpurENacUokBB0JppkIsdX5Y+2NXdN
         rAaZ0O//GGqe72u2aKu+0FKfwqjyW+FIzxIXx3UX5CUEF9ShnsDr1bOrdnlwESookJPV
         8Jwpye+ydIY+MZRaM11Qqpz+C1ByRaUa3bD30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6UE4dj/X0Qt7JsnD4bc2W7fC/UsXyQ64OUuERWk0meA=;
        b=Z7RLGKG9mZ+I3rwr5dlEJpuWqJj3Ks8Km/3J2GkVMrf+g1rVeRee1MGbh8bneJXz28
         c5OriUmMA2V3DYJ60cQnOSo8NJkWoLLWNP3GNrSXsrW8aileSxVLwRQ1tBzjvzP/zaiA
         UBT5NIsoAQGa+MnPvvbrJk61iY0vo9Ms9rZ0I/8F/N5wIvNhXWC1UldiLZbOOiqOUxYl
         1ojxOBBjNT7qcn/ve2v8HlWn/QP9xONO4vY8S83ERogXDzO8Pl4fwWl+lXotvGo1jP9i
         vPkjbPPaDM34G4QMoLsZ/0+YAFEJP9gbwVuNWuG17WgzVsH2MOsuW1fs9QFAWzsyEQUC
         4IoQ==
X-Gm-Message-State: ABuFfohhcfuVojzP22ThzbzjySgaCbPc0ijYUm+c9SVBbb81D/TGtfe+
        S2eAnMOhNRAwoqE1w7QvmyAMzKhcl/0=
X-Google-Smtp-Source: ACcGV63i7kxZw2bsAMKjNCc/nyF19C6rdXxZEWAXpB4e8yl5MNJ71Cic3jroBzszDk60Zn9VmC1cNw==
X-Received: by 2002:a5b:102:: with SMTP id 2-v6mr3917411ybx.392.1539639034417;
        Mon, 15 Oct 2018 14:30:34 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u131-v6sm3065970ywf.13.2018.10.15.14.30.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 14:30:33 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id e16-v6so8079981ybk.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:30:32 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr10211297yba.410.1539639032395;
 Mon, 15 Oct 2018 14:30:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 14:30:31
 -0700 (PDT)
In-Reply-To: <20181013115646.GA3516@embeddedor.com>
References: <20181013115646.GA3516@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 14:30:31 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+rLGyGCozaSMqFV0p+cHoJFmJBXWXHz5WfYEaDkHJdGw@mail.gmail.com>
Message-ID: <CAGXu5j+rLGyGCozaSMqFV0p+cHoJFmJBXWXHz5WfYEaDkHJdGw@mail.gmail.com>
Subject: Re: [PATCH] skbuff: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:56 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/skbuff.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 119d092..92ec346 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3505,13 +3505,19 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
>  #define __it(x, op) (x -= sizeof(u##op))
>  #define __it_diff(a, b, op) (*(u##op *)__it(a, op)) ^ (*(u##op *)__it(b, op))
>         case 32: diffs |= __it_diff(a, b, 64);
> +               /* fall through */
>         case 24: diffs |= __it_diff(a, b, 64);
> +               /* fall through */
>         case 16: diffs |= __it_diff(a, b, 64);
> +               /* fall through */
>         case  8: diffs |= __it_diff(a, b, 64);
>                 break;
>         case 28: diffs |= __it_diff(a, b, 64);
> +               /* fall through */
>         case 20: diffs |= __it_diff(a, b, 64);
> +               /* fall through */
>         case 12: diffs |= __it_diff(a, b, 64);
> +               /* fall through */
>         case  4: diffs |= __it_diff(a, b, 32);
>                 break;
>         }
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
