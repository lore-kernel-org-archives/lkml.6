Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbeCaKUd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 06:20:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55519 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752967AbeCaKUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 06:20:30 -0400
Date: Sat, 31 Mar 2018 03:20:07 -0700
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-3d94548927a96f35da57984e3410f8b53757435a@git.kernel.org>
Cc: sohil.mehta@intel.com, lkp@intel.com, hpa@zytor.com,
        tglx@linutronix.de, mitake@dcl.info.waseda.ac.jp, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, andriy.shevchenko@linux.intel.com
Reply-To: torvalds@linux-foundation.org, mitake@dcl.info.waseda.ac.jp,
        peterz@infradead.org, lkp@intel.com, tglx@linutronix.de, hpa@zytor.com,
        sohil.mehta@intel.com, andriy.shevchenko@linux.intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180119143322.16555-1-andriy.shevchenko@linux.intel.com>
References: <20180119143322.16555-1-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/io: Define readq()/writeq() to use 64-bit
 type
Git-Commit-ID: 3d94548927a96f35da57984e3410f8b53757435a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3d94548927a96f35da57984e3410f8b53757435a
Gitweb:     https://git.kernel.org/tip/3d94548927a96f35da57984e3410f8b53757435a
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Fri, 19 Jan 2018 16:33:22 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 31 Mar 2018 11:41:43 +0200

x86/io: Define readq()/writeq() to use 64-bit type

Since non atomic readq() and writeq() were added some of the drivers
would like to use it in a manner of:

 #include <io-64-nonatomic-lo-hi.h>
...
 pr_debug("Debug value of some register: %016llx\n", readq(addr));

However, lo_hi_readq() always returns __u64 data, while readq()
on x86_64 defines it as unsigned long. and thus compiler warns
about type mismatch, although they are both 64-bit on x86_64.

Convert readq() and writeq() on x86 to operate on deterministic
64-bit type. The most of architectures in the kernel already are using
either unsigned long long, or u64 type for readq() / writeq().
This change propagates consistency in that sense.

While this is not an issue per se, though if someone wants to address it,
the anchor could be the commit

  797a796a13df ("asm-generic: architecture independent readq/writeq for 32bit environment")

where non-atomic variants had been introduced.

Note, there are only few users of above pattern and they will not be
affected because they do cast returned value. The actual warning has
been issued on not-yet-upstreamed code.

Potentially we might get a new warnings if some 64-bit only code
assigns returned value to unsigned long type of variable. This is
assumed to be addressed on case-by-case basis.

Reported-by: lkp <lkp@intel.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mehta, Sohil <sohil.mehta@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180119143322.16555-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 95e948627fd0..365f5ba9222b 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -94,10 +94,10 @@ build_mmio_write(__writel, "l", unsigned int, "r", )
 
 #ifdef CONFIG_X86_64
 
-build_mmio_read(readq, "q", unsigned long, "=r", :"memory")
-build_mmio_read(__readq, "q", unsigned long, "=r", )
-build_mmio_write(writeq, "q", unsigned long, "r", :"memory")
-build_mmio_write(__writeq, "q", unsigned long, "r", )
+build_mmio_read(readq, "q", unsigned long long, "=r", :"memory")
+build_mmio_read(__readq, "q", unsigned long long, "=r", )
+build_mmio_write(writeq, "q", unsigned long long, "r", :"memory")
+build_mmio_write(__writeq, "q", unsigned long long, "r", )
 
 #define readq_relaxed(a)	__readq(a)
 #define writeq_relaxed(v, a)	__writeq(v, a)
