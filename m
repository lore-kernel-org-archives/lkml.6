Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25FBC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440A224A79
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440A224A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeGBH0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:26:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752183AbeGBH0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:26:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A3FA401EF2F;
        Mon,  2 Jul 2018 07:26:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DDB21687B;
        Mon,  2 Jul 2018 07:26:43 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com
Subject: [PATCH 0/5 V5] Support kdump for AMD secure memory encryption(SME)
Date:   Mon,  2 Jul 2018 15:26:34 +0800
Message-Id: <20180702072639.10110-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 02 Jul 2018 07:26:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 02 Jul 2018 07:26:52 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This patch is only for SME kdump, it is not support SEV kdump.

For kdump(SME), there are two cases that doesn't support:
1. SME is enabled in the first kernel, but SME is disabled in the
second kernel
Because the old memory is encrypted, we can't decrypt the old memory
if SME is off in the second kernel.

2. SME is disabled in the first kernel, but SME is enabled in the
second kernel
Maybe it is unnecessary to support this case, because the old memory
is unencrypted, the old memory can be dumped as usual, we don't need
to enable sme in the second kernel, furthermore the requirement is
rare in actual deployment. Another, If we must support the scenario,
it will increase the complexity of the code, we will have to consider
how to transfer the sme flag from the first kernel to the second kernel,
in order to let the second kernel know that whether the old memory is
encrypted.
There are two manners to transfer the SME flag to the second kernel, the
first way is to modify the assembly code, which includes some common
code and the path is too long. The second way is to use kexec tool,
which could require the sme flag to be exported in the first kernel
by "proc" or "sysfs", kexec will read the sme flag from "proc" or
"sysfs" when we use kexec tool to load image, subsequently the sme flag
will be saved in boot_params, we can properly remap the old memory
according to the previously saved sme flag. Although we can fix this
issue, maybe it is too expensive to do this. By the way, we won't fix
the problem unless someone thinks it is necessary to do it.

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

Linux 4.18-rc3:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Jul 1 16:04:53 2018 -0700

Reference:
AMD64 Architecture Programmer's Manual
https://support.amd.com/TechDocs/24593.pdf

Some changes:
1. remove the sme_active() check in __ioremap_caller().
2. remove the '#ifdef' stuff throughout this patch.
3. put some logic into the early_memremap_pgprot_adjust() and clean the
previous unnecessary changes, for example: arch/x86/include/asm/dmi.h,
arch/x86/kernel/acpi/boot.c, drivers/acpi/tables.c.
4. add a new file and modify Makefile.
5. clean compile warning in copy_device_table() and some compile error.
6. split the original patch into five patches, it will be better for
review.
7. add some comments.

Some known issues:
1. about SME
Upstream kernel doesn't work when we use kexec in the follow command. The
system will hang on 'HP ProLiant DL385Gen10 AMD EPYC 7251'. But it can't
reproduce on speedway.
(This issue doesn't matter with the kdump patch.)

Reproduce steps:
 # kexec -l /boot/vmlinuz-4.18.0-rc3+ --initrd=/boot/initramfs-4.18.0-rc3+.img --command-line="root=/dev/mapper/rhel_hp--dl385g10--03-root ro mem_encrypt=on rd.lvm.lv=rhel_hp-dl385g10-03/root rd.lvm.lv=rhel_hp-dl385g10-03/swap console=ttyS0,115200n81 LANG=en_US.UTF-8 earlyprintk=serial debug nokaslr"
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
  Add a function(ioremap_encrypted) for kdump when AMD sme enabled
  Allocate pages for kdump without encryption when SME is enabled
  Remap the device table of IOMMU in encrypted manner for kdump
  Adjust some permanent mappings in unencrypted ways for kdump when SME
    is enabled.
  Help to dump the old memory encrypted into vmcore file

 arch/x86/include/asm/io.h            |  3 ++
 arch/x86/kernel/Makefile             |  1 +
 arch/x86/kernel/crash_dump_encrypt.c | 53 ++++++++++++++++++++++++++++++++++++
 arch/x86/mm/ioremap.c                | 36 ++++++++++++++++++------
 drivers/iommu/amd_iommu_init.c       | 14 ++++++++--
 fs/proc/vmcore.c                     | 21 ++++++++++----
 include/linux/crash_dump.h           | 12 ++++++++
 kernel/kexec_core.c                  | 12 ++++++++
 8 files changed, 135 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/kernel/crash_dump_encrypt.c

-- 
2.9.5

