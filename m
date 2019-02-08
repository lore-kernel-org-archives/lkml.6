Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C275CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867C8206C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549618924;
	bh=QxygWgxkCrfkYa89r52Xnqiz6mda/hCAfIPYcoemb6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tY59qwFLSvsWuBWkwB+P+FizW7+lMOs3Wa95SlOy/2cGC1pnv2woSXmLxYWXwqGzF
	 o2w/OD61AXGmxtSwYRvjzNBLJpbNTyFKZctuRSyQ3UEwNMnWVR2gJ3eMwarZJ4P6xE
	 J7BT8PbHYQaBIV/+gAXb/ewlQuopOdPZXRh3BsLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfBHJmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:42:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33093 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHJmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:42:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so4907702otl.0;
        Fri, 08 Feb 2019 01:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6v1zqjs3usJnIUnnlrF8HWkcrCZ5SE9m8vlha7WccE=;
        b=H0vW3aZOsRocqGTm7O7Mlrq4FVPAjKmVxlX7IKVRKchkTDwK0f+jvEM6k0Z8lgy8p4
         czzs5q5ZKEKk7JZws8ezoh37Sh7hjrJGnVmU0sgb/FflPBAKNFKvhMwFmBExmKnsPksf
         kvIvhcarhNRAIgwCMqicu7oaJlj0TztjC/kI4HXbveYeCWf0gUUtHEyiSlThEtv7gdjk
         N98+aMkYeEfZlMTSI4enBUE44kzQsgx58cIfkQV8C8ceCW9RWR2w4tXS6ErrFwkk2awO
         E3v3nmOHYyQQE5boMm2Od1aWfbeuN1O/3B6WkvQMRUk9Xp+npkfArJ/Dya3yftzjskWs
         zYDA==
X-Gm-Message-State: AHQUAubzQafY9K0md3/3mMOF3mtVfFJ5SIXMFW0zsXYskCuWZEHj1s74
        WZI697x/OvtpXbqIzzvuoWt3peMxFB8SKMRXX4A=
X-Google-Smtp-Source: AHgI3Ia6tZu1qKF7aq6adb17Nm7faYapxiD+6udDktceoProhmOMJvfaSuOvXVZK5kvFxtoEwh85aDdFD/8TO9rJYAU=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr12410132oti.258.1549618921076;
 Fri, 08 Feb 2019 01:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20190207193653.18221-1-geert+renesas@glider.be>
In-Reply-To: <20190207193653.18221-1-geert+renesas@glider.be>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Feb 2019 10:41:48 +0100
Message-ID: <CAJZ5v0iXLCrSP1xRWf-wok6x_Qx+ORLEC6up6gVYvMALWBZW0w@mail.gmail.com>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 8:42 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> When unbinding the (IOMMU-enabled) R-Car SATA device on Salvator-XS
> (R-Car H3 ES2.0), in preparation of rebinding against vfio-platform for
> device pass-through for virtualization:
>
>     echo ee300000.sata > /sys/bus/platform/drivers/sata_rcar/unbind
>
> the kernel crashes with:
>
>     Unable to handle kernel paging request at virtual address ffffffbf029ffffc
>     Mem abort info:
>       ESR = 0x96000006
>       Exception class = DABT (current EL), IL = 32 bits
>       SET = 0, FnV = 0
>       EA = 0, S1PTW = 0
>     Data abort info:
>       ISV = 0, ISS = 0x00000006
>       CM = 0, WnR = 0
>     swapper pgtable: 4k pages, 39-bit VAs, pgdp = 000000007e8c586c
>     [ffffffbf029ffffc] pgd=000000073bfc6003, pud=000000073bfc6003, pmd=0000000000000000
>     Internal error: Oops: 96000006 [#1] SMP
>     Modules linked in:
>     CPU: 0 PID: 1098 Comm: bash Not tainted 5.0.0-rc5-salvator-x-00452-g37596f884f4318ef #287
>     Hardware name: Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+ (DT)
>     pstate: 60400005 (nZCv daif +PAN -UAO)
>     pc : __free_pages+0x8/0x58
>     lr : __dma_direct_free_pages+0x50/0x5c
>     sp : ffffff801268baa0
>     x29: ffffff801268baa0 x28: 0000000000000000
>     x27: ffffffc6f9c60bf0 x26: ffffffc6f9c60bf0
>     x25: ffffffc6f9c60810 x24: 0000000000000000
>     x23: 00000000fffff000 x22: ffffff8012145000
>     x21: 0000000000000800 x20: ffffffbf029fffc8
>     x19: 0000000000000000 x18: ffffffc6f86c42c8
>     x17: 0000000000000000 x16: 0000000000000070
>     x15: 0000000000000003 x14: 0000000000000000
>     x13: ffffff801103d7f8 x12: 0000000000000028
>     x11: ffffff8011117604 x10: 0000000000009ad8
>     x9 : ffffff80110126d0 x8 : ffffffc6f7563000
>     x7 : 6b6b6b6b6b6b6b6b x6 : 0000000000000018
>     x5 : ffffff8011cf3cc8 x4 : 0000000000004000
>     x3 : 0000000000080000 x2 : 0000000000000001
>     x1 : 0000000000000000 x0 : ffffffbf029fffc8
>     Process bash (pid: 1098, stack limit = 0x00000000c38e3e32)
>     Call trace:
>      __free_pages+0x8/0x58
>      __dma_direct_free_pages+0x50/0x5c
>      arch_dma_free+0x1c/0x98
>      dma_direct_free+0x14/0x24
>      dma_free_attrs+0x9c/0xdc
>      dmam_release+0x18/0x20
>      release_nodes+0x25c/0x28c
>      devres_release_all+0x48/0x4c
>      device_release_driver_internal+0x184/0x1f0
>      device_release_driver+0x14/0x1c
>      unbind_store+0x70/0xb8
>      drv_attr_store+0x24/0x34
>      sysfs_kf_write+0x4c/0x64
>      kernfs_fop_write+0x154/0x1c4
>      __vfs_write+0x34/0x164
>      vfs_write+0xb4/0x16c
>      ksys_write+0x5c/0xbc
>      __arm64_sys_write+0x14/0x1c
>      el0_svc_common+0x98/0x114
>      el0_svc_handler+0x1c/0x24
>      el0_svc+0x8/0xc
>     Code: d51b4234 17fffffa a9bf7bfd 910003fd (b9403404)
>     ---[ end trace 8c564cdd3a1a840f ]---
>
> While I've bisected this to commit e8e683ae9a736407 ("iommu/of: Fix
> probe-deferral"), and reverting that commit on post-v5.0-rc4 kernels
> does fix the problem, this turned out to be a red herring.
>
> On arm64, arch_teardown_dma_ops() resets dev->dma_ops to NULL.
> Hence if a driver has used a managed DMA allocation API, the allocated
> DMA memory will be freed using the direct DMA ops, while it may have
> been allocated using a custom DMA ops (iommu_dma_ops in this case).
>
> Fix this by reversing the order of the calls to devres_release_all() and
> arch_teardown_dma_ops().
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Question:
> Is this safe on arm32, which calls arm_teardown_iommu_dma_ops() instead
> of resetting dev->dma_ops?
>
> ---
> Adding some debug code, and comparing before/after commit
> e8e683ae9a736407:
>
>      sata_rcar ee300000.sata: of_iommu_configure:227: err = -517
>     -sata_rcar ee300000.sata: of_iommu_configure:230: calling iommu_probe_device()
>     -sata_rcar ee300000.sata: iommu_probe_device:122: Calling ipmmu_add_device
>     -sata_rcar ee300000.sata: ipmmu_add_device:893
>     -sata_rcar ee300000.sata: of_iommu_configure:232: iommu_probe_device() returned -19
>     -sata_rcar ee300000.sata: dma_alloc_attrs:257: size 2048, ops =           (null)
>     -sata_rcar ee300000.sata: __dma_direct_alloc_pages:104: size 4096
>     -sata_rcar ee300000.sata: __dma_direct_alloc_pages:115: trying dma_alloc_from_contiguous()
>     -sata_rcar ee300000.sata: dma_alloc_from_contiguous:202: cma_alloc(1) returned page ffffffbf00d20e00
>     -sata_rcar ee300000.sata: dma_alloc_attrs:271: allocated using dma_direct_alloc()
>     -sata_rcar ee300000.sata: dmam_alloc_attrs:98: size 2048 vaddr ffffff8011e95000 dma_handle 0x0x000000007c040000 attrs 0x0
>     -scsi host0: sata_rcar
>     -ata1: SATA max UDMA/133 irq 172
>     -ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>
> DMA memory used to be allocated from CMA, dma_map_ops = NULL.
> The SATA driver was probed and initialized.
>
>     +sata_rcar ee300000.sata: of_iommu_configure:234: skipping iommu_probe_device()
>
> SATA driver initialization is now deferred.
> Later, it is retried:
>
>     +sata_rcar ee300000.sata: of_iommu_configure:227: err = 0
>     +sata_rcar ee300000.sata: of_iommu_configure:230: calling iommu_probe_device()
>     +sata_rcar ee300000.sata: iommu_probe_device:122: Calling ipmmu_add_device
>     +sata_rcar ee300000.sata: ipmmu_add_device:893
>     +sata_rcar ee300000.sata: Using IPMMU context 1
>     +iommu: Adding device ee300000.sata to group 0
>     +sata_rcar ee300000.sata: ipmmu_add_device:908: Success
>     +sata_rcar ee300000.sata: of_iommu_configure:232: iommu_probe_device() returned 0
>     +sata_rcar ee300000.sata: dma_alloc_attrs:257: size 2048, ops = iommu_dma_ops
>     +sata_rcar ee300000.sata: dma_alloc_attrs:274: allocated using __iommu_alloc_attrs()
>     +sata_rcar ee300000.sata: dmam_alloc_attrs:98: size 2048 vaddr ffffff8012135000 dma_handle 0x0x00000000fffff000 attrs 0x0
>     +scsi host0: sata_rcar
>     +ata1: SATA max UDMA/133 irq 172
>     +ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>
> DMA memory is now allocated using __iommu_alloc_attrs(), as dma_map_ops
> = iommu_dma_ops.
>
> Unbind:
>
>     -sata_rcar ee300000.sata: dmam_release:32: size 2048 vaddr ffffff8011e95000 dma_handle 0x0x000000007c040000 attrs 0x0
>     +sata_rcar ee300000.sata: dmam_release:32: size 2048 vaddr ffffff8012135000 dma_handle 0x0x00000000fffff000 attrs 0x0
>      sata_rcar ee300000.sata: dma_free_attrs:289: size 2048, ops =           (null)
>
> dma_map_ops = NULL, both before/after!
>
>      sata_rcar ee300000.sata: dma_free_attrs:308: calling dma_direct_free()
>     -sata_rcar ee300000.sata: __dma_direct_free_pages:189: size 2048 page ffffffbf00d20e00
>     -sata_rcar ee300000.sata: dma_release_from_contiguous:223: cma_release(1) freed
>     -sata_rcar ee300000.sata: __dma_direct_free_pages:194: skipping __free_pages()
>
> DMA memory was correctly freed using CMA.
>
>     +sata_rcar ee300000.sata: __dma_direct_free_pages:189: size 2048 page ffffffbf029fffc8
>     +sata_rcar ee300000.sata: dma_release_from_contiguous:225: cma_release(1) failed, cma area ffffff8011cf5530
>     +sata_rcar ee300000.sata: __dma_direct_free_pages:191: calling __free_pages()
>     +Unable to handle kernel paging request at virtual address ffffffbf029ffffc
>
> Memory is incorrectly freed using the direct ops, as dma_map_ops = NULL.
> Oops...
>
> After reversing the order of the calls to arch_teardown_dma_ops() and
> devres_release_all(), dma_map_ops is still valid, and the DMA memory is
> now released using __iommu_free_attrs():
>
>     +sata_rcar ee300000.sata: dmam_release:32: size 2048 vaddr ffffff8012145000 dma_handle 0x0x00000000fffff000 attrs 0x0
>     +sata_rcar ee300000.sata: dma_free_attrs:289: size 2048, ops = iommu_dma_ops
>     +sata_rcar ee300000.sata: dma_free_attrs:311: calling __iommu_free_attrs()
> ---
>  drivers/base/dd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 8ac10af17c0043a3..d62487d024559620 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>                         drv->remove(dev);
>
>                 device_links_driver_cleanup(dev);
> -               arch_teardown_dma_ops(dev);
>
>                 devres_release_all(dev);
> +               arch_teardown_dma_ops(dev);
>                 dev->driver = NULL;
>                 dev_set_drvdata(dev, NULL);
>                 if (dev->pm_domain && dev->pm_domain->dismiss)
> --
> 2.17.1
>
