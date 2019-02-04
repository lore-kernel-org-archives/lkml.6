Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF35C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE50020820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfBDIqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:46:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50215 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfBDIqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:46:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148jY7L356500
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:45:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148jYhK356497;
        Mon, 4 Feb 2019 00:45:34 -0800
Date:   Mon, 4 Feb 2019 00:45:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-4e46c2a956215482418d7b315749fb1b6c6bc224@git.kernel.org>
Cc:     hpa@zytor.com, ard.biesheuvel@linaro.org, matt@codeblueprint.co.uk,
        peterz@infradead.org, sai.praneeth.prakhya@intel.com,
        bjorn.andersson@linaro.org, leif.lindholm@linaro.org,
        xypron.glpk@gmx.de, tglx@linutronix.de, bp@alien8.de,
        pjones@redhat.com, mingo@kernel.org, lee.jones@linaro.org,
        agraf@suse.de, takahiro.akashi@linaro.org,
        linux-kernel@vger.kernel.org, jhugo@codeaurora.org,
        torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, leif.lindholm@linaro.org, xypron.glpk@gmx.de,
          bp@alien8.de, bjorn.andersson@linaro.org,
          matt@codeblueprint.co.uk, sai.praneeth.prakhya@intel.com,
          peterz@infradead.org, hpa@zytor.com, ard.biesheuvel@linaro.org,
          torvalds@linux-foundation.org, jhugo@codeaurora.org,
          agraf@suse.de, takahiro.akashi@linaro.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          lee.jones@linaro.org, pjones@redhat.com
In-Reply-To: <20190202094119.13230-8-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-8-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/arm/arm64: Allow SetVirtualAddressMap() to be
 omitted
Git-Commit-ID: 4e46c2a956215482418d7b315749fb1b6c6bc224
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4e46c2a956215482418d7b315749fb1b6c6bc224
Gitweb:     https://git.kernel.org/tip/4e46c2a956215482418d7b315749fb1b6c6bc224
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Sat, 2 Feb 2019 10:41:16 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:27:26 +0100

efi/arm/arm64: Allow SetVirtualAddressMap() to be omitted

The UEFI spec revision 2.7 errata A section 8.4 has the following to
say about the virtual memory runtime services:

  "This section contains function definitions for the virtual memory
  support that may be optionally used by an operating system at runtime.
  If an operating system chooses to make EFI runtime service calls in a
  virtual addressing mode instead of the flat physical mode, then the
  operating system must use the services in this section to switch the
  EFI runtime services from flat physical addressing to virtual
  addressing."

So it is pretty clear that calling SetVirtualAddressMap() is entirely
optional, and so there is no point in doing so unless it achieves
anything useful for us.

This is not the case for 64-bit ARM. The identity mapping used by the
firmware is arbitrarily converted into another permutation of userland
addresses (i.e., bits [63:48] cleared), and the runtime code could easily
deal with the original layout in exactly the same way as it deals with
the converted layout. However, due to constraints related to page size
differences if the OS is not running with 4k pages, and related to
systems that may expose the individual sections of PE/COFF runtime
modules as different memory regions, creating the virtual layout is a
bit fiddly, and requires us to sort the memory map and reason about
adjacent regions with identical memory types etc etc.

So the obvious fix is to stop calling SetVirtualAddressMap() altogether
on arm64 systems. However, to avoid surprises, which are notoriously
hard to diagnose when it comes to OS<->firmware interactions, let's
start by making it an opt-out feature, and implement support for the
'efi=novamap' kernel command line parameter on ARM and arm64 systems.

( Note that 32-bit ARM generally does require SetVirtualAddressMap() to be
  used, given that the physical memory map and the kernel virtual address
  map are not guaranteed to be non-overlapping like on arm64. However,
  having support for efi=novamap,noruntime on 32-bit ARM, combined with
  the recently proposed support for earlycon=efifb, is likely to be useful
  to diagnose boot issues on such systems if they have no accessible serial
  port. )

Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190202094119.13230-8-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/arm-stub.c        |  5 +++++
 drivers/firmware/efi/libstub/efi-stub-helper.c | 10 ++++++++++
 drivers/firmware/efi/libstub/efistub.h         |  1 +
 drivers/firmware/efi/libstub/fdt.c             |  3 +++
 4 files changed, 19 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index eee42d5e25ee..626ec4b4a664 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -370,6 +370,11 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 		paddr = in->phys_addr;
 		size = in->num_pages * EFI_PAGE_SIZE;
 
+		if (novamap()) {
+			in->virt_addr = in->phys_addr;
+			continue;
+		}
+
 		/*
 		 * Make the mapping compatible with 64k pages: this allows
 		 * a 4k page size kernel to kexec a 64k page size kernel and
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 8f2d000bec75..e4610e72b78f 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -31,6 +31,7 @@ static unsigned long __chunk_size = EFI_READ_CHUNK_SIZE;
 
 static int __section(.data) __nokaslr;
 static int __section(.data) __quiet;
+static int __section(.data) __novamap;
 
 int __pure nokaslr(void)
 {
@@ -40,6 +41,10 @@ int __pure is_quiet(void)
 {
 	return __quiet;
 }
+int __pure novamap(void)
+{
+	return __novamap;
+}
 
 #define EFI_MMAP_NR_SLACK_SLOTS	8
 
@@ -479,6 +484,11 @@ efi_status_t efi_parse_options(char const *cmdline)
 			__chunk_size = -1UL;
 		}
 
+		if (!strncmp(str, "novamap", 7)) {
+			str += strlen("novamap");
+			__novamap = 1;
+		}
+
 		/* Group words together, delimited by "," */
 		while (*str && *str != ' ' && *str != ',')
 			str++;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cefcf6ba3150..1b1dfcaa6fb9 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -27,6 +27,7 @@
 
 extern int __pure nokaslr(void);
 extern int __pure is_quiet(void);
+extern int __pure novamap(void);
 
 #define pr_efi(sys_table, msg)		do {				\
 	if (!is_quiet()) efi_printk(sys_table, "EFI stub: "msg);	\
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 7cfc51935c4b..5440ba17a1c5 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -318,6 +318,9 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	if (status == EFI_SUCCESS) {
 		efi_set_virtual_address_map_t *svam;
 
+		if (novamap())
+			return EFI_SUCCESS;
+
 		/* Install the new virtual address map */
 		svam = sys_table->runtime->set_virtual_address_map;
 		status = svam(runtime_entry_count * desc_size, desc_size,
