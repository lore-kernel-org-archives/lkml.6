Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4EC9BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE51B208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE51B208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754750AbeFNIsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:48:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752928AbeFNIr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:47:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C91787D858;
        Thu, 14 Jun 2018 08:47:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6478B1C66C;
        Thu, 14 Jun 2018 08:47:52 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, thomas.lendacky@amd.com,
        dyoung@redhat.com
Subject: [PATCH 0/2 V2] Support kdump for AMD secure memory encryption(sme)
Date:   Thu, 14 Jun 2018 16:47:46 +0800
Message-Id: <20180614084748.9617-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 14 Jun 2018 08:47:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 14 Jun 2018 08:47:56 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is convenient to remap the old memory encrypted to the second kernel by
calling ioremap_encrypted().

When sme enabled on AMD server, we also need to support kdump. Because
the memory is encrypted in the first kernel, we will remap the old memory
encrypted to the second kernel(crash kernel), and sme is also enabled in
the second kernel, otherwise the old memory encrypted can not be decrypted.
Because simply changing the value of a C-bit on a page will not
automatically encrypt the existing contents of a page, and any data in the
page prior to the C-bit modification will become unintelligible. A page of
memory that is marked encrypted will be automatically decrypted when read
from DRAM and will be automatically encrypted when written to DRAM.

For the kdump, it is necessary to distinguish whether the memory is
encrypted. Furthermore, we should also know which part of the memory is
encrypted or decrypted. We will appropriately remap the memory according
to the specific situation in order to tell cpu how to deal with the
data(encrypted or decrypted). For example, when sme enabled, if the old
memory is encrypted, we will remap the old memory in encrypted way, which
will automatically decrypt the old memory encrypted when we read those data
from the remapping address.

 ----------------------------------------------
| first-kernel | second-kernel | kdump support |
|      (mem_encrypt=on|off)    |   (yes|no)    | 
|--------------+---------------+---------------|
|     on       |     on        |     yes       |
|     off      |     off       |     yes       |
|     on       |     off       |     no        |
|     off      |     on        |     no        |
|______________|_______________|_______________|

Test tools:
makedumpfile[v1.6.3]: https://github.com/LianboJ/makedumpfile
commit e1de103eca8f (A draft for kdump vmcore about AMD SME)
Author: Lianbo Jiang <lijiang@redhat.com>
Date:   Mon May 14 17:02:40 2018 +0800
Note: This patch can only dump vmcore in the case of SME enabled.

crash-7.2.1: https://github.com/crash-utility/crash.git
commit 1e1bd9c4c1be (Fix for the "bpf" command display on Linux 4.17-rc1)
Author: Dave Anderson <anderson@redhat.com>
Date:   Fri May 11 15:54:32 2018 -0400

Test environment:
HP ProLiant DL385Gen10 AMD EPYC 7251
8-Core Processor
32768 MB memory
600 GB disk space

Linux 4.17-rc7:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
commit b04e217704b7 ("Linux 4.17-rc7")
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun May 27 13:01:47 2018 -0700

Reference:
AMD64 Architecture Programmer's Manual
https://support.amd.com/TechDocs/24593.pdf

Some changes based on V1:
1. remove the sme_active() check in __ioremap_caller().
2. remove the '#ifdef' stuff throughout this patch.
3. put some logic into the early_memremap_pgprot_adjust() and clean the
previous unnecessary changes, for example: arch/x86/include/asm/dmi.h,
arch/x86/kernel/acpi/boot.c, drivers/acpi/tables.c.
4. rewrite two functions, copy_oldmem_page() and
copy_oldmem_page_encrypted().
5. distingish sme_active() and sev_active(), when a distinction doesn't
need, mem_encrypt_active() will be used.
6. clean compile warning in copy_device_table().

Some known issues:
1. about SME
Upstream kernel doesn't work when we use kexec in the follow command. The
system will hang.
(This issue doesn't matter with the kdump patch.)

Reproduce steps:
 # kexec -l /boot/vmlinuz-4.17.0-rc7+ --initrd=/boot/initramfs-4.17.0-rc7+.img --command-line="root=/dev/mapper/rhel_hp--dl385g10--03-root ro mem_encrypt=on rd.lvm.lv=rhel_hp-dl385g10-03/root rd.lvm.lv=rhel_hp-dl385g10-03/swap console=ttyS0,115200n81 LANG=en_US.UTF-8 earlyprintk=serial debug nokaslr"
 # kexec -e (or reboot)

The system will hang:
[ 1248.932239] kexec_core: Starting new kernel
early console in extract_kernel
input_data: 0x000000087e91c3b4
input_len: 0x000000000067fcbd
output: 0x000000087d400000
output_len: 0x0000000001b6fa90
kernel_total_size: 0x0000000001a9d000
trampoline_32bit: 0x0000000000099000

Decompressing Linux... 
Parsing ELF...        [-here the system will hang]

2. about SEV
Upstream kernel doesn't work about SEV on our machine, some drivers always
go wrong. We don't have the suitable machine to test SEV for kdump patch.
Maybe it is resonable to improve SEV in another patch. When SEV works
fine, we will test the kdump patch for SEV. 

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

Lianbo Jiang (2):
  Add a function(ioremap_encrypted) for kdump when AMD sme enabled.
  Support kdump when AMD secure memory encryption is active

 arch/x86/include/asm/io.h       |  3 +++
 arch/x86/kernel/crash_dump_64.c | 42 +++++++++++++++++++++++++++++++----------
 arch/x86/mm/ioremap.c           | 28 +++++++++++++++++++--------
 drivers/iommu/amd_iommu_init.c  | 14 +++++++++++++-
 fs/proc/vmcore.c                | 20 +++++++++++++++-----
 include/linux/crash_dump.h      |  5 +++++
 kernel/kexec_core.c             | 12 ++++++++++++
 7 files changed, 100 insertions(+), 24 deletions(-)

-- 
2.9.5

