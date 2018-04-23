Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755010AbeDWLv3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:51:29 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35742 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754837AbeDWLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:51:27 -0400
X-Google-Smtp-Source: AIpwx48+H0xvK4QvhK/VH8TfgzDafVAG4E7XMvTAOGR9qSzm0kIGDcGqRI4idjROXrXXzllcTmNHgl1BK5ioxpgcZpg=
MIME-Version: 1.0
In-Reply-To: <20180423103440.26592-1-marc.zyngier@arm.com>
References: <20180423103440.26592-1-marc.zyngier@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 23 Apr 2018 13:51:26 +0200
Message-ID: <CAKv+Gu9zrnUevJdde_6vSwqFh0ojtDdC7Y_uHxqcGmE=5OZizw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Level-triggered MSI support
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 April 2018 at 12:34, Marc Zyngier <marc.zyngier@arm.com> wrote:
> This series is a first shot at teaching the kernel about the oxymoron
> expressed in $SUBJECT. Over the past couple of years, we've seen some
> SoCs coming up with ways of signalling level interrupts using a new
> flavor of MSIs, where the MSI controller uses two distinct messages:
> one that raises a virtual line, and one that lowers it. The target MSI
> controller is in charge of maintaining the state of the line.
>
> This allows for a much simplified HW signal routing (no need to have
> hundreds of discrete lines to signal level interrupts if you already
> have a memory bus), but results in a departure from the current idea
> the kernel has of MSIs.
>
> This series takes a minimal approach to the problem, which is to allow
> MSI controllers to use not only one, but up to two messages at a
> time. This is controlled by a flag exposed at MSI irq domain creation,
> and is only supported with platform MSI.
>
> The rest of the series repaints the Marvell ICU/GICP drivers which
> already make use of this feature with a side-channel, and adds support
> for the same feature in GICv3. A side effect of the last GICv3 patch
> is that you can also use SPIs to signal PCI MSIs. This is a last
> resort measure for SoCs where the ITS is unusable for unspeakable
> reasons.
>

Hi Marc,

I am hitting the splat below when trying this series on SynQuacer,
with mbi range <64 32> (which is reserved in the h/w manual but note
that I haven't confirmed with Socionext whether these are expected to
work or not. However, I don't think that makes any difference
regarding the issue below.)

 Unable to handle kernel read from unreadable memory at virtual address 00000018
 Mem abort info:
   ESR = 0x96000004
   Exception class = DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp =         (ptrval)
 [0000000000000018] pgd=0000000000000000
 Internal error: Oops: 96000004 [#1] PREEMPT SMP
 Modules linked in: gpio_keys(+) efivarfs ip_tables x_tables autofs4
ext4 crc16 mbcache jbd2 fscrypto sr_mod cdrom sd_mod ahci xhci_pci
libahci xhci_hcd libata usbcore scsi_mod realtek netsec of_mdio
fixed_phy libphy i2c_synquacer gpio_mb86s7x
 CPU: 19 PID: 398 Comm: systemd-udevd Tainted: G        W
4.17.0-rc2+ #54
 Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build
#101 Apr  2 2018
 pstate: a0400085 (NzCv daIf +PAN -UAO)
 pc : iommu_dma_map_msi_msg+0x40/0x1e8
 lr : iommu_dma_map_msi_msg+0x34/0x1e8
 sp : ffff00000b8db690
 x29: ffff00000b8db690 x28: ffffeca6f07442a0
 x27: 0000000000000000 x26: ffffeca6f07442d4
 x25: ffffeca6f0744398 x24: 0000000000000000
 x23: 0000000000000016 x22: 0000000000000000
 x21: ffffeca6f755ed00 x20: ffff00000b8db770
 x19: 0000000000000016 x18: ffffffffffffffff
 x17: ffff446c203fd000 x16: ffff446c1f3b5108
 x15: ffffeca6f0a095b0 x14: ffffeca6f0a3a587
 x13: ffffeca6f0a3a586 x12: 0000000000000040
 x11: 0000000000000004 x10: 0000000000000016
 x9 : ffffeca6f70009d8 x8 : 0000000000000000
 x7 : ffffeca6f0744200 x6 : ffffeca6f0744200
 x5 : ffffeca6f7000900 x4 : ffffeca6f0744200
 x3 : 0000000000000000 x2 : 0000000000000000
 x1 : ffffeca6f0744258 x0 : 0000000000000000
 Process systemd-udevd (pid: 398, stack limit = 0x        (ptrval))
 Call trace:
  iommu_dma_map_msi_msg+0x40/0x1e8
  mbi_compose_msi_msg+0x54/0x60
  mbi_compose_mbi_msg+0x28/0x68
  irq_chip_compose_msi_msg+0x5c/0x78
  msi_domain_activate+0x40/0x90
  __irq_domain_activate_irq+0x74/0xb8
  __irq_domain_activate_irq+0x3c/0xb8
  irq_domain_activate_irq+0x4c/0x60
  irq_activate+0x40/0x50
  __setup_irq+0x4bc/0x7e0
  request_threaded_irq+0xf0/0x198
  request_any_context_irq+0x6c/0xc0
  devm_request_any_context_irq+0x78/0xf0
  gpio_keys_probe+0x324/0x9a0 [gpio_keys]
  platform_drv_probe+0x60/0xc8
  driver_probe_device+0x2c4/0x490
  __driver_attach+0x10c/0x128
  bus_for_each_dev+0x78/0xe0
  driver_attach+0x30/0x40
  bus_add_driver+0x1d0/0x298
  driver_register+0x68/0x100
  __platform_driver_register+0x54/0x60
  gpio_keys_init+0x24/0x1000 [gpio_keys]
  do_one_initcall+0x68/0x258
  do_init_module+0x64/0x1e0
  load_module+0x1e20/0x21a8
  sys_finit_module+0x108/0x140
 EFI Variables Facility v0.08 2004-May-17
  __sys_trace_return+0x0/0x4
 Code: 97ec1444 b4000ca0 f9400800 f9400800 (f9400c18)
 ---[ end trace f7956dc89d9f3be7 ]---

00000000000014a0 <iommu_dma_map_msi_msg>:
    14a0:       a9ba7bfd        stp     x29, x30, [sp, #-96]!
    14a4:       910003fd        mov     x29, sp
    14a8:       a90153f3        stp     x19, x20, [sp, #16]
    14ac:       a9025bf5        stp     x21, x22, [sp, #32]
    14b0:       a90363f7        stp     x23, x24, [sp, #48]
    14b4:       a9046bf9        stp     x25, x26, [sp, #64]
    14b8:       a90573fb        stp     x27, x28, [sp, #80]
    14bc:       2a0003f3        mov     w19, w0
    14c0:       aa1e03e0        mov     x0, x30
    14c4:       aa0103f4        mov     x20, x1
    14c8:       94000000        bl      0 <_mcount>
    14cc:       2a1303e0        mov     w0, w19
    14d0:       94000000        bl      0 <irq_get_irq_data>
    14d4:       b4000ca0        cbz     x0, 1668 <iommu_dma_map_msi_msg+0x1c8>
    14d8:       f9400800        ldr     x0, [x0, #16]
    14dc:       f9400800        ldr     x0, [x0, #16]
    14e0:       f9400c18        ldr     x24, [x0, #24]
    14e4:       aa1803e0        mov     x0, x24
    14e8:       94000000        bl      0 <iommu_get_domain_for_dev>
    14ec:       aa0003f3        mov     x19, x0
    14f0:       b40008a0        cbz     x0, 1604 <iommu_dma_map_msi_msg+0x164>
    14f4:       f9402015        ldr     x21, [x0, #64]
    14f8:       b4000875        cbz     x21, 1604 <iommu_dma_map_msi_msg+0x164>
    14fc:       911d82b6        add     x22, x21, #0x760
