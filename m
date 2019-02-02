Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793CC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF8420870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBLc/6O/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfBBJlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:41:45 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33705 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfBBJlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:41:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so7526892eds.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 01:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQBUl2UZJ0vfR/KYX3Z1OnD6qvSuR/J3cZ1KmLStMQw=;
        b=hBLc/6O/QY8ijpLk6qYy7tQmvlFjGW9YPnqwanYXgw1mgswBhE7ZzJjwAUG38zOxdS
         5yAiGypuQ8Ks8fEg8zGfrguYNTBmpN5lwRbPbfRn9cMAzutBavYdzkrdlHgRVz86LIuA
         wwuGWvX0yxxs6x2Os2bCXL+F69LaZsymCxNxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQBUl2UZJ0vfR/KYX3Z1OnD6qvSuR/J3cZ1KmLStMQw=;
        b=FwpN5eIcwSJaSkeAONGglEdiG+Az2J1j7SHkCrtqPWUZhmMtl91noj6501AVSLHYPa
         yJra0qQLnqs3NOddH/Vg5eTy53vC3alxuevn4V/b0yQxVyODQ+dFhSUSl6b4oTAjdftQ
         i1MQAPQhC+L4H29sk2VDsbi+nzHcXgHvpNhIH/3AAxQ6wU2MJ+nz0DpHgG7+mAG6VpKL
         KVnArVFMEns8fdlNg3DsvjXaa1cKmpY1kegythcTinTduJ97nPhfkYJfYtDm6wrs8AlV
         n9J00TuVUEJhV/K53D9Q8Bl6br+eB2FsPuETuuKo0QRLQXNyAvBBBxPTCA9V3GnPOW2R
         Zgow==
X-Gm-Message-State: AJcUukd+DbcieDLxPY5p4ozxRBSzkLG9JNpfV05834mEGINaYQdxiGTc
        lYi+mfdXBF0EvBx+8tHd4CBfrA==
X-Google-Smtp-Source: ALg8bN617S9wA+K5NyCJgkCfBVJnRzDB3QmUHh6+YvNvJWvkyDGA2O18oLvFR1tS2J8u+Cbf+ZkZGw==
X-Received: by 2002:a50:a786:: with SMTP id i6mr42297103edc.37.1549100497431;
        Sat, 02 Feb 2019 01:41:37 -0800 (PST)
Received: from mba13.c.hoisthospitality.com ([109.236.135.164])
        by smtp.gmail.com with ESMTPSA id l41sm2608824eda.83.2019.02.02.01.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 01:41:36 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH 07/10] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
Date:   Sat,  2 Feb 2019 10:41:16 +0100
Message-Id: <20190202094119.13230-8-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

(Note that 32-bit ARM generally does require SetVirtualAddressMap() to be
used, given that the physical memory map and the kernel virtual address
map are not guaranteed to be non-overlapping like on arm64. However,
having support for efi=novamap,noruntime on 32-bit ARM, combined with
the recently proposed support for earlycon=efifb, is likely to be useful
to diagnose boot issues on such systems if they have no accessible serial
port)

Cc: Alexander Graf <agraf@suse.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
-- 
2.17.1

