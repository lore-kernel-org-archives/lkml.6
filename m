Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A710DC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D4820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D4820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbeGYPtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:49:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeGYPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:49:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEagO8403730
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:36:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEaer7403727;
        Wed, 25 Jul 2018 07:36:40 -0700
Date:   Wed, 25 Jul 2018 07:36:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kees Cook <tipbot@zytor.com>
Message-ID: <tip-92a4728608a8fd228c572bc8ff50dd98aa0ddf2a@git.kernel.org>
Cc:     yamada.masahiro@socionext.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, keescook@chromium.org,
        linux-kernel@vger.kernel.org, dirk@gouders.net,
        peterz@infradead.org, torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          keescook@chromium.org, peterz@infradead.org,
          torvalds@linux-foundation.org, dirk@gouders.net,
          yamada.masahiro@socionext.com, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20180724230827.GA37823@beast>
References: <20180724230827.GA37823@beast>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot: Fix if_changed build flip/flop bug
Git-Commit-ID: 92a4728608a8fd228c572bc8ff50dd98aa0ddf2a
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

Commit-ID:  92a4728608a8fd228c572bc8ff50dd98aa0ddf2a
Gitweb:     https://git.kernel.org/tip/92a4728608a8fd228c572bc8ff50dd98aa0ddf2a
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Tue, 24 Jul 2018 16:08:27 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 12:00:08 +0200

x86/boot: Fix if_changed build flip/flop bug

Dirk Gouders reported that two consecutive "make" invocations on an
already compiled tree will show alternating behaviors:

$ make
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  DATAREL arch/x86/boot/compressed/vmlinux
Kernel: arch/x86/boot/bzImage is ready  (#48)
  Building modules, stage 2.
  MODPOST 165 modules

$ make
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  LD      arch/x86/boot/compressed/vmlinux
  ZOFFSET arch/x86/boot/zoffset.h
  AS      arch/x86/boot/header.o
  LD      arch/x86/boot/setup.elf
  OBJCOPY arch/x86/boot/setup.bin
  OBJCOPY arch/x86/boot/vmlinux.bin
  BUILD   arch/x86/boot/bzImage
Setup is 15644 bytes (padded to 15872 bytes).
System is 6663 kB
CRC 3eb90f40
Kernel: arch/x86/boot/bzImage is ready  (#48)
  Building modules, stage 2.
  MODPOST 165 modules

He bisected it back to:

    commit 98f78525371b ("x86/boot: Refuse to build with data relocations")

The root cause was the use of the "if_changed" kbuild function multiple
times for the same target. It was designed to only be used once per
target, otherwise it will effectively always trigger, flipping back and
forth between the two commands getting recorded by "if_changed". Instead,
this patch merges the two commands into a single function to get stable
build artifacts (i.e. .vmlinux.cmd), and a single build behavior.

Bisected-and-Reported-by: Dirk Gouders <dirk@gouders.net>
Fix-Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180724230827.GA37823@beast
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index fa42f895fdde..169c2feda14a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -106,9 +106,13 @@ define cmd_check_data_rel
 	done
 endef
 
+# We need to run two commands under "if_changed", so merge them into a
+# single invocation.
+quiet_cmd_check-and-link-vmlinux = LD      $@
+      cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
+
 $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
-	$(call if_changed,check_data_rel)
-	$(call if_changed,ld)
+	$(call if_changed,check-and-link-vmlinux)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 $(obj)/vmlinux.bin: vmlinux FORCE
