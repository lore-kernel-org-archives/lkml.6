Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29B9C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CD320881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I3pA5vBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CD320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJ2AsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 20:48:22 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44210 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeJ2AsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 20:48:22 -0400
Received: by mail-yb1-f193.google.com with SMTP id p144-v6so2440174yba.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aKSg09pa/a6oTyL7UmCKjohOMRcDGbOHi76UeYms3Qk=;
        b=I3pA5vBSj+131gPXKDA/ygvr2hujESrPgxNR4zjNSIQZo56NcyD5vn57P6XuEPSkg6
         /We3SSbhAt912qkVRJ9EfGlavYpB60xrPlkS4sSC/WDTry2t3nwnzU5bd2yKMHzNAfKI
         KMIcNrmwn+aePKVgrHGlh4a185c0UawDRDw9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aKSg09pa/a6oTyL7UmCKjohOMRcDGbOHi76UeYms3Qk=;
        b=RQ0CT2HJrIlbpDLZyo/s090SmW5x9rFf0JOK8U2FnMQEOd3U9tEMOK3bX73ZsPMA5L
         b5MDhGN50vnw5+nRxYBFH/N6zZqNb2tFbCESV7BYEewnftM8AnzfyUThUjNGauHJ4WO/
         G7hPatujW6to0WVqOjkQ8Yc+W80vywYSz9dbl0NhLCZbbug0O5wzCC/mO//klXj3Mzpo
         2YvfsoHeviu3ymLBBQIxtYKjyqrCg3OwZDUGSl6rO9FdvSLZjc4hfDyA9LpcYSzOZPqj
         tFhJSbQhyFVEX8lfywkM+ELLG7ZiqWgTheaSfCTipdqUCvvQzVYacgDm0DxoD2zvMwxt
         RnvA==
X-Gm-Message-State: AGRZ1gJ50f814yTkj357GTk1K5y4hjG7gSdfftxeAcl6XG97IFRQwX4B
        Gg0Fun4jR/+UeygIuSsLaA1Y1XgIgjs=
X-Google-Smtp-Source: AJdET5eRySlD4SBlGuqM+qTSgGdP/ULKSue2hLrLtEnOdLI4B2Y4Du8SQP2thesCB1Z5BxIVVD0kBQ==
X-Received: by 2002:a25:4455:: with SMTP id r82-v6mr1275087yba.36.1540742600564;
        Sun, 28 Oct 2018 09:03:20 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id c129-v6sm4140075ywe.84.2018.10.28.09.03.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 09:03:19 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id c126-v6so2401171ywd.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 09:03:19 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr10701245ywg.47.1540742598186;
 Sun, 28 Oct 2018 09:03:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Sun, 28 Oct 2018 09:03:17
 -0700 (PDT)
In-Reply-To: <1540645734426.61104@xiaomi.com>
References: <1540645734426.61104@xiaomi.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 28 Oct 2018 16:03:17 +0000
X-Gmail-Original-Message-ID: <CAGXu5jJ_Xsf6KGpDCt5yvdwST9smutdwEeh3eRgj0zEmjz8zKg@mail.gmail.com>
Message-ID: <CAGXu5jJ_Xsf6KGpDCt5yvdwST9smutdwEeh3eRgj0zEmjz8zKg@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: Avoid duplicate call of persistent_ram_zap()
To:     =?UTF-8?B?UGVuZzE1IFdhbmcg546L6bmP?= <wangpeng15@xiaomi.com>
Cc:     "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 2:08 PM, Peng15 Wang =E7=8E=8B=E9=B9=8F <wangpeng15=
@xiaomi.com> wrote:
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
> ---
>  fs/pstore/ram.c            |  5 +++--
>  fs/pstore/ram_core.c       | 11 +++++++----
>  include/linux/pstore_ram.h |  3 ++-
>  3 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ffcff6516e89..3044274de2f0 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -596,7 +596,8 @@ static int ramoops_init_przs(const char *name,
>                                           name, i, *cnt - 1);
>                 prz_ar[i] =3D persistent_ram_new(*paddr, zone_sz, sig,
>                                                &cxt->ecc_info,
> -                                              cxt->memtype, flags, label=
);
> +                                              cxt->memtype, flags,
> +                                              label, true);
>                 if (IS_ERR(prz_ar[i])) {
>                         err =3D PTR_ERR(prz_ar[i]);
>                         dev_err(dev, "failed to request %s mem region (0x=
%zx@0x%llx): %d\n",
> @@ -640,7 +641,7 @@ static int ramoops_init_prz(const char *name,
>
>         label =3D kasprintf(GFP_KERNEL, "ramoops:%s", name);
>         *prz =3D persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
> -                                 cxt->memtype, 0, label);
> +                                 cxt->memtype, 0, label, false);
>         if (IS_ERR(*prz)) {
>                 int err =3D PTR_ERR(*prz);
>
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index 12e21f789194..d8a520c8741c 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -486,7 +486,8 @@ static int persistent_ram_buffer_map(phys_addr_t star=
t, phys_addr_t size,
>  }
>
>  static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32=
 sig,
> -                                   struct persistent_ram_ecc_info *ecc_i=
nfo)
> +                                   struct persistent_ram_ecc_info *ecc_i=
nfo,
> +                                   bool zap_option)
>  {
>         int ret;
>
> @@ -514,7 +515,8 @@ static int persistent_ram_post_init(struct persistent=
_ram_zone *prz, u32 sig,
>
>         /* Rewind missing or invalid memory area. */
>         prz->buffer->sig =3D sig;
> -       persistent_ram_zap(prz);
> +       if (zap_option)
> +               persistent_ram_zap(prz);

This part of persistent_ram_post_init() handles the "invalid buffer"
case, which should always zap. The question is whether or not to zap
in the case of a valid buffer (the "return 0" earlier in the
function). I think you v2 patch needs similar changes found in your
v1: the v2 patch also needs to remove the "return 0" and replace it
with "zap_option =3D true;" and to remove the zap call from
ramoops_init_prz(). Then I think all the paths will be consolidated.

-Kees

>
>         return 0;
>  }
> @@ -548,7 +550,8 @@ void persistent_ram_free(struct persistent_ram_zone *=
prz)
>
>  struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t=
 size,
>                         u32 sig, struct persistent_ram_ecc_info *ecc_info=
,
> -                       unsigned int memtype, u32 flags, char *label)
> +                       unsigned int memtype, u32 flags, char *label,
> +                       bool zap_option)
>  {
>         struct persistent_ram_zone *prz;
>         int ret =3D -ENOMEM;
> @@ -568,7 +571,7 @@ struct persistent_ram_zone *persistent_ram_new(phys_a=
ddr_t start, size_t size,
>         if (ret)
>                 goto err;
>
> -       ret =3D persistent_ram_post_init(prz, sig, ecc_info);
> +       ret =3D persistent_ram_post_init(prz, sig, ecc_info, zap_option);
>         if (ret)
>                 goto err;
>
> diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
> index 602d64725222..5d4acad9fe56 100644
> --- a/include/linux/pstore_ram.h
> +++ b/include/linux/pstore_ram.h
> @@ -66,7 +66,8 @@ struct persistent_ram_zone {
>
>  struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t=
 size,
>                         u32 sig, struct persistent_ram_ecc_info *ecc_info=
,
> -                       unsigned int memtype, u32 flags, char *label);
> +                       unsigned int memtype, u32 flags, char *label,
> +                       bool zap_option);
>  void persistent_ram_free(struct persistent_ram_zone *prz);
>  void persistent_ram_zap(struct persistent_ram_zone *prz);
>
> --
> 2.19.1



--=20
Kees Cook
