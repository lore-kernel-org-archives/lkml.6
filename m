Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D56C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6816024EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6816024EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753781AbeGCBvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:51:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:5207 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752839AbeGCBvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:51:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 18:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,301,1526367600"; 
   d="scan'208";a="212956359"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2018 18:51:06 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Dave Young <dyoung@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Laszlo Ersek <lersek@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Nicolai Stange <nicstange@gmail.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 0/6] Fix memory leaks in efi subsystem
Date:   Mon,  2 Jul 2018 18:50:48 -0700
Message-Id: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Presently, in efi subsystem of kernel, every time kernel allocates
memory for a new memory map, it forgets to free the memory occupied by
old memory map. It does clear the mappings though (using efi_memmap_unmap()),
but forgets to free up the memory. Also, there is another minor issue,
where in the newly allocated memory isn't freed, should remap fail.

The bug might sound very simple but the fix looks a bit complicated
because memory used by efi memory map could be of three different types,
namely a) memblock_reserved b) memblock_alloc'ed c) normal paged memory.
The fix requires changes to many already existing efi memory map API's
because whenever the memory map is updated, the type of memory allocation
should be recorded, so that we could use it while freeing.
"efi.memmap.alloc_type" is introduced for the same reason as "bool late"
wouldn't suffice.

More detailed explanation:
--------------------------
A typical boot flow on EFI supported x86_64 machines might look something
like below
1. EFI memory map is passed by firmware to kernel.
2. Kernel does a memblock_reserve() on this memory
    (see efi_memblock_x86_reserve_range()).
3. To further process this memory map (see efi_fake_memmap(), efi_bgrt_init()
    and efi_esrt_init()), kernel might allocate some memory using
    memblock_alloc() and copies the processed memory map to newly
    allocated memory but it forgets to free memory occupied by old
    memory map i.e. the memblock_reserved memory.
4. Further, the new memblock allocated memory map is again processed
    (see efi_map_regions() in efi_enter_virtual_mode()). Kernel again
    allocates memory to store the processed memory map, but this time
    using realloc_pages() as paging is initialized. Old memory map i.e.
    the memblock_allocated memory is not freed.
6. A third processing is performed by efi_free_boot_services() and this
    time paged memory isn't freed.

Brief summary of patches:
-------------------------
Patch 1 introduces a new API called efi_memmap_free() which frees memory
allocated by efi_memmap_alloc(). This API will be used in later patches
i.e. 4, 5 and 6.

Patch 2 modifies efi_memmap_alloc(), an existing API, so that it lets
the user know about the type of allocation performed. It's used to free
the allocated memory, should remap fail.

Patch 3 modifies many existing API's in drivers/firmware/efi/memmap.c
file, so that "efi.memmap.alloc_type" now rightly records the type of
memory associated with efi memory map. As said earlier, this memory
could be of three types a) memblock_reserved b) memblock_alloc'ed
c) normal paged memory. Previously, "efi.memmap.late" recorded only two
types of memory, namely, memblock_alloc'ed and normal paged memory and
hence this approach cannot be used to fix memory leak.

Patch 4 actually fixes the issue by freeing up the memory allocated to
previous memory map before installing a new memory map.

Patch 5 fixes another issue where in the newly allocated memory isn't
freed, should remap fail.

Patch 6 fixes yet another issue in efi_fake_memmap(), unrelated to this
patch set but found in the testing process.

Testing:
--------
Tested with LUV on qemu-x86_64 and on my dev machine. Checked for
unchanged boot behavior i.e. shouldn't break any existing stuff. Built
for arm, arm64 and ia64 and found no new warnings/errors. Would
appreciate the effort if someone could test on arm machines.

Although majority of the changes are made to drivers/firmware/efi/memmap.c
file (which is common across architectures), this bug is only limited to
x86_64 machines and hence this patch set shouldn't effect any other
architectures.

Note: This patch set is based on Linus's mainline tree v4.18-rc3.
1. Please also note that this patch set makes commit "3551b85ed8bf (x86/efi:
    Free allocated memory if remap fails) in efi tree[1] obsolete.
2. This patch set is an outcome of the discussion at [2] and should
    actually be V2. But, as it now evolved into a patch set instead of
    single patch and also fixes another two issues, I have started it as
    a new series and hence V1.

[1] git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
[2] https://lkml.org/lkml/2018/6/25/1113

Sai Praneeth (6):
  efi: Introduce efi_memmap_free() to free memory allocated by    
    efi_memmap_alloc()
  efi: Let the user of efi_memmap_alloc() know the type of allocation   
     performed
  efi: Use efi.memmap.alloc_type instead of efi.memmap.late
  x86/efi: Free existing memory map before installing new memory map
  x86/efi: Free allocated memory if remap fails
  efi: Fix unaligned fake memmap entries corrupting efi memory map

 arch/x86/platform/efi/efi.c     |  7 +++-
 arch/x86/platform/efi/quirks.c  | 34 ++++++++++++----
 drivers/firmware/efi/arm-init.c |  2 +-
 drivers/firmware/efi/fake_mem.c | 21 +++++++---
 drivers/firmware/efi/memmap.c   | 86 +++++++++++++++++++++++++++++++----------
 include/linux/efi.h             | 23 ++++++++---
 6 files changed, 131 insertions(+), 42 deletions(-)

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Nicolai Stange <nicstange@gmail.com>
Cc: Naresh Bhat <naresh.bhat@linaro.org>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

-- 
2.7.4

