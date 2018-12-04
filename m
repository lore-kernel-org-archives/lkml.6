Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F42C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B213320834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B213320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeLDXIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbeLDXIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:08:40 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CFA92081C;
        Tue,  4 Dec 2018 23:08:38 +0000 (UTC)
Date:   Tue, 4 Dec 2018 18:08:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [PATCH v2 0/4] Static calls
Message-ID: <20181204180835.29f9aa03@vmware.local.home>
In-Reply-To: <cover.1543200841.git.jpoimboe@redhat.com>
References: <cover.1543200841.git.jpoimboe@redhat.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Where did this end up BTW?

I know that there's controversy about the
CONFIG_HAVE_STATIC_CALL_OPTIMIZED option, but I don't think the 
CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED version was controversial. From the
v1 patch 0 description:

There are three separate implementations, depending on what the arch
supports:

  1) CONFIG_HAVE_STATIC_CALL_OPTIMIZED: patched call sites - requires
     objtool and a small amount of arch code
  
  2) CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED: patched trampolines - requires
     a small amount of arch code
  
  3) If no arch support, fall back to regular function pointers

My benchmarks showed the best improvements with the
STATIC_CALL_OPTIMIZED, but it still showed improvement with the
UNOPTIMIZED version as well. Can we at least apply 2 and 3 from the
above (which happen to be the first part of the patch set. 1 comes in
at the end).

I would also just call it CONFIG_STATIC_CALL. If we every agree on the
optimized version, then we can call it CONFIG_STATIC_CALL_OPTIMIZED.
Have an option called UNOPTIMIZED just seems wrong.

-- Steve



On Mon, 26 Nov 2018 07:54:56 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> v2:
> - fix STATIC_CALL_TRAMP() macro by using __PASTE() [Ard]
> - rename optimized/unoptimized -> inline/out-of-line [Ard]
> - tweak arch interfaces for PLT and add key->tramp field [Ard]
> - rename 'poison' to 'defuse' and do it after all sites have been patched [Ard]
> - fix .init handling [Ard, Steven]
> - add CONFIG_HAVE_STATIC_CALL [Steven]
> - make interfaces more consistent across configs to allow tracepoints to
>   use them [Steven]
> - move __ADDRESSABLE() to static_call() macro [Steven]
> - prevent 2-byte jumps [Steven]
> - add offset to asm-offsets.c instead of hard coding key->func offset
> - add kernel_text_address() sanity check
> - make __ADDRESSABLE() symbols truly unique
> 
> TODO:
> - port Ard's arm64 patches to the new arch interfaces
> - tracepoint performance testing
> 
> --------------------
> 
> These patches are related to two similar patch sets from Ard and Steve:
> 
> - https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
> - https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org
> 
> The code is also heavily inspired by the jump label code, as some of the
> concepts are very similar.
> 
> There are three separate implementations, depending on what the arch
> supports:
> 
>   1) CONFIG_HAVE_STATIC_CALL_INLINE: patched call sites - requires
>      objtool and a small amount of arch code
>   
>   2) CONFIG_HAVE_STATIC_CALL_OUTLINE: patched trampolines - requires
>      a small amount of arch code
>   
>   3) If no arch support, fall back to regular function pointers
> 
> 
> Josh Poimboeuf (4):
>   compiler.h: Make __ADDRESSABLE() symbol truly unique
>   static_call: Add static call infrastructure
>   x86/static_call: Add out-of-line static call implementation
>   x86/static_call: Add inline static call implementation for x86-64
> 
>  arch/Kconfig                                  |  10 +
>  arch/x86/Kconfig                              |   4 +-
>  arch/x86/include/asm/static_call.h            |  52 +++
>  arch/x86/kernel/Makefile                      |   1 +
>  arch/x86/kernel/asm-offsets.c                 |   6 +
>  arch/x86/kernel/static_call.c                 |  78 ++++
>  include/asm-generic/vmlinux.lds.h             |  11 +
>  include/linux/compiler.h                      |   2 +-
>  include/linux/module.h                        |  10 +
>  include/linux/static_call.h                   | 202 ++++++++++
>  include/linux/static_call_types.h             |  19 +
>  kernel/Makefile                               |   1 +
>  kernel/module.c                               |   5 +
>  kernel/static_call.c                          | 350 ++++++++++++++++++
>  tools/objtool/Makefile                        |   3 +-
>  tools/objtool/check.c                         | 126 ++++++-
>  tools/objtool/check.h                         |   2 +
>  tools/objtool/elf.h                           |   1 +
>  .../objtool/include/linux/static_call_types.h |  19 +
>  tools/objtool/sync-check.sh                   |   1 +
>  20 files changed, 899 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/include/asm/static_call.h
>  create mode 100644 arch/x86/kernel/static_call.c
>  create mode 100644 include/linux/static_call.h
>  create mode 100644 include/linux/static_call_types.h
>  create mode 100644 kernel/static_call.c
>  create mode 100644 tools/objtool/include/linux/static_call_types.h
> 

