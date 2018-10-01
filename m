Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309AE21470
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309AE21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbeJAUrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:47:10 -0400
Received: from verein.lst.de ([213.95.11.211]:37859 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbeJAUrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:47:10 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 086E768BC7; Mon,  1 Oct 2018 16:09:10 +0200 (CEST)
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
Subject: [PATCH v3 0/4] arm64 live patching
Message-Id: <20181001140910.086E768BC7@newverein.lst.de>
Date:   Mon,  1 Oct 2018 16:09:10 +0200 (CEST)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Some substantial changes were requested, so I had to shuffle a few
things around. All the bigger changes are in now.

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

[TODO]

* use more S_X* constants

* run the full livepatch test suite, especially test apply_relocate_add()
  functionality late after module load.

[Changes from v1]:

* Missing compiler support is now a Makefile error, instead
  of a warning. This will keep the compile log shorter and
  it will thus be easier to spot the problem.

* A separate ftrace_regs_caller. Only that one will write out
  a complete pt_regs, for efficiency.

* Replace the use of X19 with X28 to remember the old PC during
  live patch detection, as only that is saved&restored now for
  non-regs ftrace.

* CONFIG_DYNAMIC_FTRACE_WITH_REGS and CC_USING_PATCHABLE_FUNCTION_ENTRY
  are currently synonymous on arm64, but differentiate better for
  the future when this is no longer the case.

* Clean up "old"/"new" insn value setting vs. #ifdefs.

* #define a INSN_MOV_X9_X30 with suggested aarch64_insn_gen call
  and use that instead of an immediate hex value.

	Torsten
