Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9EE2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfAIW7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:59:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfAIW7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:59:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9240481104;
        Wed,  9 Jan 2019 22:59:51 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD4C810A1820;
        Wed,  9 Jan 2019 22:59:44 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 0/6] Static calls
Date:   Wed,  9 Jan 2019 16:59:35 -0600
Message-Id: <cover.1547073843.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 09 Jan 2019 22:59:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this version, I stopped trying to use text_poke_bp(), and instead
went with a different approach: if the call site destination doesn't
cross a cacheline boundary, just do an atomic write.  Otherwise, keep
using the trampoline indefinitely.

NOTE: At least experimentally, the call destination writes seem to be
atomic with respect to instruction fetching.  On Nehalem I can easily
trigger crashes when writing a call destination across cachelines while
reading the instruction on other CPU; but I get no such crashes when
respecting cacheline boundaries.

BUT, the SDM doesn't document this approach, so it would be great if any
CPU people can confirm that it's safe!


v3:
- Split up the patches a bit more so that out-of-line static calls can
  be separately mergeable.  Inline is more controversial, and other
  approaches or improvements might be considered.  For example, Nadav is
  looking at implementing it with the help of a GCC plugin to ensure the
  call sites don't cross cacheline boundaries.

- Get rid of the use of text_poke_bp(), in favor of atomic writes.
  Out-of-line calls will be promoted to inline only if the call sites
  don't cross cache line boundaries. [Linus/Andy]

- Converge the inline and out-of-line trampolines into a single
  implementation, which uses a direct jump.  This was made possible by
  making static_call_update() safe to be called during early boot.

- Remove trampoline poisoning for now, since trampolines may still be
  needed for call sites which cross cache line boundaries.

- Rename CONFIG_HAVE_STATIC_CALL_OUTLINE -> CONFIG_HAVE_STATIC_CALL [Steven]

- Add missing __static_call_update() call to static_call_update() [Edward]

- Add missing key->func update in __static_call_update() [Edward]

- Put trampoline in a separate section to prevent 2-byte tail calls [Linus]


v2:
- fix STATIC_CALL_TRAMP() macro by using __PASTE() [Ard]
- rename optimized/unoptimized -> inline/out-of-line [Ard]
- tweak arch interfaces for PLT and add key->tramp field [Ard]
- rename 'poison' to 'defuse' and do it after all sites have been patched [Ard]
- fix .init handling [Ard, Steven]
- add CONFIG_HAVE_STATIC_CALL [Steven]
- make interfaces more consistent across configs to allow tracepoints to
  use them [Steven]
- move __ADDRESSABLE() to static_call() macro [Steven]
- prevent 2-byte jumps [Steven]
- add offset to asm-offsets.c instead of hard coding key->func offset
- add kernel_text_address() sanity check
- make __ADDRESSABLE() symbols truly unique


Static calls are a replacement for global function pointers.  They use
code patching to allow direct calls to be used instead of indirect
calls.  They give the flexibility of function pointers, but with
improved performance.  This is especially important for cases where
retpolines would otherwise be used, as retpolines can significantly
impact performance.

The concept and code are an extension of previous work done by Ard
Biesheuvel and Steven Rostedt:

  https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
  https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org

There are three implementations, depending on arch support:

1) basic function pointers
2) out-of-line: patched trampolines (CONFIG_HAVE_STATIC_CALL)
3) inline: patched call sites (CONFIG_HAVE_STATIC_CALL_INLINE)



Josh Poimboeuf (6):
  compiler.h: Make __ADDRESSABLE() symbol truly unique
  static_call: Add basic static call infrastructure
  x86/static_call: Add out-of-line static call implementation
  static_call: Add inline static call infrastructure
  x86/alternative: Use a single access in text_poke() where possible
  x86/static_call: Add inline static call implementation for x86-64

 arch/Kconfig                                  |   7 +
 arch/x86/Kconfig                              |   4 +-
 arch/x86/include/asm/static_call.h            |  33 ++
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/alternative.c                 |  31 +-
 arch/x86/kernel/static_call.c                 |  57 ++++
 arch/x86/kernel/vmlinux.lds.S                 |   1 +
 include/asm-generic/vmlinux.lds.h             |  15 +
 include/linux/compiler.h                      |   2 +-
 include/linux/module.h                        |  10 +
 include/linux/static_call.h                   | 196 +++++++++++
 include/linux/static_call_types.h             |  22 ++
 kernel/Makefile                               |   1 +
 kernel/module.c                               |   5 +
 kernel/static_call.c                          | 316 ++++++++++++++++++
 scripts/Makefile.build                        |   3 +
 tools/objtool/Makefile                        |   3 +-
 tools/objtool/builtin-check.c                 |   3 +-
 tools/objtool/builtin.h                       |   2 +-
 tools/objtool/check.c                         | 131 +++++++-
 tools/objtool/check.h                         |   2 +
 tools/objtool/elf.h                           |   1 +
 .../objtool/include/linux/static_call_types.h |  22 ++
 tools/objtool/sync-check.sh                   |   1 +
 24 files changed, 860 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/include/asm/static_call.h
 create mode 100644 arch/x86/kernel/static_call.c
 create mode 100644 include/linux/static_call.h
 create mode 100644 include/linux/static_call_types.h
 create mode 100644 kernel/static_call.c
 create mode 100644 tools/objtool/include/linux/static_call_types.h

-- 
2.17.2

