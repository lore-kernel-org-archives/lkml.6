Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A008EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B87520892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B87520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeKIGzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:55:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50963 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbeKIGzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:55:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90DFF3078A25;
        Thu,  8 Nov 2018 21:17:59 +0000 (UTC)
Received: from treble.redhat.com (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09EA15D979;
        Thu,  8 Nov 2018 21:17:57 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH RFC 0/3] Static calls
Date:   Thu,  8 Nov 2018 15:15:50 -0600
Message-Id: <cover.1541711457.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 08 Nov 2018 21:18:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are related to two similar patch sets from Ard and Steve:

- https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
- https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org

The code is also heavily inspired by the jump label code, as some of the
concepts are very similar.

There are three separate implementations, depending on what the arch
supports:

  1) CONFIG_HAVE_STATIC_CALL_OPTIMIZED: patched call sites - requires
     objtool and a small amount of arch code
  
  2) CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED: patched trampolines - requires
     a small amount of arch code
  
  3) If no arch support, fall back to regular function pointers


TODO:

- I'm not sure about the objtool approach.  Objtool is (currently)
  x86-64 only, which means we have to use the "unoptimized" version
  everywhere else.  I may experiment with a GCC plugin instead.

- Does this feature have much value without retpolines?  If not, should
  we make it depend on retpolines somehow?

- Find some actual users of the interfaces (tracepoints? crypto?)


Details (cribbed from comments in include/linux/static_call.h):
------------------------------------------------------------------------

Static calls use code patching to hard-code function pointers into
direct branch instructions.  They give the flexibility of function
pointers, but with improved performance.  This is especially important
for cases where retpolines would otherwise be used, as retpolines can
significantly impact performance.

API overview:

 DECLARE_STATIC_CALL(key, func);
 DEFINE_STATIC_CALL(key, func);
 static_call(key, args...);
 static_call_update(key, func);

Usage example:

  # Start with the following functions (with identical prototypes):
  int func_a(int arg1, int arg2);
  int func_b(int arg1, int arg2);

  # Define a 'my_key' reference, associated with func_a() by default
  DEFINE_STATIC_CALL(my_key, func_a);

  # Call func_a()
  static_call(my_key, arg1, arg2);

  # Update 'my_key' to point to func_b()
  static_call_update(my_key, func_b);

  # Call func_b()
  static_call(my_key, arg1, arg2);

Implementation details:

There are three different implementations:

1) Optimized static calls (patched call sites)

   This requires objtool, which detects all the static_call() sites and
   annotates them in the '.static_call_sites' section.  By default, the call
   sites will call into a temporary per-key trampoline which has an indirect
   branch to the current destination function associated with the key.
   During system boot (or module init), all call sites are patched to call
   their destination functions directly.  Updates to a key will patch all
   call sites associated with that key.

2) Unoptimized static calls (patched trampolines)

   Each static_call() site calls into a permanent trampoline associated with
   the key.  The trampoline has a direct branch to the default function.
   Updates to a key will modify the direct branch in the key's trampoline.

3) Generic implementation

   This is the default implementation if the architecture hasn't implemented
   CONFIG_HAVE_STATIC_CALL_[UN]OPTIMIZED.  In this case, a basic
   function pointer is used.


Josh Poimboeuf (3):
  static_call: Add static call infrastructure
  x86/static_call: Add x86 unoptimized static call implementation
  x86/static_call: Add optimized static call implementation for 64-bit

 arch/Kconfig                                  |   6 +
 arch/x86/Kconfig                              |   4 +-
 arch/x86/include/asm/static_call.h            |  42 +++
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/static_call.c                 |  84 +++++
 include/asm-generic/vmlinux.lds.h             |  11 +
 include/linux/module.h                        |  10 +
 include/linux/static_call.h                   | 186 +++++++++++
 include/linux/static_call_types.h             |  19 ++
 kernel/Makefile                               |   1 +
 kernel/module.c                               |   5 +
 kernel/static_call.c                          | 297 ++++++++++++++++++
 tools/objtool/Makefile                        |   3 +-
 tools/objtool/check.c                         | 126 +++++++-
 tools/objtool/check.h                         |   2 +
 tools/objtool/elf.h                           |   1 +
 .../objtool/include/linux/static_call_types.h |  19 ++
 tools/objtool/sync-check.sh                   |   1 +
 18 files changed, 815 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/static_call.h
 create mode 100644 arch/x86/kernel/static_call.c
 create mode 100644 include/linux/static_call.h
 create mode 100644 include/linux/static_call_types.h
 create mode 100644 kernel/static_call.c
 create mode 100644 tools/objtool/include/linux/static_call_types.h

-- 
2.17.2

