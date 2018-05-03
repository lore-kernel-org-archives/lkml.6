Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeECK2R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:28:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:58239 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeECK2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:28:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="46453009"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] x86/io: Define readq()/writeq() to use 64-bit type
Date: Thu,  3 May 2018 13:28:10 +0300
Message-Id: <20180503102810.59657-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

- resend after v4.17-rc1 as agreed before

 arch/x86/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index f6e5b9375d8c..6259acc0f484 100644
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
-- 
2.17.0
