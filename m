Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB5FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61270208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61270208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932932AbeGHU4N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 16:56:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:32448 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932162AbeGHU4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 16:56:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 13:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,327,1526367600"; 
   d="scan'208";a="238749519"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2018 13:56:10 -0700
Subject: [PATCH 3/4] lib/iov_iter: Fix pipe handling in _copy_to_iter_mcsafe
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
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Sun, 08 Jul 2018 13:46:12 -0700
Message-ID: <153108277278.37979.3327916996902264102.stgit@dwillia2-desk3.amr.corp.intel.com>
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

By mistake the ITER_PIPE early-exit / warning from copy_from_iter() was
cargo-culted in _copy_to_iter_mcsafe() rather than a machine-check-safe
version of copy_to_iter_pipe().

Implement copy_pipe_to_iter_mcsafe() being careful to return the
indication of short copies due to a CPU exception.

Without this regression-fix all splice reads to dax-mode files fail.

Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Reported-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Tested-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 lib/iov_iter.c |   37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 09fb73ad9d54..8be175df3075 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -596,6 +596,37 @@ static unsigned long memcpy_mcsafe_to_page(struct page *page, size_t offset,
 	return ret;
 }
 
+static size_t copy_pipe_to_iter_mcsafe(const void *addr, size_t bytes,
+				struct iov_iter *i)
+{
+	struct pipe_inode_info *pipe = i->pipe;
+	size_t n, off, xfer = 0;
+	int idx;
+
+	if (!sanity(i))
+		return 0;
+
+	bytes = n = push_pipe(i, bytes, &idx, &off);
+	if (unlikely(!n))
+		return 0;
+	for ( ; n; idx = next_idx(idx, pipe), off = 0) {
+		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
+		unsigned long rem;
+
+		rem = memcpy_mcsafe_to_page(pipe->bufs[idx].page, off, addr,
+				chunk);
+		i->idx = idx;
+		i->iov_offset = off + chunk - rem;
+		xfer += chunk - rem;
+		if (rem)
+			break;
+		n -= chunk;
+		addr += chunk;
+	}
+	i->count -= xfer;
+	return xfer;
+}
+
 /**
  * _copy_to_iter_mcsafe - copy to user with source-read error exception handling
  * @addr: source kernel address
@@ -627,10 +658,8 @@ size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
 	const char *from = addr;
 	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
 
-	if (unlikely(i->type & ITER_PIPE)) {
-		WARN_ON(1);
-		return 0;
-	}
+	if (unlikely(i->type & ITER_PIPE))
+		return copy_pipe_to_iter_mcsafe(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
 	iterate_and_advance(i, bytes, v,

