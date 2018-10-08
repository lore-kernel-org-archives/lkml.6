Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9FEC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F105D2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfeM2tYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F105D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJHVe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:34:59 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33882 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeJHVe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:34:59 -0400
Received: by mail-it1-f194.google.com with SMTP id l127-v6so10677145ith.1;
        Mon, 08 Oct 2018 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VlQgCxEuKeY+MRIUHvLnkTGUGGoeX9GQADU44EiYRw=;
        b=RfeM2tYbIFih9YHOqLAh2TzoFh692mBOJxhlSO6ATiC7V2rOS7YdgtI0u4848WPhpZ
         1xRo7u+lIKZscLWqDErkHsmps5GZzTRdUQ805H99K9JpL3LbrY0Yu5XgYFG3RggNA/5c
         HTpHM3ZOQQHUiCc+SM2LTanXBbXFFQGSwiF1Efabp889zxADUjR3qnLo5PvpAkYcNMR7
         93gZmArnQH0bJXInqtnVu8YQoEmWTAHW9TxSdIRzIhrebS73UlML3uu0eq5nm43d4Huo
         szWvgZeKdkoso11qpVOIkhw34WV5PDMS9CRZZ4Qmd/h7uKKLqk2z+BE+IERz6eFNqjMA
         eSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VlQgCxEuKeY+MRIUHvLnkTGUGGoeX9GQADU44EiYRw=;
        b=Vl5kO/JzA9zYslax5YGOzFB2aibNXWatugr9RsRGgtRXdG9aJJZQtoPfoNVm3l43D2
         tj+Y1ybyx5sFlxLET+k0P1QMpJg+GTVSa/LmYVXCdf341+aF9TPD1mEPVqbdWBc/b7nz
         cw7r4Wq9rY0z5JjNbNww17AGaGbfrBIILX+RbF3YNLsBhxgkH2WMQnBwePvm0y0DPzs9
         qK5zQ82mqsIJud0pLrrLeuxIThBdNvnlHcErdyZ9cNNlQi1MJRL6rjSNzoqw+VKP0M83
         XKdV1Cd8bIKuxytVTFvKmc+BkJLxY0YGR2hwloAYW1O2qYMJL9p0dnioagB+Mgf6P3hp
         dFhw==
X-Gm-Message-State: ABuFfoiF8pNZ6NFr7H9xwuGSeXcE2MOoakSTQV17enOpxO+fC9dtNzfc
        pvfJkObg3mPDwaH6kvl+ZgxbmeOhoIfjmyiRPzk=
X-Google-Smtp-Source: ACcGV61WI5zf7rODoAfn2HaCnRlT34ik6sO0X6TQHd8VadVfBmF0EcrCz6Emyz3TmqqkgKVr2cwpFpNiHKKEYl3085U=
X-Received: by 2002:a24:118f:: with SMTP id 137-v6mr16557615itf.30.1539008581167;
 Mon, 08 Oct 2018 07:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181005161845.959919-1-arnd@arndb.de>
In-Reply-To: <20181005161845.959919-1-arnd@arndb.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 8 Oct 2018 16:22:50 +0200
Message-ID: <CAOi1vP8Wy0DjEWBWh05iSx-RJS41hTc1rs2TXdz_1mcNpf68Dg@mail.gmail.com>
Subject: Re: [PATCH] ceph: use an enum instead of 'static const' to define constants
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>, pombredanne@nexb.com,
        Luis Henriques <lhenriques@suse.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 6:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building with W=1 produces lots of warnings for files including
> ceph_features.h:
>
> include/linux/ceph/ceph_features.h:15:24: error: 'CEPH_FEATUREMASK_SERVER_M' defined but not used [-Werror=unused-const-variable=]
>
> The normal way to define compile-time constants in the kernel is
> to use either macros or enums, and gcc does not warn about those.
>
> Converting to an enum is simple here and means we can still use
> the names while debugging.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/ceph/ceph_features.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
> index 6b92b3395fa9..676908eca060 100644
> --- a/include/linux/ceph/ceph_features.h
> +++ b/include/linux/ceph/ceph_features.h
> @@ -11,15 +11,15 @@
>  #define CEPH_FEATURE_INCARNATION_2 (1ull<<57) // CEPH_FEATURE_SERVER_JEWEL
>
>  #define DEFINE_CEPH_FEATURE(bit, incarnation, name)                    \
> -       static const uint64_t CEPH_FEATURE_##name = (1ULL<<bit);                \
> -       static const uint64_t CEPH_FEATUREMASK_##name =                 \
> -               (1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation);
> +       CEPH_FEATURE_##name = (1ULL<<bit),                              \
> +       CEPH_FEATUREMASK_##name =                                       \
> +               (1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation),
>
>  /* this bit is ignored but still advertised by release *when* */
> -#define DEFINE_CEPH_FEATURE_DEPRECATED(bit, incarnation, name, when) \
> -       static const uint64_t DEPRECATED_CEPH_FEATURE_##name = (1ULL<<bit); \
> -       static const uint64_t DEPRECATED_CEPH_FEATUREMASK_##name =              \
> -               (1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation);
> +#define DEFINE_CEPH_FEATURE_DEPRECATED(bit, incarnation, name, when)   \
> +       DEPRECATED_CEPH_FEATURE_##name = (1ULL<<bit),                   \
> +       DEPRECATED_CEPH_FEATUREMASK_##name =                            \
> +               (1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation),
>
>  /*
>   * this bit is ignored by release *unused* and not advertised by
> @@ -71,7 +71,7 @@
>   * This ensures that no two versions who have different meanings for
>   * the bit ever speak to each other.
>   */
> -
> +enum ceph_features {
>  DEFINE_CEPH_FEATURE( 0, 1, UID)
>  DEFINE_CEPH_FEATURE( 1, 1, NOSRCADDR)
>  DEFINE_CEPH_FEATURE_RETIRED( 2, 1, MONCLOCKCHECK, JEWEL, LUMINOUS)
> @@ -170,13 +170,13 @@ DEFINE_CEPH_FEATURE(61, 1, CEPHX_V2)             // *do not share this bit*
>
>  DEFINE_CEPH_FEATURE(62, 1, RESERVED)           // do not use; used as a sentinal
>  DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facing
> -
> +};

I don't particularly like this because it looks like lower constants
are actually ints and the rest are unsigned longs, even though they all
have ULL suffixes.  The standard seems to require that enum constants
be representable as ints, is the non-pedantic behaviour documented
somewhere?

Thanks,

                Ilya
