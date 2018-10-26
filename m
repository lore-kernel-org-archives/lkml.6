Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EED0C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0D02085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0D02085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeJZW5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:57:25 -0400
Received: from verein.lst.de ([213.95.11.211]:37724 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeJZW5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:57:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id D922868C94; Fri, 26 Oct 2018 16:20:08 +0200 (CEST)
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v4 0/3] arm64 live patching
Message-Id: <20181026142008.D922868C94@newverein.lst.de>
Date:   Fri, 26 Oct 2018 16:20:08 +0200 (CEST)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again!

V4 should include all your requested changes. Since only Julien
commented "OK" on the reliable stacktrace part, I finished it on my
own. This set now passes the relevant tests in Libor's test suite, so
livepatching the kernel proper does work.

Remember to apply Jessica's addendum in order to livepatch functions
that live in modules.

[Changes from v3]:

* Compiler support for -fpatchable-function-entry now automagically
  selects _WITH_REGS when DYNAMIC_FTRACE is switched on. Consequently,
  CONFIG_DYNAMIC_FTRACE_WITH_REGS is the only preprocessor symbol
  set by this feature (as asked for by Takahiro in v2)

* The dynamic ftrace caller creates 2 stack frames, as suggested by Ard:
  first a "preliminary" for the callee, and another for ftrace_caller
  itself. This gives the stack layout really a clean look.

* Because the ftrace-clobbered x9 is now saved immediately in the
  "callee" frame, it can be used to base pt_regs access. Much prettier now.

* Dynamic replacement insn "mov x9, lr" is generated using the common
  framework; a hopefully meaningful macro name is used for abbreviation.

* The use_ftrace_trampoline() helper introduced in v3 got renamed
  and streamlined with a reference variable, both as pointed out by Mark.

* Superflous barriers during trace application removed.

* #ifdef replaced by IS_ENABLED() where possible.

* Made stuff compile with gcc7 or older, too ;-)

* Fix my misguided .text.ftrace_regs_trampoline section assumption.
  the second trampoline goes into .text.ftrace_trampoline as well.

* Properly detect the bottom of kthread stacks, by setting a global
  symbol to the address where their LR points to and compare against it.

* Rewrote many comments to hopefully clear things up.

[Changes from v2]:

* ifeq($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y) instead of ifdef

* "fix" commit 06aeaaeabf69da4. (new patch 1)
  Made DYNAMIC_FTRACE_WITH_REGS a real choice. The current situation
  would be that a linux-4.20 kernel on arm64 should be built with
  gcc >= 8; as in this case, as well as all other archs, the "default y"
  works. Only kernels >= 4.20, arm64, gcc < 8, must change this to "n"
  in order to not be stopped by the Makefile $(error) from patch 2/4.
  You'll then fall back to the DYNAMIC_FTRACE, if selected, like before.

* use some S_X* constants to refer to offsets into pt_regs in assembly.

* have the compiler/assembler generate the mov x9,x30 instruction that
  saves LR at compile time, rather than generate it repeatedly at runtime.

* flip the ftrace_regs_caller stack frame so that it is no longer
  upside down, as Ard remarked. This change broke the graph caller somehow.

* extend handling of the module arch-dependent ftrace trampoline with
  a companion "regs" version.
  
* clear the _TIF_PATCH_PENDING on do_notify_resume()

* took care of arch/arm64/kernel/time.c when changing stack unwinder
  semantics

[Changes from v1]:

* Missing compiler support is now a Makefile error, instead
  of a warning. This will keep the compile log shorter and
  it will thus be easier to spot the problem.

* A separate ftrace_regs_caller. Only that one will write out
  a complete pt_regs, for efficiency.

* Replace the use of X19 with X28 to remember the old PC during
  live patch detection, as only that is saved&restored now for
  non-regs ftrace.

* CONFIG_DYNAMIC_FTRACE_WITH_REGS and CONFIG_DYNAMIC_FTRACE_WITH_REGS
  are currently synonymous on arm64, but differentiate better for
  the future when this is no longer the case.

* Clean up "old"/"new" insn value setting vs. #ifdefs.

* #define a INSN_MOV_X9_X30 with suggested aarch64_insn_gen call
  and use that instead of an immediate hex value.

	Torsten
