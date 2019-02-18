Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B13C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92AD2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AFCsdZMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbfBRObv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:31:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50614 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387691AbfBRObt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:31:49 -0500
Received: from zn.tnic (p200300EC2BC7C700F85306BC490356B0.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:c700:f853:6bc:4903:56b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BCF511EC027A;
        Mon, 18 Feb 2019 15:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550500307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iwxWUcVc3+LMqyiIRuj5IVr8lZvXUUHP3fCa/dq3B8Y=;
        b=AFCsdZMgzKDtB0UuTZZ8PWy/CsSOfgC3bY/twKguHMz6hPBQP/ziY1KLia8MpzsFJno1ES
        XXAMZSSOErhZpGACFEvdFQN/p+JFeZSHvorxHDz966+4omfWr7FL7x3Vr/vymrd/MnrMqn
        ChTwJc2rAaKTMUBqQpijfNba2GaEC6M=
Date:   Mon, 18 Feb 2019 15:31:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild: Disable extra debugging info in .s output
Message-ID: <20190218143145.GF4265@zn.tnic>
References: <20190201103648.GF31854@zn.tnic>
 <CAK7LNAQ4juLxrdMoPumQQ-96fMorf+wfAqkNxq1X1k=0i_R4vQ@mail.gmail.com>
 <20190201151139.GK31854@zn.tnic>
 <CAK7LNATVeX=6Mmn6A4+EGmZ9OSf=ePwbQWV1m1c=e=_LiebdNQ@mail.gmail.com>
 <20190202144227.GC27822@zn.tnic>
 <20190206104729.GC7314@zn.tnic>
 <CAK7LNAT+GhbEwP7v7NWd2kqW76qbXM1mtKhc21YXkp7BUJjzKQ@mail.gmail.com>
 <20190210123923.GA14948@zn.tnic>
 <20190218083008.GB4265@zn.tnic>
 <CAK7LNAQ_UfHcin1G_fqEX0qZ-AFe7=GHfnHZ2QZu1oe=dZW-aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ_UfHcin1G_fqEX0qZ-AFe7=GHfnHZ2QZu1oe=dZW-aA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 06:10:57PM +0900, Masahiro Yamada wrote:
> Could you send v2 as I suggested?
> Your commit log describes your motivation perfectly.
> 
> (I lost the applicable patch because
> I just modified the code locally and pasted it
> into the previous email.)

Sure, here it is.

Thx.

---
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 25 Nov 2018 23:58:00 +0100
Subject: [PATCH] kbuild: Disable extra debugging info in .s output

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
  # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
          movq    this_cpu(%rip), %rax    # this_cpu, this_cpu
          movq    64(%rax), %rax  # this_cpu.94_1->c_bsp_resume, _2
  # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
          testq   %rax, %rax      # _2
          je      .L8     #,
  # arch/x86/kernel/cpu/common.c:1870:            this_cpu->c_bsp_resume(&boot_cpu_data);
          movq    $boot_cpu_data, %rdi    #,
          jmp     __x86_indirect_thunk_rax
  .L8:
  # arch/x86/kernel/cpu/common.c:1871: }
          rep ret
          .size   bsp_resume, .-bsp_resume

  [ bp: write commit message. ]

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
---
 Makefile               | 13 ++++++++-----
 scripts/Makefile.build |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 96c5335e7ee4..c5e7d3ac8bd2 100644
--- a/Makefile
+++ b/Makefile
@@ -729,25 +729,28 @@ KBUILD_CFLAGS	+= -fomit-frame-pointer
 endif
 endif
 
-KBUILD_CFLAGS   += $(call cc-option, -fno-var-tracking-assignments)
+DEBUG_CFLAGS	:= $(call cc-option, -fno-var-tracking-assignments)
 
 ifdef CONFIG_DEBUG_INFO
 ifdef CONFIG_DEBUG_INFO_SPLIT
-KBUILD_CFLAGS   += $(call cc-option, -gsplit-dwarf, -g)
+DEBUG_CFLAGS	+= $(call cc-option, -gsplit-dwarf, -g)
 else
-KBUILD_CFLAGS	+= -g
+DEBUG_CFLAGS	+= -g
 endif
 KBUILD_AFLAGS	+= -Wa,-gdwarf-2
 endif
 ifdef CONFIG_DEBUG_INFO_DWARF4
-KBUILD_CFLAGS	+= $(call cc-option, -gdwarf-4,)
+DEBUG_CFLAGS	+= $(call cc-option, -gdwarf-4,)
 endif
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
-KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
+DEBUG_CFLAGS	+= $(call cc-option, -femit-struct-debug-baseonly) \
 		   $(call cc-option,-fno-var-tracking)
 endif
 
+KBUILD_CFLAGS += $(DEBUG_CFLAGS)
+export DEBUG_CFLAGS
+
 ifdef CONFIG_FUNCTION_TRACER
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
   # gcc 5 supports generating the mcount tables directly
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fd03d60f6c5a..8f5c86da77b1 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -104,7 +104,7 @@ modkern_cflags =                                          \
 quiet_modtag = $(if $(part-of-module),[M],   )
 
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
+cmd_cc_s_c       = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
 
 $(obj)/%.s: $(src)/%.c FORCE
 	$(call if_changed_dep,cc_s_c)
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
