Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D58C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2CC2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fzX8s4zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfAUJxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:53:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56608 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbfAUJxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:53:42 -0500
Received: from zn.tnic (p200300EC2BC625005DE3D5B66D6AB027.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:2500:5de3:d5b6:6d6a:b027])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF1411EC0242;
        Mon, 21 Jan 2019 10:53:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548064421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=fIiUPnVpcjvsiQknAVrfBBqh9W1zC6uC2DORF8yu5bk=;
        b=fzX8s4zptRoak0irnSIrIyA+sv4TuM81rAIhqJykRURov5aTvcgxk8EGVK08u2YImR79HO
        mXRcVkbwFXJssFT/nKJOOQ6FaHSOySkOP9qNSXgHjs0f2GuOyySFNwdWQPWloHH5p5/PpB
        uKJ9AKf+lYtajx5zfOWCQaFyoYavd1U=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kbuild@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] kbuild: Disable extra debugging info in .s output
Date:   Mon, 21 Jan 2019 10:53:38 +0100
Message-Id: <20190121095338.8565-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Modern gcc adds view assignments, reset assertion checking in .loc
directives and a couple more additional debug markers, which clutters
the asm output unnecessarily:

For example:

  bsp_resume:
  .LFB3466:
          .loc 1 1868 1 is_stmt 1 view -0
          .cfi_startproc
          .loc 1 1869 2 view .LVU73
  # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
          .loc 1 1869 14 is_stmt 0 view .LVU74
          movq    this_cpu(%rip), %rax    # this_cpu, this_cpu
          movq    64(%rax), %rax  # this_cpu.94_1->c_bsp_resume, _2
  # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
          .loc 1 1869 5 view .LVU75
          testq   %rax, %rax      # _2
          je      .L8     #,
          .loc 1 1870 3 is_stmt 1 view .LVU76
          movq    $boot_cpu_data, %rdi    #,
          jmp     __x86_indirect_thunk_rax

or
  	.loc 2 57 9 view .LVU478
  	.loc 2 57 9 view .LVU479
  	.loc 2 57 9 view .LVU480
  	.loc 2 57 9 view .LVU481
  .LBB1385:
  .LBB1383:
  .LBB1379:
  .LBB1377:
  .LBB1375:
  	.loc 2 57 9 view .LVU482
  	.loc 2 57 9 view .LVU483
  	movl	%edi, %edx	# cpu, cpu
  .LVL87:
  	.loc 2 57 9 is_stmt 0 view .LVU484

That MOV in there is drowned in debugging information and latter makes
it hard to follow the asm. And that DWARF info is not really needed for
asm output staring.

Disable the debug information generation which clutters the asm output
unnecessarily:

  bsp_resume:
  .LFB3466:
          .loc 1 1868 1
  # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
          .loc 1 1869 14
          movq    this_cpu(%rip), %rax    # this_cpu, this_cpu
          movq    64(%rax), %rax  # this_cpu.94_1->c_bsp_resume, _2
  # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
          .loc 1 1869 5
          testq   %rax, %rax      # _2
          je      .L8     #,
  # arch/x86/kernel/cpu/common.c:1870:            this_cpu->c_bsp_resume(&boot_cpu_data);
          .loc 1 1870 3
          movq    $boot_cpu_data, %rdi    #,
          jmp     __x86_indirect_thunk_rax

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
---
 scripts/Makefile.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fd03d60f6c5a..4f33fdab89d2 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -103,8 +103,12 @@ modkern_cflags =                                          \
 		$(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL))
 quiet_modtag = $(if $(part-of-module),[M],   )
 
+disable_extra_cc_dbg := $(call cc-option,-gno-as-locview-support)
+disable_extra_cc_dbg += $(call cc-option,-fno-dwarf2-cfi-asm)
+disable_extra_cc_dbg += $(call cc-option,-feliminate-unused-debug-symbols)
+disable_extra_cc_dbg += $(call cc-option,-gno-statement-frontiers)
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
+cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) $(disable_extra_cc_dbg) -fverbose-asm -S -o $@ $<
 
 $(obj)/%.s: $(src)/%.c FORCE
 	$(call if_changed_dep,cc_s_c)
-- 
2.19.1

