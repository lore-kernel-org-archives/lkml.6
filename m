Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbeEOBvo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:51:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752307AbeEOBvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:51:42 -0400
From: Lianbo Jiang <lijiang@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, thomas.lendacky@amd.com, dyoung@redhat.com
Subject: [PATCH 0/2] support kdump for AMD secure memory encryption(sme)
Date: Tue, 15 May 2018 09:51:31 +0800
Message-Id: <20180515015133.4363-1-lijiang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
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

Linux 4.17-rc4:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
commit 75bc37fefc44 ("Linux 4.17-rc4")
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun May 6 16:57:38 2018 -1000

Reference:
AMD64 Architecture Programmer's Manual
https://support.amd.com/TechDocs/24593.pdf

Lianbo Jiang (2):
  add a function(ioremap_encrypted) for kdump when AMD sme enabled.
  support kdump when AMD secure memory encryption is active

 arch/x86/include/asm/dmi.h      | 14 +++++++++++++-
 arch/x86/include/asm/io.h       |  2 ++
 arch/x86/kernel/acpi/boot.c     |  8 ++++++++
 arch/x86/kernel/crash_dump_64.c | 27 +++++++++++++++++++++++++++
 arch/x86/mm/ioremap.c           | 25 +++++++++++++++++--------
 drivers/acpi/tables.c           | 14 +++++++++++++-
 drivers/iommu/amd_iommu_init.c  |  9 ++++++++-
 fs/proc/vmcore.c                | 36 +++++++++++++++++++++++++++++++-----
 include/linux/crash_dump.h      |  4 ++++
 kernel/kexec_core.c             | 12 ++++++++++++
 10 files changed, 135 insertions(+), 16 deletions(-)

-- 
2.9.5
