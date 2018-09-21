Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF1ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58562154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58562154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbeIUN7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:59:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388909AbeIUN7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:59:19 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 298E0942DBA91;
        Fri, 21 Sep 2018 16:11:32 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 16:11:25 +0800
Subject: Re: Bug report: HiBMC crash
To:     "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <d390c2df-64f6-484e-e48f-953e88cc4501@huawei.com>
 <40ead141-6d9d-31bf-4b62-639b31db9793@huawei.com>
 <5BA48650.7050505@hisilicon.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <chris@chris-wilson.co.uk>, <daniel.vetter@ffwll.ch>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e8f99d84-422f-f79f-f207-e9658b190800@huawei.com>
Date:   Fri, 21 Sep 2018 09:11:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <5BA48650.7050505@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2018 06:49, Liuxinliang (Matthew Liu) wrote:
> Hi John,
> Thank you for reporting bug.
> I am now using 4.18.7. I haven't found this issue yet.
> I will try linux-next and figure out what's wrong with it.
>
> Thanks,
> Xinliang
>
>

As mentioned in internal mail, the issue may be that the surface 
depth/bpp we were using the in the driver was previously invalid, but 
code has since been added in v4.19 to reject this. Specifically it looks 
like this patch:

commit 70109354fed232dfce8fb2c7cadf635acbe03e19
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Wed Sep 5 16:31:16 2018 +0100

     drm: Reject unknown legacy bpp and depth for drm_mode_addfb ioctl


Thanks,
John

> On 2018/9/20 19:23, John Garry wrote:
>> On 20/09/2018 11:04, John Garry wrote:
>>> Hi,
>>>
>>> I am seeing this crash below on linux-next (20 Sept).
>>>
>>> This is on an arm64 D05 board, which includes the HiBMC device. D06 was
>>> also crashing for what looked like same reason. I am using standard
>>> defconfig, except DRM and DRM_HISI_HIBMC are built-in.
>>>
>>> Is this a known issue? I tested v4.19-rc3 and it had no such crash.
>>>
>>> The origin seems to be here, where pointer info is not checked for NULL
>>> for safety:
>>> static int framebuffer_check(struct drm_device *dev,
>>>                  const struct drm_mode_fb_cmd2 *r)
>>> {
>>> ...
>>>
>>>     /* now let the driver pick its own format info */
>>>     info = drm_get_format_info(dev, r);
>>>
>>> ...
>>>
>>>     for (i = 0; i < info->num_planes; i++) {
>>>         unsigned int width = fb_plane_width(r->width, info, i);
>>>         unsigned int height = fb_plane_height(r->height, info, i);
>>>         unsigned int cpp = info->cpp[i];
>>>
>>>
>>
>> Upon closer inspection the crash is actually from hibmc probe error
>> handling path, specifically
>> hibmc_fbdev_destroy()->drm_framebuffer_put() is called with fb holding
>> the error value from hibmc_framebuffer_init(), as shown:
>>
>> static int hibmc_drm_fb_create(struct drm_fb_helper *helper,
>>                    struct drm_fb_helper_surface_size *sizes)
>> {
>>
>>     ...
>>
>>     hi_fbdev->fb = hibmc_framebuffer_init(priv->dev, &mode_cmd, gobj);
>>     if (IS_ERR(hi_fbdev->fb)) {
>>         ret = PTR_ERR(hi_fbdev->fb);
>>
>>         *** hi_fbdev->fb holds error code ***
>>
>>         DRM_ERROR("failed to initialize framebuffer: %d\n", ret);
>>         goto out_release_fbi;
>>     }
>>
>>
>> static void hibmc_fbdev_destroy(struct hibmc_fbdev *fbdev)
>> {
>>     struct hibmc_framebuffer *gfb = fbdev->fb;
>>     struct drm_fb_helper *fbh = &fbdev->helper;
>>
>>     drm_fb_helper_unregister_fbi(fbh);
>>
>>     drm_fb_helper_fini(fbh);
>>
>> **    &gfb->fb holds error code, not pointer ***
>>
>>     if (gfb)
>>         drm_framebuffer_put(&gfb->fb);
>> }
>>
>> This change fixes the crash for me:
>>
>>     hi_fbdev->fb = hibmc_framebuffer_init(priv->dev, &mode_cmd, gobj);
>>     if (IS_ERR(hi_fbdev->fb)) {
>>         ret = PTR_ERR(hi_fbdev->fb);
>> +        hi_fbdev->fb = NULL;
>>         DRM_ERROR("failed to initialize framebuffer: %d\n", ret);
>>         goto out_release_fbi;
>>     }
>>
>> Why we're hitting the error path at all, I don't know.
>>
>> And, having said all that, the code I pointed out in
>> framebuffer_check() still does not seem safe for same reason I
>> mentioned originally.
>>
>> John
>>
>>> John
>>>
>>> [    9.220446] pci 0007:90:00.0: can't derive routing for PCI INT A
>>> [    9.226517] hibmc-drm 0007:91:00.0: PCI INT A: no GSI
>>> [    9.231847] [TTM] Zone  kernel: Available graphics memory:
>>> 16297696 kiB
>>> [    9.238536] [TTM] Zone   dma32: Available graphics memory: 2097152
>>> kiB
>>> [    9.245133] [TTM] Initializing pool allocator
>>> [    9.249536] [TTM] Initializing DMA pool allocator
>>> [    9.254340] [drm] Supports vblank timestamp caching Rev 2
>>> (21.10.2013).
>>> [    9.261026] [drm] No driver support for vblank timestamp query.
>>> [    9.272431] WARNING: CPU: 16 PID: 293 at
>>> drivers/gpu/drm/drm_fourcc.c:221 drm_format_info.part.1+0x0/0x8
>>> [    9.282014] Modules linked in:
>>> [    9.285095] CPU: 16 PID: 293 Comm: kworker/16:1 Not tainted
>>> 4.19.0-rc4-next-20180920-00001-g9b0012c #322
>>> [    9.294677] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
>>> D05 IT21 Nemo 2.0 RC0 04/18/2018
>>> [    9.303915] Workqueue: events work_for_cpu_fn
>>> [    9.308314] pstate: 60000005 (nZCv daif -PAN -UAO)
>>> [    9.313150] pc : drm_format_info.part.1+0x0/0x8
>>> [    9.317724] lr : drm_get_format_info+0x90/0x98
>>> [    9.322208] sp : ffff00000af1baf0
>>> [    9.325549] x29: ffff00000af1baf0 x28: 0000000000000000
>>> [    9.330915] x27: ffff00000af1bcb0 x26: ffff8017d3018800
>>> [    9.336279] x25: ffff8017d28a0018 x24: ffff8017d2f80018
>>> [    9.341644] x23: ffff8017d3018670 x22: ffff00000af1bbf0
>>> [    9.347009] x21: ffff8017d3018a70 x20: ffff00000af1bbf0
>>> [    9.352373] x19: ffff00000af1bbf0 x18: ffffffffffffffff
>>> [    9.357737] x17: 0000000000000000 x16: 0000000000000000
>>> [    9.363102] x15: ffff0000092296c8 x14: ffff000009074000
>>> [    9.368466] x13: 0000000000000000 x12: 0000000000000000
>>> [    9.373831] x11: ffff8017fbffe008 x10: ffff8017db9307e8
>>> [    9.379195] x9 : 0000000000000000 x8 : ffff8017b517c800
>>> [    9.384560] x7 : 0000000000000000 x6 : 000000000000003f
>>> [    9.389924] x5 : 0000000000000040 x4 : 0000000000000000
>>> [    9.395289] x3 : ffff000008d04000 x2 : 0000000056555941
>>> [    9.400654] x1 : ffff000008d04f70 x0 : 0000000000000044
>>> [    9.406019] Call trace:
>>> [    9.408483]  drm_format_info.part.1+0x0/0x8
>>> [    9.412705]  drm_helper_mode_fill_fb_struct+0x20/0x80
>>> [    9.417807]  hibmc_framebuffer_init+0x48/0xd0
>>> [    9.422204]  hibmc_drm_fb_create+0x1ec/0x3c8
>>> [    9.426513] __drm_fb_helper_initial_config_and_unlock+0x1cc/0x418
>>> [    9.432756]  drm_fb_helper_initial_config+0x3c/0x48
>>> [    9.437681]  hibmc_fbdev_init+0xb4/0x198
>>> [    9.441638]  hibmc_pci_probe+0x2f4/0x3c8
>>> [    9.445598]  local_pci_probe+0x3c/0xb0
>>> [    9.449379]  work_for_cpu_fn+0x18/0x28
>>> [    9.453161]  process_one_work+0x1e0/0x318
>>> [    9.457207]  worker_thread+0x228/0x450
>>> [    9.460988]  kthread+0x128/0x130
>>> [    9.464244]  ret_from_fork+0x10/0x18
>>> [    9.467850] ---[ end trace 2695ffa0af5be373 ]---
>>> [    9.472525] WARNING: CPU: 16 PID: 293 at
>>> drivers/gpu/drm/drm_framebuffer.c:730 drm_framebuffer_init+0x18/0x110
>>> [    9.482634] Modules linked in:
>>> [    9.485714] CPU: 16 PID: 293 Comm: kworker/16:1 Tainted: G        W
>>>       4.19.0-rc4-next-20180920-00001-g9b0012c #322
>>> [    9.496702] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
>>> D05 IT21 Nemo 2.0 RC0 04/18/2018
>>> [    9.505936] Workqueue: events work_for_cpu_fn
>>> [    9.510333] pstate: 60000005 (nZCv daif -PAN -UAO)
>>> [    9.515170] pc : drm_framebuffer_init+0x18/0x110
>>> [    9.519831] lr : hibmc_framebuffer_init+0x60/0xd0
>>> [    9.524578] sp : ffff00000af1baf0
>>> [    9.527920] x29: ffff00000af1baf0 x28: 0000000000000000
>>> [    9.533284] x27: ffff00000af1bcb0 x26: ffff8017d3018800
>>> [    9.538649] x25: ffff8017d28a0018 x24: ffff8017d2f80018
>>> [    9.544014] x23: ffff8017d3018670 x22: ffff00000af1bbf0
>>> [    9.549378] x21: ffff8017d3018a70 x20: ffff8017d2420000
>>> [    9.554743] x19: ffff8017b517c700 x18: ffffffffffffffff
>>> [    9.560108] x17: 0000000000000000 x16: 0000000000000000
>>> [    9.565472] x15: ffff0000092296c8 x14: ffff000009074000
>>> [    9.570837] x13: 0000000000000000 x12: 0000000000000000
>>> [    9.576201] x11: ffff8017fbffe008 x10: ffff8017db9307e8
>>> [    9.581566] x9 : 0000000000000000 x8 : ffff8017b517c800
>>> [    9.586930] x7 : 0000000000000000 x6 : 000000000000003f
>>> [    9.592295] x5 : 0000000000000040 x4 : 0000000000000000
>>> [    9.597660] x3 : ffff00000af1bc24 x2 : ffff000008d23f50
>>> [    9.603024] x1 : ffff8017b517c700 x0 : 0000000000000000
>>> [    9.608389] Call trace:
>>> [    9.610852]  drm_framebuffer_init+0x18/0x110
>>> [    9.615161]  hibmc_framebuffer_init+0x60/0xd0
>>> [    9.619558]  hibmc_drm_fb_create+0x1ec/0x3c8
>>> [    9.623867] __drm_fb_helper_initial_config_and_unlock+0x1cc/0x418
>>> [    9.630110]  drm_fb_helper_initial_config+0x3c/0x48
>>> [    9.635034]  hibmc_fbdev_init+0xb4/0x198
>>> [    9.638991]  hibmc_pci_probe+0x2f4/0x3c8
>>> [    9.642949]  local_pci_probe+0x3c/0xb0
>>> [    9.646731]  work_for_cpu_fn+0x18/0x28
>>> [    9.650513]  process_one_work+0x1e0/0x318
>>> [    9.654558]  worker_thread+0x228/0x450
>>> [    9.658339]  kthread+0x128/0x130
>>> [    9.661594]  ret_from_fork+0x10/0x18
>>> [    9.665199] ---[ end trace 2695ffa0af5be374 ]---
>>> [    9.669868] [drm:hibmc_framebuffer_init] *ERROR* drm_framebuffer_init
>>> failed: -22
>>> [    9.677434] [drm:hibmc_drm_fb_create] *ERROR* failed to initialize
>>> framebuffer: -22
>>> [    9.685182] [drm:hibmc_fbdev_init] *ERROR* failed to setup initial
>>> conn config: -22
>>> [    9.692926] [drm:hibmc_pci_probe] *ERROR* failed to initialize fbdev:
>>> -22
>>> [    9.699791] Unable to handle kernel NULL pointer dereference at
>>> virtual address 000000000000001a
>>> [    9.708672] Mem abort info:
>>> [    9.711489]   ESR = 0x96000004
>>> [    9.714570]   Exception class = DABT (current EL), IL = 32 bits
>>> [    9.720551]   SET = 0, FnV = 0
>>> [    9.723631]   EA = 0, S1PTW = 0
>>> [    9.726799] Data abort info:
>>> [    9.729702]   ISV = 0, ISS = 0x00000004
>>> [    9.733573]   CM = 0, WnR = 0
>>> [    9.736566] [000000000000001a] user address but active_mm is swapper
>>> [    9.742987] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>> [    9.748614] Modules linked in:
>>> [    9.751694] CPU: 16 PID: 293 Comm: kworker/16:1 Tainted: G        W
>>>       4.19.0-rc4-next-20180920-00001-g9b0012c #322
>>> [    9.762681] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
>>> D05 IT21 Nemo 2.0 RC0 04/18/2018
>>> [    9.771915] Workqueue: events work_for_cpu_fn
>>> [    9.776312] pstate: 60000005 (nZCv daif -PAN -UAO)
>>> [    9.781150] pc : drm_mode_object_put+0x0/0x20
>>> [    9.785547] lr : hibmc_fbdev_fini+0x40/0x58
>>> [    9.789767] sp : ffff00000af1bcf0
>>> [    9.793108] x29: ffff00000af1bcf0 x28: 0000000000000000
>>> [    9.798473] x27: 0000000000000000 x26: ffff000008f66630
>>> [    9.803838] x25: 0000000000000000 x24: ffff0000095abb98
>>> [    9.809203] x23: ffff8017db92fe00 x22: ffff8017d2b13000
>>> [    9.814568] x21: ffffffffffffffea x20: ffff8017d2f80018
>>> [    9.819933] x19: ffff8017d28a0018 x18: ffffffffffffffff
>>> [    9.825297] x17: 0000000000000000 x16: 0000000000000000
>>> [    9.830662] x15: ffff0000092296c8 x14: ffff00008939970f
>>> [    9.836026] x13: ffff00000939971d x12: ffff000009229940
>>> [    9.841391] x11: ffff0000085f8fc0 x10: ffff00000af1b9a0
>>> [    9.846756] x9 : 000000000000000d x8 : 6620657a696c6169
>>> [    9.852121] x7 : ffff8017d3340580 x6 : ffff8017d4168000
>>> [    9.857486] x5 : 0000000000000000 x4 : ffff8017db92fb20
>>> [    9.862850] x3 : 0000000000002690 x2 : ffff8017d3340480
>>> [    9.868214] x1 : 0000000000000028 x0 : 0000000000000002
>>> [    9.873580] Process kworker/16:1 (pid: 293, stack limit =
>>> 0x(____ptrval____))
>>> [    9.880788] Call trace:
>>> [    9.883252]  drm_mode_object_put+0x0/0x20
>>> [    9.887297]  hibmc_unload+0x1c/0x80
>>> [    9.890815]  hibmc_pci_probe+0x170/0x3c8
>>> [    9.894773]  local_pci_probe+0x3c/0xb0
>>> [    9.898555]  work_for_cpu_fn+0x18/0x28
>>> [    9.902337]  process_one_work+0x1e0/0x318
>>> [    9.906382]  worker_thread+0x228/0x450
>>> [    9.910164]  kthread+0x128/0x130
>>> [    9.913418]  ret_from_fork+0x10/0x18
>>> [    9.917024] Code: a94153f3 a8c27bfd d65f03c0 d503201f (f9400c01)
>>> [    9.923180] ---[ end trace 2695ffa0af5be375 ]---
>>>
>>> On Thu, 20 Sep 2018 at 10:06, John Garry <john.garry2@mail.dcu.ie>
>>> wrote:
>>> [    9.196615] arm-smmu-v3 arm-smmu-v3.4.auto: ias 44-bit, oas 44-bit
>>> (features 0x00000f0d)
>>> [    9.206296] arm-smmu-v3 arm-smmu-v3.4.auto: no evtq irq - events will
>>> not be reported!
>>> [    9.214302] arm-smmu-v3 arm-smmu-v3.4.auto: no gerr irq - errors will
>>> not be reported!
>>> [    9.222673] pci 0007:90:00.0: can't derive routing for PCI INT A
>>> [    9.228746] hibmc-drm 0007:91:00.0: PCI INT A: no GSI
>>> [    9.234073] [TTM] Zone  kernel: Available graphics memory:
>>> 16297696 kiB
>>> [    9.240763] [TTM] Zone   dma32: Available graphics memory: 2097152
>>> kiB
>>> [    9.247361] [TTM] Initializing pool allocator
>>> [    9.251763] [TTM] Initializing DMA pool allocator
>>> [    9.256565] [drm] Supports vblank timestamp caching Rev 2
>>> (21.10.2013).
>>> [    9.263250] [drm] No driver support for vblank timestamp query.
>>> [    9.274661] WARNING: CPU: 16 PID: 293 at
>>> drivers/gpu/drm/drm_fourcc.c:221 drm_format_info.part.1+0x0/0x8
>>> [    9.284244] Modules linked in:
>>> [    9.287326] CPU: 16 PID: 293 Comm: kworker/16:1 Not tainted
>>> 4.19.0-rc4-next-20180919-00001-gcb2f9f4-dirty #321
>>> [    9.297435] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
>>> D05 IT21 Nemo 2.0 RC0 04/18/2018
>>> [    9.306674] Workqueue: events work_for_cpu_fn
>>> [    9.311072] pstate: 60000005 (nZCv daif -PAN -UAO)
>>> [    9.315909] pc : drm_format_info.part.1+0x0/0x8
>>> [    9.320482] lr : drm_get_format_info+0x90/0x98
>>> [    9.324966] sp : ffff00000af1baf0
>>> [    9.328307] x29: ffff00000af1baf0 x28: 0000000000000000
>>> [    9.333673] x27: ffff00000af1bcb0 x26: ffff8017b4d78800
>>> [    9.339037] x25: ffff8017b4d68018 x24: ffff8017b4d94018
>>> [    9.344402] x23: ffff8017b4d78670 x22: ffff00000af1bbf0
>>> [    9.349767] x21: ffff8017b4d78a70 x20: ffff00000af1bbf0
>>> [    9.355131] x19: ffff00000af1bbf0 x18: ffffffffffffffff
>>> [    9.360495] x17: 0000000000000000 x16: 0000000000000000
>>> [    9.365860] x15: ffff0000092296c8 x14: ffff000009074000
>>> [    9.371225] x13: 0000000000000000 x12: 0000000000000000
>>> [    9.376589] x11: ffff8017fbffe008 x10: ffff8017db9307e8
>>> [    9.381954] x9 : 0000000000000000 x8 : ffff8017b4d66800
>>> [    9.387319] x7 : 0000000000000000 x6 : 000000000000003f
>>> [    9.392683] x5 : 0000000000000040 x4 : 0000000000000000
>>> [    9.398048] x3 : ffff000008d04000 x2 : 0000000056555941
>>> [    9.403412] x1 : ffff000008d04f30 x0 : 0000000000000044
>>> [    9.408777] Call trace:
>>> [    9.411241]  drm_format_info.part.1+0x0/0x8
>>> [    9.415462]  drm_helper_mode_fill_fb_struct+0x20/0x80
>>> [    9.420564]  hibmc_framebuffer_init+0x48/0xd0
>>> [    9.424961]  hibmc_drm_fb_create+0x1ec/0x3c8
>>> [    9.429271] __drm_fb_helper_initial_config_and_unlock+0x1cc/0x418
>>> [    9.435513]  drm_fb_helper_initial_config+0x3c/0x48
>>> [    9.440438]  hibmc_fbdev_init+0xb4/0x198
>>> [    9.444395]  hibmc_pci_probe+0x2f4/0x3c8
>>> [    9.448356]  local_pci_probe+0x3c/0xb0
>>> [    9.452137]  work_for_cpu_fn+0x18/0x28
>>> [    9.455919]  process_one_work+0x1e0/0x318
>>> [    9.459964]  worker_thread+0x228/0x450
>>> [    9.463746]  kthread+0x128/0x130
>>> [    9.467002]  ret_from_fork+0x10/0x18
>>> [    9.470608] ---[ end trace b05497eb4d842ec0 ]---
>>> [    9.475285] WARNING: CPU: 16 PID: 293 at
>>> drivers/gpu/drm/drm_framebuffer.c:730 drm_framebuffer_init+0x18/0x110
>>> [    9.485394] Modules linked in:
>>> [    9.488474] CPU: 16 PID: 293 Comm: kworker/16:1 Tainted: G        W
>>>       4.19.0-rc4-next-20180919-00001-gcb2f9f4-dirty #321
>>> [    9.499989] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
>>> D05 IT21 Nemo 2.0 RC0 04/18/2018
>>> [    9.509223] Workqueue: events work_for_cpu_fn
>>> [    9.513621] pstate: 60000005 (nZCv daif -PAN -UAO)
>>> [    9.518457] pc : drm_framebuffer_init+0x18/0x110
>>> [    9.523118] lr : hibmc_framebuffer_init+0x60/0xd0
>>> [    9.527865] sp : ffff00000af1baf0
>>> [    9.531207] x29: ffff00000af1baf0 x28: 0000000000000000
>>> [    9.536571] x27: ffff00000af1bcb0 x26: ffff8017b4d78800
>>> [    9.541936] x25: ffff8017b4d68018 x24: ffff8017b4d94018
>>> [    9.547301] x23: ffff8017b4d78670 x22: ffff00000af1bbf0
>>> [    9.552666] x21: ffff8017b4d78a70 x20: ffff8017b4d48000
>>> [    9.558030] x19: ffff8017b4d66700 x18: ffffffffffffffff
>>> [    9.563395] x17: 0000000000000000 x16: 0000000000000000
>>> [    9.568760] x15: ffff0000092296c8 x14: ffff000009074000
>>> [    9.574124] x13: 0000000000000000 x12: 0000000000000000
>>> [    9.579489] x11: ffff8017fbffe008 x10: ffff8017db9307e8
>>> [    9.584854] x9 : 0000000000000000 x8 : ffff8017b4d66800
>>> [    9.590218] x7 : 0000000000000000 x6 : 000000000000003f
>>> [    9.595582] x5 : 0000000000000040 x4 : 0000000000000000
>>> [    9.600946] x3 : ffff00000af1bc24 x2 : ffff000008d23f10
>>> [    9.606311] x1 : ffff8017b4d66700 x0 : 0000000000000000
>>> [    9.611675] Call trace:
>>> [    9.614138]  drm_framebuffer_init+0x18/0x110
>>> [    9.618447]  hibmc_framebuffer_init+0x60/0xd0
>>> [    9.622845]  hibmc_drm_fb_create+0x1ec/0x3c8
>>> [    9.627154] __drm_fb_helper_initial_config_and_unlock+0x1cc/0x418
>>> [    9.633397]  drm_fb_helper_initial_config+0x3c/0x48
>>> [    9.638321]  hibmc_fbdev_init+0xb4/0x198
>>> [    9.642278]  hibmc_pci_probe+0x2f4/0x3c8
>>> [    9.646236]  local_pci_probe+0x3c/0xb0
>>> [    9.650018]  work_for_cpu_fn+0x18/0x28
>>> [    9.653800]  process_one_work+0x1e0/0x318
>>> [    9.657845]  worker_thread+0x228/0x450
>>> [    9.661627]  kthread+0x128/0x130
>>> [    9.664881]  ret_from_fork+0x10/0x18
>>> [    9.668486] ---[ end trace b05497eb4d842ec1 ]---
>>> [    9.673153] [drm:hibmc_framebuffer_init] *ERROR* drm_framebuffer_init
>>> failed: -22
>>> [    9.680720] [drm:hibmc_drm_fb_create] *ERROR* failed to initialize
>>> framebuffer: -22
>>> [    9.688468] [drm:hibmc_fbdev_init] *ERROR* failed to setup initial
>>> conn config: -22
>>> [    9.696212] [drm:hibmc_pci_probe] *ERROR* failed to initialize fbdev:
>>> -22
>>> [    9.703075] Unable to handle kernel NULL pointer dereference at
>>> virtual address 000000000000001a
>>> [    9.711957] Mem abort info:
>>> [    9.714774]   ESR = 0x96000004
>>> [    9.717855]   Exception class = DABT (current EL), IL = 32 bits
>>> [    9.723835]   SET = 0, FnV = 0
>>> [    9.726916]   EA = 0, S1PTW = 0
>>> [    9.730084] Data abort info:
>>> [    9.732986]   ISV = 0, ISS = 0x00000004
>>> [    9.736858]   CM = 0, WnR = 0
>>> [    9.739850] [000000000000001a] user address but active_mm is swapper
>>> [    9.746271] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>> [    9.751898] Modules linked in:
>>> [    9.754978] CPU: 16 PID: 293 Comm: kworker/16:1 Tainted: G        W
>>>       4.19.0-rc4-next-20180919-00001-gcb2f9f4-dirty #321
>>> [    9.766493] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
>>> D05 IT21 Nemo 2.0 RC0 04/18/2018
>>> [    9.775727] Workqueue: events work_for_cpu_fn
>>> [    9.780124] pstate: 60000005 (nZCv daif -PAN -UAO)
>>> [    9.784962] pc : drm_mode_object_put+0x0/0x20
>>> [    9.789359] lr : hibmc_fbdev_fini+0x40/0x58
>>> [    9.793579] sp : ffff00000af1bcf0
>>> [    9.796920] x29: ffff00000af1bcf0 x28: 0000000000000000
>>> [    9.802285] x27: 0000000000000000 x26: ffff000008f66530
>>> [    9.807649] x25: 0000000000000000 x24: ffff0000095abb98
>>> [    9.813014] x23: ffff8017db92fe00 x22: ffff8017d2aeb000
>>> [    9.818378] x21: ffffffffffffffea x20: ffff8017b4d94018
>>> [    9.823742] x19: ffff8017b4d68018 x18: ffffffffffffffff
>>> [    9.829106] x17: 0000000000000000 x16: 0000000000000000
>>> [    9.834471] x15: ffff0000092296c8 x14: ffff00008939970f
>>> [    9.839835] x13: ffff00000939971d x12: ffff000009229940
>>> [    9.845200] x11: ffff0000085f8840 x10: ffff00000af1b9a0
>>> [    9.850564] x9 : 000000000000000d x8 : 696c616974696e69
>>> [    9.855929] x7 : ffff8017d2b96580 x6 : ffff8017d4168000
>>> [    9.861294] x5 : 0000000000000000 x4 : ffff8017db92fb20
>>> [    9.866659] x3 : 0000000000002650 x2 : ffff8017d2b96480
>>> [    9.872023] x1 : 0000000000000028 x0 : 0000000000000002
>>> [    9.877389] Process kworker/16:1 (pid: 293, stack limit =
>>> 0x(____ptrval____))
>>> [    9.884598] Call trace:
>>> [    9.887061]  drm_mode_object_put+0x0/0x20
>>> [    9.891107]  hibmc_unload+0x1c/0x80
>>> [    9.894625]  hibmc_pci_probe+0x170/0x3c8
>>> [    9.898583]  local_pci_probe+0x3c/0xb0
>>> [    9.902364]  work_for_cpu_fn+0x18/0x28
>>> [    9.906146]  process_one_work+0x1e0/0x318
>>> [    9.910192]  worker_thread+0x228/0x450
>>> [    9.913973]  kthread+0x128/0x130
>>> [    9.917227]  ret_from_fork+0x10/0x18
>>> [    9.920833] Code: a94153f3 a8c27bfd d65f03c0 d503201f (f9400c01)
>>> [    9.926989] ---[ end trace b05497eb4d842ec2 ]---
>>>
>>>
>>>
>>> .
>>>
>>
>>
>>
>> .
>>
>
>


