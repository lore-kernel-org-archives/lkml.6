Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbeE1COJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 22:14:09 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41570 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752950AbeE1COG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 22:14:06 -0400
X-Google-Smtp-Source: ADUXVKKSy9C/a48fkze6rIy8OJFfqvQvLi5yNOmfqjJ4qEY8ARAnLSUeOxqEMiYJ6QamCoxEqRlPtTTl82AySytQZMo=
MIME-Version: 1.0
In-Reply-To: <20180527215411.24701-1-colin.king@canonical.com>
References: <20180527215411.24701-1-colin.king@canonical.com>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Sun, 27 May 2018 22:14:05 -0400
X-Google-Sender-Auth: UN-hyhUS61dlWNvgOyuiVg01ebk
Message-ID: <CAKb7Uvjwid5WSyCm2_+sZ2EPauaG0ef9QS2gm_tSk53hXtkHDA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH][next] drm/nouveau/disp: avoid potential
 overflow on shift of int value
To: Colin King <colin.king@canonical.com>
Cc: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 5:54 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The constant values being shifted are 32 bit integers and may potentially
> overflow on the shift.  Avoid this potential overflow by making them
> unsigned long long values before the shift.
>
> Detected by CoverityScan, CID#1469383, 1469400 ("Unintentional
> integer overflow")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/changf119.c | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/changf119.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/changf119.c
> index 29e6dd58ac48..99b94802ed63 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/changf119.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/changf119.c
> @@ -52,7 +52,7 @@ void
>  gf119_disp_chan_intr(struct nv50_disp_chan *chan, bool en)
>  {
>         struct nvkm_device *device = chan->disp->base.engine.subdev.device;
> -       const u64 mask = 0x00000001 << chan->chid.user;
> +       const u64 mask = 0x00000001ULL << chan->chid.user;

I'm pretty sure all of these should just be u32 (below as well). The
registers that this is masking are all 32-bit, more doesn't make
sense.

>         if (!en) {
>                 nvkm_mask(device, 0x610090, mask, 0x00000000);
>                 nvkm_mask(device, 0x6100a0, mask, 0x00000000);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
> index 57719f675eec..43ae3b092e43 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
> @@ -166,7 +166,7 @@ void
>  nv50_disp_chan_intr(struct nv50_disp_chan *chan, bool en)
>  {
>         struct nvkm_device *device = chan->disp->base.engine.subdev.device;
> -       const u64 mask = 0x00010001 << chan->chid.user;
> +       const u64 mask = 0x00010001ULL << chan->chid.user;
>         const u64 data = en ? 0x00010000 : 0x00000000;
>         nvkm_mask(device, 0x610028, mask, data);
>  }
> --
> 2.17.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
