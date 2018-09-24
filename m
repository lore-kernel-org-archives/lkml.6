Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693F0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE262145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE262145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeIYCT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:19:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:26545 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbeIYCT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:19:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 13:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,299,1534834800"; 
   d="scan'208";a="265335190"
Received: from gnu-4.sc.intel.com ([172.25.70.231])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2018 13:14:59 -0700
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH] x86: Discard .note.gnu.property sections
Date:   Mon, 24 Sep 2018 13:14:59 -0700
Message-Id: <20180924201459.35923-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the command-line option, -mx86-used-note=yes, the x86 assembler
in binutils 2.32 and above generates a program property note in a note
section, .note.gnu.property, to encode used x86 ISAs and features.
To exclude .note.gnu.property sections from NOTE segment in x86 kernel
linker script:

PHDRS {
 text PT_LOAD FLAGS(5);
 data PT_LOAD FLAGS(6);
 percpu PT_LOAD FLAGS(6);
 init PT_LOAD FLAGS(7);
 note PT_NOTE FLAGS(0);
}
SECTIONS
{
...
 .notes : AT(ADDR(.notes) - 0xffffffff80000000) { __start_notes = .; KEEP(*(.not
e.*)) __stop_notes = .; } :text :note
...
}

this patch discards .note.gnu.property sections in kernel linker script
by adding

 /DISCARD/ : {
  *(.note.gnu.property)
 }

before .notes sections.  Since .exit.text and .exit.data sections are
discarded at runtime, it undefines EXIT_TEXT and EXIT_DATA to exclude
.exit.text and .exit.data sections from default discarded sections.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 arch/x86/kernel/vmlinux.lds.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8bde0a419f86..7e1e0ef1578a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -138,6 +138,10 @@ SECTIONS
 		_etext = .;
 	} :text = 0x9090
 
+	/* .note.gnu.property sections should be discarded */
+	/DISCARD/ : {
+		*(.note.gnu.property)
+	}
 	NOTES :text :note
 
 	EXCEPTION_TABLE(16) :text = 0x9090
@@ -373,7 +377,12 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 
-	/* Sections to be discarded */
+	/* Sections to be discarded.  EXIT_TEXT and EXIT_DATA discard at runtime.
+	 * not link time.  */
+#undef EXIT_TEXT
+#define EXIT_TEXT
+#undef EXIT_DATA
+#define EXIT_DATA
 	DISCARDS
 	/DISCARD/ : {
 		*(.eh_frame)
-- 
2.17.1

