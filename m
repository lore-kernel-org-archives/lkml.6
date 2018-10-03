Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498F1C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA51213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA51213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJDEWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:22:44 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:14656 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbeJDEWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:22:42 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 3 Oct 2018 14:32:27 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 5A1B3407C9;
        Wed,  3 Oct 2018 14:32:32 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        <linux-xtensa@linux-xtensa.org>
Subject: [PATCH v9 00/10] x86: macrofying inline asm
Date:   Wed, 3 Oct 2018 14:30:50 -0700
Message-ID: <20181003213100.189959-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set deals with an interesting yet stupid problem: kernel code
that does not get inlined despite its simplicity. There are several
causes for this behavior: "cold" attribute on __init, different function
optimization levels; conditional constant computations based on
__builtin_constant_p(); and finally large inline assembly blocks.

This patch-set deals with the inline assembly problem. I separated these
patches from the others (that were sent in the RFC) for easier
inclusion. I also separated the removal of unnecessary new-lines which
would be sent separately.

The problem with inline assembly is that inline assembly is often used
by the kernel for things that are other than code - for example,
assembly directives and data. GCC however is oblivious to the content of
the blocks and assumes their cost in space and time is proportional to
the number of the perceived assembly "instruction", according to the
number of newlines and semicolons. Alternatives, paravirt and other
mechanisms are affected, causing code not to be inlined, and degrading
compilation quality in general.

The solution that this patch-set carries for this problem is to create
an assembly macro, and then call it from the inline assembly block.  As
a result, the compiler sees a single "instruction" and assigns the more
appropriate cost to the code.

To avoid uglification of the code, as many noted, the macros are first
precompiled into an assembly file, which is later assembled together
with the C files. This also enables to avoid duplicate implementation
that was set before for the asm and C code. This can be seen in the
exception table changes.

Overall this patch-set slightly increases the kernel size (my build was
done using my Ubuntu 18.04 config + localyesconfig for the record):

   text	   data	    bss	    dec	    hex	filename
18140829 10224724 2957312 31322865 1ddf2f1 ./vmlinux before
18163608 10227348 2957312 31348268 1de562c ./vmlinux after (+0.1%)

The number of static functions in the image is reduced by 379, but
actually inlining is even better, which does not always shows in these
numbers: a function may be inlined causing the calling function not to
be inlined.

I ran some limited number of benchmarks, and in general the performance
impact is not very notable. You can still see >10 cycles shaved off some
syscalls that manipulate page-tables (e.g., mprotect()), in which
paravirt caused many functions not to be inlined. In addition this
patch-set can prevent issues such as [1], and improves code readability
and maintainability.

Update: Rasmus recently caused me (inadvertently) to become paranoid
about the dependencies. To clarify: if any of the headers changes, any c
file which uses macros that are included in macros.S would be fine as
long as it includes the header as well (as it should). Adding an
assertion to check this is done might become slightly ugly, and nobody
else is concerned about it. Another minor issue is that changes of
macros.S would not trigger a global rebuild, but that is pretty similar
to changes of the Makefile that do not trigger a rebuild.

[1] https://patchwork.kernel.org/patch/10450037/

v8->v9: * Restoring the '-pipe' parameter (Rasmus)
	* Adding Kees's tested-by tag (Kees)

v7->v8:	* Add acks (Masahiro, Max)
	* Rebase on 4.19 (Ingo)

v6->v7: * Fix context switch tracking (Ingo)
	* Fix xtensa build error (Ingo)
	* Rebase on 4.18-rc8

v5->v6:	* Removing more code from jump-labels (PeterZ)
	* Fix build issue on i386 (0-day, PeterZ)

v4->v5:	* Makefile fixes (Masahiro, Sam)

v3->v4: * Changed naming of macros in 2 patches (PeterZ)
	* Minor cleanup of the paravirt patch

v2->v3: * Several build issues resolved (0-day)
	* Wrong comments fix (Josh)
	* Change asm vs C order in refcount (Kees)

v1->v2:	* Compiling the macros into a separate .s file, improving
	  readability (Linus)
	* Improving assembly formatting, applying most of the comments
	  according to my judgment (Jan)
	* Adding exception-table, cpufeature and jump-labels
	* Removing new-line cleanup; to be submitted separately

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-sparse@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: virtualization@lists.linux-foundation.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86@kernel.org
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org

Nadav Amit (10):
  xtensa: defining LINKER_SCRIPT for the linker script
  Makefile: Prepare for using macros for inline asm
  x86: objtool: use asm macro for better compiler decisions
  x86: refcount: prevent gcc distortions
  x86: alternatives: macrofy locks for better inlining
  x86: bug: prevent gcc distortions
  x86: prevent inline distortion by paravirt ops
  x86: extable: use macros instead of inline assembly
  x86: cpufeature: use macros instead of inline assembly
  x86: jump-labels: use macros instead of inline assembly

 Makefile                               |  9 ++-
 arch/x86/Makefile                      |  7 ++
 arch/x86/entry/calling.h               |  2 +-
 arch/x86/include/asm/alternative-asm.h | 20 ++++--
 arch/x86/include/asm/alternative.h     | 11 +--
 arch/x86/include/asm/asm.h             | 61 +++++++---------
 arch/x86/include/asm/bug.h             | 98 +++++++++++++++-----------
 arch/x86/include/asm/cpufeature.h      | 82 ++++++++++++---------
 arch/x86/include/asm/jump_label.h      | 77 ++++++++------------
 arch/x86/include/asm/paravirt_types.h  | 56 +++++++--------
 arch/x86/include/asm/refcount.h        | 74 +++++++++++--------
 arch/x86/kernel/macros.S               | 16 +++++
 arch/xtensa/kernel/Makefile            |  4 +-
 include/asm-generic/bug.h              |  8 +--
 include/linux/compiler.h               | 56 +++++++++++----
 scripts/Kbuild.include                 |  4 +-
 scripts/mod/Makefile                   |  2 +
 17 files changed, 331 insertions(+), 256 deletions(-)
 create mode 100644 arch/x86/kernel/macros.S

-- 
2.17.1

