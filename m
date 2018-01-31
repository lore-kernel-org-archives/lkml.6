Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbeAaPtd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:49:33 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:37486 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbeAaPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:49:31 -0500
X-Google-Smtp-Source: AH8x225b0Mq/Cw31+GxdVZGfwyJjTk80mccs5hY32Crex0b1gVpOWefVW7JTV4WBkNgPh2hyev8/y8xhqRuoSqCXtDk=
MIME-Version: 1.0
In-Reply-To: <20180131145755.26109-1-peter.malone@gmail.com>
References: <20180130203042.4797-1-peter.malone@gmail.com> <20180131145755.26109-1-peter.malone@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 31 Jan 2018 16:49:10 +0100
X-Google-Sender-Auth: 3v3tbi68gG8NgkGdz0pvc2SKU5Q
Message-ID: <CA+7wUsyy+g5evf0SQ+AWZdUzHR9uh1dBWYJm6z+c13XvVtyerw@mail.gmail.com>
Subject: Re: [PATCH v2] Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC
 in sbusfb_ioctl_helper().
To: Peter Malone <peter.malone@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Jan 31, 2018 at 3:57 PM, Peter Malone <peter.malone@gmail.com> wrote:
> Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in
> sbusfb_ioctl_helper().
>
> 'index' is defined as an int in sbusfb_ioctl_helper().
> We retrieve this from the user:
> if (get_user(index, &c->index) ||
>     __get_user(count, &c->count) ||
>     __get_user(ured, &c->red) ||
>     __get_user(ugreen, &c->green) ||
>     __get_user(ublue, &c->blue))
>        return -EFAULT;
>
> and then we use 'index' in the following way:
> red = cmap->red[index + i] >> 8;
> green = cmap->green[index + i] >> 8;
> blue = cmap->blue[index + i] >> 8;
>
> This is a classic information leak vulnerability. 'index' should be
> an unsigned int, given its usage above.
>
> This patch is straight-forward; it changes 'index' to unsigned int
> in two switch-cases: FBIOGETCMAP_SPARC && FBIOPUTCMAP_SPARC.
>
> Signed-off-by: Peter Malone <peter.malone@gmail.com>
> ---

much better :)

> v2: fixed formatting
>
>  drivers/video/fbdev/sbuslib.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
> index af6fc97f4ba4..a436d44f1b7f 100644
> --- a/drivers/video/fbdev/sbuslib.c
> +++ b/drivers/video/fbdev/sbuslib.c
> @@ -122,7 +122,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
>                 unsigned char __user *ured;
>                 unsigned char __user *ugreen;
>                 unsigned char __user *ublue;
> -               int index, count, i;
> +               unsigned int index, count, i;
>
>                 if (get_user(index, &c->index) ||
>                     __get_user(count, &c->count) ||
> @@ -161,7 +161,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
>                 unsigned char __user *ugreen;
>                 unsigned char __user *ublue;
>                 struct fb_cmap *cmap = &info->cmap;
> -               int index, count, i;
> +               unsigned int index, count, i;
>                 u8 red, green, blue;
>
>                 if (get_user(index, &c->index) ||
> --
> 2.14.3
>

By just looking at the code and commit message:

Acked-by: Mathieu Malaterre <malat@debian.org>
