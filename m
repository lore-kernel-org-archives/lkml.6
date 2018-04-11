Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48eYy3fWNplHxnwx/arl1KiB0ayf9HVQnljnPAnQP27PlJxZs7TGf3O5n64Ks8KFaP6O5Qf
ARC-Seal: i=1; a=rsa-sha256; t=1523473343; cv=none;
        d=google.com; s=arc-20160816;
        b=Nl+T3mL22XwEDHNtWIVHzZDZMuDb5KChxesAeq7lTjbocTtok3FcixgwnMSTbbeJU6
         0YYeYuyCQZbH10jzEHrqcVbzrpVHK27CDlBzIMo2swCrimB3p69OYjyycllyxxVQhhTp
         oAW7nyYQL2WowArWzW6IXmvN+gm33ItQwrxCuX3L7CAX9Jj/bwi4gsbAjltOL9nHn/uS
         iEbppuFbDl2K9cooPKoIvgNMw1ZuG97MkJuhttnKvuOBmcdU6QH/01Y72G8vx46xo2hl
         7LQsJt8XL5gBWgi4YroivRRFq+raDk7mECH62PS2XLwFQr+fGyv5tDxSxyP3koDFco0e
         /S8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0t8x8d+1R7bl26qkr3keGeY/sIPMGhfDpqQGy30FcTc=;
        b=U2YcxXKGfmSLs5ZKt7m9EiqhmqyEqHe4IeAwOS1P7Vwjb8CIXSwUCeAEGkxNFVJk5x
         DjznON6xe0cxyYD3Xw95BziqFPrH1JcEQTzEOUdAvM7NM2TZPApfM6X4zdIlfwHJuem6
         BKK8yTFzM1KtmZ0e60A6F37wL/2ef2/cUULtiw0XI7+zO7psp9i+w4yVVSPfzX3Yei5n
         Ts1TS1w8H8vmwIkDfwq+19R57L2BclfHogusqlav/UPB9etlrWpTrTLTQhtg6okYKfLy
         MH7K7emSoLkOXJQ4A6ZkUz4vNTBHhg7TCGYShx4N/FAEbyFCutFs8tdlSYd4qlo1964C
         gHSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Graf <agraf@suse.de>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Will Deacon <will.deacon@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 179/310] arm64: kernel: restrict /dev/mem read() calls to linear region
Date: Wed, 11 Apr 2018 20:35:18 +0200
Message-Id: <20180411183630.312958431@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477585103947316?=
X-GMAIL-MSGID: =?utf-8?q?1597477585103947316?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>


[ Upstream commit 1151f838cb626005f4d69bf675dacaaa5ea909d6 ]

When running lscpu on an AArch64 system that has SMBIOS version 2.0
tables, it will segfault in the following way:

  Unable to handle kernel paging request at virtual address ffff8000bfff0000
  pgd = ffff8000f9615000
  [ffff8000bfff0000] *pgd=0000000000000000
  Internal error: Oops: 96000007 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 0 PID: 1284 Comm: lscpu Not tainted 4.11.0-rc3+ #103
  Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
  task: ffff8000fa78e800 task.stack: ffff8000f9780000
  PC is at __arch_copy_to_user+0x90/0x220
  LR is at read_mem+0xcc/0x140

This is caused by the fact that lspci issues a read() on /dev/mem at the
offset where it expects to find the SMBIOS structure array. However, this
region is classified as EFI_RUNTIME_SERVICE_DATA (as per the UEFI spec),
and so it is omitted from the linear mapping.

So let's restrict /dev/mem read/write access to those areas that are
covered by the linear region.

Reported-by: Alexander Graf <agraf@suse.de>
Fixes: 4dffbfc48d65 ("arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/mmap.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -18,6 +18,7 @@
 
 #include <linux/elf.h>
 #include <linux/fs.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/export.h>
@@ -102,12 +103,18 @@ void arch_pick_mmap_layout(struct mm_str
  */
 int valid_phys_addr_range(phys_addr_t addr, size_t size)
 {
-	if (addr < PHYS_OFFSET)
-		return 0;
-	if (addr + size > __pa(high_memory - 1) + 1)
-		return 0;
-
-	return 1;
+	/*
+	 * Check whether addr is covered by a memory region without the
+	 * MEMBLOCK_NOMAP attribute, and whether that region covers the
+	 * entire range. In theory, this could lead to false negatives
+	 * if the range is covered by distinct but adjacent memory regions
+	 * that only differ in other attributes. However, few of such
+	 * attributes have been defined, and it is debatable whether it
+	 * follows that /dev/mem read() calls should be able traverse
+	 * such boundaries.
+	 */
+	return memblock_is_region_memory(addr, size) &&
+	       memblock_is_map_memory(addr);
 }
 
 /*
