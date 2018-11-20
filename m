Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022BCC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68D920831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68D920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbeKUEAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:00:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37569 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbeKUEAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:00:32 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C80CC8F631DAB;
        Wed, 21 Nov 2018 01:30:12 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 01:30:10 +0800
Subject: Re: WARN_ON after gic_reserve_range
To:     Jan Glauber <Jan.Glauber@cavium.com>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <20181120162305.GA2088@hc>
CC:     "Richter, Robert" <Robert.Richter@cavium.com>,
        Will Deacon <will.deacon@arm.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2665ddbd-5912-12b9-f5bd-6ccaec0e6e2d@huawei.com>
Date:   Tue, 20 Nov 2018 17:30:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181120162305.GA2088@hc>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 16:23, Jan Glauber wrote:
> Hi Marc,
>
> with 4.20-rc3 I see two WARN_ON's firing on a ThunderX2 system that come from
> commit 3fb68faee867 (irqchip/gic-v3-its: Register LPI tables with EFI config table).
>
> Global efi_memreserve_root is NULL as it will only be set when early initcalls are
> running, but from the backtrace the WARN_ON's are running even earlier (init_IRQ).
>
> Am I the only one seeing this?
>

I see it also:

[    0.000000] Booting Linux on physical CPU 0x0000010000 [0x410fd082]
[    0.000000] Linux version 4.20.0-rc3 
(johnpgarry@johnpgarry-ThinkCentre-M93p) (gcc version 7.3.1 20180425 
[linaro-7.3-2018.05-rc1 revision 
38aec9a676236eaa42ca03ccb3a6c1dd0182c29f] (Linaro GCC 7.3-2018.05-rc1)) 
#971 SMP PREEMPT Tue Nov 20 17:15:03 GMT 2018
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS=0x3f050000  SMBIOS 3.0=0x39b00000 
ACPI=0x39bd0000  ACPI 2.0=

...


[    0.000000] ITS@0x00000408c6000000: allocated 65536 Virtual CPUs 
@1fb9d80000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000408c6000000: allocated 512 Interrupt 
Collections @1fbb977000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] WARNING: CPU: 0 PID: 0 at 
drivers/irqchip/irq-gic-v3-its.c:1696 its_init+0x360/0x5f4
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc3 #971
[    0.000000] pstate: 00000085 (nzcv daIf -PAN -UAO)
[    0.000000] pc : its_init+0x360/0x5f4
[    0.000000] lr : its_init+0x35c/0x5f4
[    0.000000] sp : ffff000009183ca0
[    0.000000] x29: ffff000009183ca0 x28: ffff7dfffe67b3e4
[    0.000000] x27: 0000000000000001 x26: ffff801fbb928000
[    0.000000] x25: ffff000009325360 x24: ffff00000918c8c8
[    0.000000] x23: ffff801fbb802100 x22: ffff00000918c8c8
[    0.000000] x21: ffff000009189000 x20: ffff0000091b8000
[    0.000000] x19: ffff000009325000 x18: ffffffffffffffff
[    0.000000] x17: 0000000001f4d3b5 x16: 0000000000000000
[    0.000000] x15: ffff0000091896c8 x14: ffff801fbb97389b
[    0.000000] x13: ffff801fbb97389a x12: 2074707572726574
[    0.000000] x11: ffff000009183a00 x10: ffff000009183a00
[    0.000000] x9 : ffff7e007eeed400 x8 : ffff801fbbb60000
[    0.000000] x7 : a2a2a2a2a2a2a2a2 x6 : 0000801ff2d1c000
[    0.000000] x5 : ffff7e0000000000 x4 : ffff00000918c8c8
[    0.000000] x3 : ffff801fbbb50000 x2 : 0000000000000000
[    0.000000] x1 : 0000000000010000 x0 : 00000000ffffffed
[    0.000000] Call trace:
[    0.000000]  its_init+0x360/0x5f4
[    0.000000]  gic_init_bases+0x2d4/0x2f4
[    0.000000]  gic_acpi_init+0x154/0x278
[    0.000000]  acpi_match_madt+0x44/0x78
[    0.000000]  acpi_table_parse_entries_array+0x13c/0x214
[    0.000000]  acpi_table_parse_entries+0x40/0x60
[    0.000000]  acpi_table_parse_madt+0x24/0x2c
[    0.000000]  __acpi_probe_device_table+0x80/0xdc
[    0.000000]  irqchip_init+0x30/0x38
[    0.000000]  init_IRQ+0xfc/0x130
[    0.000000]  start_kernel+0x288/0x418
[    0.000000] ---[ end trace c841ef100bdd09a6 ]---
[    0.000000] GICv3: using LPI property table @0x0000001fbbb50000
[    0.000000] ITS: Using DirectLPI for VPE invalidation
[    0.000000] ITS: Enabling GICv4 support
[    0.000000] WARNING: CPU: 0 PID: 0 at 
drivers/irqchip/irq-gic-v3-its.c:2096 its_cpu_init+0x3a0/0x470
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W 
4.20.0-rc3 #971
[    0.000000] pstate: 00000085 (nzcv daIf -PAN -UAO)
[    0.000000] pc : its_cpu_init+0x3a0/0x470
[    0.000000] lr : its_cpu_init+0x39c/0x470
[    0.000000] sp : ffff000009183cf0
[    0.000000] x29: ffff000009183cf0 x28: ffff7dfffe67b3e4
[    0.000000] x27: 0000000000000001 x26: ffff801fbb928000
[    0.000000] x25: ffff000008fc7000 x24: ffff000009500070
[    0.000000] x23: ffff7e007eeed800 x22: ffff000009325000
[    0.000000] x21: ffff000009500000 x20: ffff000009189000
[    0.000000] x19: ffff0000091b8000 x18: ffffffffffffffff
[    0.000000] x17: 0000000000000000 x16: ffff000009192580
[    0.000000] x15: ffff0000091896c8 x14: ffff0000892ed70f
[    0.000000] x13: ffff0000092ed71d x12: ffff0000091a1000
[    0.000000] x11: ffff000009183970 x10: ffff000009189940
[    0.000000] x9 : 00000000ffffffd0 x8 : ffff0000086029d0
[    0.000000] x7 : 6e696c62616e4520 x6 : 0000000000000110
[    0.000000] x5 : ffff7e0000000000 x4 : 0000000000000010
[    0.000000] x3 : 000000000000ffff x2 : 0000000000000000
[    0.000000] x1 : 0000000000010000 x0 : 00000000ffffffed
[    0.000000] Call trace:
[    0.000000]  its_cpu_init+0x3a0/0x470
[    0.000000]  gic_init_bases+0x2d8/0x2f4
[    0.000000]  gic_acpi_init+0x154/0x278
[    0.000000]  acpi_match_madt+0x44/0x78
[    0.000000]  acpi_table_parse_entries_array+0x13c/0x214
[    0.000000]  acpi_table_parse_entries+0x40/0x60
[    0.000000]  acpi_table_parse_madt+0x24/0x2c
[    0.000000]  __acpi_probe_device_table+0x80/0xdc
[    0.000000]  irqchip_init+0x30/0x38
[    0.000000]  init_IRQ+0xfc/0x130
[    0.000000]  start_kernel+0x288/0x418
[    0.000000] ---[ end trace c841ef100bdd09a7 ]---
[    0.000000] GICv3: CPU0: using allocated LPI pending table 
@0x0000001fbbb60000
[    0.000000] arch_timer: Enabling global workaround for HiSilicon 
erratum 161010101
[    0.000000] arch_timer: CPU0: Trapping CNTVCT access


> [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:1696 its_init+0x36c/0x608
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc3-jang+ #69
> [    0.000000] pstate: 60000089 (nZCv daIf -PAN -UAO)
> [    0.000000] pc : its_init+0x36c/0x608
> [    0.000000] lr : its_init+0x368/0x608
> [    0.000000] sp : ffff000008e53c60
> [    0.000000] x29: ffff000008e53c60 x28: ffff7dfffe6807a4
> [    0.000000] x27: 0000000000000001 x26: ffff80267b4c2100
> [    0.000000] x25: ffff000008ffe930 x24: ffff000008e5d9c8
> [    0.000000] x23: ffff80267bc10300 x22: ffff000008e5d9c8
> [    0.000000] x21: ffff000008e59000 x20: ffff000008f12000
> [    0.000000] x19: ffff000008ffe000 x18: ffffffffffffffff
> [    0.000000] x17: 0000000000000009 x16: 0000000000000000
> [    0.000000] x15: ffff000008e59648 x14: ffff000088fa616f
> [    0.000000] x13: ffff000008fa617d x12: ffff000008e7e000
> [    0.000000] x11: ffff000008e53900 x10: ffff000008e59eb0
> [    0.000000] x9 : ffff000008e3e018 x8 : ffff00000875ac58
> [    0.000000] x7 : 206f6e203a746e65 x6 : 000000000000018c
> [    0.000000] x5 : 0000000000000001 x4 : 0000000000000000
> [    0.000000] x3 : 0000000000000001 x2 : 4f419eae5e0eb800
> [    0.000000] x1 : 0000000000000000 x0 : 00000000ffffffed
> [    0.000000] Call trace:
> [    0.000000]  its_init+0x36c/0x608
> [    0.000000]  gic_init_bases+0x288/0x300
> [    0.000000]  gic_acpi_init+0x124/0x248
> [    0.000000]  acpi_match_madt+0x4c/0x88
> [    0.000000]  acpi_table_parse_entries_array+0x134/0x220
> [    0.000000]  acpi_table_parse_entries+0x70/0x98
> [    0.000000]  acpi_table_parse_madt+0x40/0x50
> [    0.000000]  __acpi_probe_device_table+0x88/0xe4
> [    0.000000]  irqchip_init+0x38/0x40
> [    0.000000]  init_IRQ+0xcc/0x100
> [    0.000000]  start_kernel+0x2fc/0x490
> [    0.000000] ---[ end trace 41868d15bb5cf8f6 ]---
>
> --Jan
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>


