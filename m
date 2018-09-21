Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D36ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0239921550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0239921550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390566AbeIUWNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:13:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728221AbeIUWNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:13:38 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 29AE3F65F81C4;
        Sat, 22 Sep 2018 00:23:59 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Sat, 22 Sep 2018
 00:23:50 +0800
Subject: Re: Bug report: HiBMC crash
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>
References: <d390c2df-64f6-484e-e48f-953e88cc4501@huawei.com>
 <40ead141-6d9d-31bf-4b62-639b31db9793@huawei.com>
 <5BA48650.7050505@hisilicon.com>
 <e8f99d84-422f-f79f-f207-e9658b190800@huawei.com>
 <153754012047.21139.481244931312769112@skylake-alporthouse-com>
CC:     Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <daniel.vetter@ffwll.ch>, <baowenyi@huawei.com>,
        "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <55d90408-084a-6f20-26c4-b5bc1536d600@huawei.com>
Date:   Fri, 21 Sep 2018 17:23:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <153754012047.21139.481244931312769112@skylake-alporthouse-com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2018 15:28, Chris Wilson wrote:
> Quoting John Garry (2018-09-21 09:11:19)
>> On 21/09/2018 06:49, Liuxinliang (Matthew Liu) wrote:
>>> Hi John,
>>> Thank you for reporting bug.
>>> I am now using 4.18.7. I haven't found this issue yet.
>>> I will try linux-next and figure out what's wrong with it.
>>>
>>> Thanks,
>>> Xinliang
>>>
>>>
>>
>> As mentioned in internal mail, the issue may be that the surface
>> depth/bpp we were using the in the driver was previously invalid, but
>> code has since been added in v4.19 to reject this. Specifically it looks
>> like this patch:
>>
>> commit 70109354fed232dfce8fb2c7cadf635acbe03e19
>> Author: Chris Wilson <chris@chris-wilson.co.uk>
>> Date:   Wed Sep 5 16:31:16 2018 +0100
>>
>>      drm: Reject unknown legacy bpp and depth for drm_mode_addfb ioctl
>
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
> index b92595c477ef..f3e7f41e6781 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
> @@ -71,7 +71,6 @@ static int hibmc_drm_fb_create(struct drm_fb_helper *helper,
>         DRM_DEBUG_DRIVER("surface width(%d), height(%d) and bpp(%d)\n",
>                          sizes->surface_width, sizes->surface_height,
>                          sizes->surface_bpp);
> -       sizes->surface_depth = 32;
>
>         bytes_per_pixel = DIV_ROUND_UP(sizes->surface_bpp, 8);
>
> @@ -192,7 +191,6 @@ int hibmc_fbdev_init(struct hibmc_drm_private *priv)
>                 return -ENOMEM;
>         }
>
> -       priv->fbdev = hifbdev;
>         drm_fb_helper_prepare(priv->dev, &hifbdev->helper,
>                               &hibmc_fbdev_helper_funcs);
>
> @@ -246,6 +244,7 @@ int hibmc_fbdev_init(struct hibmc_drm_private *priv)
>                          fix->ypanstep, fix->ywrapstep, fix->line_length,
>                          fix->accel, fix->capabilities);
>
> +       priv->fbdev = hifbdev;
>         return 0;
>
>  fini:
 >
 > Apply chunks 2&3 first to confirm they fix the GPF.
 > -Chris

Hi Chris,

So relocating where priv->fbdev is set does fix the crash.

However then applying chunk #1 introduces another crash:

     9.229007] pci 0007:90:00.0: can't derive routing for PCI INT A
[    9.235082] hibmc-drm 0007:91:00.0: PCI INT A: no GSI
[    9.240457] [TTM] Zone  kernel: Available graphics memory: 16297792 kiB
[    9.247147] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    9.253744] [TTM] Initializing pool allocator
[    9.258148] [TTM] Initializing DMA pool allocator
[    9.262951] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    9.269636] [drm] No driver support for vblank timestamp query.
[    9.280967] Unable to handle kernel    9.229007] pci 0007:90:00.0: 
can't derive routing for PCI INT A
[    9.235082] hibmc-drm 0007:91:00.0: PCI INT A: no GSI
[    9.240457] [TTM] Zone  kernel: Available graphics memory: 16297792 kiB
[    9.247147] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    9.253744] [TTM] Initializing pool allocator
[    9.258148] [TTM] Initializing DMA pool allocator
[    9.262951] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    9.269636] [drm] No driver support for vblank timestamp query.
[    9.280967] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000150
[    9.289849] Mem abort info:
[    9.292666]   ESR = 0x96000044
[    9.295747]   Exception class = DABT (current EL), IL = 32 bits
[    9.301728]   SET = 0, FnV = 0
[    9.304809]   EA = 0, S1PTW = 0
[    9.307977] Data abort info:
[    9.310882]   ISV = 0, ISS = 0x00000044
[    9.314754]   CM = 0, WnR = 1
[    9.317744] [0000000000000150] user address but active_mm is swapper
[    9.324166] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[    9.329793] Modules linked in:
[    9.332874] CPU: 16 PID: 293 Comm: kworker/16:1 Not tainted 
4.19.0-rc4-next-20180920-00001-g9b0012c-dirty #345
[    9.342983] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon 
D05 IT21 Nemo 2.0 RC0 04/18/2018
[    9.352223] Workqueue: events work_for_cpu_fn
[    9.356621] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    9.361461] pc : hibmc_drm_fb_create+0x20c/0x3c0
[    9.366122] lr : hibmc_drm_fb_create+0x1e4/0x3c0
[    9.370781] sp : ffff00000aeebb50
[    9.374123] x29: ffff00000aeebb50 x28: 0000000000000000
[    9.379489] x27: ffff00000aeebca0 x26: ffff8017b3830800
[    9.384854] x25: ffff8017b3828018 x24: ffff8017b3850018
[    9.390219] x23: ffff8017b3830670 x22: ffff8017b3830800
[    9.395583] x21: 00000000000eb000 x20: ffff8017b3830a70
[    9.400948] x19: ffff0000091f9000 x18: ffffffffffffffff
[    9.406313] x17: 0000000000000000 x16: ffff8017d4168000
[    9.411678] x15: ffff0000091f96c8 x14: ffff000009049000
[    9.417042] x13: 0000000000000000 x12: 0000000000000000
[    9.422407] x11: ffff8017daf39940 x10: 0000000000000040
[    9.427772] x9 : ffff8017b53e02b0 x8 : ffff8017daf39918
[    9.433136] x7 : ffff8017daf39a60 x6 : ffff8017b3840800
[    9.438500] x5 : 0000000000000000 x4 : 0000000000000000
[    9.443865] x3 : ffff8017b53e0290 x2 : ffff000009306000
[    9.449229] x1 : ffff000008fe1d70 x0 : 0000000000000000
[    9.454594] Process kworker/16:1 (pid: 293, stack limit = 
0x(____ptrval____))
[    9.461803] Call trace:
[    9.464267]  hibmc_drm_fb_create+0x20c/0x3c0
[    9.468578]  __drm_fb_helper_initial_config_and_unlock+0x1cc/0x418
[    9.474820]  drm_fb_helper_initial_config+0x3c/0x48
[    9.479744]  hibmc_fbdev_init+0xb8/0x1b0
[    9.483701]  hibmc_pci_probe+0x2f4/0x3c8
[    9.487660]  local_pci_probe+0x3c/0xb0
[    9.491442]  work_for_cpu_fn+0x18/0x28
[    9.495225]  process_one_work+0x1e0/0x318
[    9.499270]  worker_thread+0x228/0x450
[    9.503052]  kthread+0x128/0x130
[    9.506308]  ret_from_fork+0x10/0x18
[    9.509914] Code: 12144eb5 b0004841 9135c021 d0006162 (b9015015)
[    9.516071] ---[ end trace ce5de8f0d3370702 ]---

  NULL pointer dereference at virtual address 0000000000000150
[    9.289849] Mem abort info:
[    9.292666]   ESR = 0x96000044
[    9.295747]   Exception class = DABT (current EL), IL = 32 bits
[    9.301728]   SET = 0, FnV = 0
[    9.304809]   EA = 0, S1PTW = 0
[    9.307977] Data abort info:
[    9.310882]   ISV = 0, ISS = 0x00000044
[    9.314754]   CM = 0, WnR = 1
[    9.317744] [0000000000000150] user address but active_mm is swapper
[    9.324166] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[    9.329793] Modules linked in:
[    9.332874] CPU: 16 PID: 293 Comm: kworker/16:1 Not tainted 
4.19.0-rc4-next-20180920-00001-g9b0012c-dirty #345
[    9.342983] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon 
D05 IT21 Nemo 2.0 RC0 04/18/2018
[    9.352223] Workqueue: events work_for_cpu_fn
[    9.356621] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    9.361461] pc : hibmc_drm_fb_create+0x20c/0x3c0
[    9.366122] lr : hibmc_drm_fb_create+0x1e4/0x3c0
[    9.370781] sp : ffff00000aeebb50
[    9.374123] x29: ffff00000aeebb50 x28: 0000000000000000
[    9.379489] x27: ffff00000aeebca0 x26: ffff8017b3830800
[    9.384854] x25: ffff8017b3828018 x24: ffff8017b3850018
[    9.390219] x23: ffff8017b3830670 x22: ffff8017b3830800
[    9.395583] x21: 00000000000eb000 x20: ffff8017b3830a70
[    9.400948] x19: ffff0000091f9000 x18: ffffffffffffffff
[    9.406313] x17: 0000000000000000 x16: ffff8017d4168000
[    9.411678] x15: ffff0000091f96c8 x14: ffff000009049000
[    9.417042] x13: 0000000000000000 x12: 0000000000000000
[    9.422407] x11: ffff8017daf39940 x10: 0000000000000040
[    9.427772] x9 : ffff8017b53e02b0 x8 : ffff8017daf39918
[    9.433136] x7 : ffff8017daf39a60 x6 : ffff8017b3840800
[    9.438500] x5 : 0000000000000000 x4 : 0000000000000000
[    9.443865] x3 : ffff8017b53e0290 x2 : ffff000009306000
[    9.449229] x1 : ffff000008fe1d70 x0 : 0000000000000000
[    9.454594] Process kworker/16:1 (pid: 293, stack limit = 
0x(____ptrval____))
[    9.461803] Call trace:
[    9.464267]  hibmc_drm_fb_create+0x20c/0x3c0
[    9.468578]  __drm_fb_helper_initial_config_and_unlock+0x1cc/0x418
[    9.474820]  drm_fb_helper_initial_config+0x3c/0x48
[    9.479744]  hibmc_fbdev_init+0xb8/0x1b0
[    9.483701]  hibmc_pci_probe+0x2f4/0x3c8
[    9.487660]  local_pci_probe+0x3c/0xb0
[    9.491442]  work_for_cpu_fn+0x18/0x28
[    9.495225]  process_one_work+0x1e0/0x318
[    9.499270]  worker_thread+0x228/0x450
[    9.503052]  kthread+0x128/0x130
[    9.506308]  ret_from_fork+0x10/0x18
[    9.509914] Code: 12144eb5 b0004841 9135c021 d0006162 (b9015015)
[    9.516071] ---[ end trace ce5de8f0d3370702 ]---


I already locally added the following to fix error path (with identical 
chunk #1) instead of #2+3:

index b92595c..8bd2907 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
@@ -122,6 +122,7 @@ static int hibmc_drm_fb_create(struct drm_fb_helper 
*helper,
         hi_fbdev->fb = hibmc_framebuffer_init(priv->dev, &mode_cmd, gobj);
         if (IS_ERR(hi_fbdev->fb)) {
                 ret = PTR_ERR(hi_fbdev->fb);
+               hi_fbdev->fb = NULL;
                 DRM_ERROR("failed to initialize framebuffer: %d\n", ret);
                 goto out_release_fbi;
         }

And vga function seems ok:
[    9.233035] hibmc-drm 0007:91:00.0: PCI INT A: no GSI
[    9.238361] [TTM] Zone  kernel: Available graphics memory: 16297762 kiB
[    9.245051] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    9.251650] [TTM] Initializing pool allocator
[    9.256052] [TTM] Initializing DMA pool allocator
[    9.260856] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    9.267541] [drm] No driver support for vblank timestamp query.
[    9.306234] Console: switching to colour frame buffer device 100x37
[    9.329622] hibmc-drm 0007:91:00.0: fb0: hibmcdrmfb frame buffer device
[    9.336530] [drm] Initialized hibmc 1.0.0 20160828 for 0007:91:00.0 
on minor 0
[    9.356393] loop: module loaded

I can send a patchset, but it would be good for a hibmc maintainer to 
also comment ....

Thanks,
John

>
> .
>


