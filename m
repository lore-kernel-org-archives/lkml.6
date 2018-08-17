Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839E7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456182191C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456182191C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeHQN1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:27:35 -0400
Received: from verein.lst.de ([213.95.11.211]:36049 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbeHQN1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:27:35 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id C628D68EF4; Fri, 17 Aug 2018 12:25:44 +0200 (CEST)
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
Subject: [PATCH v2 0/3] arm64 live patching
Message-Id: <20180817102544.C628D68EF4@newverein.lst.de>
Date:   Fri, 17 Aug 2018 12:25:44 +0200 (CEST)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Here's v2; I hope I have incorporated all feedback properly.
Julien: #S_X28 + 8 is in, but ftrace_modify_call() is referenced
from generic code: kernel/trace/ftrace.c __ftrace_replace_code()

And I'd *really* like some feedback from ARM/Linaro/... on the stack
unwinder!

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
