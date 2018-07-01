Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3955C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C5F24E5D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C5F24E5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeGAQCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:02:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:29350 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752217AbeGAQCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:02:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2018 09:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,295,1526367600"; 
   d="scan'208";a="51250016"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jul 2018 09:02:18 -0700
Subject: [PATCH] lib/iov_iter: Fix pipe handling in _copy_to_iter_mcsafe
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
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Sun, 01 Jul 2018 08:52:20 -0700
Message-ID: <153046008813.2019.6356018879675062644.stgit@dwillia2-desk3.amr.corp.intel.com>
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

I'm submitting this fix back through the tip tree since the regression
originated through tip/x86/dax.

 lib/iov_iter.c |   37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7e43cd54c84c..d4c5de8d6fba 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -596,15 +596,44 @@ static unsigned long memcpy_mcsafe_to_page(struct page *page, size_t offset,
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
 size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
 {
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

