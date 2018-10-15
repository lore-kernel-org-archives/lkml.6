Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E47C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAB0205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bjV0CiIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AAB0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeJPFQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:16:54 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44032 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeJPFQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:16:53 -0400
Received: by mail-yb1-f196.google.com with SMTP id x5-v6so8070895ybl.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8JsxQyrD35YmcDL4dadNfCIv9g+QpGQPlYAQrEKiZBI=;
        b=bjV0CiIlwfaNBY/KsYVRIx2OxD7MPUkfogoiV2SwIendvPWKsA/WGrPAHUj7K6T4om
         Mig8jdKR1X6b1OYtNAsE9p3KAVR0yQ5qjWe2AOYowQhVfNOBEjKRbGjwdAUmKF0maKi4
         SinpZ4HbzDyvz7On+Os8Y2mbAQuTnGjDV257w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8JsxQyrD35YmcDL4dadNfCIv9g+QpGQPlYAQrEKiZBI=;
        b=QhQfqrWmSasIBVE5xk6Is/nKbInOub/YxGwFyX1w45lTXfFEE3RNEgqEu/YILLxxGQ
         M2aSdn6V0xDiGeE/hDFRFCJVCxguKxx7Pop7LMr7jDPQ1LMb+vaeBHB2oolvo5KjVmyD
         Ci4QXIheANJfrP5V3onkc3c0iIdCDCIhEHWG9zBD5rufa2fWXtmjCYEzZzpqcPefWfyJ
         i/SJCVtjXvQLTkgaezGMYfI0KSdBefum/ZnWBOqubU9jLufMt6Gy9AOh+zAdiwIYXJc9
         ccbH8h2apOeFd2XDsTkzQVYcbRJooH7f2xG2JsmyHNum7++PcAzBMYYHRpX6lyJ0grHv
         zhYg==
X-Gm-Message-State: ABuFfoiEVt3FfEDgDEEVyLwwlL+l3TNAe8P9wvHy6V4ezMCo64Ewg1Jy
        ezBZZbtEcDcXesf/End1Y0jvAulvOVM=
X-Google-Smtp-Source: ACcGV60nHca4pZJR4/dFvx1/vOW8UPKbdbzLY2PGk2U/yezqc0wp1Ow/bJUdfSMqisZjG84Vv+WpDA==
X-Received: by 2002:a25:e6d7:: with SMTP id d206-v6mr10174131ybh.258.1539638991345;
        Mon, 15 Oct 2018 14:29:51 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id q2-v6sm2912163ywg.87.2018.10.15.14.29.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 14:29:49 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id v1-v6so8104995ywv.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:29:49 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr10119988ywg.47.1539638988663;
 Mon, 15 Oct 2018 14:29:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 14:29:47
 -0700 (PDT)
In-Reply-To: <20181013114847.GA3160@embeddedor.com>
References: <20181013114847.GA3160@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 14:29:47 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK-1DYcU3Aij9=spJa9d7ch2-mjXDZVEhmcWCVhWtE8NQ@mail.gmail.com>
Message-ID: <CAGXu5jK-1DYcU3Aij9=spJa9d7ch2-mjXDZVEhmcWCVhWtE8NQ@mail.gmail.com>
Subject: Re: [PATCH] signal: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:48 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Yes, please. :) I love every step closer we get to being able to use
-Wimplicit-fallthrough.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees


> ---
>  include/linux/signal.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 200ed96..f428e86 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -129,9 +129,11 @@ static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
>                 b3 = b->sig[3]; b2 = b->sig[2];                         \
>                 r->sig[3] = op(a3, b3);                                 \
>                 r->sig[2] = op(a2, b2);                                 \
> +               /* fall through */                                      \
>         case 2:                                                         \
>                 a1 = a->sig[1]; b1 = b->sig[1];                         \
>                 r->sig[1] = op(a1, b1);                                 \
> +               /* fall through */                                      \
>         case 1:                                                         \
>                 a0 = a->sig[0]; b0 = b->sig[0];                         \
>                 r->sig[0] = op(a0, b0);                                 \
> @@ -161,7 +163,9 @@ static inline void name(sigset_t *set)                                      \
>         switch (_NSIG_WORDS) {                                          \
>         case 4: set->sig[3] = op(set->sig[3]);                          \
>                 set->sig[2] = op(set->sig[2]);                          \
> +               /* fall through */                                      \
>         case 2: set->sig[1] = op(set->sig[1]);                          \
> +               /* fall through */                                      \
>         case 1: set->sig[0] = op(set->sig[0]);                          \
>                     break;                                              \
>         default:                                                        \
> @@ -182,6 +186,7 @@ static inline void sigemptyset(sigset_t *set)
>                 memset(set, 0, sizeof(sigset_t));
>                 break;
>         case 2: set->sig[1] = 0;
> +               /* fall through */
>         case 1: set->sig[0] = 0;
>                 break;
>         }
> @@ -194,6 +199,7 @@ static inline void sigfillset(sigset_t *set)
>                 memset(set, -1, sizeof(sigset_t));
>                 break;
>         case 2: set->sig[1] = -1;
> +               /* fall through */
>         case 1: set->sig[0] = -1;
>                 break;
>         }
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
