Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeERHkO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:40:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58575 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbeERHkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:40:12 -0400
Date: Fri, 18 May 2018 00:38:23 -0700
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-6469a0ee0a06b2ea1f5afbb1d5a3feed017d4c7a@git.kernel.org>
Cc: bp@alien8.de, dvlasenk@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        andriy.shevchenko@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        tglx@linutronix.de, lkp@intel.com, brgerst@gmail.com,
        sohil.mehta@intel.com
Reply-To: dvlasenk@redhat.com, bp@alien8.de, jpoimboe@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, lkp@intel.com, tglx@linutronix.de,
        brgerst@gmail.com, sohil.mehta@intel.com
In-Reply-To: <20180515115211.55050-1-andriy.shevchenko@linux.intel.com>
References: <20180515115211.55050-1-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/io: Define readq()/writeq() to use 64-bit type
Git-Commit-ID: 6469a0ee0a06b2ea1f5afbb1d5a3feed017d4c7a
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

Commit-ID:  6469a0ee0a06b2ea1f5afbb1d5a3feed017d4c7a
Gitweb:     https://git.kernel.org/tip/6469a0ee0a06b2ea1f5afbb1d5a3feed017d4c7a
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Tue, 15 May 2018 14:52:11 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 18 May 2018 09:11:26 +0200

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
the anchor could be the commit:

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
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180515115211.55050-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index f6e5b9375d8c..6de64840dd22 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -94,10 +94,10 @@ build_mmio_write(__writel, "l", unsigned int, "r", )
 
 #ifdef CONFIG_X86_64
 
-build_mmio_read(readq, "q", unsigned long, "=r", :"memory")
-build_mmio_read(__readq, "q", unsigned long, "=r", )
-build_mmio_write(writeq, "q", unsigned long, "r", :"memory")
-build_mmio_write(__writeq, "q", unsigned long, "r", )
+build_mmio_read(readq, "q", u64, "=r", :"memory")
+build_mmio_read(__readq, "q", u64, "=r", )
+build_mmio_write(writeq, "q", u64, "r", :"memory")
+build_mmio_write(__writeq, "q", u64, "r", )
 
 #define readq_relaxed(a)	__readq(a)
 #define writeq_relaxed(v, a)	__writeq(v, a)
