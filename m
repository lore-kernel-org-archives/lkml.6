Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11102C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C124820874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C124820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754277AbeFTDDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:03:44 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36637 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753862AbeFTDDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:03:40 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 19 Jun 2018 20:03:36 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id F09A240DE7;
        Tue, 19 Jun 2018 20:03:39 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Nadav Amit <namit@vmware.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v5 0/9] x86: macrofying inline asm for better compilation
Date:   Tue, 19 Jun 2018 12:48:45 -0700
Message-ID: <20180619194854.69486-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
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

I ran some benchmarks, and in general the performance impact is not very
notable. You can still see 10 cycles shaved off some syscalls that
manipulate page-tables (e.g., mprotect()), in which paravirt caused many
functions not to be inlined. In addition this patch-set can prevent
issues such as [1], and arguably improves code readability and
maintainability.

[1] https://patchwork.kernel.org/patch/10450037/

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


Nadav Amit (9):
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
 arch/x86/Makefile                      | 11 ++-
 arch/x86/include/asm/alternative-asm.h | 20 ++++--
 arch/x86/include/asm/alternative.h     | 11 +--
 arch/x86/include/asm/asm.h             | 61 +++++++---------
 arch/x86/include/asm/bug.h             | 98 +++++++++++++++-----------
 arch/x86/include/asm/cpufeature.h      | 82 ++++++++++++---------
 arch/x86/include/asm/jump_label.h      | 65 ++++++++++-------
 arch/x86/include/asm/paravirt_types.h  | 56 +++++++--------
 arch/x86/include/asm/refcount.h        | 74 +++++++++++--------
 arch/x86/kernel/macros.S               | 16 +++++
 include/asm-generic/bug.h              |  8 +--
 include/linux/compiler.h               | 56 +++++++++++----
 scripts/Kbuild.include                 |  4 +-
 scripts/mod/Makefile                   |  2 +
 15 files changed, 340 insertions(+), 233 deletions(-)
 create mode 100644 arch/x86/kernel/macros.S

-- 
2.17.0

