Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeECRJW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:09:22 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43749 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECRJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:09:19 -0400
X-Google-Smtp-Source: AB8JxZq8L/8KUHVN9edmN9lF6rXdiGNAGfjYVXM5DBwnH96sh4ljYjzNLnmDHHqyNpKXWfEpqauT4jV9fWGBAceuD6Q=
MIME-Version: 1.0
In-Reply-To: <20180502200137.6870-1-malat@debian.org>
References: <20180423195055.26069-1-malat@debian.org> <20180502200137.6870-1-malat@debian.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 3 May 2018 19:08:58 +0200
X-Google-Sender-Auth: wJPxiWJXW7Bvh6mmULa_uCvP-qs
Message-ID: <CA+7wUsxvpRXixzT6WNLQng1rsXMzi9A-wvHGnivMAs5=x2LXOg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild/debian: Use KBUILD_BUILD_* when set
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "Malaterre, Mathieu" <malat@debian.org>,
        Riku Voipio <riku.voipio@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 10:01 PM, Mathieu Malaterre <malat@debian.org> wrote:
> Be nice to the user and check env vars KBUILD_BUILD_USER &
> KBUILD_BUILD_HOST when those are set.
>
> Since DEBEMAIL accept a syntax where the full name is present, be extra
> nice to user and extract email address only.
>
> Cc: Riku Voipio <riku.voipio@linaro.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: update patch since syntax of DEBEMAIL may contain full name

Should be replaced by:

https://lists.debian.org/debian-kernel/2018/05/msg00029.html

>  scripts/package/mkdebian | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 6adb3a16ba3b..3f4e43446db3 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -73,9 +73,19 @@ fi
>
>  # Try to determine maintainer and email values
>  if [ -n "$DEBEMAIL" ]; then
> -       email=$DEBEMAIL
> +       case "$DEBEMAIL" in
> +         *\ * )
> +           email=$(echo $DEBEMAIL | cut -d '<' -f2 | cut -d '>' -f1)
> +           echo >&2 "Extracting email from DEBEMAIL. Use DEBFULLNAME instead."
> +           ;;
> +         *)
> +           email=$DEBEMAIL
> +           ;;
> +       esac
>  elif [ -n "$EMAIL" ]; then
>         email=$EMAIL
> +elif [ -n "$KBUILD_BUILD_USER" ] && [ -n "$KBUILD_BUILD_HOST" ]; then
> +       email=$KBUILD_BUILD_USER@$KBUILD_BUILD_HOST
>  else
>         email=$(id -nu)@$(hostname -f 2>/dev/null || hostname)
>  fi
> --
> 2.11.0
>
