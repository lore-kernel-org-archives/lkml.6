Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAEDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FAE2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FAE2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbeLDV0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:26:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:51967 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbeLDV0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:26:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="96127310"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2018 13:26:01 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 1/4] x86/vdso: Remove obsolete "fake section table" reservation
Date:   Tue,  4 Dec 2018 13:25:57 -0800
Message-Id: <20181204212600.28090-2-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204212600.28090-1-sean.j.christopherson@intel.com>
References: <20181204212600.28090-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At one point the vDSO image was manually stripped down by vdso2c in an
attempt to minimize the size of the image mapped into userspace.  Part
of that stripping process involved building a fake section table so as
not to break userspace processes that parse the section table.  Memory
for the fake section table was reserved in the .rodata section so that
vdso2c could simply copy the entire PT_LOAD segment into the userspace
image after building the fake table.

Eventually, the entire fake section table approach was dropped in favor
of stripping the vdso "the old fashioned way", i.e. via objdump -S.
But, the reservation in .rodata for the fake table was left behind.
Remove the reserveration along with a few other related defines and
section entries.

Removing the fake section table placeholder zaps a whopping 0x340 bytes
from the 64-bit vDSO image, which drops the current image's size to
under 4k, i.e. reduces the effective size of the userspace vDSO mapping
by a full page.

Fixes: da861e18eccc ("x86, vdso: Get rid of the fake section mechanism")
Cc: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 22 ----------------------
 arch/x86/entry/vdso/vdso2c.c          |  8 --------
 2 files changed, 30 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index acfd5ba7d943..0cedc905c8d6 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -7,16 +7,6 @@
  * This script controls its layout.
  */
 
-#if defined(BUILD_VDSO64)
-# define SHDR_SIZE 64
-#elif defined(BUILD_VDSO32) || defined(BUILD_VDSOX32)
-# define SHDR_SIZE 40
-#else
-# error unknown VDSO target
-#endif
-
-#define NUM_FAKE_SHDRS 13
-
 SECTIONS
 {
 	/*
@@ -60,20 +50,8 @@ SECTIONS
 		*(.bss*)
 		*(.dynbss*)
 		*(.gnu.linkonce.b.*)
-
-		/*
-		 * Ideally this would live in a C file, but that won't
-		 * work cleanly for x32 until we start building the x32
-		 * C code using an x32 toolchain.
-		 */
-		VDSO_FAKE_SECTION_TABLE_START = .;
-		. = . + NUM_FAKE_SHDRS * SHDR_SIZE;
-		VDSO_FAKE_SECTION_TABLE_END = .;
 	}						:text
 
-	.fake_shstrtab	: { *(.fake_shstrtab) }		:text
-
-
 	.note		: { *(.note.*) }		:text	:note
 
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 4674f58581a1..8e470b018512 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -76,8 +76,6 @@ enum {
 	sym_hpet_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
-	sym_VDSO_FAKE_SECTION_TABLE_START,
-	sym_VDSO_FAKE_SECTION_TABLE_END,
 };
 
 const int special_pages[] = {
@@ -98,12 +96,6 @@ struct vdso_sym required_syms[] = {
 	[sym_hpet_page] = {"hpet_page", true},
 	[sym_pvclock_page] = {"pvclock_page", true},
 	[sym_hvclock_page] = {"hvclock_page", true},
-	[sym_VDSO_FAKE_SECTION_TABLE_START] = {
-		"VDSO_FAKE_SECTION_TABLE_START", false
-	},
-	[sym_VDSO_FAKE_SECTION_TABLE_END] = {
-		"VDSO_FAKE_SECTION_TABLE_END", false
-	},
 	{"VDSO32_NOTE_MASK", true},
 	{"__kernel_vsyscall", true},
 	{"__kernel_sigreturn", true},
-- 
2.19.2

