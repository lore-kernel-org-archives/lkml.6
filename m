Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD0EECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9221B20652
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9221B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeGOX6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:58:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47589 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOX6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:58:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNWC1A921867
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:32:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNWBjI921864;
        Sun, 15 Jul 2018 16:32:11 -0700
Date:   Sun, 15 Jul 2018 16:32:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-092b31aa2048cf7561a39697974adcd147fbb27b@git.kernel.org>
Cc:     dan.j.williams@intel.com, luto@amacapital.net,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, peterz@infradead.org, mingo@kernel.org,
        ross.zwisler@linux.intel.com, bp@alien8.de,
        torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          akpm@linux-foundation.org, dan.j.williams@intel.com,
          luto@amacapital.net, tglx@linutronix.de, viro@zeniv.linux.org.uk,
          torvalds@linux-foundation.org, bp@alien8.de,
          ross.zwisler@linux.intel.com, tony.luck@intel.com,
          mingo@kernel.org, peterz@infradead.org
In-Reply-To: <153108277790.37979.1486841789275803399.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153108277790.37979.1486841789275803399.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] x86/asm/memcpy_mcsafe: Fix copy_to_user_mcsafe()
 exception handling
Git-Commit-ID: 092b31aa2048cf7561a39697974adcd147fbb27b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  092b31aa2048cf7561a39697974adcd147fbb27b
Gitweb:     https://git.kernel.org/tip/092b31aa2048cf7561a39697974adcd147fbb27b
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Sun, 8 Jul 2018 13:46:17 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:05:05 +0200

x86/asm/memcpy_mcsafe: Fix copy_to_user_mcsafe() exception handling

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

Reported-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Tested-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")
Link: http://lkml.kernel.org/r/153108277790.37979.1486841789275803399.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig                  | 2 +-
 arch/x86/include/asm/uaccess_64.h | 7 ++++++-
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
