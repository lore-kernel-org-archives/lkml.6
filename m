Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419DFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42B62075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42B62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeIGM6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:58:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbeIGM6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:58:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 281F0402315B;
        Fri,  7 Sep 2018 08:18:21 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4754910075D3;
        Fri,  7 Sep 2018 08:18:10 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com
Subject: [PATCH 0/4 v7] Support kdump for AMD secure memory encryption(SME)
Date:   Fri,  7 Sep 2018 16:18:01 +0800
Message-Id: <20180907081805.368-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 08:18:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 08:18:21 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
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

kexec-tools-2.0.17: git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
commit b9de21ef51a7 (kexec: fix for "Unhandled rela relocation: R_X86_64_PLT32" error)
Note:
Before you load the kernel and initramfs for kdump, this patch(http://lists.infradead.org/pipermail/kexec/2018-September/021460.html)
must be merged to kexec-tools, and then the kdump kernel will work well. Because there
is a patch which is removed based on v6(x86/ioremap: strengthen the logic in early_memremap_pgprot_adjust()
to adjust encryption mask).

Test environment:
HP ProLiant DL385Gen10 AMD EPYC 7251
8-Core Processor
32768 MB memory
600 GB disk space

Linux 4.19-rc2:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
commit 57361846b52bc686112da6ca5368d11210796804

Reference:
AMD64 Architecture Programmer's Manual
https://support.amd.com/TechDocs/24593.pdf

Changes since v6:
1. There is a patch which is removed based on v6.
(x86/ioremap: strengthen the logic in early_memremap_pgprot_adjust() to adjust encryption mask)
Dave Young suggests that this patch can be removed and fix the kexec-tools.
Reference: http://lists.infradead.org/pipermail/kexec/2018-September/021460.html)
2. Update the patch log.

Some known issues:
1. about SME
Upstream kernel will hang on HP machine(DL385Gen10 AMD EPYC 7251) when
we execute the kexec command as follow:

# kexec -l /boot/vmlinuz-4.19.0-rc2+ --initrd=/boot/initramfs-4.19.0-rc2+.img --command-line="root=/dev/mapper/rhel_hp--dl385g10--03-root ro mem_encrypt=on rd.lvm.lv=rhel_hp-dl385g10-03/root rd.lvm.lv=rhel_hp-dl385g10-03/swap console=ttyS0,115200n81 LANG=en_US.UTF-8 earlyprintk=serial debug nokaslr"
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


Lianbo Jiang (4):
  x86/ioremap: add a function ioremap_encrypted() to remap kdump old
    memory
  kexec: allocate unencrypted control pages for kdump in case SME is
    enabled
  amd_iommu: remap the device table of IOMMU with the memory encryption
    mask for kdump
  kdump/vmcore: support encrypted old memory with SME enabled

 arch/x86/include/asm/io.h            |  3 ++
 arch/x86/kernel/Makefile             |  1 +
 arch/x86/kernel/crash_dump_encrypt.c | 53 ++++++++++++++++++++++++++++
 arch/x86/mm/ioremap.c                | 25 ++++++++-----
 drivers/iommu/amd_iommu_init.c       | 14 ++++++--
 fs/proc/vmcore.c                     | 21 +++++++----
 include/linux/crash_dump.h           | 12 +++++++
 kernel/kexec_core.c                  | 12 +++++++
 8 files changed, 125 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/kernel/crash_dump_encrypt.c

-- 
2.17.1

