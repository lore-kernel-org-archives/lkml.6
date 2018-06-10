Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id x/shBw2ZHVvmCgAAmS7hNA
	; Sun, 10 Jun 2018 21:34:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 230DB60792; Sun, 10 Jun 2018 21:34:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=2.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	MAILING_LIST_MULTI autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4285A604D4;
	Sun, 10 Jun 2018 21:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4285A604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeFJVeK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 17:34:10 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:52609 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752170AbeFJVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 17:34:06 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 10 Jun 2018 14:34:05 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id DB362406D6;
        Sun, 10 Jun 2018 14:34:05 -0700 (PDT)
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Nadav Amit <namit@vmware.com>, Alok Kataria <akataria@vmware.com>,
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
Subject: [PATCH v3 0/9] x86: macrofying inline asm for better compilation
Date: Sun, 10 Jun 2018 07:19:02 -0700
Message-ID: <20180610141911.52948-1-namit@vmware.com>
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
with the the C files. This also enables to avoid duplicate
implementation that was set before for the asm and C code. This can be
seen in the exception table changes.

Overall this patch-set slightly increases the kernel size (my build was
done using my Ubuntu 18.04 config + localyesconfig for the record):

   text	   data	    bss	    dec	    hex	filename
18140829 10224724 2957312 31322865 1ddf2f1 ./vmlinux before
18163608 10227348 2957312 31348268 1de562c ./vmlinux after (+0.1%)

The number of static functions in the image is reduced by 379, but
actually inlining is even better, which does not always shows in these
numbers: a function may be inlined causing the calling function not to
be inlined.

The Makefile stuff may not be too clean. Ideas for improvements are
welcome.

v2->v3: * Several build issues resolved (0-day)
	* Wrong comments fix (Josh)
	* Change asm vs C order in refcount (Kees)

v1->v2:	* Compiling the macros into a separate .s file, improving
	  readability (Linus)
	* Improving assembly formatting, applying most of the comments
	  according to my judgment (Jan)
	* Adding exception-table, cpufeature and jump-labels
	* Removing new-line cleanup; to be submitted separately

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
 arch/x86/include/asm/paravirt_types.h  | 54 +++++++-------
 arch/x86/include/asm/refcount.h        | 74 +++++++++++--------
 arch/x86/kernel/Makefile               |  6 ++
 arch/x86/kernel/macros.S               | 16 +++++
 include/asm-generic/bug.h              |  8 +--
 include/linux/compiler.h               | 56 +++++++++++----
 scripts/Kbuild.include                 |  4 +-
 15 files changed, 347 insertions(+), 228 deletions(-)
 create mode 100644 arch/x86/kernel/macros.S

-- 
2.17.0
