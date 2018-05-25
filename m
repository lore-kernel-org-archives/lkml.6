Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967572AbeEYRrp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:47:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:8486 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967349AbeEYRro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:47:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="50237280"
Subject: [PATCH] uio, lib: Fix CONFIG_ARCH_HAS_UACCESS_MCSAFE compilation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvdimm@lists.01.org, mingo@kernel.org, tglx@linutronix.de,
        x86@kernel.org
Date: Fri, 25 May 2018 10:37:47 -0700
Message-ID: <152726957962.11148.3528187388080177021.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common Kconfig CONFIG_ARCH_HAS_UACCESS_MCSAFE that archs can
optionally select, and fixup the declaration of _copy_to_iter_mcsafe().

Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Ingo, Thomas, fyi, here is a trivial compilation fixup I will carry in
my tree based on tip/x86/dax. I missed defining the Kconfig symbol, and
my unit test was only dependent on the low level implementation.

 include/linux/uio.h |    2 +-
 lib/Kconfig         |    3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index f5766e853a77..409c845d4cd3 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -155,7 +155,7 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i);
 #endif
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_MCSAFE
-size_t _copy_to_iter_mcsafe(void *addr, size_t bytes, struct iov_iter *i);
+size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i);
 #else
 #define _copy_to_iter_mcsafe _copy_to_iter
 #endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 5fe577673b98..907f6e4f1cf2 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -586,6 +586,9 @@ config ARCH_HAS_PMEM_API
 config ARCH_HAS_UACCESS_FLUSHCACHE
 	bool
 
+config ARCH_HAS_UACCESS_MCSAFE
+	bool
+
 config STACKDEPOT
 	bool
 	select STACKTRACE
