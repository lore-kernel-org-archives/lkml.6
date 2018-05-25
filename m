Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755340AbeEYC6B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:58:01 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42750 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755268AbeEYC5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:57:52 -0400
X-Google-Smtp-Source: ADUXVKIUI/68QbTx09EH6iz3axYTZpW093yzBeozVeesbbafEmGNvmWNWQZXPw3pfgXZLdq/mWVffA==
MIME-Version: 1.0
References: <b8eb41e576c4007d40223699eb951db32916b86a.camel@collabora.com> <25470133.K8n9sLBzRS@diego>
In-Reply-To: <25470133.K8n9sLBzRS@diego>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 25 May 2018 11:57:37 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DwFiKJ-JyFkFqC-XzTyBeanbQWazw8OqT4XQRmwrNJrA@mail.gmail.com>
Message-ID: <CAAFQd5DwFiKJ-JyFkFqC-XzTyBeanbQWazw8OqT4XQRmwrNJrA@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: vop: fix irq disabled after vop driver probed
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Ezequiel Garcia <ezequiel@collabora.com>,
        Jeffy <jeffy.chen@rock-chips.com>, enric.balletbo@collabora.co.uk,
        tomeu.vizoso@collabora.co.uk, Robin Murphy <robin.murphy@arm.com>,
        Ricky Liang <jcliang@chromium.org>, simon xue <xxm@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4P2w6pM017115

Hi Heiko, Sandy,

On Fri, May 25, 2018 at 7:07 AM Heiko Stübner <heiko@sntech.de> wrote:

> From: Sandy Huang <hjc@rock-chips.com>

> The vop irq is shared between vop and iommu and irq probing in the
> iommu driver moved to the probe function recently. This can in some
> cases lead to a stall if the irq is triggered while the vop driver
> still has it disabled.

> But there is no real need to disable the irq, as the vop can simply
> also track its enabled state and ignore irqs in that case.

> So remove the enable/disable handling and add appropriate condition
> to the irq handler.

> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> [added an actual commit message]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Hi Ezequiel,

> this patch came from a discussion I had with Rockchip people over the
> iommu changes and resulting issues back in april, but somehow was
> forgotten and not posted to the lists. Correcting that now.

> So removing the enable/disable voodoo on the shared interrupt is
> the preferred way.

>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 ++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 510cdf0..61493d4 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -549,8 +549,6 @@ static int vop_enable(struct drm_crtc *crtc)

>          spin_unlock(&vop->reg_lock);

> -       enable_irq(vop->irq);
> -

While this one should be okay (+/- my comment for vop_isr()), because the
hardware is already powered on and clocked at this point...

>          drm_crtc_vblank_on(crtc);

>          return 0;
> @@ -596,8 +594,6 @@ static void vop_crtc_atomic_disable(struct drm_crtc
*crtc,

>          vop_dsp_hold_valid_irq_disable(vop);

> -       disable_irq(vop->irq);
> -
>          vop->is_enabled = false;

...this one is more tricky. There might be an interrupt handler still
running at this point. disable_irq() waits for any running handler to
complete before disabling, so we might want to call synchronize_irq() after
setting is_enabled to false.


>          /*
> @@ -1168,6 +1164,13 @@ static irqreturn_t vop_isr(int irq, void *data)
>          int ret = IRQ_NONE;

>          /*
> +        * since the irq is shared with iommu, iommu irq is enabled
before vop
> +        * enable, so before vop enable we do nothing.
> +        */
> +       if (!vop->is_enabled)
> +               return IRQ_NONE;

This doesn't seem to be properly synchronized. We don't even call it under
a spinlock, so no barriers are issued. Perhaps we should make this atomic_t?

Best regards,
Tomasz
