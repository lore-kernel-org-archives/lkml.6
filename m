Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969179AbeEXVDm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:03:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56830 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967154AbeEXVDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:03:39 -0400
Message-ID: <b8eb41e576c4007d40223699eb951db32916b86a.camel@collabora.com>
Subject: Re: [PATCH v8 03/14] iommu/rockchip: Request irqs in
 rk_iommu_probe()
From: Ezequiel Garcia <ezequiel@collabora.com>
Reply-To: 20180323073814.5802-4-jeffy.chen@rock-chips.com
To: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Enric =?ISO-8859-1?Q?Balletb=F2?=
        <enric.balletbo@collabora.co.uk>,
        Tomeu Vizoso <tomeu.vizoso@collabora.co.uk>,
        Robin Murphy <robin.murphy@arm.com>
Cc: jcliang@chromium.org, xxm@rock-chips.com, tfiga@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date: Thu, 24 May 2018 18:02:10 -0300
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jeffy, Robin:

Some odd issues to report here.

On 23 March 2018 at 04:38, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Move request_irq to the end of rk_iommu_probe().
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> Loop platform_get_irq() as Robin suggested.
>
> Changes in v2: None
>
>  drivers/iommu/rockchip-iommu.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 73117dbe839e..ec3ff936aa60 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -90,8 +90,6 @@ struct rk_iommu {
>         struct device *dev;
>         void __iomem **bases;
>         int num_mmu;
> -       int *irq;
> -       int num_irq;
>         bool reset_disabled;
>         struct iommu_device iommu;
>         struct list_head node; /* entry in rk_iommu_domain.iommus */
> @@ -830,13 +828,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>
>         iommu->domain = domain;
>
> -       for (i = 0; i < iommu->num_irq; i++) {
> -               ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
> -                                      IRQF_SHARED, dev_name(dev), iommu);
> -               if (ret)
> -                       return ret;
> -       }
> -
>         for (i = 0; i < iommu->num_mmu; i++) {
>                 rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>                                rk_domain->dt_dma);
> @@ -885,9 +876,6 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>         }
>         rk_iommu_disable_stall(iommu);
>
> -       for (i = 0; i < iommu->num_irq; i++)
> -               devm_free_irq(iommu->dev, iommu->irq[i], iommu);
> -
>         iommu->domain = NULL;
>
>         dev_dbg(dev, "Detached from iommu domain\n");
> @@ -1138,7 +1126,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
>         struct rk_iommu *iommu;
>         struct resource *res;
>         int num_res = pdev->num_resources;
> -       int err, i;
> +       int err, i, irq;
>
>         iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
>         if (!iommu)
> @@ -1165,23 +1153,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
>         if (iommu->num_mmu == 0)
>                 return PTR_ERR(iommu->bases[0]);
>
> -       iommu->num_irq = platform_irq_count(pdev);
> -       if (iommu->num_irq < 0)
> -               return iommu->num_irq;
> -       if (iommu->num_irq == 0)
> -               return -ENXIO;
> +       i = 0;
> +       while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
> +               if (irq < 0)
> +                       return irq;
>
> -       iommu->irq = devm_kcalloc(dev, iommu->num_irq, sizeof(*iommu->irq),
> -                                 GFP_KERNEL);
> -       if (!iommu->irq)
> -               return -ENOMEM;
> -
> -       for (i = 0; i < iommu->num_irq; i++) {
> -               iommu->irq[i] = platform_get_irq(pdev, i);
> -               if (iommu->irq[i] < 0) {
> -                       dev_err(dev, "Failed to get IRQ, %d\n", iommu->irq[i]);
> -                       return -ENXIO;
> -               }
> +               err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
> +                                      IRQF_SHARED, dev_name(dev), iommu);
> +               if (err)
> +                       return err;
>         }
>
>         iommu->reset_disabled = device_property_read_bool(dev,
> --
> 2.11.0
>
>

Odd as it may be, this patch is causing problems with DRM,
on any recent kernel, either linux-next or v4.17-rc5 shows
the same issue.

I debugged this issue on a RK3288 Rock2 board connected to
a Samsung TV, but I also saw this warning on a RK3399 board.

The issue is a several-second stall at:

[..]
[    2.091953] rockchip-drm display-subsystem: bound ff930000.vop (ops 0xc078ebb4)
[    2.100310] rockchip-drm display-subsystem: bound ff940000.vop (ops 0xc078ebb4)
[    2.108550] dwhdmi-rockchip ff980000.hdmi: Detected HDMI TX controller v2.00a with HDCP (DWC MHL PHY)
[    2.119307] rockchip-drm display-subsystem: bound ff980000.hdmi (ops 0xc0790860)
[    2.127588] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.134988] [drm] No driver support for vblank timestamp query.
[boot stalls for several seconds]

followed by this warning:

[    2.251400] ------------[ cut here ]------------
[    2.251465] WARNING: CPU: 2 PID: 38 at /home/zeta/repos/linux/next/kernel/irq/manage.c:525 enable_irq+0x34/0x6c
[    2.251479] Unbalanced enable for IRQ 49
[    2.251490] Modules linked in:
[    2.251537] CPU: 2 PID: 38 Comm: kworker/2:1 Not tainted 4.17.0-rc5-00001-g5bc6dc2896ec-dirty #31
[    2.251551] Hardware name: Rockchip (Device Tree)
[    2.251595] Workqueue: events deferred_probe_work_func
[    2.251681] [<c0110984>] (unwind_backtrace) from [<c010ca98>] (show_stack+0x10/0x14)
[    2.251743] [<c010ca98>] (show_stack) from [<c06c7100>] (dump_stack+0x94/0xa8)
[    2.251807] [<c06c7100>] (dump_stack) from [<c0122140>] (__warn+0xf8/0x110)
[    2.251868] [<c0122140>] (__warn) from [<c0122190>] (warn_slowpath_fmt+0x38/0x48)
[    2.251927] [<c0122190>] (warn_slowpath_fmt) from [<c01722d0>] (enable_irq+0x34/0x6c)
[    2.251986] [<c01722d0>] (enable_irq) from [<c04afc34>] (vop_crtc_atomic_enable+0x2c4/0x7b4)
[    2.252053] [<c04afc34>] (vop_crtc_atomic_enable) from [<c047e20c>]
(drm_atomic_helper_commit_modeset_enables+0x170/0x19c)
[    2.252119] [<c047e20c>] (drm_atomic_helper_commit_modeset_enables) from [<c0480cfc>]
(drm_atomic_helper_commit_tail_rpm+0x24/0x64)
[    2.252175] [<c0480cfc>] (drm_atomic_helper_commit_tail_rpm) from [<c0480ca4>] (commit_tail+0x40/0x6c)
[    2.252230] [<c0480ca4>] (commit_tail) from [<c0480eb8>] (drm_atomic_helper_commit+0x118/0x120)
[    2.252291] [<c0480eb8>] (drm_atomic_helper_commit) from [<c049b02c>] (drm_atomic_commit+0x4c/0x50)
[    2.252357] [<c049b02c>] (drm_atomic_commit) from [<c0483440>] (restore_fbdev_mode_atomic+0x1b8/0x210)
[    2.252420] [<c0483440>] (restore_fbdev_mode_atomic) from [<c0486698>]
(drm_fb_helper_restore_fbdev_mode_unlocked+0x4c/0x90)
[    2.252469] [<c0486698>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c048670c>]
(drm_fb_helper_set_par+0x30/0x54)
[    2.252520] [<c048670c>] (drm_fb_helper_set_par) from [<c04014c4>] (fbcon_init+0x474/0x4b0)
[    2.252569] [<c04014c4>] (fbcon_init) from [<c044f358>] (visual_init+0x9c/0xe4)
[    2.252617] [<c044f358>] (visual_init) from [<c045129c>] (do_bind_con_driver+0x140/0x2bc)
[    2.252666] [<c045129c>] (do_bind_con_driver) from [<c045172c>] (do_take_over_console+0x12c/0x188)
[    2.252714] [<c045172c>] (do_take_over_console) from [<c0401580>] (do_fbcon_takeover+0x80/0xd8)
[    2.252775] [<c0401580>] (do_fbcon_takeover) from [<c0141818>] (notifier_call_chain+0x44/0x84)
[    2.252832] [<c0141818>] (notifier_call_chain) from [<c0141b0c>] (__blocking_notifier_call_chain+0x48/0x60)
[    2.252877] [<c0141b0c>] (__blocking_notifier_call_chain) from [<c0141b3c>] (blocking_notifier_call_chain+0x18/0x20)
[    2.252935] [<c0141b3c>] (blocking_notifier_call_chain) from [<c03f9654>] (register_framebuffer+0x1fc/0x2bc)
[    2.252996] [<c03f9654>] (register_framebuffer) from [<c048625c>]
(__drm_fb_helper_initial_config_and_unlock+0x21c/0x3f0)
[    2.253054] [<c048625c>] (__drm_fb_helper_initial_config_and_unlock) from [<c04b2210>]
(rockchip_drm_fbdev_init+0x68/0xf0)
[    2.253105] [<c04b2210>] (rockchip_drm_fbdev_init) from [<c04ad688>] (rockchip_drm_bind+0x184/0x1dc)
[    2.253163] [<c04ad688>] (rockchip_drm_bind) from [<c04c2a94>] (try_to_bring_up_master+0x148/0x188)
[    2.253226] [<c04c2a94>] (try_to_bring_up_master) from [<c04c2cdc>] (component_master_add_with_match+0xc4/0xf8)
[    2.253282] [<c04c2cdc>] (component_master_add_with_match) from [<c04ad8c8>]
(rockchip_drm_platform_probe+0x1a0/0x268)
[    2.253336] [<c04ad8c8>] (rockchip_drm_platform_probe) from [<c04c9a4c>] (platform_drv_probe+0x4c/0xac)
[    2.253390] [<c04c9a4c>] (platform_drv_probe) from [<c04c7dd0>] (driver_probe_device+0x23c/0x33c)
[    2.253440] [<c04c7dd0>] (driver_probe_device) from [<c04c629c>] (bus_for_each_drv+0x58/0x8c)
[    2.253486] [<c04c629c>] (bus_for_each_drv) from [<c04c7ab8>] (__device_attach+0xb0/0x110)
[    2.253532] [<c04c7ab8>] (__device_attach) from [<c04c704c>] (bus_probe_device+0x84/0x8c)
[    2.253577] [<c04c704c>] (bus_probe_device) from [<c04c74e0>] (deferred_probe_work_func+0x44/0x13c)
[    2.253637] [<c04c74e0>] (deferred_probe_work_func) from [<c013ad90>] (process_one_work+0x14c/0x42c)
[    2.253699] [<c013ad90>] (process_one_work) from [<c013b298>] (worker_thread+0x228/0x538)
[    2.253755] [<c013b298>] (worker_thread) from [<c01402d8>] (kthread+0x12c/0x15c)
[    2.253802] [<c01402d8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    2.253822] Exception stack(0xee3affb0 to 0xee3afff8)
[    2.253855] ffa0:                                     00000000 00000000 00000000 00000000
[    2.253896] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.253930] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.253951] ---[ end trace b95f9f3d3a06357b ]---

Git-bisection wasn't easy because of regressions in the middle
of the merge, so I did some manual bisection until I found
this patch!

There are two workaround for this issue:

1) Don't request the interrupts in the iommu driver:

--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1152,17 +1152,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
        if (iommu->num_mmu == 0)
                return PTR_ERR(iommu->bases[0]);
 
-       i = 0;
-       while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
-               if (irq < 0)
-                       return irq;
-
-               err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
-                                      IRQF_SHARED, dev_name(dev), iommu);
-               if (err)
-                       return err;
-       }
-

2) Don't disable/enable interrupts in the vop driver:

--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -549,8 +549,6 @@ static int vop_enable(struct drm_crtc *crtc)
 
        spin_unlock(&vop->reg_lock);
 
-       enable_irq(vop->irq);
-
        drm_crtc_vblank_on(crtc);
 
        return 0;
@@ -596,8 +594,6 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 
        vop_dsp_hold_valid_irq_disable(vop);
 
-       disable_irq(vop->irq);
-
        vop->is_enabled = false;
 
        /*
@@ -1586,9 +1582,6 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
        if (ret)
                goto err_disable_pm_runtime;
 
-       /* IRQ is initially disabled; it gets enabled in power_on */
-       disable_irq(vop->irq);
-

Any of these remove the stall and the warning.

Ideas?

Confused as hell,
Eze
