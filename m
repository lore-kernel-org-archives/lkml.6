Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbeBDRxG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 12:53:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:17281 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbeBDRxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 12:53:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,460,1511856000";
   d="scan'208";a="14931752"
Subject: [PATCH v2 0/3] x86/entry: Clear registers to sanitize speculative
 usages
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de
Cc: Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Date: Sun, 04 Feb 2018 09:43:55 -0800
Message-ID: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 [1]:
* Move CLEAR_REGS_EXTRA_NOSPEC before TRACE_IRQS_OFF to protect tracing
  users (Andy)

[1]: https://lkml.org/lkml/2018/2/3/397

---

At entry userspace may have populated callee saved registers with values
that could be useful in a speculative execution attack. Clear them to
minimize the kernel's attack surface.

Note, this is done to make it harder to find / manipulate exploitable
sequences in the kernel.

The clearing is limited to the 64-bit 'extra' registers since those are
the most likely to survive with user populated values deep into the call
chain. Normal register pressure likely clobbers values in the lower
registers and the 32-bit case.

As for cycle impact on my Sandy Bridge test system it can handle the xor
sequence at 3.5 instructions per cycle.

---

Andi Kleen (2):
      x86/entry: Clear registers for 64bit exceptions/interrupts
      x86/entry: Clear registers for compat syscalls

Dan Williams (1):
      x86/entry: Clear extra registers beyond syscall arguments for 64bit kernels


 arch/x86/entry/calling.h         |   17 +++++++++++++++++
 arch/x86/entry/entry_64.S        |    6 ++++++
 arch/x86/entry/entry_64_compat.S |    3 +++
 3 files changed, 26 insertions(+)
