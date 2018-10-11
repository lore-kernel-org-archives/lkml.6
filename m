Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99C3C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788922075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788922075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeJKWu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:50:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:21581 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbeJKWto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:49:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 08:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="77271639"
Received: from 2b52.sc.intel.com ([143.183.136.147])
  by fmsmga007.fm.intel.com with ESMTP; 11 Oct 2018 08:21:45 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: [PATCH v5 08/11] x86: Insert endbr32/endbr64 to vDSO
Date:   Thu, 11 Oct 2018 08:16:51 -0700
Message-Id: <20181011151654.27221-9-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011151654.27221-1-yu-cheng.yu@intel.com>
References: <20181011151654.27221-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

When Intel indirect branch tracking is enabled, functions in vDSO which
may be called indirectly must have endbr32 or endbr64 as the first
instruction.  Compiler must support -fcf-protection=branch so that it
can be used to compile vDSO.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 arch/x86/entry/vdso/.gitignore        |  4 ++++
 arch/x86/entry/vdso/Makefile          | 12 +++++++++++-
 arch/x86/entry/vdso/vdso-layout.lds.S |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/.gitignore b/arch/x86/entry/vdso/.gitignore
index aae8ffdd5880..552941fdfae0 100644
--- a/arch/x86/entry/vdso/.gitignore
+++ b/arch/x86/entry/vdso/.gitignore
@@ -5,3 +5,7 @@ vdso32-sysenter-syms.lds
 vdso32-int80-syms.lds
 vdso-image-*.c
 vdso2c
+vclock_gettime.S
+vgetcpu.S
+vclock_gettime.asm
+vgetcpu.asm
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 141d415a8c80..0b1b464e7ae7 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -108,13 +108,17 @@ vobjx32s := $(foreach F,$(vobjx32s-y),$(obj)/$F)
 
 # Convert 64bit object file to x32 for x32 vDSO.
 quiet_cmd_x32 = X32     $@
-      cmd_x32 = $(OBJCOPY) -O elf32-x86-64 $< $@
+      cmd_x32 = $(OBJCOPY) -R .note.gnu.property -O elf32-x86-64 $< $@
 
 $(obj)/%-x32.o: $(obj)/%.o FORCE
 	$(call if_changed,x32)
 
 targets += vdsox32.lds $(vobjx32s-y)
 
+ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+    $(obj)/vclock_gettime.o $(obj)/vgetcpu.o $(obj)/vdso32/vclock_gettime.o: KBUILD_CFLAGS += -fcf-protection=branch
+endif
+
 $(obj)/%.so: OBJCOPYFLAGS := -S
 $(obj)/%.so: $(obj)/%.so.dbg
 	$(call if_changed,objcopy)
@@ -172,6 +176,12 @@ quiet_cmd_vdso = VDSO    $@
 
 VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
 	$(call ld-option, --build-id) -Bsymbolic
+ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+  VDSO_LDFLAGS += $(call ldoption, -z$(comma)ibt)
+endif
+ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+  VDSO_LDFLAGS += $(call ldoption, -z$(comma)shstk)
+endif
 GCOV_PROFILE := n
 
 #
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index acfd5ba7d943..cabaeedfed78 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -74,6 +74,7 @@ SECTIONS
 	.fake_shstrtab	: { *(.fake_shstrtab) }		:text
 
 
+	.note.gnu.property : { *(.note.gnu.property) }	:text	:note
 	.note		: { *(.note.*) }		:text	:note
 
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
-- 
2.17.1

