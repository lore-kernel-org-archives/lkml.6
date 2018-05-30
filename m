Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968618AbeE3B6o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:58:44 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41605 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965890AbeE3B6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:58:39 -0400
X-Google-Smtp-Source: ADUXVKJHmMxnu/MUBKbyMTPWVUuePB/xN6jCEYn79Yqr4osi8rYQm5iebevnvSJyIvefuCwP0YgT34+FX0kYQy42hUs=
MIME-Version: 1.0
In-Reply-To: <1527577145-7750-1-git-send-email-nick.desaulniers@gmail.com>
References: <1527577145-7750-1-git-send-email-nick.desaulniers@gmail.com>
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Tue, 29 May 2018 18:58:38 -0700
Message-ID: <CAH7mPvioLyWRYz1+yORXbJVaMV+pTLgPKgPZ1OTFLak6tjdZSQ@mail.gmail.com>
Subject: Re: [PATCH] video/hdmi: prefer strlcpy to strncpy
To: b.zolnierkie@samsung.com
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ebiggers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:59 PM, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> Fixes a stringop-truncation warning from gcc-8.
>
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  drivers/video/hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> index 111a0ab..46c184c 100644
> --- a/drivers/video/hdmi.c
> +++ b/drivers/video/hdmi.c
> @@ -168,8 +168,8 @@ int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
>         frame->version = 1;
>         frame->length = HDMI_SPD_INFOFRAME_SIZE;
>
> -       strncpy(frame->vendor, vendor, sizeof(frame->vendor));
> -       strncpy(frame->product, product, sizeof(frame->product));
> +       strlcpy(frame->vendor, vendor, sizeof(frame->vendor));
> +       strlcpy(frame->product, product, sizeof(frame->product));
>
>         return 0;
>  }
> --
> 2.7.4
>

Eric points out this can leak kernel memory if size is less than length of src.
