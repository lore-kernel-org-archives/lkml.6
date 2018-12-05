Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B167FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A65920892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A65920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeLESFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:05:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42835 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLESFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:05:41 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB5I3tf41373727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Dec 2018 10:03:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB5I3sNF1373724;
        Wed, 5 Dec 2018 10:03:54 -0800
Date:   Wed, 5 Dec 2018 10:03:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sean Christopherson <tipbot@zytor.com>
Message-ID: <tip-24b7c77bbb24f129beead93574ff248c3db1288e@git.kernel.org>
Cc:     bp@alien8.de, hpa@zytor.com, riel@surriel.com, dvlasenk@redhat.com,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        torvalds@linux-foundation.org, brgerst@gmail.com,
        dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: dvlasenk@redhat.com, hpa@zytor.com, riel@surriel.com,
          bp@alien8.de, sean.j.christopherson@intel.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          brgerst@gmail.com, dave.hansen@linux.intel.com, luto@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <20181204212600.28090-2-sean.j.christopherson@intel.com>
References: <20181204212600.28090-2-sean.j.christopherson@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/vdso: Remove obsolete "fake section table"
 reservation
Git-Commit-ID: 24b7c77bbb24f129beead93574ff248c3db1288e
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

Commit-ID:  24b7c77bbb24f129beead93574ff248c3db1288e
Gitweb:     https://git.kernel.org/tip/24b7c77bbb24f129beead93574ff248c3db1288e
Author:     Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate: Tue, 4 Dec 2018 13:25:57 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 5 Dec 2018 08:58:11 +0100

x86/vdso: Remove obsolete "fake section table" reservation

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

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: da861e18eccc ("x86, vdso: Get rid of the fake section mechanism")
Link: http://lkml.kernel.org/r/20181204212600.28090-2-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
