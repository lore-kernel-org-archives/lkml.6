Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6FDC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18066208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18066208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933045AbeGHU4d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 16:56:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:56669 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932437AbeGHU4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 16:56:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 13:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,327,1526367600"; 
   d="scan'208";a="73179621"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002.jf.intel.com with ESMTP; 08 Jul 2018 13:56:00 -0700
Subject: [PATCH 1/4] lib/iov_iter: Document _copy_to_iter_mcsafe()
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Sun, 08 Jul 2018 13:46:02 -0700
Message-ID: <153108276256.37979.1689794213845539316.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153108275728.37979.14771120672220174225.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153108275728.37979.14771120672220174225.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some theory of operation documentation to _copy_to_iter_mcsafe().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 lib/iov_iter.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7e43cd54c84c..94fa361be7bb 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -596,6 +596,32 @@ static unsigned long memcpy_mcsafe_to_page(struct page *page, size_t offset,
 	return ret;
 }
 
+/**
+ * _copy_to_iter_mcsafe - copy to user with source-read error exception handling
+ * @addr: source kernel address
+ * @bytes: total transfer length
+ * @iter: destination iterator
+ *
+ * The pmem driver arranges for filesystem-dax to use this facility via
+ * dax_copy_to_iter() for protecting read/write to persistent memory.
+ * Unless / until an architecture can guarantee identical performance
+ * between _copy_to_iter_mcsafe() and _copy_to_iter() it would be a
+ * performance regression to switch more users to the mcsafe version.
+ *
+ * Otherwise, the main differences between this and typical _copy_to_iter().
+ *
+ * * Typical tail/residue handling after a fault retries the copy
+ *   byte-by-byte until the fault happens again. Re-triggering machine
+ *   checks is potentially fatal so the implementation uses source
+ *   alignment and poison alignment assumptions to avoid re-triggering
+ *   hardware exceptions.
+ *
+ * * ITER_KVEC, ITER_PIPE, and ITER_BVEC can return short copies.
+ *   Compare to copy_to_iter() where only ITER_IOVEC attempts might return
+ *   a short copy.
+ *
+ * See MCSAFE_TEST for self-test.
+ */
 size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;

