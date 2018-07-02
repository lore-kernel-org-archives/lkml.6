Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9EFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0283F25CB5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0283F25CB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeGBV0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:26:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:4554 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752889AbeGBV0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:26:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 14:26:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,300,1526367600"; 
   d="scan'208";a="61790261"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2018 14:26:07 -0700
Subject: [PATCH] x86/asm/memcpy_mcsafe: Fix copy_to_user_mcsafe() exception
 handling
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Date:   Mon, 02 Jul 2018 14:16:10 -0700
Message-ID: <153056565378.3420.295180898468362039.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <20180702165803.GB19488@linux.intel.com>
References: <20180702165803.GB19488@linux.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All copy_to_user() implementations need to be prepared to handle faults
accessing userspace. The __memcpy_mcsafe() implementation handles both
mmu-faults on the user destination and machine-check-exceptions on the
source buffer. However, the memcpy_mcsafe() wrapper may silently
fallback to memcpy() depending on build options and cpu-capabilities.

Force copy_to_user_mcsafe() to always use __memcpy_mcsafe() when
available, and otherwise disable all of the copy_to_user_mcsafe()
infrastructure when __memcpy_mcsafe() is not available, i.e.
CONFIG_X86_MCE=n.

This fixes crashes of the form:
    run fstests generic/323 at 2018-07-02 12:46:23
    BUG: unable to handle kernel paging request at 00007f0d50001000
    RIP: 0010:__memcpy+0x12/0x20
    [..]
    Call Trace:
     copyout_mcsafe+0x3a/0x50
     _copy_to_iter_mcsafe+0xa1/0x4a0
     ? dax_alive+0x30/0x50
     dax_iomap_actor+0x1f9/0x280
     ? dax_iomap_rw+0x100/0x100
     iomap_apply+0xba/0x130
     ? dax_iomap_rw+0x100/0x100
     dax_iomap_rw+0x95/0x100
     ? dax_iomap_rw+0x100/0x100
     xfs_file_dax_read+0x7b/0x1d0 [xfs]
     xfs_file_read_iter+0xa7/0xc0 [xfs]
     aio_read+0x11c/0x1a0

Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Reported-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Ingo,

Here is an additional copy_to_iter_mcsafe() fix to address the crash
reported by Ross. This now passes xfstests:generic/323 on my system.

 arch/x86/Kconfig                  |    2 +-
 arch/x86/include/asm/uaccess_64.h |    7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1dbb4ee19d7..887d3a7bb646 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -63,7 +63,7 @@ config X86
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_REFCOUNT
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
-	select ARCH_HAS_UACCESS_MCSAFE		if X86_64
+	select ARCH_HAS_UACCESS_MCSAFE		if X86_64 && X86_MCE
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 62acb613114b..a9d637bc301d 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -52,7 +52,12 @@ copy_to_user_mcsafe(void *to, const void *from, unsigned len)
 	unsigned long ret;
 
 	__uaccess_begin();
-	ret = memcpy_mcsafe(to, from, len);
+	/*
+	 * Note, __memcpy_mcsafe() is explicitly used since it can
+	 * handle exceptions / faults.  memcpy_mcsafe() may fall back to
+	 * memcpy() which lacks this handling.
+	 */
+	ret = __memcpy_mcsafe(to, from, len);
 	__uaccess_end();
 	return ret;
 }

