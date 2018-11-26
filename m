Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B898DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADF020855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADF020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeK0AtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:49:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeK0AtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:49:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1CDFC04959D;
        Mon, 26 Nov 2018 13:55:07 +0000 (UTC)
Received: from treble.redhat.com (ovpn-121-105.rdu2.redhat.com [10.10.121.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16F6A194AE;
        Mon, 26 Nov 2018 13:55:04 +0000 (UTC)
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
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 0/4] Static calls
Date:   Mon, 26 Nov 2018 07:54:56 -0600
Message-Id: <cover.1543200841.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 26 Nov 2018 13:55:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

TODO:
- port Ard's arm64 patches to the new arch interfaces
- tracepoint performance testing

--------------------

These patches are related to two similar patch sets from Ard and Steve:

- https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
- https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org

The code is also heavily inspired by the jump label code, as some of the
concepts are very similar.

There are three separate implementations, depending on what the arch
supports:

  1) CONFIG_HAVE_STATIC_CALL_INLINE: patched call sites - requires
     objtool and a small amount of arch code
  
  2) CONFIG_HAVE_STATIC_CALL_OUTLINE: patched trampolines - requires
     a small amount of arch code
  
  3) If no arch support, fall back to regular function pointers


Josh Poimboeuf (4):
  compiler.h: Make __ADDRESSABLE() symbol truly unique
  static_call: Add static call infrastructure
  x86/static_call: Add out-of-line static call implementation
  x86/static_call: Add inline static call implementation for x86-64

 arch/Kconfig                                  |  10 +
 arch/x86/Kconfig                              |   4 +-
 arch/x86/include/asm/static_call.h            |  52 +++
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/asm-offsets.c                 |   6 +
 arch/x86/kernel/static_call.c                 |  78 ++++
 include/asm-generic/vmlinux.lds.h             |  11 +
 include/linux/compiler.h                      |   2 +-
 include/linux/module.h                        |  10 +
 include/linux/static_call.h                   | 202 ++++++++++
 include/linux/static_call_types.h             |  19 +
 kernel/Makefile                               |   1 +
 kernel/module.c                               |   5 +
 kernel/static_call.c                          | 350 ++++++++++++++++++
 tools/objtool/Makefile                        |   3 +-
 tools/objtool/check.c                         | 126 ++++++-
 tools/objtool/check.h                         |   2 +
 tools/objtool/elf.h                           |   1 +
 .../objtool/include/linux/static_call_types.h |  19 +
 tools/objtool/sync-check.sh                   |   1 +
 20 files changed, 899 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/include/asm/static_call.h
 create mode 100644 arch/x86/kernel/static_call.c
 create mode 100644 include/linux/static_call.h
 create mode 100644 include/linux/static_call_types.h
 create mode 100644 kernel/static_call.c
 create mode 100644 tools/objtool/include/linux/static_call_types.h

-- 
2.17.2

