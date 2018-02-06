Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeBFB1O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 20:27:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:9448 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752069AbeBFB1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 20:27:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,467,1511856000";
   d="scan'208";a="29063321"
Subject: [PATCH v3 0/3] x86/entry: Clear registers to sanitize speculative
 usages
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@kernel.org
Cc: Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Date: Mon, 05 Feb 2018 17:18:00 -0800
Message-ID: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 [1]:
* Interleave clearing with preserving in the syscall and compat syscall
  path (Linus)

* Extend clearing protection to r10 and r11 in the sycall path and r8 +
  r9 in the compat syscall path. (Ingo)

* Drop some redundant clearing at interrupt / exception entry.

[1]: https://lkml.org/lkml/2018/2/4/125

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

As for cycle impact, interleaving the clearing with pushing values onto
the stack hides most the overhead.

---

Andi Kleen (2):
      x86/entry: Clear registers for 64bit exceptions/interrupts
      x86/entry: Clear registers for compat syscalls

Dan Williams (1):
      x86/entry: Clear extra registers beyond syscall arguments for 64bit kernels


 arch/x86/entry/calling.h         |   19 +++++++++++++++++++
 arch/x86/entry/entry_64.S        |   20 ++++++++++++++++++--
 arch/x86/entry/entry_64_compat.S |   30 ++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)
