Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeBCXap (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 18:30:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:8449 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbeBCXai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 18:30:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,457,1511856000";
   d="scan'208";a="171462145"
Subject: [PATCH 0/3] x86/entry: clear registers to sanitize speculative
 usages
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de
Cc: Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Date: Sat, 03 Feb 2018 15:21:31 -0800
Message-ID: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
