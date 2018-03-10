Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeCJPY2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 10:24:28 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41332 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932188AbeCJPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 10:24:26 -0500
X-Google-Smtp-Source: AG47ELsuPNHY8VV2aVy0wglMjl84WiqGKPB52XcUmZfIGFo+9Dwzjmf5kYiV8twN9qRrAEoQwhWC6nDBW/Bnr3LJfuk=
MIME-Version: 1.0
In-Reply-To: <744974f1-d9b3-9fc1-621d-f4b5d3e806b6@spiers.me>
References: <744974f1-d9b3-9fc1-621d-f4b5d3e806b6@spiers.me>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 10 Mar 2018 07:24:24 -0800
X-Google-Sender-Auth: coKOF72uu7cI4OMiTlUiqTTh3As
Message-ID: <CAGXu5j+Suz=mkXm9W=OXjkXU5nRBrkKc=cdYsJ0nYu2Ba-qN_w@mail.gmail.com>
Subject: Re: [PATCH] rbd: Remove VLA usage
To: Kyle Spiers <kyle@spiers.me>
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
        Alex Elder <elder@kernel.org>, ceph-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 9:14 PM, Kyle Spiers <kyle@spiers.me> wrote:
> From 4198ebe2e8058ff676d8e2f993d8806d6ca29c11 Mon Sep 17 00:00:00 2001
> From: Kyle Spiers <kyle@spiers.me>
> Date: Fri, 9 Mar 2018 12:34:15 -0800
> Subject: [PATCH] rbd: Remove VLA usage
>
> As part of the effort to remove VLAs from the kernel[1], this moves
> the literal values into the stack array calculation instead of using a
> variable for the sizing. The resulting size can be found from
> sizeof(buf).
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Kyle Spiers <kyle@spiers.me>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> ---
>  drivers/block/rbd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8e40da0..0e94e1f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3100,8 +3100,8 @@ static int __rbd_notify_op_lock(struct rbd_device
> *rbd_dev,
>  {
>      struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>      struct rbd_client_id cid = rbd_get_cid(rbd_dev);
> -    int buf_size = 4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN;
> -    char buf[buf_size];
> +    char buf[4 + 4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN];
> +    int buf_size = sizeof(buf);
>      void *p = buf;
>
>      dout("%s rbd_dev %p notify_op %d\n", __func__, rbd_dev, notify_op);
> @@ -3619,8 +3619,8 @@ static void __rbd_acknowledge_notify(struct
> rbd_device *rbd_dev,
>                       u64 notify_id, u64 cookie, s32 *result)
>  {
>      struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
> -    int buf_size = 4 + CEPH_ENCODING_START_BLK_LEN;
> -    char buf[buf_size];
> +    char buf[4 + CEPH_ENCODING_START_BLK_LEN];
> +    int buf_size = sizeof(buf);
>      int ret;
>
>      if (result) {
> -- 2.7.4
>



-- 
Kees Cook
Pixel Security
