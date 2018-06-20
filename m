Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC683C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A95208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A95208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932770AbeFTImW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:42:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:47651 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbeFTImP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:42:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 01:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,246,1526367600"; 
   d="scan'208";a="48491287"
Received: from lteixeir-mobl.ger.corp.intel.com (HELO [10.252.35.108]) ([10.252.35.108])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jun 2018 01:39:44 -0700
Subject: Re: [PATCH] drm: fix pci_dev root device is NULL without check.
To:     Caicai <caizhaopeng@deepin.com>, gustavo@padovan.org
Cc:     seanpaul@chromium.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180619074756.19047-1-caizhaopeng@deepin.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <c3aeb1e5-8b4c-d34d-43e8-5f69c2c95b55@linux.intel.com>
Date:   Wed, 20 Jun 2018 10:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619074756.19047-1-caizhaopeng@deepin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 19-06-18 om 09:47 schreef Caicai:
>     on my laptop with ATI Radeon R7 350 graphics card,I found root was NULL,we should check
>     the device before get/set pcie speed cap mask. Here is my messages.
>     [    8.996093] [drm] radeon kernel modesetting enabled.
>     [    8.996093] [drm] initializing kernel modesetting (OLAND 0x1002:0x6610 0x174B:0xA00B).
>     [    8.996093] [drm] register mmio base: 0x10000000
>     [    8.996093] [drm] register mmio size: 262144
>     [    9.121093] ATOM BIOS: C55001
>     [    9.121093] [drm] GPU not posted. posting now...
>     [    9.125000] radeon 0001:20:00.0: VRAM: 2048M 0x0000000000000000 - 0x000000007FFFFFFF (2048M used)
>     [    9.125000] radeon 0001:20:00.0: GTT: 2048M 0x0000000080000000 - 0x00000000FFFFFFFF
>     [    9.125000] [drm] Detected VRAM RAM=2048M, BAR=256M
>     [    9.125000] [drm] RAM width 128bits DDR
>     [    9.125000] [drm] radeon: 2048M of VRAM memory ready
>     [    9.125000] [drm] radeon: 2048M of GTT memory ready.
>     [    9.125000] [drm] Loading oland Microcode
>     [    9.128906] [drm] Internal thermal controller with fan control
>     [    9.128906] Unable to handle kernel paging request at virtual address 000000000000003c
>     [    9.128906] CPU 3 systemd-udevd(148): Oops 0
>     [    9.128906] pc = [<ffffffff80e63824>]  ra = [<fffffffc03faf914>]  ps = 0000    Not tainted
>     [    9.128906] pc is at drm_pcie_get_speed_cap_mask+0x3c/0x12c
>     [    9.128906] ra is at si_dpm_init+0x64/0x1398 [radeon]
>     [    9.128906] v0 = ffffffffffffffea  t0 = fffffc07fcc3a400  t1 = 0000000000001106
>     [    9.128906] t2 = 0000000000001166  t3 = 0000000000000000  t4 = fffffc018eafc000
>     [    9.128906] t5 = ffffffffffffff80  t6 = 000000000000003f  t7 = fffffc07f6a90000
>     [    9.128906] s0 = fffffc07f6a9390c  s1 = 0000000000000000  s2 = fffffc07f59119b0
>     [    9.128906] s3 = 0000000000000001  s4 = fffffffffffffff4  s5 = fffffc07f5910000
>     [    9.128906] s6 = 0000000000000000
>     [    9.128906] a0 = fffffc07f706c800  a1 = fffffc07f6a9390c  a2 = fffffffffffffffc
>     [    9.128906] a3 = ffffffff815fb510  a4 = ffffffff815fb4c8  a5 = 0000000000000000
>     [    9.128906] t8 = 000000000000007f  t9 = ffffffff80d86c14  t10= 0000000000000001
>     [    9.128906] t11= 00000000000003c0  pv = ffffffff80e637e8  at = 0000000000000000
>     [    9.128906] gp = ffffffff815e9230  sp = fffffc07f6a93868
>     [    9.128906] Disabling lock debugging due to kernel taint
>     [    9.128906] Trace:
>     [    9.128906] [<ffffffff80e61260>] drm_dev_register+0xb0/0x138
>     [    9.128906] [<ffffffff80e64368>] drm_get_pci_dev+0x120/0x208
>     [    9.128906] [<ffffffff80dcced4>] local_pci_probe+0x38/0x8c
>     [    9.128906] [<ffffffff80dcdac0>] pci_device_probe+0x170/0x1d0
>     [    9.128906] [<ffffffff80e9d654>] driver_probe_device+0x168/0x2fc
>     [    9.128906] [<ffffffff80e9d87c>] __driver_attach+0x94/0xe8
>     [    9.128906] [<ffffffff80e9acf4>] bus_for_each_dev+0x94/0xd4
>     [    9.128906] [<ffffffff80e9d7e8>] __driver_attach+0x0/0xe8
>     [    9.128906] [<ffffffff80e9ce98>] driver_attach+0x2c/0x40
>     [    9.128906] [<ffffffff80e9c870>] bus_add_driver+0x140/0x2d4
>     [    9.128906] [<ffffffff80e9e28c>] driver_register+0x100/0x180
>     [    9.128906] [<ffffffff80dccda0>] __pci_register_driver+0x48/0x5c
>     [    9.128906] [<ffffffff80e644cc>] drm_pci_init+0x7c/0x168
>     [    9.128906] [<ffffffff809102fc>] do_one_initcall+0x188/0x25c
>     [    9.128906] [<ffffffff809f5f00>] do_init_module+0x8c/0x2c8
>     [    9.128906] [<ffffffff80a5b698>] kmem_cache_alloc+0x1f8/0x22c
>     [    9.128906] [<ffffffff809f5eb4>] do_init_module+0x40/0x2c8
>     [    9.128906] [<ffffffff809b36c8>] load_module+0x1ea8/0x263c
>     [    9.128906] [<ffffffff809af9fc>] unknown_module_param_cb+0x0/0xc8
>     [    9.128906] [<ffffffff809b40a4>] SYSC_finit_module+0x94/0xb4
>     [    9.128906] [<ffffffff809aeb68>] module_notes_read+0x0/0x4c
>     [    9.128906] [<ffffffff80911040>] entSys+0xa0/0xc0
Grepping on entSys the only mention is on alpha.

Is dev->pdev->bus->parent NULL by any chance?
>     [    9.128906] Code: 8c300188  c020003b  8c210010  f85f1106  f87f1166  8d410038 <842a003c> 40220502
>     [    9.128906] systemd-udevd[136]: worker [148] terminated by signal 11 (Segmentation fault)
>
> Signed-off-by: Caicai <caizhaopeng@deepin.com>
> ---
>  drivers/gpu/drm/drm_pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
> index 4db9c515b74f..3d1cd760b79c 100644
> --- a/drivers/gpu/drm/drm_pci.c
> +++ b/drivers/gpu/drm/drm_pci.c
> @@ -332,10 +332,12 @@ int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
>  	u32 lnkcap, lnkcap2;
>  
>  	*mask = 0;
> -	if (!dev->pdev)
> +	if (!dev->pdev || !dev->pdev->bus)
>  		return -EINVAL;
I think we can assume our device is on a bus.
>  	root = dev->pdev->bus->self;
> +	if (!root)
> +		return -EINVAL;
I'm not a PCI expert, but seems like a bad design to say none of the speeds are supported just because we lack a bridge.

btw, drm_pcie_get_max_link_width is similarly affected.

~Maarten

