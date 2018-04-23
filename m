Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755060AbeDWMbt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:31:49 -0400
Received: from foss.arm.com ([217.140.101.70]:40496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754863AbeDWMbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:31:48 -0400
Subject: Re: [PATCH 0/7] Level-triggered MSI support
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180423103440.26592-1-marc.zyngier@arm.com>
 <CAKv+Gu9zrnUevJdde_6vSwqFh0ojtDdC7Y_uHxqcGmE=5OZizw@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <5aff4953-caf7-b0f0-38ec-abfa0d8e58c7@arm.com>
Date: Mon, 23 Apr 2018 13:31:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9zrnUevJdde_6vSwqFh0ojtDdC7Y_uHxqcGmE=5OZizw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Ard,

On 23/04/18 12:51, Ard Biesheuvel wrote:
> On 23 April 2018 at 12:34, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> This series is a first shot at teaching the kernel about the oxymoron
>> expressed in $SUBJECT. Over the past couple of years, we've seen some
>> SoCs coming up with ways of signalling level interrupts using a new
>> flavor of MSIs, where the MSI controller uses two distinct messages:
>> one that raises a virtual line, and one that lowers it. The target MSI
>> controller is in charge of maintaining the state of the line.
>>
>> This allows for a much simplified HW signal routing (no need to have
>> hundreds of discrete lines to signal level interrupts if you already
>> have a memory bus), but results in a departure from the current idea
>> the kernel has of MSIs.
>>
>> This series takes a minimal approach to the problem, which is to allow
>> MSI controllers to use not only one, but up to two messages at a
>> time. This is controlled by a flag exposed at MSI irq domain creation,
>> and is only supported with platform MSI.
>>
>> The rest of the series repaints the Marvell ICU/GICP drivers which
>> already make use of this feature with a side-channel, and adds support
>> for the same feature in GICv3. A side effect of the last GICv3 patch
>> is that you can also use SPIs to signal PCI MSIs. This is a last
>> resort measure for SoCs where the ITS is unusable for unspeakable
>> reasons.
>>
> 
> Hi Marc,
> 
> I am hitting the splat below when trying this series on SynQuacer,
> with mbi range <64 32> (which is reserved in the h/w manual but note
> that I haven't confirmed with Socionext whether these are expected to
> work or not. However, I don't think that makes any difference
> regarding the issue below.)

Thanks for giving it a go. Something looks odd below:

> 
>  Unable to handle kernel read from unreadable memory at virtual address 00000018
>  Mem abort info:
>    ESR = 0x96000004
>    Exception class = DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>  Data abort info:
>    ISV = 0, ISS = 0x00000004
>    CM = 0, WnR = 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp =         (ptrval)
>  [0000000000000018] pgd=0000000000000000
>  Internal error: Oops: 96000004 [#1] PREEMPT SMP
>  Modules linked in: gpio_keys(+) efivarfs ip_tables x_tables autofs4
> ext4 crc16 mbcache jbd2 fscrypto sr_mod cdrom sd_mod ahci xhci_pci
> libahci xhci_hcd libata usbcore scsi_mod realtek netsec of_mdio
> fixed_phy libphy i2c_synquacer gpio_mb86s7x
>  CPU: 19 PID: 398 Comm: systemd-udevd Tainted: G        W
> 4.17.0-rc2+ #54
>  Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build
> #101 Apr  2 2018
>  pstate: a0400085 (NzCv daIf +PAN -UAO)
>  pc : iommu_dma_map_msi_msg+0x40/0x1e8
>  lr : iommu_dma_map_msi_msg+0x34/0x1e8
>  sp : ffff00000b8db690
>  x29: ffff00000b8db690 x28: ffffeca6f07442a0
>  x27: 0000000000000000 x26: ffffeca6f07442d4
>  x25: ffffeca6f0744398 x24: 0000000000000000
>  x23: 0000000000000016 x22: 0000000000000000
>  x21: ffffeca6f755ed00 x20: ffff00000b8db770
>  x19: 0000000000000016 x18: ffffffffffffffff
>  x17: ffff446c203fd000 x16: ffff446c1f3b5108
>  x15: ffffeca6f0a095b0 x14: ffffeca6f0a3a587
>  x13: ffffeca6f0a3a586 x12: 0000000000000040
>  x11: 0000000000000004 x10: 0000000000000016
>  x9 : ffffeca6f70009d8 x8 : 0000000000000000
>  x7 : ffffeca6f0744200 x6 : ffffeca6f0744200
>  x5 : ffffeca6f7000900 x4 : ffffeca6f0744200
>  x3 : 0000000000000000 x2 : 0000000000000000
>  x1 : ffffeca6f0744258 x0 : 0000000000000000
>  Process systemd-udevd (pid: 398, stack limit = 0x        (ptrval))
>  Call trace:
>   iommu_dma_map_msi_msg+0x40/0x1e8

We die here because irq_get_msi_desc() has returned a NULL pointer.
That's not really expected.

>   mbi_compose_msi_msg+0x54/0x60
>   mbi_compose_mbi_msg+0x28/0x68

We're requesting a platform MSI...

>   irq_chip_compose_msi_msg+0x5c/0x78
>   msi_domain_activate+0x40/0x90
>   __irq_domain_activate_irq+0x74/0xb8
>   __irq_domain_activate_irq+0x3c/0xb8
>   irq_domain_activate_irq+0x4c/0x60
>   irq_activate+0x40/0x50
>   __setup_irq+0x4bc/0x7e0
>   request_threaded_irq+0xf0/0x198
>   request_any_context_irq+0x6c/0xc0
>   devm_request_any_context_irq+0x78/0xf0
>   gpio_keys_probe+0x324/0x9a0 [gpio_keys]

from the gpio_keys driver, which shouldn't be doing platform MSI at all.
It looks like we've looked-up the wrong irq domain, and really bad
things happen after that.

Could you point me to the device-tree of this machine? I need to
understand how we can end-up in such a situation.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
