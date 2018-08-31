Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7A1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E50D2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E50D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeHaM0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:26:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbeHaM0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:26:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF27E401EF02;
        Fri, 31 Aug 2018 08:19:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6068110D18E0;
        Fri, 31 Aug 2018 08:19:34 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com
Subject: [PATCH 0/5 V6] Support kdump for AMD secure memory encryption(SME)
Date:   Fri, 31 Aug 2018 16:19:25 +0800
Message-Id: <20180831081930.31561-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 31 Aug 2018 08:19:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 31 Aug 2018 08:19:46 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SME is enabled on AMD machine, we also need to support kdump. Because
the memory is encrypted in the first kernel, we will remap the old memory
to the kdump kernel for dumping data, and SME is also enabled in the kdump
kernel, otherwise the old memory can not be decrypted.

For the kdump, it is necessary to distinguish whether the memory is encrypted.
Furthermore, we should also know which part of the memory is encrypted or
decrypted. We will appropriately remap the memory according to the specific
situation in order to tell cpu how to access the memory.

As we know, a page of memory that is marked as encrypted, which will be
automatically decrypted when read from DRAM, and will also be automatically
encrypted when written to DRAM. If the old memory is encrypted, we have to
remap the old memory with the memory encryption mask, which will automatically
decrypt the old memory when we read those data.

For kdump(SME), there are two cases that doesn't support:

 ----------------------------------------------
| first-kernel | second-kernel | kdump support |
|      (mem_encrypt=on|off)    |   (yes|no)    |
|--------------+---------------+---------------|
|     on       |     on        |     yes       |
|     off      |     off       |     yes       |
|     on       |     off       |     no        |
|     off      |     on        |     no        |
|______________|_______________|_______________|

1. SME is enabled in the first kernel, but SME is disabled in kdump kernel
In this case, because the old memory is encrypted, we can't decrypt the
old memory.

2. SME is disabled in the first kernel, but SME is enabled in kdump kernel
It is unnecessary to support in this case, because the old memory is
unencrypted, the old memory can be dumped as usual, we don't need to enable
SME in kdump kernel. Another, If we must support the scenario, it will
increase the complexity of the code, we will have to consider how to pass
the SME flag from the first kernel to the kdump kernel, in order to let the
kdump kernel know that whether the old memory is encrypted.

There are two methods to pass the SME flag to the kdump kernel. The first
method is to modify the assembly code, which includes some common code and
the path is too long. The second method is to use kexec tool, which could
require the SME flag to be exported in the first kernel by "proc" or "sysfs",
kexec tools will read the SME flag from "proc" or "sysfs" when we use kexec
tools to load image, subsequently the SME flag will be saved in boot_params,
we can properly remap the old memory according to the previously saved SME
flag. But it is too expensive to do this.

This patches are only for SME kdump, the patches don't support SEV kdump.

Test tools:
makedumpfile[v1.6.3]: https://github.com/LianboJ/makedumpfile
commit e1de103eca8f (A draft for kdump vmcore about AMD SME)
Note: This patch can only dump vmcore in the case of SME enabled.

crash-7.2.3: https://github.com/crash-utility/crash.git
commit 001f77a05585 (Fix for Linux 4.19-rc1 and later kernels that contain
                     kernel commit7290d58095712a89f845e1bca05334796dd49ed2)

Test environment:
HP ProLiant DL385Gen10 AMD EPYC 7251
8-Core Processor
32768 MB memory
600 GB disk space

Linux 4.19-rc1:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
commit 5b394b2ddf0347bef56e50c69a58773c94343ff3

Reference:
AMD64 Architecture Programmer's Manual
https://support.amd.com/TechDocs/24593.pdf

Changes since v5:
1. modified patches log.

Some known issues:
1. about SME
Upstream kernel will hang on HP machine(DL385Gen10 AMD EPYC 7251) when
we execute the kexec command as follow:

# kexec -l /boot/vmlinuz-4.19.0-rc1+ --initrd=/boot/initramfs-4.19.0-rc1+.img --command-line="root=/dev/mapper/rhel_hp--dl385g10--03-root ro mem_encrypt=on rd.lvm.lv=rhel_hp-dl385g10-03/root rd.lvm.lv=rhel_hp-dl385g10-03/swap console=ttyS0,115200n81 LANG=en_US.UTF-8 earlyprintk=serial debug nokaslr"
# kexec -e (or reboot)

But this issue can not be reproduced on speedway machine, and this issue
is irrelevant to my posted patches.

The kernel log:
[ 1248.932239] kexec_core: Starting new kernel
early console in extract_kernel
input_data: 0x000000087e91c3b4
input_len: 0x000000000067fcbd
output: 0x000000087d400000
output_len: 0x0000000001b6fa90
kernel_total_size: 0x0000000001a9d000
trampoline_32bit: 0x0000000000099000

Decompressing Linux...
Parsing ELF...        [---Here the system will hang]

2. about SEV
Upstream kernel(Host OS) doesn't work in host side, some drivers about
SEV always go wrong in host side. We can't boot SEV Guest OS to test
kdump patch. Maybe it is more reasonable to improve SEV in another
patch. When some drivers can work in host side and it can also boot
Virtual Machine(SEV Guest OS), it will be suitable to fix SEV for kdump.

[  369.426131] INFO: task systemd-udevd:865 blocked for more than 120 seconds.
[  369.433177]       Not tainted 4.17.0-rc5+ #60
[  369.437585] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  369.445783] systemd-udevd   D    0   865    813 0x80000004
[  369.451323] Call Trace:
[  369.453815]  ? __schedule+0x290/0x870
[  369.457523]  schedule+0x32/0x80
[  369.460714]  __sev_do_cmd_locked+0x1f6/0x2a0 [ccp]
[  369.465556]  ? cleanup_uevent_env+0x10/0x10
[  369.470084]  ? remove_wait_queue+0x60/0x60
[  369.474219]  ? 0xffffffffc0247000
[  369.477572]  __sev_platform_init_locked+0x2b/0x70 [ccp]
[  369.482843]  sev_platform_init+0x1d/0x30 [ccp]
[  369.487333]  psp_pci_init+0x40/0xe0 [ccp]
[  369.491380]  ? 0xffffffffc0247000
[  369.494936]  sp_mod_init+0x18/0x1000 [ccp]
[  369.499071]  do_one_initcall+0x4e/0x1d4
[  369.502944]  ? _cond_resched+0x15/0x30
[  369.506728]  ? kmem_cache_alloc_trace+0xae/0x1d0
[  369.511386]  ? do_init_module+0x22/0x220
[  369.515345]  do_init_module+0x5a/0x220
[  369.519444]  load_module+0x21cb/0x2a50
[  369.523227]  ? m_show+0x1c0/0x1c0
[  369.526571]  ? security_capable+0x3f/0x60
[  369.530611]  __do_sys_finit_module+0x94/0xe0
[  369.534915]  do_syscall_64+0x5b/0x180
[  369.538607]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  369.543698] RIP: 0033:0x7f708e6311b9
[  369.547536] RSP: 002b:00007ffff9d32aa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  369.555162] RAX: ffffffffffffffda RBX: 000055602a04c2d0 RCX: 00007f708e6311b9
[  369.562346] RDX: 0000000000000000 RSI: 00007f708ef52039 RDI: 0000000000000008
[  369.569801] RBP: 00007f708ef52039 R08: 0000000000000000 R09: 000055602a048b20
[  369.576988] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
[  369.584177] R13: 000055602a075260 R14: 0000000000020000 R15: 0000000000000000

Lianbo Jiang (5):
  x86/ioremap: add a function ioremap_encrypted() to remap kdump old
    memroy
  x86/ioremap: strengthen the logic in early_memremap_pgprot_adjust() to
    adjust encryption mask
  kexec: allocate unencrypted control pages for kdump in case SME is
    enabled
  iommu/amd_iommu: remap the device table of IOMMU with the memory
    encryption mask for kdump
  kdump/vmcore: support encrypted old memory with SME enabled

 arch/x86/include/asm/io.h            |  3 ++
 arch/x86/kernel/Makefile             |  1 +
 arch/x86/kernel/crash_dump_encrypt.c | 53 ++++++++++++++++++++++++++++
 arch/x86/mm/ioremap.c                | 34 +++++++++++++-----
 drivers/iommu/amd_iommu_init.c       | 14 ++++++--
 fs/proc/vmcore.c                     | 21 +++++++----
 include/linux/crash_dump.h           | 12 +++++++
 kernel/kexec_core.c                  | 12 +++++++
 8 files changed, 133 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/kernel/crash_dump_encrypt.c

-- 
2.17.1

